#!/usr/bin/env python3
"""How much sideways RAM buys how much of the render bill (rose-micro.md R6).

Combines three measured things:
  * exact painter code size per (radius, x-offset), from bbc/bench/genpaint.py
  * measured cost of the generic render_blob per radius (rendercost.mjs)
  * measured cost of a precompiled painter per radius (bbc/bench)
and a demo's real radius histogram, to answer: if painters for radii 0..R are
generated into sideways RAM, how many bytes is that, what share of plots do
they cover, and what share of render time do they save?

Usage: paintbudget.py <plots.bin> [<plots.bin> ...]
"""
import math
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "bench"))
from genpaint import emit_painter, spans  # noqa: E402

import numpy as np

# render_blob, measured per radius on Everyway/JeSuisRose (rendercost.mjs).
GENERIC = {0: 514, 1: 811, 2: 1117, 3: 1434, 4: 1773, 5: 2119, 6: 2498, 7: 2847,
           8: 3183, 9: 3671, 10: 4085, 11: 4402, 12: 4857, 13: 5387, 14: 5892,
           15: 6231, 16: 6733, 20: 8772, 26: 12413, 32: 16079}

def generic_cost(r):
    if r in GENERIC:
        return GENERIC[r]
    return 666 + 90.1 * (2 * r + 1) + 12.08 * (math.pi * r * r / 4)

def painter_cost(r):
    """Fitted from the measured r=2,4,8,12 painters: 29 + 73.5*lines + 4.1*bytes."""
    b = sum(len(line) for line in spans(r, 0))
    return 29 + 73.5 * (2 * r + 1) + 4.1 * b

def painter_bytes(r):
    return sum(emit_painter(r, off, "x")[1] for off in range(4))

def load(path):
    return np.frombuffer(open(path, "rb").read(), dtype="<i2").reshape(-1, 5)

def main():
    print(f"{'r':>3} {'4 variants':>11} {'cumulative':>11}   "
          f"{'generic':>8} {'painter':>8} {'saving':>7}")
    cum = 0
    sizes, cums = {}, {}
    for r in range(0, 17):
        n = painter_bytes(r)
        cum += n
        sizes[r], cums[r] = n, cum
        print(f"{r:>3} {n:>10} B {cum:>10} B   {generic_cost(r):>8.0f} "
              f"{painter_cost(r):>8.0f} {generic_cost(r) - painter_cost(r):>7.0f}")

    for path in sys.argv[1:]:
        p = load(path)
        radii = p[:, 3].astype(int)
        tot_plots = len(radii)
        tot_time = sum(generic_cost(r) for r in radii)
        print(f"\n{os.path.basename(path)}: {tot_plots} plots, "
              f"{tot_time/1e6:.1f}M cycles of render at today's cost")
        print(f"  {'cap':>4} {'SWRAM':>9} {'plots covered':>15} {'render time saved':>19}")
        for cap in (4, 6, 8, 10, 12, 15, 16):
            covered = radii <= cap
            saved = sum(generic_cost(r) - painter_cost(r) for r in radii[covered])
            print(f"  r<={cap:<3} {cums[cap]/1024:>7.1f}K {100*covered.mean():>13.1f}% "
                  f"{100*saved/tot_time:>17.1f}%")

if __name__ == "__main__":
    main()
