#!/usr/bin/env node
// Experiment 6, measured on the finished engine rather than a synthetic
// benchmark: what does one frame of compiled Rose Nano actually cost?
//
// Build with NOVSYNC=1 so frames run back to back, then sample the frame
// counter and the live-turtle count against the cycle counter.
//
//   NOVSYNC=1 sh bbc/nano/build.sh bloom 600
//   node bbc/nano/profile.mjs bloom <talive-addr-hex>

import path from "path";
import { readFileSync } from "fs";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const here = path.dirname(new URL(import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, "$1"));
const name = process.argv[2] || "bloom";
const log = readFileSync(path.join(here, "build", `${name}.log`), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)&([0-9A-Fa-f]{4})/g)) sym[m[1]] = parseInt(m[2], 16);
const MAXT = 48;
const FRLO = 0x80, FRHI = 0x81;

const session = new MachineSession("B-DFS1.2", {});
await session.initialise();
await session.boot(30);
session.loadDisc(path.join(here, "build", `${name}.ssd`));
await session.type("*RUN NANO");
await session.runFor(4_000_000);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;
const frames = () => session.readMemory(FRLO, 1)[0] + 256 * session.readMemory(FRHI, 1)[0];
const alive = () => session.readMemory(sym.talive, MAXT).reduce((a, b) => a + (b ? 1 : 0), 0);

console.log(`${name}: engine+program &${sym.start.toString(16)}-&${sym.progend.toString(16)}` +
    ` = ${sym.progend - sym.start} bytes, ${0x3000 - sym.progend} free\n`);
console.log(" frames   live   cycles/frame   % of a 50Hz frame");

// Let the pool saturate, then measure over a long window so the frame counter
// is not the limiting resolution.
while (alive() < MAXT - 4) await session.runFor(200_000);

for (const secs of [1, 2, 4]) {
    const live = alive();
    const f0 = frames(), c0 = cyc();
    await session.runFor(secs * 2_000_000);
    const df = frames() - f0, dc = cyc() - c0;
    const per = dc / df;
    console.log(`${String(df).padStart(7)}${String(live).padStart(7)}` +
        `${per.toFixed(0).padStart(15)}${(100 * per / 40000).toFixed(1).padStart(20)}%`);
}
process.exit(0);
