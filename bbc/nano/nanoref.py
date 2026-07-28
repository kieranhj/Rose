#!/usr/bin/env python3
"""Reference model for Rose Nano — the verification half of the toolchain.

rose-nano.md §9 calls the port's bit-exact + pixel-perfect harness "the port's
superpower" and says Nano cannot inherit it directly but must build its own.
This is it: a Python implementation of the same semantics, rendering to a
20480-byte MODE 2 buffer that is compared byte-for-byte against the screen RAM
dumped out of jsbeeb by run.mjs.

  nanoref.py <source.nano> <frames> [--out screen.bin] [--png out.png]
  nanoref.py <source.nano> <frames> --check <emulator-screen.bin>

Everything here mirrors runtime.asm deliberately, including the things that are
not obviously right (128-direction tables, toroidal wrap, allocation scanning
from slot 0), because the point is to catch divergence, not to be elegant.
"""
import os
import sys
import math

sys.path.insert(0, __file__.rsplit("/", 1)[0].rsplit("\\", 1)[0])
from nanoc import (Parser, Compiler, MAXT, NLOCAL, DIRS, GW, GH, SCREEN,
                   blob_spans, pick_pair, encode, tokenise, CMP)

CANVAS = 20480


# --------------------------------------------------------------- flattening
# The compiler turns `when` into compare + branch; the reference must take the
# same path, so it flattens to the same shape rather than walking the tree.

def flatten(proc):
    ops = []

    def block(body, i, end):
        while i < end:
            t = body[i]
            if t[0] == "when":
                depth, j, elsat = 0, i + 1, None
                while j < end:
                    h = body[j][0]
                    if h == "when":
                        depth += 1
                    elif h == "done":
                        if depth == 0:
                            break
                        depth -= 1
                    elif h == "else" and depth == 0:
                        elsat = j
                    j += 1
                doneat = j
                brk = len(ops)
                ops.append(["br", t[1], t[2], t[3], None])
                block(body, i + 1, elsat if elsat is not None else doneat)
                jmp = len(ops)
                ops.append(["jmp", None])
                ops[brk][4] = len(ops)
                if elsat is not None:
                    block(body, elsat + 1, doneat)
                ops[jmp][1] = len(ops)
                i = doneat + 1
            else:
                ops.append(t)
                i += 1

    block(proc.body, 0, len(proc.body))
    ops.append(["die"])
    return ops


class Turtle:
    __slots__ = ("alive", "xl", "xh", "yl", "yh", "dir", "tint", "size",
                 "wait", "pc", "proc", "loc")

    def __init__(self):
        self.alive = 0
        self.xl = self.xh = self.yl = self.yh = 0
        self.dir = self.tint = self.size = self.wait = 0
        self.pc = 0
        self.proc = None
        self.loc = [0] * NLOCAL


class Machine:
    def __init__(self, src):
        self.p = Parser(open(src).read()).parse()
        c = Compiler(self.p)
        c.compile()                      # only to collect move distances
        self.dists = c.dists
        self.code = {pr.name: flatten(pr) for pr in self.p.procs}
        self.params = {pr.name: pr.params for pr in self.p.procs}
        self.entry = self.p.procs[0].name

        # Move tables, generated exactly as nanoc emits them.
        self.dx, self.dy = [], []
        for d in self.dists:
            dx, dy = [], []
            for i in range(DIRS):
                a = 2 * math.pi * i / DIRS
                dx.append(int(round(math.cos(a) * d * 256 / 2)) & 0xFFFF)
                dy.append(int(round(math.sin(a) * d * 256)) & 0xFFFF)
            self.dx.append(dx)
            self.dy.append(dy)

        self.pata, self.patb = [], []
        for t in range(8):
            a, b = pick_pair(self.p.plan.get(t, 0))
            self.pata.append(encode(a, b))
            self.patb.append(encode(b, a))
        bg = pick_pair(self.p.back)
        self.backa, self.backb = encode(*bg), encode(bg[1], bg[0])

        self.spans = [blob_spans(s) for s in range(4)]
        self.rnd = 1

        self.scr = bytearray(CANVAS)
        for i in range(CANVAS):
            self.scr[i] = self.backa if (i & 1) == 0 else self.backb

        self.t = [Turtle() for _ in range(MAXT)]
        t0 = self.t[0]
        t0.alive, t0.xh, t0.yh, t0.tint, t0.size = 1, 80, 128, 1, 0
        t0.proc, t0.pc = self.entry, 0

    # --- primitives mirroring the runtime ---------------------------------
    def nrand(self):
        a = (self.rnd << 1) & 0xFF
        if self.rnd & 0x80:
            a ^= 0x1D
        self.rnd = a
        return a

    def value(self, t, tok):
        ps = self.params[t.proc]
        if tok in ps:
            return t.loc[ps.index(tok)]
        return Compiler.num(tok)

    def expr(self, t, toks):
        if toks[0] == "rand":
            return self.nrand() & (int(toks[1]) - 1)
        v = self.value(t, toks[0])
        if len(toks) >= 3 and toks[1] in "+-":
            n = Compiler.num(toks[2])
            v = (v + n) & 0xFF if toks[1] == "+" else (v - n) & 0xFF
        return v

    def move(self, t, k):
        i = t.dir >> 1
        dx, dy = self.dx[k][i], self.dy[k][i]
        x = ((t.xh << 8) | t.xl) + dx
        y = ((t.yh << 8) | t.yl) + dy
        t.xl, t.xh = x & 0xFF, (x >> 8) & 0xFF
        t.yl, t.yh = y & 0xFF, (y >> 8) & 0xFF
        if t.xh >= 160:
            t.xh = (t.xh + 160) & 0xFF if t.xh >= 208 else t.xh - 160

    def draw(self, t):
        pa, pb = self.pata[t.tint & 7], self.patb[t.tint & 7]
        col, row = t.xh >> 2, t.yh >> 3
        for dy, dxe in self.spans[t.size & 3]:
            r = (row + dy) & 31
            base = r * 640
            c0 = max(0, col - dxe)
            c1 = min(GW - 1, col + dxe)
            for c in range(c0, c1 + 1):
                p = base + c * 16
                for i in range(16):
                    self.scr[p + i] = pa if (i & 1) == 0 else pb

    def alloc(self):
        for i in range(MAXT):
            if not self.t[i].alive:
                return i
        return None

    # --- the scheduler ----------------------------------------------------
    def frame(self):
        for xi in range(MAXT):
            t = self.t[xi]
            if not t.alive:
                continue
            if t.wait:
                t.wait -= 1
                continue
            self.run(t, xi)

    def run(self, t, xi):
        ops = self.code[t.proc]
        while True:
            op = ops[t.pc]
            k = op[0]
            t.pc += 1
            if k == "draw":
                self.draw(t)
            elif k == "move":
                self.move(t, self.dists.index(Compiler.num(op[1])))
            elif k == "turn":
                v = (self.expr(t, op[1:]) if op[1] == "rand"
                     else self.value(t, op[1]))
                t.dir = (t.dir + v) & 0xFF
            elif k == "tint":
                t.tint = self.value(t, op[1])
            elif k == "size":
                t.size = self.value(t, op[1])
            elif k == "face":
                t.dir = self.value(t, op[1])
            elif k == "jump":
                t.xl = t.yl = 0
                t.xh = self.value(t, op[1])
                t.yh = self.value(t, op[2])
            elif k == "wait":
                t.wait = max(1, Compiler.num(op[1]))
                return
            elif k == "fork":
                self.fork(t, op)
            elif k == "br":
                a = self.value(t, op[1])
                b = self.value(t, op[3])
                c = CMP[op[2]]
                ok = {"gt": a > b, "ge": a >= b, "lt": a < b,
                      "le": a <= b, "eq": a == b, "ne": a != b}[c]
                if not ok:
                    t.pc = op[4]
            elif k == "jmp":
                t.pc = op[1]
            elif k == "die":
                t.alive = 0
                return
            else:
                raise SyntaxError(f"reference: unknown op {k}")

    def fork(self, t, op):
        slot = self.alloc()
        if slot is None:
            return
        ch = self.t[slot]
        ch.xl, ch.xh, ch.yl, ch.yh = t.xl, t.xh, t.yl, t.yh
        ch.dir, ch.tint, ch.size = t.dir, t.tint, t.size
        ch.loc = list(t.loc)
        ch.wait, ch.alive = 0, 1
        for n, a in enumerate(op[2:]):
            ch.loc[n] = self.expr(t, tokenise(a))
        ch.proc, ch.pc = op[1], 0


def to_png(scr, path):
    from PIL import Image
    import numpy as np
    BBC = [(0, 0, 0), (255, 0, 0), (0, 255, 0), (255, 255, 0),
           (0, 0, 255), (255, 0, 255), (0, 255, 255), (255, 255, 255)]
    img = np.zeros((256, 160, 3), dtype=np.uint8)
    for a in range(CANVAS):
        b = scr[a]
        cell = a // 16
        row_c, col = divmod(cell, GW)
        i = a & 15
        y = row_c * 8 + (i & 7)
        x = col * 4 + (i >> 3) * 2
        left = ((b >> 1) & 1) | ((b >> 2) & 2) | ((b >> 3) & 4) | ((b >> 4) & 8)
        right = (b & 1) | ((b >> 1) & 2) | ((b >> 2) & 4) | ((b >> 3) & 8)
        img[y, x] = BBC[left & 7]
        img[y, x + 1] = BBC[right & 7]
    Image.fromarray(img).resize((640, 512), Image.NEAREST).save(path)


def sheet(src, marks, path, scale=2):
    """Render several frames of a program side by side, without the emulator.

    This is the Nano equivalent of the visualizer: the reference model is
    already a complete implementation of the language, so previewing a program
    costs a few seconds of Python rather than a build-and-boot cycle.
    """
    from PIL import Image, ImageDraw
    m = Machine(src)
    imgs, at = [], 0
    for f in marks:
        while at < f:
            m.frame()
            at += 1
        tmp = f"__sheet{f}.png"
        to_png(m.scr, tmp)
        im = Image.open(tmp).copy()
        os.remove(tmp)
        bar = Image.new("RGB", (im.width, im.height + 16), (16, 16, 16))
        bar.paste(im, (0, 16))
        ImageDraw.Draw(bar).text((4, 3), f"frame {f}", fill=(200, 200, 200))
        imgs.append(bar)
    gap = 6
    W = sum(i.width for i in imgs) + gap * (len(imgs) - 1)
    out = Image.new("RGB", (W, imgs[0].height), (40, 40, 40))
    x = 0
    for i in imgs:
        out.paste(i, (x, 0))
        x += i.width + gap
    out.save(path)
    print("wrote", path)


def main():
    if "--sheet" in sys.argv:
        i = sys.argv.index("--sheet")
        sheet(sys.argv[1], [int(v) for v in sys.argv[i + 1].split(",")],
              sys.argv[i + 2])
        return
    src, frames = sys.argv[1], int(sys.argv[2])
    m = Machine(src)
    for _ in range(frames):
        m.frame()
    args = sys.argv[3:]
    if "--out" in args:
        open(args[args.index("--out") + 1], "wb").write(bytes(m.scr))
    if "--png" in args:
        to_png(m.scr, args[args.index("--png") + 1])
    if "--check" in args:
        have = open(args[args.index("--check") + 1], "rb").read()
        bad = sum(1 for i in range(CANVAS) if have[i] != m.scr[i])
        if bad:
            first = next(i for i in range(CANVAS) if have[i] != m.scr[i])
            print(f"*** {bad}/{CANVAS} bytes differ (first at &{SCREEN + first:04X}: "
                  f"machine {have[first]:02X}, model {m.scr[first]:02X})")
            sys.exit(1)
        print(f"screen matches the model exactly ({CANVAS} bytes)")
    live = sum(1 for t in m.t if t.alive)
    print(f"{src}: {frames} frames, {live} turtles still live")


if __name__ == "__main__":
    main()
