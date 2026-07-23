#!/usr/bin/env node
// ============================================================================
// profile.mjs — exact cycle attribution profiler for the BBC Rose engine.
//
// Boots build/<name>/rose.ssd in headless jsbeeb (Master) and attributes
// every host CPU cycle to an engine region via a per-instruction hook and a
// 64K pc→region lookup table. Region boundaries come from the SYM lines
// beebasm prints into build/<name>/beebasm.log.
//
// Regions:
//   init    one-time startup (entry..sched)
//   interp  dispatcher, opcode handlers, scheduler      → parasite (Tube)
//   emit    record build + hash + log                   → parasite (Tube)
//   render  rec_done glue, render_blob..chain, SWRAM    → host    (Tube)
//   tick    frame_tick work: colorscript, palette       → host    (Tube)
//   idle    vsync_wait poll loop (headroom)
//   other   error handlers, anything unmapped
//
// Usage: node profile.mjs <buildDir> [maxMcycles] [chunkMcycles] [startFrame]
//   e.g. node profile.mjs ../build/ball 400 20
//   startFrame: run at full speed (no hook) until zp frame counter reaches
//   this frame, then start profiling.
// Stops early when DONEFLAG (&0B86) goes non-zero.
// ============================================================================

import { readFileSync } from "fs";
import path from "path";

const JSBEEB = "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const DONEFLAG = 0x0b86;
const FRAME_LO = 0x7f;

const buildDir = process.argv[2];
if (!buildDir) {
    console.error("usage: node profile.mjs <buildDir> [maxMcycles] [chunkMcycles]");
    process.exit(1);
}
const maxCycles = (parseFloat(process.argv[3]) || 800) * 1e6;
const chunkCycles = (parseFloat(process.argv[4]) || 40) * 1e6;
const startFrame = parseInt(process.argv[5]) || 0;

// --- symbols ----------------------------------------------------------------
const log = readFileSync(path.join(buildDir, "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);
const need = "entry sched emit_rec rec_done build_rec op_wait frame_tick vsync_wait cs_loop err_unimpl render_blob ctab".split(" ");
for (const n of need) if (!(n in sym)) { console.error(`missing symbol ${n} in beebasm.log`); process.exit(1); }

// --- pc → region map ----------------------------------------------------------
const R = { init: 0, interp: 1, emit: 2, rblob: 3, rspan: 4, rchain: 5, tick: 6, idle: 7, other: 8 };
const NAMES = Object.keys(R);
const RENDER = [R.rblob, R.rspan, R.rchain];
const map = new Uint8Array(0x10000).fill(R.other);
const span = (a, b, r) => map.fill(r, a, b);
span(0x0e00, sym.entry, R.rchain);           // span middle chain
span(sym.entry, sym.sched, R.init);
span(sym.sched, sym.emit_rec, R.interp);
span(sym.emit_rec, sym.rec_done, R.emit);
span(sym.rec_done, sym.build_rec, R.rblob);  // ACCCON/bank glue around render_blob
span(sym.build_rec, sym.op_wait, R.emit);
span(sym.op_wait, sym.frame_tick, R.interp);
span(sym.frame_tick, sym.vsync_wait, R.tick);
span(sym.vsync_wait, sym.cs_loop, R.idle);
span(sym.cs_loop, sym.err_unimpl, R.tick);
span(sym.q_drain || sym.render_blob, sym.ctab, R.rblob); // drain glue + renderer
span(0x8000, 0xc000, R.rspan);               // SWRAM span fillers (banks 4/5)

// --- boot ---------------------------------------------------------------------
const session = new MachineSession("Master", {});
await session.initialise();
session.loadDisc(path.resolve(buildDir, "rose.ssd"));
session.keyDown(16); // SHIFT
session.reset(true);
await session.runFor(2_000_000);
session.keyUp(16);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;

// Run the boot (SRLOADs are slow under emulated DFS) until the engine entry.
await session.runUntilAddress(sym.entry, 90);
if (session.registers().pc !== sym.entry) {
    console.error("engine entry never reached — boot failed (pc=&" + session.registers().pc.toString(16) + ")");
    process.exit(1);
}
console.error(`booted to entry &${sym.entry.toString(16)} at ${(cyc() / 1e6).toFixed(1)}M cycles`);

// Optional fast-forward (no hook installed, so this runs at full emulator speed).
if (startFrame > 0) {
    const fr = () => { const b = session.readMemory(FRAME_LO, 2); return b[0] | (b[1] << 8); };
    while (fr() < startFrame && session.readMemory(DONEFLAG, 1)[0] === 0) await session.runFor(4_000_000);
    console.error(`fast-forwarded to frame ${fr()}`);
}

// --- profile -------------------------------------------------------------------
const totals = new Float64Array(9);
const chunks = [];
let chunk = new Float64Array(9);
let chunkStart = cyc();
let last = cyc();
let lastRegion = R.init;

const frameAt = () => { const b = session.readMemory(FRAME_LO, 2); return b[0] | (b[1] << 8); };
let chunkFrame0 = frameAt();

const hook = proc.debugInstruction.add((pc) => {
    const now = proc.cycleSeconds * 2_000_000 + proc.currentCycles;
    const d = now - last;
    totals[lastRegion] += d;
    chunk[lastRegion] += d;
    last = now;
    lastRegion = map[pc];
    return false;
});

const t0 = cyc();
let done = false;
while (!done && cyc() - t0 < maxCycles) {
    await session.runFor(Math.min(chunkCycles, 2_000_000));
    if (cyc() - chunkStart >= chunkCycles) {
        const f1 = frameAt();
        chunks.push({ from: chunkFrame0, to: f1, c: chunk });
        chunk = new Float64Array(9);
        chunkStart = cyc();
        chunkFrame0 = f1;
    }
    done = session.readMemory(DONEFLAG, 1)[0] !== 0;
}
proc.debugInstruction.remove(hook);
if (chunk.some((v) => v > 0)) chunks.push({ from: chunkFrame0, to: frameAt(), c: chunk });

// --- report ---------------------------------------------------------------------
const frames = frameAt();
const ran = cyc() - t0;
console.log(`\n${path.basename(path.resolve(buildDir))}: ${(ran / 1e6).toFixed(1)}M cycles profiled, ` +
    `${frames} frames reached${done ? " (DONE)" : ""}`);

const render = RENDER.reduce((a, r) => a + totals[r], 0);
const busy = totals[R.interp] + totals[R.emit] + render + totals[R.tick];
console.log("\nregion        Mcycles      %busy   %total");
for (const n of NAMES) {
    const v = totals[R[n]];
    const pb = [R.interp, R.emit, ...RENDER, R.tick].includes(R[n]) ? ((100 * v) / busy).toFixed(1) : "  -";
    console.log(`${n.padEnd(10)} ${(v / 1e6).toFixed(2).padStart(9)}   ${String(pb).padStart(7)}  ${((100 * v) / ran).toFixed(1).padStart(6)}`);
}
const P = totals[R.interp] + totals[R.emit];         // parasite side under the Tube split
const H = render + totals[R.tick];                   // host side
console.log(`\nTube model: parasite(interp+emit) ${(P / 1e6).toFixed(1)}M  host(render+tick) ${(H / 1e6).toFixed(1)}M` +
    `  → split ${((100 * P) / (P + H)).toFixed(0)}/${((100 * H) / (P + H)).toFixed(0)}`);
console.log(`per-frame avg: parasite ${(P / frames / 1e3).toFixed(2)}K  host ${(H / frames / 1e3).toFixed(2)}K  (slot = 40K)`);
console.log(`est. Tube frame cost = max(parasite/2, host) = ${(Math.max(P / 2, H) / frames / 1e3).toFixed(2)}K vs now ${((P + H) / frames / 1e3).toFixed(2)}K`);

console.log("\nchunks (frames: interp/emit/render/tick/idle Mcyc):");
for (const { from, to, c } of chunks) {
    console.log(`  f${String(from).padStart(5)}-${String(to).padEnd(5)} ` +
        `${(c[R.interp] / 1e6).toFixed(1).padStart(6)} ${(c[R.emit] / 1e6).toFixed(1).padStart(6)} ` +
        `${((c[R.rblob] + c[R.rspan] + c[R.rchain]) / 1e6).toFixed(1).padStart(6)} ${(c[R.tick] / 1e6).toFixed(1).padStart(6)} ` +
        `${(c[R.idle] / 1e6).toFixed(1).padStart(6)}`);
}
session.destroy();
