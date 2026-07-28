#!/usr/bin/env node
// ============================================================================
// opcost.mjs — exact per-execution cost of every opcode handler.
//
// profile.mjs answers "where do the cycles go"; this answers "what does one
// `move` cost". It runs a real demo in headless jsbeeb with a per-instruction
// hook and a small state machine: cycles are charged to the last *handler*
// entered (so helper subroutines — sinlook, smul16, push_RA — land on their
// caller, which is what a per-op cost means), switching only on an op_* entry
// point, the dispatcher, or a non-interpreter region (render, emit, tick).
//
// Usage: node opcost.mjs <buildDir> [maxMcycles] [startFrame]
//   e.g. node opcost.mjs ../build/everyway 200
// Single-CPU builds only (the Tube build's handlers run on the parasite).
// ============================================================================

import { readFileSync, readdirSync } from "fs";
import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const DONEFLAG = 0x0b86;
const FRAME_LO = 0x7f;

const buildDir = process.argv[2];
if (!buildDir) {
    console.error("usage: node opcost.mjs <buildDir> [maxMcycles] [startFrame]");
    process.exit(1);
}
const maxCycles = (parseFloat(process.argv[3]) || 200) * 1e6;
const startFrame = parseInt(process.argv[4]) || 0;

// --- symbols ---------------------------------------------------------------
const log = readFileSync(path.join(buildDir, "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);

// Anything that starts a new charge bucket.
const starts = new Map();
for (const [name, addr] of Object.entries(sym)) {
    if (name.startsWith("op_")) starts.set(addr, name);
}
starts.set(sym.next_op, "(dispatch)");
for (const n of ["sched", "run_turtle", "emit_rec", "rec_done", "build_rec",
                 "frame_tick", "vsync_wait", "cs_loop", "q_drain", "render_blob"]) {
    if (sym[n] !== undefined && !starts.has(sym[n])) starts.set(sym[n], "(" + n + ")");
}
for (const n of (process.env.OPCOST_EXTRA || "").split(",").filter(Boolean)) {
    if (sym[n] !== undefined) starts.set(sym[n], n); else console.error("no symbol " + n);
}
if (!starts.size) { console.error("no op_* symbols in beebasm.log"); process.exit(1); }

// --- boot ------------------------------------------------------------------
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
if (startFrame > 0) {
    const fr = () => { const b = session.readMemory(FRAME_LO, 2); return b[0] | (b[1] << 8); };
    while (fr() < startFrame && session.readMemory(DONEFLAG, 1)[0] === 0) await session.runFor(4_000_000);
}

// --- measure ---------------------------------------------------------------
const total = new Map(), count = new Map(), worst = new Map();
let cur = "(init)", last = cyc(), curStart = last;

const hook = proc.debugInstruction.add((pc) => {
    const now = proc.cycleSeconds * 2_000_000 + proc.currentCycles;
    const name = starts.get(pc);
    if (name !== undefined) {
        const d = now - curStart;
        total.set(cur, (total.get(cur) || 0) + d);
        if (d > (worst.get(cur) || 0)) worst.set(cur, d);
        count.set(name, (count.get(name) || 0) + 1);
        cur = name;
        curStart = now;
    }
    last = now;
    return false;
});

const t0 = cyc();
let done = false;
while (!done && cyc() - t0 < maxCycles) {
    await session.runFor(2_000_000);
    done = session.readMemory(DONEFLAG, 1)[0] !== 0;
}
proc.debugInstruction.remove(hook);

// --- report ----------------------------------------------------------------
const ran = cyc() - t0;
const frames = (() => { const b = session.readMemory(FRAME_LO, 2); return b[0] | (b[1] << 8); })();
console.log(`${path.basename(path.resolve(buildDir))}: ${(ran / 1e6).toFixed(1)}M cycles, ` +
    `${frames} frames${done ? " (DONE)" : ""}\n`);
console.log("handler            executions      cycles   mean   worst   %of run");
const rows = [...count.keys()]
    .map((n) => ({ n, c: count.get(n) || 0, t: total.get(n) || 0 }))
    .filter((r) => r.c > 0)
    .sort((a, b) => b.t - a.t);
for (const r of rows) {
    console.log(`${r.n.padEnd(18)} ${String(r.c).padStart(10)} ${(r.t / 1e6).toFixed(2).padStart(11)}M ` +
        `${(r.t / r.c).toFixed(1).padStart(6)} ${String(worst.get(r.n) || 0).padStart(7)} ` +
        `${((100 * r.t) / ran).toFixed(1).padStart(8)}`);
}
session.destroy();
