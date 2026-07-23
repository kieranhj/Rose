#!/usr/bin/env node
// ============================================================================
// runverify.mjs — boot build/<name>/rose.ssd headless, run to completion, and
// verify LOGCNT/LOGCHK against expected_plots.bin (count mod 65536 + the
// order-independent rol32-xor-sum checksum). Much faster than the MCP loop.
//
// Usage: node runverify.mjs <buildDir> [maxMcycles]   (default 4000)
//   JSBEEB_TUBE=1  — attach the 65C02 co-processor (Master Turbo timing);
//                    uses the patched jsbeeb clone until PR #706 ships.
//   JSBEEB_PATH    — override the jsbeeb package location.
// ============================================================================

import { readFileSync } from "fs";
import path from "path";

const TUBE = process.env.JSBEEB_TUBE === "1";
const PATCHED = "C:/Users/khcon/AppData/Local/Temp/claude/C--Users-khcon-OneDrive-Archie-Repos-Rose/32f2e656-c2a1-404f-925e-471ee4c2fc4c/scratchpad/jsbeeb";
const CACHED = "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const JSBEEB = process.env.JSBEEB_PATH || (TUBE ? PATCHED : CACHED);
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const buildDir = process.argv[2];
const maxCycles = (parseFloat(process.argv[3]) || 4000) * 1e6;
const LOGCNT = 0x0b80;
const DONEFLAG = 0x0b86;

// Expected values from the visualizer ground truth.
const exp = readFileSync(path.join(buildDir, "expected_plots.bin"));
const nrec = Math.floor(exp.length / 10);
let chk = 0;
for (let r = 0; r < nrec; r++) {
    let h = 0;
    for (let i = 0; i < 10; i++) {
        h = ((h << 1) | (h >>> 31)) >>> 0;          // rol32(h,1)
        h = (h ^ exp[r * 10 + i]) >>> 0;
    }
    chk = (chk + h) >>> 0;
}
const expCount = nrec & 0xffff;

const session = new MachineSession("Master", TUBE ? { tube: true } : {});
await session.initialise();
session.loadDisc(path.resolve(buildDir, "rose.ssd"));
session.keyDown(16);
session.reset(true);
await session.runFor(2_000_000);
session.keyUp(16);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;
const t0 = cyc();
while (session.readMemory(DONEFLAG, 1)[0] !== 0xff && cyc() - t0 < maxCycles) {
    await session.runFor(8_000_000);
}
const done = session.readMemory(DONEFLAG, 1)[0] === 0xff;
const hdr = session.readMemory(LOGCNT, 6);
const gotCount = hdr[0] | (hdr[1] << 8);
const gotChk = (hdr[2] | (hdr[3] << 8) | (hdr[4] << 16) | (hdr[5] << 24)) >>> 0;

const hex = (v) => v.toString(16).toUpperCase().padStart(8, "0");
console.log(`${path.basename(path.resolve(buildDir))}: ran ${((cyc() - t0) / 1e6).toFixed(0)}M cycles, done=${done}`);
console.log(`  count ${gotCount} (expected ${expCount} = ${nrec} mod 65536)  chk ${hex(gotChk)} (expected ${hex(chk)})`);
const pass = done && gotCount === expCount && gotChk === chk;
console.log(pass ? "  PASS" : "  FAIL");
session.destroy();
process.exit(pass ? 0 : 1);
