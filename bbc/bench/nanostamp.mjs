#!/usr/bin/env node
// Rose Nano experiment 1 (bbc/docs/rose-nano.md §13.3, §10): what does a
// byte-aligned MODE 2 blob stamp actually cost on a stock Model B?
//
// Part 1 of the experiment (the MODE 2 memory layout) was confirmed
// interactively: +1 = next scanline within a character row, +8 = next 2-pixel
// column, 32-byte character cell, +640 = next character row.  So a blob is
// (width/2) x ceil(rows/8) contiguous runs of up to 8 bytes.
//
// This script pokes generated 6502 into a real machine and times it against
// the emulator's cycle counter.  No beebasm, no disc: the code is emitted here
// so the shapes stay in step with nanorender.py's grid model.
//
//   node bbc/bench/nanostamp.mjs [model]        default B-DFS1.2

import path from "path";

const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");

const MODEL = process.argv[2] || "B-DFS1.2";

// --- memory map -------------------------------------------------------------
// Everything lives in the MODE 7 free-RAM window (&1900–&7BFF) so the largest
// generated body — ~4KB for the rc=3 dithered blob — cannot reach the tables or
// the write target.  Screen writes go to plain RAM; on the BBC the video system
// reads on the opposite phase, so RAM is full 2MHz either way (§2).
const TABLES = 0x1900;
const ROWLO = TABLES, ROWHI = TABLES + 0x20;
const COLLO = TABLES + 0x40, COLHI = TABLES + 0x70;
const CODE = 0x1a00;      // generated benchmark body, up to ~9KB
const SCREEN = 0x4000;    // stand-in for &3000; same RAM, clear of the code
const PO = 0x70;          // blob origin (top-left byte)
const P = 0x72;           // working pointer, re-based per character row
const CNT = 0x74;         // loop counter
const COL = 0x76, ROW = 0x77;
const LOOPN = 256;

// --- a very small 6502 emitter ----------------------------------------------
const lo = (a) => a & 0xff, hi = (a) => (a >> 8) & 0xff;
class Asm {
    constructor(org) { this.org = org; this.b = []; }
    get pc() { return this.org + this.b.length; }
    e(...bytes) { this.b.push(...bytes); return this; }
    ldaImm(n) { return this.e(0xa9, n & 0xff); }
    ldaZp(a) { return this.e(0xa5, a); }
    adcImm(n) { return this.e(0x69, n & 0xff); }
    ldaAbsX(a) { return this.e(0xbd, lo(a), hi(a)); }
    ldaAbsY(a) { return this.e(0xb9, lo(a), hi(a)); }
    ldxZp(a) { return this.e(0xa6, a); }
    ldyZp(a) { return this.e(0xa4, a); }
    ldyImm(n) { return this.e(0xa0, n & 0xff); }
    staZp(a) { return this.e(0x85, a); }
    staIndY(a) { return this.e(0x91, a); }
    staAbsY(a) { return this.e(0x99, lo(a), hi(a)); }
    iny() { return this.e(0xc8); }
    clc() { return this.e(0x18); }
    adcAbsX(a) { return this.e(0x7d, lo(a), hi(a)); }
    incZp(a) { return this.e(0xe6, a); }
    cmpImm(n) { return this.e(0xc9, n & 0xff); }
    bne(target) { const r = target - (this.pc + 2); return this.e(0xd0, r & 0xff); }
    jmp(a) { return this.e(0x4c, lo(a), hi(a)); }
    rts() { return this.e(0x60); }
}

// Address of a grid cell, for a 40x32 grid over a 160x256 MODE 2 canvas:
// cell = 4 pixels x 8 rows = 2 byte-columns x 8 rows = 16 bytes, and it never
// straddles a character row because 256/32 = 8 = the character row height.
function cellAddr(col, row) {
    return SCREEN + row * 640 + (col >> 1) * 32 + (col & 1) * 16;
}

// --- the benchmarks ---------------------------------------------------------
// Each emits ONE blob's worth of work; the harness wraps it in a LOOPN loop and
// subtracts the empty-loop cost.

function emitAddr(a) {
    // PO = rowbase[row] + coloff[col]     -- the whole per-blob address setup
    a.ldxZp(COL).ldyZp(ROW);
    a.ldaAbsY(ROWLO).clc().adcAbsX(COLLO).staZp(PO);
    a.ldaAbsY(ROWHI).adcAbsX(COLHI).staZp(PO + 1);
}

// A blob is a set of contiguous 8-byte runs — one per (byte-column, character
// row) pair, because +1 is the next scanline but only within a character row.
// Each character row band therefore needs its own base pointer; within a band
// every run is reachable with an immediate Y (13 columns x 8 = 104 max).
//
// `flat` keeps one byte value for the whole blob — a dither that varies only
// *within* a byte, so every stamped byte is identical and the LDA is hoisted
// out. Otherwise the value alternates per row, costing an LDA per byte.
function emitStamp(a, cols, charRows, flat) {
    const A = 0x5a, B = 0xa5;
    for (let cr = 0; cr < charRows; cr++) {
        // P = PO + cr*640
        const off = cr * 640;
        if (cr === 0) {
            a.ldaZp(PO).staZp(P).ldaZp(PO + 1).staZp(P + 1);
        } else {
            a.ldaZp(PO).clc().adcImm(lo(off)).staZp(P);
            a.ldaZp(PO + 1).adcImm(hi(off)).staZp(P + 1);
        }
        if (flat) a.ldaImm(A);
        for (let c = 0; c < cols; c++) {
            a.ldyImm(c * 8);
            for (let i = 0; i < 8; i++) {
                if (!flat) a.ldaImm(i & 1 ? B : A);
                a.staIndY(P).iny();
            }
        }
    }
}

// Grid geometry: a blob of cell-radius rc spans (2rc+1) cells each way.
// Cell = 2 byte-columns x 8 rows, so cols = 2*(2rc+1), charRows = 2rc+1.
function shapeFor(rc) {
    const n = 2 * rc + 1;
    return { cols: 2 * n, charRows: n, bytes: 2 * n * n * 8 };
}

const BENCH = [];
BENCH.push({ name: "empty loop", emit: () => {} });
BENCH.push({ name: "address setup only", emit: (a) => emitAddr(a) });
for (const rc of [0, 1, 2, 3]) {
    const s = shapeFor(rc);
    BENCH.push({
        name: `blob rc=${rc}  ${s.cols * 2}x${s.charRows * 8}px  ${s.bytes}B flat`,
        bytes: s.bytes, runs: s.cols * s.charRows, rc,
        emit: (a) => { emitAddr(a); emitStamp(a, s.cols, s.charRows, true); },
    });
    BENCH.push({
        name: `blob rc=${rc}  ${s.cols * 2}x${s.charRows * 8}px  ${s.bytes}B dithered`,
        bytes: s.bytes, runs: s.cols * s.charRows, rc, dith: true,
        emit: (a) => { emitAddr(a); emitStamp(a, s.cols, s.charRows, false); },
    });
}

// --- harness ----------------------------------------------------------------
const session = new MachineSession(MODEL, {});
await session.initialise();
await session.boot(30);

const proc = session._machine.processor;
const cyc = () => proc.cycleSeconds * 2_000_000 + proc.currentCycles;

// Tables.
const rowlo = [], rowhi = [], collo = [], colhi = [];
for (let r = 0; r < 32; r++) { const v = SCREEN + r * 640; rowlo.push(lo(v)); rowhi.push(hi(v)); }
for (let c = 0; c < 40; c++) { const v = (c >> 1) * 32 + (c & 1) * 16; collo.push(lo(v)); colhi.push(hi(v)); }
session.writeMemory(ROWLO, rowlo);
session.writeMemory(ROWHI, rowhi);
session.writeMemory(COLLO, collo);
session.writeMemory(COLHI, colhi);
session.writeMemory(COL, [8, 4]);   // col=8 row=4: a mid-screen, aligned cell
if (process.env.NANO_DEBUG) console.error('code sizes checked at emit time');

async function timeOne(emit) {
    const a = new Asm(CODE);
    a.ldaImm(0).staZp(CNT);
    const top = a.pc;
    emit(a);
    a.incZp(CNT);
    a.ldaZp(CNT);
    a.cmpImm(LOOPN & 0xff);
    // The bodies run to ~4KB, far past a relative branch, so: beq over a jmp.
    a.e(0xf0, 0x03);        // beq +3
    a.jmp(top);
    const done = a.pc;
    a.jmp(done);
    if (a.pc >= SCREEN) throw new Error(`body too large: ends at &${a.pc.toString(16)}`);
    session.writeMemory(CODE, a.b);
    proc.pc = CODE;
    proc.s = 0xff;
    const t0 = cyc();
    await session.runUntilAddress(done, 30);
    if (session.registers().pc !== done) throw new Error("never reached done");
    return (cyc() - t0) / LOOPN;
}

const res = [];
for (const b of BENCH) res.push({ ...b, cost: await timeOne(b.emit) });
const overhead = res[0].cost;

console.log(`model ${MODEL}, ${LOOPN} iterations, empty loop ${overhead.toFixed(1)} cyc\n`);
console.log("benchmark                                    cycles   cyc/byte");
for (const r of res.slice(1)) {
    const net = r.cost - overhead;
    console.log(`${r.name.padEnd(44)}${net.toFixed(0).padStart(7)}` +
        (r.bytes ? `   ${(net / r.bytes).toFixed(2)}` : ""));
}

// Fit cycles = a + k*bytes over the flat blobs.
for (const kind of ["flat", "dithered"]) {
    const pts = res.filter((r) => r.bytes && r.name.endsWith(kind));
    const n = pts.length;
    const sx = pts.reduce((s, p) => s + p.bytes, 0);
    const sy = pts.reduce((s, p) => s + (p.cost - overhead), 0);
    const sxx = pts.reduce((s, p) => s + p.bytes * p.bytes, 0);
    const sxy = pts.reduce((s, p) => s + p.bytes * (p.cost - overhead), 0);
    const k = (n * sxy - sx * sy) / (n * sxx - sx * sx);
    const c = (sy - k * sx) / n;
    console.log(`\n${kind}: cycles ~= ${c.toFixed(0)} + ${k.toFixed(2)} * bytes`);
}
process.exit(0);
