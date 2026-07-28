#!/usr/bin/env python3
"""Exact painter code size for circles AND squares, radii 0..12 (rose-micro.md D3d).

genpaint.py only generates circles. A square blob is the same generator with a
constant half-width, so we swap the span function and reuse emit_painter, which
resolves `spans` at module level.
"""
import math
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "bench"))
import genpaint

circle_spans = genpaint.spans


def square_spans(r, off):
    """Every line is the full width: half-width = r for all dy."""
    out = []
    for dy in range(-r, r + 1):
        lo, hi = off - r, off + r
        k0, k1 = math.floor(lo / 4), math.floor(hi / 4)
        line = []
        for k in range(k0, k1 + 1):
            first = max(lo, 4 * k) - 4 * k
            last = min(hi, 4 * k + 3) - 4 * k
            line.append((k, first, last))
        out.append(line)
    return out


def painter_bytes(r, spanfn):
    genpaint.spans = spanfn
    try:
        return sum(genpaint.emit_painter(r, off, "x")[1] for off in range(4))
    finally:
        genpaint.spans = circle_spans


def stored_bytes(r, spanfn):
    return sum(len(line) for line in spanfn(r, 0))


def painter_cost(r, spanfn):
    """§10.2's fitted painter law: 29 + 73.5*lines + 4.1*bytes."""
    return 29 + 73.5 * (2 * r + 1) + 4.1 * stored_bytes(r, spanfn)


RMAX = 12

print(f"{'r':>3} | {'circle 4off':>11} {'cum':>7} | {'square 4off':>11} {'cum':>7} |"
      f" {'sq/ci':>6} | {'ci cyc':>7} {'sq cyc':>7}")
print("-" * 82)
cc = cs = 0
rows = []
for r in range(0, RMAX + 1):
    bc = painter_bytes(r, circle_spans)
    bs = painter_bytes(r, square_spans)
    cc += bc
    cs += bs
    rows.append((r, bc, cc, bs, cs))
    print(f"{r:>3} | {bc:>11,} {cc:>7,} | {bs:>11,} {cs:>7,} |"
          f" {bs / bc:>6.2f} | {painter_cost(r, circle_spans):>7,.0f}"
          f" {painter_cost(r, square_spans):>7,.0f}")

print()
print(f"circles r0..{RMAX}, all 4 offsets : {cc:>7,} B  = {cc/1024:6.1f} KB")
print(f"squares r0..{RMAX}, all 4 offsets : {cs:>7,} B  = {cs/1024:6.1f} KB")
print(f"both                              : {cc+cs:>7,} B  = {(cc+cs)/1024:6.1f} KB"
      f"  = {(cc+cs)/16384:.2f} banks of 16KB")
print(f"square/circle ratio               : {cs/cc:.3f}   (4/pi = {4/math.pi:.3f})")

print()
print("Cumulative totals at other ceilings (both shapes, all 4 offsets):")
print(f"{'ceiling':>7} {'circles':>9} {'squares':>9} {'both':>9} {'KB':>7} {'banks':>6}")
for r, bc, cumc, bs, cums in rows:
    tot = cumc + cums
    print(f"{r:>7} {cumc:>9,} {cums:>9,} {tot:>9,} {tot/1024:>7.1f} {tot/16384:>6.2f}")
