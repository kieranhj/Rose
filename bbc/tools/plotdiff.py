#!/usr/bin/env python3
"""Compare two Rose plot streams (reference vs Micro) and quantify the drift.

  plotdiff.py <ref.bin> <micro.bin> [--form W H] [--bands N]

Plots are emitted deterministically, so as long as control flow agrees the two
streams line up index-for-index and the positional delta is the drift. Where
control flow diverges (a rand- or comparison-driven branch flipping because of
quantisation) the streams desynchronise; we detect that by frame-boundary
alignment and report it rather than pretending the deltas are meaningful.
"""
import argparse
import numpy as np


def load(path):
    return np.frombuffer(open(path, "rb").read(), dtype="<i2").reshape(-1, 5)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("ref")
    ap.add_argument("micro")
    ap.add_argument("--form", type=int, nargs=2, default=[352, 280])
    ap.add_argument("--bands", type=int, default=8)
    a = ap.parse_args()

    r, m = load(a.ref), load(a.micro)
    print(f"plots: ref {len(r)}  micro {len(m)}  ({len(m)-len(r):+d})")

    # Per-frame plot counts: the coarse "did control flow survive" signal.
    nf = int(max(r[:, 0].max(), m[:, 0].max())) + 1
    cr = np.bincount(r[:, 0].astype(np.int32), minlength=nf)
    cm = np.bincount(m[:, 0].astype(np.int32), minlength=nf)
    same = cr == cm
    first_div = int(np.argmax(~same)) if not same.all() else -1
    print(f"frames with identical plot counts: {same.sum()}/{nf} "
          f"({100.0*same.sum()/nf:.1f}%)"
          + (f"; first divergence at frame {first_div}" if first_div >= 0 else ""))

    n = min(len(r), len(m))
    aligned = r[:n, 0] == m[:n, 0]
    k = int(np.argmax(~aligned)) if not aligned.all() else n
    print(f"index-aligned prefix: {k} plots "
          f"({100.0*k/max(len(r),1):.1f}% of reference)")

    if k == 0:
        return
    dx = m[:k, 1].astype(np.int32) - r[:k, 1].astype(np.int32)
    dy = m[:k, 2].astype(np.int32) - r[:k, 2].astype(np.int32)
    dr = m[:k, 3].astype(np.int32) - r[:k, 3].astype(np.int32)
    d = np.hypot(dx, dy)
    print(f"position drift over aligned prefix: mean {d.mean():.2f}px  "
          f"p50 {np.percentile(d,50):.2f}  p95 {np.percentile(d,95):.2f}  "
          f"max {d.max():.0f}px   identical {100.0*(d==0).mean():.1f}%")
    print(f"radius changed on {100.0*(dr!=0).mean():.1f}% of plots "
          f"(clamped by RMAX), max delta {abs(dr).max()}")

    # Drift vs time: is it bounded or accumulating?
    frames = r[:k, 0].astype(np.int32)
    fmax = frames.max() + 1
    print("drift by time band (mean / p95 / max px):")
    for b in range(a.bands):
        lo, hi = fmax * b // a.bands, fmax * (b + 1) // a.bands
        sel = (frames >= lo) & (frames < hi)
        if not sel.any():
            continue
        db = d[sel]
        print(f"  frames {lo:6d}-{hi:6d}: {db.mean():6.2f} / "
              f"{np.percentile(db,95):6.2f} / {db.max():5.0f}   ({sel.sum()} plots)")


if __name__ == "__main__":
    main()
