#!/usr/bin/env python3
"""Generate precompiled brush painters (rose-micro.md R6) and their benchmark.

For a given radius and x-offset, emits straight-line 6502 that paints the whole
blob: every span's byte count, left/right edge masks and column offsets are
resolved at generation time, so the runtime does no per-line setup at all —
only the vertical address walk, which cannot be baked because a blob's phase
within the MODE 1 character row is not known until it is drawn.

Calling convention (a blob is one `jsr`):
    dst   (zp,2) address of the TOP line's centre byte, minus the Y bias (128)
    TM    (zp)   scanlines left in the current character row (1..8)
    FILL  (zp)   the 4-pixel fill byte for this tint
    MF0..9(zp)   FILL masked by each of the 10 possible in-byte pixel runs
                 (recomputed only when the tint changes, not per blob)

Writes paint.asm, bench.json (benchmark manifest) and expect.bin (the buffer
the validation blob must produce).
"""
import json
import math
import os
import sys

ROWB = 640          # MODE 1 bytes per character row
YBIAS = 128         # Y indexes +-15 bytes either side of the centre column

# MODE 1: pixel p of a byte uses bits (7-p) and (3-p).
def pixmask(p):
    return (0x88 >> p) & 0xFF

def runmask(first, last):
    m = 0
    for p in range(first, last + 1):
        m |= pixmask(p)
    return m

# The 10 possible contiguous pixel runs inside a byte, in a fixed order so the
# generated code can index MF0..MF9.
RUNS = [(f, l) for f in range(4) for l in range(f, 4)]
RUN_INDEX = {r: i for i, r in enumerate(RUNS)}
assert len(RUNS) == 10

def halfwidth(r, dy):
    """The engine's coverage rule: dx^2+dy^2 < (r+0.5)^2 -> isqrt(r^2+r-dy^2)."""
    v = r * r + r - dy * dy
    return math.isqrt(v) if v >= 0 else -1

def spans(r, off):
    """Per line, the list of (byte index k, first pixel, last pixel)."""
    out = []
    for dy in range(-r, r + 1):
        hw = halfwidth(r, dy)
        lo, hi = off - hw, off + hw          # pixel columns relative to centre byte's pixel 0
        k0, k1 = math.floor(lo / 4), math.floor(hi / 4)
        line = []
        for k in range(k0, k1 + 1):
            first = max(lo, 4 * k) - 4 * k
            last = min(hi, 4 * k + 3) - 4 * k
            line.append((k, first, last))
        out.append(line)
    return out

def emit_painter(r, off, name):
    """Return (asm text, code size in bytes)."""
    L = []
    size = [0]
    def ins(text, n):
        L.append("    " + text)
        size[0] += n

    lines = spans(r, off)
    for i, line in enumerate(lines):
        a_is_fill = False
        # left edge, then interiors (which need A = FILL), then right edge
        full = [s for s in line if s[1] == 0 and s[2] == 3]
        part = [s for s in line if not (s[1] == 0 and s[2] == 3)]
        for (k, f, l) in part[:1]:
            ins(f"ldy #{YBIAS + 8 * k}", 2)
            ins("lda (dst),y", 2)
            ins(f"and #{(~runmask(f, l)) & 0xFF}", 2)
            ins(f"ora MF{RUN_INDEX[(f, l)]}", 2)
            ins("sta (dst),y", 2)
        if full:
            ins("lda FILL", 2)
            for (k, f, l) in full:
                ins(f"ldy #{YBIAS + 8 * k}", 2)
                ins("sta (dst),y", 2)
        for (k, f, l) in part[1:]:
            ins(f"ldy #{YBIAS + 8 * k}", 2)
            ins("lda (dst),y", 2)
            ins(f"and #{(~runmask(f, l)) & 0xFF}", 2)
            ins(f"ora MF{RUN_INDEX[(f, l)]}", 2)
            ins("sta (dst),y", 2)
        if i != len(lines) - 1:
            L.append(f"    jsr nextline        ; line {i - r}")
            size[0] += 3
    L.append("    rts")
    size[0] += 1
    return f".{name}\n" + "\n".join(L) + "\n", size[0]

def main():
    radii = [int(x) for x in (sys.argv[1:] or ["2", "4", "8", "12"])]
    here = os.path.dirname(os.path.abspath(__file__))
    painters, bench, sizes = [], [], {}
    for r in radii:
        for off in (0, 1):
            name = f"paint_r{r}_o{off}"
            asm, n = emit_painter(r, off, name)
            painters.append(asm)
            sizes[name] = n
            bench.append({"label": f"bs_{name}", "name": f"blob r={r} off={off}",
                          "called": True, "bytes": n})

    # Validation: paint r=8 off=1 once into a cleared buffer and compare.
    VR, VOFF = 8, 1
    VX, VY = 33, 21           # centre x, top line y of the validation blob
    BUFN = 4096
    buf = bytearray(BUFN)
    # The emulator's blob starts at buffer offset VBASE with TM lines left in
    # the current character row; replicate that walk exactly.
    addr = (VY >> 3) * ROWB + (VY & 7) + (VX >> 2) * 8
    tm = 8 - (VY & 7)
    fill = 0x55                                  # tint 1 (bit0 of each pixel)
    for line in spans(VR, VOFF):
        for (k, f, l) in line:
            m = runmask(f, l)
            i = addr + 8 * k
            buf[i] = (buf[i] & (~m & 0xFF)) | (fill & m)
        tm -= 1
        addr += 1
        if tm == 0:
            addr += ROWB - 8
            tm = 8
    open(os.path.join(here, "expect.bin"), "wb").write(bytes(buf))

    with open(os.path.join(here, "paint.inc.asm"), "w") as f:
        f.write("; generated by genpaint.py — do not edit\n")
        f.write(f"VR = {VR}\nVOFF = {VOFF}\nVX = {VX}\nVY = {VY}\nBUFN = {BUFN}\n\n")
        # Benchmark loops first: the harness falls through them in address
        # order, so the painters themselves must sit past .bs_end.
        for b in bench:
            lbl = b["label"]
            fn = lbl[3:]
            f.write(f""".{lbl}
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_{fn}
    phy
    phx
    jsr setup_blob
    jsr {fn}
    plx
    ply
    dex
    bne l_{fn}
    dey
    bne l_{fn}

""")
        f.write(".bs_end\n    jmp bs_end\n\n")
        f.write(f".paint_validate\n    jmp paint_r{VR}_o{VOFF}\n\n")
        for a in painters:
            f.write(a + "\n")
        for b in bench:
            f.write(f'PRINT "SYM {b["label"]}", ~{b["label"]}\n')
        f.write('PRINT "SYM bs_end", ~bs_end\n')
        f.write('PRINT "SYM paint_validate", ~paint_validate\n')

    manifest = {"ssd": "paint.ssd", "loopn": 2048,
                "bench": [{"label": "bs_empty", "name": "empty loop", "called": False},
                          {"label": "bs_scaffold", "name": "call scaffold (jsr/rts only)",
                           "called": False}] + bench,
                "sizes": sizes,
                "validate": {"expect": "expect.bin", "buffer_sym": "buffer", "len": BUFN}}
    json.dump(manifest, open(os.path.join(here, "bench.json"), "w"), indent=1)
    total = sum(sizes.values())
    print("generated painters:", ", ".join(f"{k}={v}B" for k, v in sizes.items()))
    print(f"total {total} bytes")

if __name__ == "__main__":
    main()
