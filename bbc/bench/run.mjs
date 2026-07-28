#!/usr/bin/env node
// Runs bench.ssd in headless jsbeeb and reports per-iteration cycle costs.
// Each benchmark is bracketed by consecutive .bs_* labels; we run to each in
// turn and diff the cycle counter, then subtract the empty-loop cost.

import { readFileSync } from "fs";
import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const here = path.dirname(new URL(import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, "$1"));
// Optional manifest (bbc/bench/bench.json, written by genpaint.py) describes a
// generated benchmark set; without it we run the built-in Micro primitive list.
const manifest = process.argv[2]
    ? JSON.parse(readFileSync(path.join(here, process.argv[2]), "utf8")) : null;
const log = readFileSync(path.join(here, process.argv[3] || "beebasm.log"), "utf8");
const sym = {};
for (const m of log.matchAll(/SYM (\w+)\s*[&$]?([0-9A-Fa-f]{3,4})/g)) sym[m[1]] = parseInt(m[2], 16);

const LOOPN = 256 * 8;
// name, label, iterations-per-loop-body (1 unless the body does N ops)
const BENCH = [
    ["empty loop", "bs_empty"],
    ["call scaffold (phy/phx/jsr/rts)", "bs_scaffold"],
    ["32-bit add (zp)", "bs_add32"],
    ["16-bit add (zp)", "bs_add16"],
    ["push+pop, 32-bit slot", "bs_pushpop32"],
    ["push+pop, 16-bit slot", "bs_pushpop16"],
    ["smul16 (16x16->32)", "bs_smul16"],
    ["smul168 (16x8->24)", "bs_smul168"],
    ["move, micro Q8 sine", "bs_move16q8"],
    ["move, micro Q12 sine", "bs_move16q12"],
    ["op_const, micro", "bs_const16"],
    ["op_rlocal, micro", "bs_rlocal16"],
    ["op_wstate, micro", "bs_wstate16"],
    ["op_op (add), micro", "bs_op16"],
    ["fork state copy, 144 B", "bs_copy144"],
    ["fork state copy, 32 B", "bs_copy32"],
    [null, "bs_end"],
];

if (manifest) {
    BENCH.length = 0;
    for (const b of manifest.bench) BENCH.push([b.name, b.label, b.called]);
    BENCH.push([null, "bs_end"]);
}

const session = new MachineSession("Master", {});
await session.initialise();
session.loadDisc(path.join(here, manifest ? manifest.ssd : "bench.ssd"));
session.keyDown(16);
session.reset(true);
await session.runFor(2_000_000);
session.keyUp(16);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;

await session.runUntilAddress(sym.entry, 60);
if (session.registers().pc !== sym.entry) {
    console.error("bench never started (pc=&" + session.registers().pc.toString(16) + ")");
    process.exit(1);
}

// --- correctness: replay validate()'s arithmetic in JS ----------------------
const sin8 = [];
for (let i = 0; i < 1024; i++)
    sin8.push(Math.max(-128, Math.min(127, Math.round(Math.sin(2 * Math.PI * i / 1024) * 128))));
let vx = 0, vy = 0, vdir = 0;
const vm = 0x0123;
for (let i = 0; i < 256; i++) {
    vdir = (vdir + 397) & 0xFFFF;
    const idx = vdir >> 6;
    const ca = sin8[(idx + 256) & 1023], sa = sin8[idx & 1023];
    vx = (vx + (((vm * ca + 64) >> 7) & 0xFFFF)) & 0xFFFF;
    vy = (vy + (((vm * sa + 64) >> 7) & 0xFFFF)) & 0xFFFF;
}

const marks = [];
let validated = null, vbuf = null;   // read at bs_empty, before the benchmarks move the turtle
const DBG = process.env.BENCH_DEBUG;
for (const [, label] of BENCH) {
    await session.runUntilAddress(sym[label], 60);
    if (session.registers().pc !== sym[label]) {
        console.error(`never reached ${label}`);
        process.exit(1);
    }
    marks.push(cyc());
    if (marks.length === 1) {
        // Capture before the benchmark loops overwrite what the validation run made.
        if (sym.state !== undefined) validated = session.readMemory(sym.state, 4);
        if (manifest && manifest.validate)
            vbuf = session.readMemory(sym[manifest.validate.buffer_sym], manifest.validate.len);
    }
    if (DBG) console.error(label, "@&"+sym[label].toString(16), "cyc", cyc());
}

if (manifest && manifest.validate) {
    const v = manifest.validate;
    const want = readFileSync(path.join(here, v.expect));
    const have = vbuf;
    let bad = 0;
    for (let i = 0; i < v.len; i++) if (want[i] !== have[i]) bad++;
    console.log(`painter validation: ${bad ? "*** " + bad + " bytes differ ***" : "buffer matches the model exactly"}`);
    if (bad) process.exitCode = 1;
}
const got = validated || [0, 0, 0, 0];
const gx = got[0] | (got[1] << 8), gy = got[2] | (got[3] << 8);
const ok = gx === vx && gy === vy;
if (!manifest) console.log(`move16q8 validation: 256 moves -> x=${gx} y=${gy} (model x=${vx} y=${vy}) ` +
    (ok ? "MATCH" : "*** MISMATCH ***"));
if (!manifest && !ok) process.exitCode = 1;

const per = [];
for (let i = 0; i < BENCH.length - 1; i++) {
    per.push((marks[i + 1] - marks[i]) / LOOPN);
}
const overhead = per[0];

console.log(`${LOOPN} iterations each; empty-loop overhead ${overhead.toFixed(2)} cyc/iter\n`);
const scaffold = per[1] - overhead;
const CALLED = manifest
    ? new Set(manifest.bench.filter((b) => b.called).map((b) => b.label))
    : new Set(["bs_smul16", "bs_smul168", "bs_move16q8", "bs_move16q12",
               "bs_const16", "bs_rlocal16", "bs_wstate16", "bs_op16",
               "bs_copy144", "bs_copy32"]);
const SZ = manifest ? manifest.sizes || {} : {};
console.log("benchmark                          cycles     net of call    code");
for (let i = 1; i < per.length; i++) {
    const raw = per[i] - overhead;
    const net = CALLED.has(BENCH[i][1]) ? (raw - scaffold).toFixed(1) : "";
    const bytes = SZ[BENCH[i][1].slice(3)];
    console.log(`${BENCH[i][0].padEnd(33)} ${raw.toFixed(1).padStart(7)} ${net.padStart(15)}` +
        (bytes ? `  ${String(bytes).padStart(6)} B` : ""));
}
session.destroy();
