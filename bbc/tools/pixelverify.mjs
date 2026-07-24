// ============================================================================
// pixelverify.mjs — render verification: run a Tube build to DONE, dump the
// MODE 1 shadow screen, and compare every logical pixel against a reference
// render of expected_plots.bin using the visualizer's exact semantics:
// coverage dx^2+dy^2 < (r+0.5)^2 (squares = full 2r+1 quad), plots stable-
// sorted by (t, y-r). Complements runverify.mjs (which checks the plot LOG):
// this one checks what actually reached the screen.
//
// Usage: node tools/pixelverify.mjs build/<name>-tube [maxMcycles] [W H XOFF YOFF]
//   form geometry defaults to the standard 352x280 crop (XOFF 16, YOFF 12);
//   pass e.g. "320 180 0 0" for the WIDE=2 letterbox builds.
// ============================================================================
import { readFileSync, writeFileSync, readdirSync } from "fs";
const J = "C:/Users/khcon/AppData/Local/Temp/claude/C--Users-khcon-OneDrive-Archie-Repos-Rose/32f2e656-c2a1-404f-925e-471ee4c2fc4c/scratchpad/jsbeeb";
const { MachineSession } = await import("file:///" + J + "/src/machine-session.js");

const dir = process.argv[2];
const SW = 320, SH = 256, ROWB = 640;
const W = parseInt(process.argv[4]) || 352, H = parseInt(process.argv[5]) || 280;
const XOFF = process.argv[6] !== undefined ? parseInt(process.argv[6]) : 16;
const YOFF = process.argv[7] !== undefined ? parseInt(process.argv[7]) : 12;

// reference: stable (t, y-r) order, exact shader coverage, logical = tint & 3
const data = readFileSync(dir + "/expected_plots.bin");
const n = Math.floor(data.length / 10);
const plots = [];
for (let i = 0; i < n; i++) {
    const v = new Int16Array(data.buffer, data.byteOffset + i * 10, 5);
    plots.push({ t: v[0], x: v[1], y: v[2], r: v[3], c: v[4], i });
}
plots.sort((a, b) => (a.t - b.t) || ((a.y - a.r) - (b.y - b.r)) || (a.i - b.i));
const ref = new Uint8Array(W * H);
for (const p of plots) {
    if (p.r < 0) continue;
    const sq = p.c < 0;
    const tint = (sq ? ~p.c : p.c) & 3;
    for (let dy = -p.r; dy <= p.r; dy++) {
        const yy = p.y + dy;
        if (yy < 0 || yy >= H) continue;
        let hw;
        if (sq) hw = p.r;
        else { const v = p.r * p.r + p.r - dy * dy; hw = Math.floor(Math.sqrt(v)); while (hw*hw > v) hw--; while ((hw+1)*(hw+1) <= v) hw++; }
        for (let xx = Math.max(0, p.x - hw); xx <= Math.min(W - 1, p.x + hw); xx++) ref[yy * W + xx] = tint;
    }
}

const s = new MachineSession("Master", { tube: true });
await s.initialise();
s.loadDisc(dir + "/" + readdirSync(dir).find((f) => f.endsWith(".ssd")));
s.keyDown(16); s.reset(true);
await s.runFor(2_000_000); s.keyUp(16);
const max = (parseFloat(process.argv[3]) || 4000) * 1e6;
const proc = s._machine.processor;
const cyc = () => proc.cycleSeconds * 2e6 + proc.currentCycles;
const t0 = cyc();
while (s.readMemory(0x0b86, 1)[0] !== 0xff && cyc() - t0 < max) await s.runFor(8_000_000);
console.log("done:", s.readMemory(0x0b86, 1)[0] === 0xff);

// dump shadow screen via CPU (LYNNE stays paged on the host)
const scr = [];
for (let a = 0x3000; a < 0x8000; a += 256) scr.push(...s.readMemory(a, 256));
let mism = 0, checked = 0;
const mismap = new Map();
for (let sy = 0; sy < SH; sy++) {
    for (let sx = 0; sx < SW; sx++) {
        const addr = ((sy >> 3) * ROWB) + (sy & 7) + ((sx >> 2) * 8);
        const b = scr[addr];
        const sh = 3 - (sx & 3);
        const log = (((b >> (4 + sh)) & 1) << 1) | ((b >> sh) & 1);
        const fx = sx + XOFF, fy = sy + YOFF;
        const want = fx < W && fy < H ? ref[fy * W + fx] & 3 : 0;
        checked++;
        if (log !== want) { mism++; const k = want + "->" + log; mismap.set(k, (mismap.get(k) || 0) + 1);
            if (mism <= 8) console.log("  at screen", sx, sy, "form", fx, fy, k); }
    }
}
console.log(`mismatched pixels: ${mism} / ${checked}`);
for (const [k, v] of [...mismap.entries()].sort((a, b) => b[1] - a[1]).slice(0, 6)) console.log("  ", k, v);
console.log(mism === 0 ? "PASS" : "FAIL");
s.destroy();
process.exit(mism === 0 ? 0 : 1);
