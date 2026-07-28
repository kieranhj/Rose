#!/usr/bin/env node
// Experiment 5: does palette cycling do what §4.2 claims — keep a finished
// picture moving for no per-frame drawing at all?
//
// Runs a build, then screenshots the SAME unchanging screen memory at several
// frames and stitches them into a strip.  If the strip changes, the picture is
// alive; if the screen bytes also change, the demo is cheating by redrawing.
//
//   node bbc/nano/palseq.mjs cycle 260,266,272,278,284,290

import { writeFileSync } from "fs";
import path from "path";
const JSBEEB = process.env.JSBEEB_PATH ||
    "C:/Users/khcon/AppData/Local/npm-cache/_npx/e76f2a7d329553db/node_modules/jsbeeb";
const { MachineSession } = await import("file:///" + JSBEEB + "/src/machine-session.js");
const sharp = (await import("file:///" + JSBEEB.replace(/\/jsbeeb$/, "") + "/sharp/lib/index.js")).default;

const here = path.dirname(new URL(import.meta.url).pathname.replace(/^\/([A-Za-z]:)/, "$1"));
const name = process.argv[2] || "cycle";
const marks = (process.argv[3] || "260,266,272,278").split(",").map(Number);

const session = new MachineSession("B-DFS1.2", {});
await session.initialise();
await session.boot(30);
session.loadDisc(path.join(here, "build", `${name}.ssd`));
await session.type("*RUN NANO");
await session.runFor(4_000_000);

const FRLO = 0x80, FRHI = 0x81;
const frames = () => session.readMemory(FRLO, 1)[0] + 256 * session.readMemory(FRHI, 1)[0];
const readRange = (addr, len) => {
    const out = new Uint8Array(len);
    for (let i = 0; i < len; i += 256)
        out.set(session.readMemory(addr + i, Math.min(256, len - i)), i);
    return out;
};

const shots = [];
let ref = null;
for (const f of marks) {
    while (frames() < f) await session.runFor(20_000);
    const scr = readRange(0x3000, 20480);
    if (ref === null) ref = scr;
    const same = scr.every((v, i) => v === ref[i]);
    shots.push({ f, png: await session.screenshotActive({ scale: 1 }), same });
    console.log(`frame ${f}: screen bytes ${same ? "identical to the first shot" : "CHANGED"}`);
}

const metas = await Promise.all(shots.map((s) => sharp(s.png).metadata()));
const W = metas.reduce((a, m) => a + m.width, 0) + 6 * (shots.length - 1);
const H = metas[0].height;
const composites = [];
let x = 0;
for (let i = 0; i < shots.length; i++) {
    composites.push({ input: shots[i].png, left: x, top: 0 });
    x += metas[i].width + 6;
}
await sharp({ create: { width: W, height: H, channels: 3, background: { r: 40, g: 40, b: 40 } } })
    .composite(composites).png()
    .toFile(path.join(here, "build", `${name}-palseq.png`));
console.log("wrote build/" + name + "-palseq.png");
process.exit(0);
