#!/usr/bin/env node
// ============================================================================
// frametime.mjs — per-frame cycle cost of a real build, as a CSV.
//
// profile.mjs aggregates region cycles over chunks of frames; this keeps the
// same pc→region map but flushes a row every time the engine reaches
// frame_tick, so each frame's interp / emit / render / tick / idle cost is
// recorded separately. That is what bbc/tools/budget.py's offline model has to
// predict, so this file is the ground truth it is validated against.
//
// Usage: node frametime.mjs <buildDir> <out.csv> [maxMcycles]
//   e.g. node frametime.mjs bbc/build/ball ft-ball.csv 200
// Single-CPU builds only (a Tube build's interpreter runs on the parasite).
// ============================================================================

import { readFileSync, readdirSync, writeFileSync } from "fs";
import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const DONEFLAG = 0x0b86;

const buildDir = process.argv[2];
const outPath = process.argv[3];
if (!buildDir || !outPath) {
    console.error("usage: node frametime.mjs <buildDir> <out.csv> [maxMcycles]");
    process.exit(1);
}
const maxCycles = (parseFloat(process.argv[4]) || 400) * 1e6;

const log = readFileSync(path.join(buildDir, "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);

// Same regions as profile.mjs.
const R = { init: 0, interp: 1, emit: 2, render: 3, tick: 4, idle: 5, other: 6 };
const map = new Uint8Array(0x10000).fill(R.other);
const span = (a, b, r) => map.fill(r, a, b);
span(0x0e00, sym.entry, R.render);           // span middle chain
span(sym.entry, sym.sched, R.init);
span(sym.sched, sym.emit_rec, R.interp);
span(sym.emit_rec, sym.rec_done, R.emit);
span(sym.rec_done, sym.build_rec, R.render);
span(sym.build_rec, sym.op_wait, R.emit);
span(sym.op_wait, sym.frame_tick, R.interp);
span(sym.frame_tick, sym.vsync_wait, R.tick);
span(sym.vsync_wait, sym.cs_loop, R.idle);
span(sym.cs_loop, sym.err_unimpl, R.tick);
span(sym.q_drain || sym.render_blob, sym.ctab, R.render);
span(0x8000, 0xc000, R.render);              // SWRAM span fillers

const session = new MachineSession("Master", {});
await session.initialise();
session.loadDisc(path.resolve(buildDir, readdirSync(buildDir).find((f) => f.endsWith(".ssd"))));
session.keyDown(16);
session.reset(true);
await session.runFor(2_000_000);
session.keyUp(16);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;

await session.runUntilAddress(sym.entry, 90);
if (session.registers().pc !== sym.entry) {
    console.error("engine entry never reached (pc=&" + session.registers().pc.toString(16) + ")");
    process.exit(1);
}

const rows = [];
let cur = new Float64Array(7);
let last = cyc();
let lastRegion = R.init;
const TICK = sym.frame_tick;

const hook = proc.debugInstruction.add((pc) => {
    const now = proc.cycleSeconds * 2_000_000 + proc.currentCycles;
    cur[lastRegion] += now - last;
    last = now;
    lastRegion = map[pc];
    if (pc === TICK) {                       // one frame's work is complete
        rows.push(cur);
        cur = new Float64Array(7);
    }
    return false;
});

const t0 = cyc();
let done = false;
while (!done && cyc() - t0 < maxCycles) {
    await session.runFor(2_000_000);
    done = session.readMemory(DONEFLAG, 1)[0] !== 0;
}
proc.debugInstruction.remove(hook);

const out = ["frame,interp,emit,render,tick,idle"];
rows.forEach((c, i) =>
    out.push(`${i},${c[R.interp].toFixed(0)},${c[R.emit].toFixed(0)},` +
        `${c[R.render].toFixed(0)},${c[R.tick].toFixed(0)},${c[R.idle].toFixed(0)}`));
writeFileSync(outPath, out.join("\n") + "\n");
const busy = rows.map((c) => c[R.interp] + c[R.emit] + c[R.render] + c[R.tick]);
const mean = busy.reduce((a, b) => a + b, 0) / busy.length;
console.log(`${path.basename(path.resolve(buildDir))}: ${rows.length} frames -> ${outPath}` +
    `  (mean busy ${(mean / 1000).toFixed(1)}K cycles/frame)`);
session.destroy();
