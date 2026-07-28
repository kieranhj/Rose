#!/usr/bin/env node
// ============================================================================
// rendercost.mjs — cost of render_blob bucketed by blob radius.
//
// Charges every cycle spent inside the render code (render_blob..ctab, the
// SWRAM span fillers at &8000-&BFFF, and the shared store chain at &0E00) to
// the radius of the record being drawn, read from REC at each render_blob
// entry. Validates (or corrects) the cost law in rose-micro.md §1.1.
//
// Usage: node rendercost.mjs <buildDir> [maxMcycles]
// ============================================================================
import { readFileSync, readdirSync } from "fs";
import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const DONEFLAG = 0x0b86;
const buildDir = process.argv[2];
const maxCycles = (parseFloat(process.argv[3]) || 150) * 1e6;
const REC = parseInt(process.env.REC_ADDR || "0", 16) || null;

const log = readFileSync(path.join(buildDir, "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);
const recAddr = REC || sym.REC;
if (!recAddr) { console.error("need REC address: set REC_ADDR=<hex>"); process.exit(1); }

// pc -> "is render code"
const isRender = new Uint8Array(0x10000);
isRender.fill(1, 0x0e00, sym.entry);          // shared store chain
isRender.fill(1, sym.render_blob, sym.ctab);  // renderer proper
isRender.fill(1, 0x8000, 0xc000);             // SWRAM span fillers

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

const total = new Map(), count = new Map();
let curR = -1, last = cyc(), inRender = false;
const hook = proc.debugInstruction.add((pc) => {
    const now = proc.cycleSeconds * 2_000_000 + proc.currentCycles;
    if (inRender) total.set(curR, (total.get(curR) || 0) + (now - last));
    last = now;
    if (pc === sym.render_blob) {
        const b = session.readMemory(recAddr + 6, 4);
        const r = b[0] | (b[1] << 8);
        const sq = (b[3] & 0x80) !== 0;
        curR = sq ? -(r + 1) : r;     // squares recorded as -(r+1)
        count.set(curR, (count.get(curR) || 0) + 1);
    }
    inRender = isRender[pc] === 1;
    return false;
});

const t0 = cyc();
let done = false;
while (!done && cyc() - t0 < maxCycles) {
    await session.runFor(2_000_000);
    done = session.readMemory(DONEFLAG, 1)[0] !== 0;
}
proc.debugInstruction.remove(hook);

console.log(`${path.basename(path.resolve(buildDir))}: ${((cyc() - t0) / 1e6).toFixed(1)}M cycles\n`);
console.log("radius   blobs      Mcycles    mean   model 90(2r+1)+5.4B   ratio");
const keys = [...count.keys()].filter((r) => r >= 0).sort((a, b) => a - b);
let bt = 0, bn = 0;
for (const r of keys) {
    const c = count.get(r), t = total.get(r) || 0;
    const model = 90 * (2 * r + 1) + 5.4 * (Math.PI * r * r / 4);
    bt += t; bn += c;
    console.log(`${String(r).padStart(6)} ${String(c).padStart(7)} ${(t / 1e6).toFixed(2).padStart(12)} ` +
        `${(t / c).toFixed(0).padStart(7)} ${model.toFixed(0).padStart(20)} ${(t / c / model).toFixed(2).padStart(7)}`);
}
const sq = [...count.keys()].filter((r) => r < 0);
for (const r of sq) {
    const c = count.get(r), t = total.get(r) || 0;
    console.log(`sq ${String(-r - 1).padStart(3)} ${String(c).padStart(7)} ${(t / 1e6).toFixed(2).padStart(12)} ${(t / c).toFixed(0).padStart(7)}`);
}
console.log(`\nall radii: ${bn} blobs, ${(bt / 1e6).toFixed(1)}M cycles, mean ${(bt / bn).toFixed(0)}`);
session.destroy();
