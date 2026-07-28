#!/usr/bin/env python3
"""Rose Nano compiler — .nano source to 6502 for a stock BBC Model B.

See bbc/docs/rose-nano.md.  Nano is ahead-of-time compiled (§6.4): each proc
becomes straight-line 6502 with turtle state in structure-of-arrays indexed by
X, and `wait` is a coroutine yield that saves PC.  There is no interpreter and
no dispatch.

  nanoc.py <source.nano> <out.asm>

Geometry (settled by experiment 1, §14.1):
  MODE 2, 160x256, 20480 bytes at &3000
  +1 = next scanline within a character row, +8 = next 2-pixel column
  grid 40x32; a cell is 4px x 8 rows = 16 CONTIGUOUS bytes at &3000 + row*640 + col*16
"""
import re
import sys
import math

MAXT = 48                 # turtle slots
NLOCAL = 4                # locals/params per turtle
ORG = 0x1900              # PAGE on a Model B with DFS
SCREEN = 0x3000
GW, GH = 40, 32
DIRS = 128                # move-table resolution (direction is still a byte)

# The eight BBC physical colours as 12-bit RGB.
BBC = [0x000, 0xF00, 0x0F0, 0xFF0, 0x00F, 0xF0F, 0x0FF, 0xFFF]


# --------------------------------------------------------------------- colour

def rgb24(v):
    return ((v >> 8 & 15) * 17, (v >> 4 & 15) * 17, (v & 15) * 17)


def lin(c):
    return [(x / 255.0) ** 2.2 for x in c]


def unlin(c):
    return [min(1.0, max(0.0, x)) ** (1 / 2.2) * 255.0 for x in c]


BBC_LIN = [lin(rgb24(c)) for c in BBC]
WEIGHT = (2.0, 4.0, 3.0)


def pick_pair(target12, fuse=0.02):
    """Best 50/50 pair of physical colours for a 12-bit RGB target.

    §13.4: matching on colour error alone picks pairs that do not fuse at a
    MODE 2 pixel (gold as red/green).  The separation penalty is what makes the
    result look like the target instead of like speckle.

    The coefficient does NOT transfer from §13.4's eight-level chooser.  There
    the penalty was scaled by the minority fraction, so a 1:7 dither was
    penalised eighth as hard as a 1:1 one; here every mix IS 1:1, so 0.25
    collapses every colour to a solid.  Calibrated to 0.02 against the same
    targets: 880 -> black+yellow, 08F -> blue+cyan, F80 -> red+yellow.
    """
    tgt = rgb24(target12)
    best, bestd = (0, 0), 1e18
    for a in range(8):
        for b in range(a, 8):
            mix = unlin([(BBC_LIN[a][i] + BBC_LIN[b][i]) / 2 for i in range(3)])
            d = sum((WEIGHT[i] * (mix[i] - tgt[i])) ** 2 for i in range(3))
            if a != b:
                sep = sum((WEIGHT[i] * (rgb24(BBC[a])[i] - rgb24(BBC[b])[i])) ** 2
                          for i in range(3))
                d += fuse * sep
            if d < bestd:
                bestd, best = d, (a, b)
    return best


def encode(a, b):
    """MODE 2 byte holding left pixel `a`, right pixel `b`.

    Left pixel uses bits 7,5,3,1 and right 6,4,2,0 — confirmed against the
    machine in §14.1 (a single white pixel at x=0 reads back as &2A).
    """
    v = 0
    for i in range(4):
        v |= ((a >> i) & 1) << (1 + 2 * i)
        v |= ((b >> i) & 1) << (2 * i)
    return v


# --------------------------------------------------------------------- shapes

def blob_spans(size):
    """Rows of a blob of cell-radius `size`, as (dy, dx-extent) pairs."""
    out = []
    for dy in range(-size, size + 1):
        w = 0
        for dx in range(size, -1, -1):
            if dx * dx + dy * dy <= size * size + size:
                w = dx
                break
        out.append((dy, w))
    return out


# --------------------------------------------------------------------- parser

def tokenise(s):
    return re.findall(r"[A-Za-z_]\w*|\$?\w+|[+-]", s)


KEYWORDS = {"jump", "face", "tint", "size", "move", "turn", "draw", "wait",
            "fork", "when", "else", "done", "proc", "plan", "back"}
CMP = {">": "gt", "<": "lt", ">=": "ge", "<=": "le", "=": "eq", "<>": "ne"}


class Proc:
    def __init__(self, name, params):
        self.name, self.params, self.body = name, params, []


class Parser:
    def __init__(self, text):
        self.lines = []
        for raw in text.splitlines():
            line = raw.split(";")[0].rstrip()
            if line.strip():
                self.lines.append(line)
        self.plan = {}
        self.back = 0
        self.procs = []

    def parse(self):
        i = 0
        cur = None
        while i < len(self.lines):
            line = self.lines[i]
            tok = line.split()
            head = tok[0]
            if head == "plan":
                i += 1
                while i < len(self.lines) and self.lines[i][0] in " \t":
                    for ent in self.lines[i].split():
                        k, v = ent.split(":")
                        self.plan[int(k)] = int(v, 16)
                    i += 1
                continue
            if head == "back":
                self.back = int(tok[1], 16)
            elif head == "proc":
                cur = Proc(tok[1], tok[2:])
                self.procs.append(cur)
            else:
                if cur is None:
                    raise SyntaxError(f"statement outside proc: {line}")
                cur.body.append(tok)
            i += 1
        return self


# ------------------------------------------------------------------ code gen

class Compiler:
    def __init__(self, p):
        self.p = p
        self.out = []
        self.dists = []          # distinct move distances -> tables
        self.lbl = 0
        self.procmap = {pr.name: pr for pr in p.procs}

    def e(self, s=""):
        self.out.append(s)

    def label(self, tag):
        self.lbl += 1
        return f".{tag}{self.lbl}"

    def dist_index(self, d):
        if d not in self.dists:
            if len(self.dists) >= 8:
                raise SyntaxError("more than 8 distinct move distances")
            self.dists.append(d)
        return self.dists.index(d)

    # --- expressions -------------------------------------------------------
    # v1 supports: constant, local, local+const, local-const, rand N.
    # The result lands in A.  This is deliberately the smallest grammar that
    # expresses the Rose recursion idiom (`fork self n-1`, `when n > 0`).
    def expr(self, proc, toks):
        if not toks:
            raise SyntaxError("empty expression")
        if toks[0] == "rand":
            n = int(toks[1])
            self.e("    JSR nrand")
            self.e(f"    AND #{n - 1}")
            return
        base = toks[0]
        if base in proc.params:
            self.e(f"    LDA tl{proc.params.index(base)},X")
        else:
            self.e(f"    LDA #{self.num(base)}")
        if len(toks) >= 3 and toks[1] in "+-":
            n = self.num(toks[2]) if toks[2] not in proc.params else None
            if n is None:
                raise SyntaxError("expression operand must be a constant")
            if toks[1] == "+":
                self.e("    CLC")
                self.e(f"    ADC #{n}")
            else:
                self.e("    SEC")
                self.e(f"    SBC #{n}")
        return

    @staticmethod
    def num(t):
        if t.startswith("$"):
            return int(t[1:], 16)
        if t.startswith("~"):
            return (-int(t[1:])) & 0xFF
        return int(t) & 0xFF

    def value(self, proc, tok):
        """A single term into A (no arithmetic)."""
        if tok in proc.params:
            self.e(f"    LDA tl{proc.params.index(tok)},X")
        else:
            self.e(f"    LDA #{self.num(tok)}")

    # --- statements --------------------------------------------------------
    def compile(self):
        for pr in self.p.procs:
            self.e()
            self.e(f".proc_{pr.name}")
            self.block(pr, pr.body, 0, len(pr.body))
            self.e("    JMP tdie")

    def block(self, proc, body, i, end):
        while i < end:
            i = self.stmt(proc, body, i, end)

    def stmt(self, proc, body, i, end):
        t = body[i]
        op = t[0]
        if op == "jump":
            self.e("    LDA #0 : STA txl,X : STA tyl,X")
            self.value(proc, t[1]); self.e("    STA txh,X")
            self.value(proc, t[2]); self.e("    STA tyh,X")
        elif op == "face":
            self.value(proc, t[1]); self.e("    STA tdir,X")
        elif op == "tint":
            self.value(proc, t[1]); self.e("    STA ttint,X")
        elif op == "size":
            self.value(proc, t[1]); self.e("    STA tsize,X")
        elif op == "turn":
            if t[1] == "rand":
                self.expr(proc, t[1:])
            else:
                self.value(proc, t[1])
            self.e("    CLC : ADC tdir,X : STA tdir,X")
        elif op == "move":
            k = self.dist_index(self.num(t[1]))
            self.e(f"    LDY #{k}")
            self.e("    JSR tmove")
        elif op == "draw":
            self.e("    JSR tdraw")
        elif op == "wait":
            n = self.num(t[1])
            lab = self.label("rs")
            self.e(f"    LDA #{max(1, n)} : STA twait,X")
            self.e(f"    LDA #LO({lab[1:]}) : STA tpcl,X")
            self.e(f"    LDA #HI({lab[1:]}) : STA tpch,X")
            self.e("    JMP tyield")
            self.e(lab)
        elif op == "fork":
            self.fork(proc, t)
        elif op == "when":
            return self.when(proc, body, i, end)
        else:
            raise SyntaxError(f"unknown statement: {' '.join(t)}")
        return i + 1

    def fork(self, proc, t):
        target = t[1]
        if target not in self.procmap:
            raise SyntaxError(f"fork of unknown proc {target}")
        args = t[2:]
        skip = self.label("nofork")
        self.e("    JSR talloc")
        self.e(f"    BCS {skip[1:]}")
        self.e("    JSR tclone")           # Y = child slot, copies state
        # Arguments are evaluated in the PARENT's frame, then stored into the
        # child's locals.  A is free; Y holds the child slot.
        for n, a in enumerate(args):
            if n >= NLOCAL:
                raise SyntaxError("too many fork arguments")
            self.e("    STY tsave")
            self.expr(proc, tokenise(a))
            self.e("    LDY tsave")
            self.e(f"    STA tl{n},Y")
        self.e(f"    LDA #LO(proc_{target}) : STA tpcl,Y")
        self.e(f"    LDA #HI(proc_{target}) : STA tpch,Y")
        self.e(skip)

    def when(self, proc, body, i, end):
        t = body[i]
        if len(t) < 4:
            raise SyntaxError(f"when needs <a> <op> <b>: {' '.join(t)}")
        a, opx, b = t[1], t[2], t[3]
        if opx not in CMP:
            raise SyntaxError(f"bad comparison {opx}")
        els, fin, ok = self.label("els"), self.label("fin"), self.label("ok")
        self.value(proc, a)
        if b in proc.params:
            self.e(f"    CMP tl{proc.params.index(b)},X")
        else:
            self.e(f"    CMP #{self.num(b)}")
        # Branch to `els` when the condition is FALSE (unsigned compare).
        k = CMP[opx]
        if k == "gt":
            self.e(f"    BEQ {els[1:]}")
            self.e(f"    BCC {els[1:]}")
        elif k == "ge":
            self.e(f"    BCC {els[1:]}")
        elif k == "lt":
            self.e(f"    BCS {els[1:]}")
        elif k == "le":
            self.e(f"    BCC {ok[1:]}")
            self.e(f"    BEQ {ok[1:]}")
            self.e(f"    JMP {els[1:]}")
            self.e(ok)
        elif k == "eq":
            self.e(f"    BNE {els[1:]}")
        else:
            self.e(f"    BEQ {els[1:]}")

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
        self.block(proc, body, i + 1, elsat if elsat is not None else doneat)
        self.e(f"    JMP {fin[1:]}")
        self.e(els)
        if elsat is not None:
            self.block(proc, body, elsat + 1, doneat)
        self.e(fin)
        return doneat + 1

    # --- tables ------------------------------------------------------------
    def tables(self):
        e = self.e
        e()
        e("; ---- move tables: (direction >> 1) -> delta, per distinct distance")
        e("; dx is halved because MODE 2 pixels are 2:1, so motion stays isotropic")
        for k, d in enumerate(self.dists):
            for axis in "xy":
                for half in ("lo", "hi"):
                    vals = []
                    for i in range(DIRS):
                        ang = 2 * math.pi * i / DIRS
                        v = (math.cos(ang) * d * 256 / 2 if axis == "x"
                             else math.sin(ang) * d * 256)
                        v = int(round(v)) & 0xFFFF
                        vals.append(v & 0xFF if half == "lo" else v >> 8)
                    e(f".d{axis}{half}{k}")
                    for n in range(0, DIRS, 16):
                        e("    EQUB " + ",".join(str(x) for x in vals[n:n + 16]))
        e()
        e(".dxlotab")
        e("    EQUB " + ",".join(f"LO(dxlo{k})" for k in range(len(self.dists))))
        e(".dxhitab")
        e("    EQUB " + ",".join(f"HI(dxlo{k})" for k in range(len(self.dists))))
        # Table-of-tables for each of the four arrays.
        for nm in ("dxlo", "dxhi", "dylo", "dyhi"):
            e(f".{nm}_l")
            e("    EQUB " + ",".join(f"LO({nm}{k})" for k in range(len(self.dists))))
            e(f".{nm}_h")
            e("    EQUB " + ",".join(f"HI({nm}{k})" for k in range(len(self.dists))))

        e()
        e("; ---- screen row bases: &3000 + row*640")
        e(".rowlo")
        e("    EQUB " + ",".join(str((SCREEN + r * 640) & 0xFF) for r in range(GH)))
        e(".rowhi")
        e("    EQUB " + ",".join(str((SCREEN + r * 640) >> 8) for r in range(GH)))

        e()
        e("; ---- blob shapes: per size, a run of (dy, dx-extent) rows")
        offs, dys, dxs = [], [], []
        for s in range(4):
            offs.append(len(dys))
            for dy, dx in blob_spans(s):
                dys.append(dy & 0xFF)
                dxs.append(dx)
        e(".spanofs")
        e("    EQUB " + ",".join(str(v) for v in offs))
        e(".spancnt")
        e("    EQUB " + ",".join(str(2 * s + 1) for s in range(4)))
        e(".spandy")
        e("    EQUB " + ",".join(str(v) for v in dys))
        e(".spandx")
        e("    EQUB " + ",".join(str(v) for v in dxs))

        e()
        e("; ---- tint -> the two MODE 2 bytes of its 50/50 dither pair")
        pa, pb = [], []
        for t in range(8):
            rgb = self.p.plan.get(t, 0)
            a, b = pick_pair(rgb)
            pa.append(encode(a, b))
            pb.append(encode(b, a))
        e(".pata")
        e("    EQUB " + ",".join(str(v) for v in pa))
        e(".patb")
        e("    EQUB " + ",".join(str(v) for v in pb))
        bg = pick_pair(self.p.back)
        e(f"BACKA = {encode(*bg)}")
        e(f"BACKB = {encode(bg[1], bg[0])}")

    def arrays(self):
        e = self.e
        e()
        e("; ---- turtle state, structure of arrays (§6.1)")
        for nm in ("txl", "txh", "tyl", "tyh", "tdir", "ttint", "tsize",
                   "twait", "tpcl", "tpch", "talive"):
            e(f".{nm}  SKIP {MAXT}")
        for n in range(NLOCAL):
            e(f".tl{n}  SKIP {MAXT}")


def main():
    src, out = sys.argv[1], sys.argv[2]
    p = Parser(open(src).read()).parse()
    c = Compiler(p)
    c.compile()
    body = list(c.out)
    c.out = []
    c.tables()
    tables = list(c.out)
    c.out = []
    c.arrays()
    arrays = list(c.out)

    runtime = open(__file__.replace("nanoc.py", "runtime.asm")).read()
    runtime = runtime.replace("@@ENTRY@@", f"proc_{p.procs[0].name}")
    with open(out, "w") as f:
        f.write(f"; generated by nanoc.py from {src}\n")
        f.write(f"MAXT = {MAXT}\nNDIST = {len(c.dists)}\n")
        f.write(f"ORGADDR = &{ORG:04X}\nSCREEN = &{SCREEN:04X}\n")
        f.write(runtime.replace("; @@PROCS@@", "\n".join(body))
                       .replace("; @@TABLES@@", "\n".join(tables))
                       .replace("; @@ARRAYS@@", "\n".join(arrays)))
    print(f"{src}: {len(p.procs)} procs, {len(c.dists)} move distances, "
          f"{len(p.plan)} tints")


if __name__ == "__main__":
    main()
