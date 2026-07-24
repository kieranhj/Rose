#!/usr/bin/env node
// ============================================================================
// opprofile.mjs — per-handler cycle attribution for the BBC Rose interpreter.
//
// Like profile.mjs but fine-grained: every SYM label printed into
// beebasm.log becomes a region boundary, so cycles are attributed to
// individual opcode handlers and helper routines (push_RA, umul16, ...).
// Subroutine time lands on the subroutine, not its caller.
//
// Usage: node opprofile.mjs <buildDir> [maxMcycles]
// Stops early when DONEFLAG (&0B86) goes non-zero. Single-CPU builds only.
// ============================================================================

import { readFileSync, readdirSync } from "fs";
import path from "path";

const JSBEEB = "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const DONEFLAG = 0x0b86;
const FRAME_LO = 0x7f;

const buildDir = process.argv[2];
if (!buildDir) {
    console.error("usage: node opprofile.mjs <buildDir> [maxMcycles]");
    process.exit(1);
}
const maxCycles = (parseFloat(process.argv[3]) || 800) * 1e6;

// --- symbols: every SYM line is a region --------------------------------------
const log = readFileSync(path.join(buildDir, "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);
const labels = Object.entries(sym).sort((a, b) => a[1] - b[1]);
if (labels.length < 20) { console.error("too few SYM labels — rebuild with current interp.asm"); process.exit(1); }

const names = ["chain", ...labels.map(([n]) => n), "swram"];
const map = new Uint16Array(0x10000);          // region index per pc
map.fill(0, 0x0e00, labels[0][1]);             // &0E00 chain before first label
for (let i = 0; i < labels.length; i++) {
    const from = labels[i][1];
    const to = i + 1 < labels.length ? labels[i + 1][1] : 0x8000;
    map.fill(i + 1, from, to);
}
map.fill(names.length - 1, 0x8000, 0xc000);    // SWRAM fillers

// --- boot ----------------------------------------------------------------------
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
    console.error("boot failed (pc=&" + session.registers().pc.toString(16) + ")");
    process.exit(1);
}
console.error(`booted at ${(cyc() / 1e6).toFixed(1)}M cycles`);

// --- profile ---------------------------------------------------------------------
const totals = new Float64Array(names.length);
const hits = new Float64Array(names.length);   // entries into the region
let last = cyc();
let lastRegion = 0;

const hook = proc.debugInstruction.add((pc) => {
    const now = proc.cycleSeconds * 2_000_000 + proc.currentCycles;
    const r = map[pc];
    totals[lastRegion] += now - last;
    if (r !== lastRegion) hits[r]++;
    last = now;
    lastRegion = r;
    return false;
});

const t0 = cyc();
let done = false;
while (!done && cyc() - t0 < maxCycles) {
    await session.runFor(2_000_000);
    done = session.readMemory(DONEFLAG, 1)[0] !== 0;
}
proc.debugInstruction.remove(hook);

const fr = session.readMemory(FRAME_LO, 2);
const frames = fr[0] | (fr[1] << 8);
const ran = cyc() - t0;
console.log(`\n${path.basename(path.resolve(buildDir))}: ${(ran / 1e6).toFixed(1)}M cycles, ` +
    `${frames} frames${done ? " (DONE)" : ""}\n`);
console.log("region            Mcycles   %total     entries   cyc/entry");
const order = [...names.keys()].sort((a, b) => totals[b] - totals[a]);
for (const i of order) {
    if (totals[i] < ran / 1000) continue;      // hide < 0.1%
    console.log(`${names[i].padEnd(14)} ${(totals[i] / 1e6).toFixed(2).padStart(10)} ` +
        `${((100 * totals[i]) / ran).toFixed(1).padStart(7)} ${hits[i].toExponential(2).padStart(11)} ` +
        `${hits[i] ? (totals[i] / hits[i]).toFixed(0).padStart(9) : "        -"}`);
}
session.destroy();
