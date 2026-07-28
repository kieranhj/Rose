#!/usr/bin/env node
// Run a Rose Nano build under jsbeeb: boot the disc, *RUN NANO, let it draw,
// then dump the MODE 2 screen as a PNG and as raw bytes for verification.
//
//   node bbc/nano/run.mjs <name> [frames] [--profile]
//
// --profile times one frame of the running engine, which is the measurement
// experiment 6 asked for: what does a compiled turtle step actually cost?

import { writeFileSync } from "fs";
import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const here = path.dirname(new URL(import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, "$1"));
const name = process.argv[2] || "spiral";
const frames = parseInt(process.argv[3] || "400", 10);
const profile = process.argv.includes("--profile");

const session = new MachineSession("B-DFS1.2", {});
await session.initialise();
await session.boot(30);
session.loadDisc(path.join(here, "build", `${name}.ssd`));
await session.type("*RUN NANO");
await session.runFor(4_000_000);          // load + init + clear

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;

// Run the requested number of 50Hz frames' worth of time.
const t0 = cyc();
await session.runFor(frames * 40_000);
const spent = cyc() - t0;

// The engine writes &FF to &8C when it hits MAXFRAMES.
const done = session.readMemory(0x8c, 1)[0];

const screen = Buffer.from(readRange(session, 0x3000, 20480));
writeFileSync(path.join(here, "build", `${name}.screen.bin`), screen);

function readRange(s, addr, len) {
    const out = new Uint8Array(len);
    for (let i = 0; i < len; i += 256)
        out.set(s.readMemory(addr + i, Math.min(256, len - i)), i);
    return out;
}

// Screenshot straight from the emulator's framebuffer.
const png = await session.screenshotActive({ scale: 2 });
writeFileSync(path.join(here, "build", `${name}.png`), png);

console.log(`${name}: ran ${frames} frames (${spent.toLocaleString()} cycles), ` +
    `done=${done === 0xff}`);

if (profile) {
    // Time a single scheduler pass by breaking on the vsync OSBYTE twice.
    const marks = [];
    for (let i = 0; i < 6; i++) {
        const a = cyc();
        await session.runFor(40_000);
        marks.push(cyc() - a);
    }
    console.log("frame samples:", marks.join(", "));
}
process.exit(0);
