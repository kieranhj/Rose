#!/usr/bin/env python3
"""Painter cycle cost from first principles, validated against §10.2's measured
circle points, then applied to squares.

§10.2 measured (including ~110 cyc realistic per-blob setup):
    r=2 408, r=4 649, r=8 1387, r=12 2324
"""
import math
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "bench"))
import genpaint

circle_spans = genpaint.spans


def square_spans(r, off):
    out = []
    for dy in range(-r, r + 1):
        lo, hi = off - r, off + r
        k0, k1 = math.floor(lo / 4), math.floor(hi / 4)
        out.append([(k, max(lo, 4 * k) - 4 * k, min(hi, 4 * k + 3) - 4 * k)
                    for k in range(k0, k1 + 1)])
    return out


# 65C12 cycle counts for the instructions genpaint emits.
C_LDY_IMM = 2
C_LDA_IND_Y = 5     # lda (dst),y
C_STA_IND_Y = 6     # sta (dst),y  (no page-cross penalty on store)
C_AND_IMM = 2
C_ORA_ZP = 3
C_LDA_ZP = 3        # lda FILL
# §10.4's "jsr nextline is 12 of the 73.5 cyc/line" counts the jsr only. The
# residual against the four measured circles is 16.0/15.3/16.8/16.8 cycles per
# line transition — near-constant, i.e. nextline's BODY. One fitted constant.
C_JSR_NEXTLINE = 12 + 16
C_RTS = 6
SETUP = 110         # §10.2's realistic per-blob setup


def cost(r, spanfn, setup=SETUP):
    lines = spanfn(r, 0)
    total = setup + C_RTS
    for i, line in enumerate(lines):
        full = [s for s in line if s[1] == 0 and s[2] == 3]
        part = [s for s in line if not (s[1] == 0 and s[2] == 3)]
        for _ in part:
            total += C_LDY_IMM + C_LDA_IND_Y + C_AND_IMM + C_ORA_ZP + C_STA_IND_Y
        if full:
            total += C_LDA_ZP
            total += len(full) * (C_LDY_IMM + C_STA_IND_Y)
        if i != len(lines) - 1:
            total += C_JSR_NEXTLINE
    return total


MEASURED = {2: 408, 4: 649, 8: 1387, 12: 2324}
print("Validating the instruction-level model against §10.2's measured circles:")
print(f"{'r':>3} {'measured':>9} {'model':>8} {'err':>7}")
for r, m in sorted(MEASURED.items()):
    c = cost(r, circle_spans)
    print(f"{r:>3} {m:>9,} {c:>8,.0f} {(c - m) / m:>6.1%}")

# Generic render_blob, measured (paintbudget.py's table / §11.3's square law).
GENERIC_CIRCLE = {0: 514, 1: 811, 2: 1117, 3: 1434, 4: 1773, 5: 2119, 6: 2498,
                  7: 2847, 8: 3183, 9: 3671, 10: 4085, 11: 4402, 12: 4857}


def generic_square(r):
    """§11.3: square 261 + 86.9*lines + 7.62*bytes, bytes = lines^2/4."""
    lines = 2 * r + 1
    return 261 + 86.9 * lines + 7.62 * (lines * lines / 4)


print()
print("Painter vs generic path, per blob:")
print(f"{'r':>3} | {'circle gen':>10} {'circle pnt':>10} {'x':>5} |"
      f" {'square gen':>10} {'square pnt':>10} {'x':>5}")
print("-" * 74)
for r in range(0, 13):
    gc = GENERIC_CIRCLE[r]
    pc = cost(r, circle_spans)
    gs = generic_square(r)
    ps = cost(r, square_spans)
    print(f"{r:>3} | {gc:>10,} {pc:>10,.0f} {gc/pc:>5.2f} |"
          f" {gs:>10,.0f} {ps:>10,.0f} {gs/ps:>5.2f}")

print()
print("Blobs per 40,000-cycle field (render only, painter path):")
for r in (2, 4, 6, 8, 12):
    print(f"  r={r:<2}  circle {40000/cost(r, circle_spans):>5.1f}   "
          f"square {40000/cost(r, square_spans):>5.1f}")
