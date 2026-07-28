#!/usr/bin/env python3
"""Per-frame render cost of a plot stream under the Rose Nano cost law.

  nanobudget.py <plots.bin> [--grid 40x32] [--stamp 4x8] [--sizes 0,1,2]

Nano's blob is byte-aligned and grid-snapped, so the renderer has no mask and no
read-modify-write. Consecutive addresses are consecutive scanlines *within a
character row* (confirmed under jsbeeb), so a blob is a set of contiguous 8-byte
runs, one per (byte-column, character row) pair:

    cycles ~= PER_BLOB + PER_BYTE * bytes

against Micro's *measured* law (rose-micro.md §10):

    cycles  = 666 + 90 * lines + 12 * bytes

Both are printed so the comparison is explicit, and both sets of constants are
measured on a real machine -- Nano's by bbc/bench/nanostamp.mjs on a Model B,
Micro's by bbc/tools/rendercost.mjs on a Master.
"""
import argparse
import numpy as np

CANVAS_W, CANVAS_H = 160, 256
# Measured on a stock Model B under jsbeeb -- bbc/bench/nanostamp.mjs.
# Flat: one byte value for the whole blob (dither varies within the byte only).
# Dithered: the value alternates per row, costing an LDA per byte.
PER_BLOB, PER_BYTE = 57.0, 8.79           # flat
PER_BLOB_D, PER_BYTE_D = 54.0, 10.86      # per-row dithered
FRAME = 40000     # 2MHz, 50Hz


def micro_cost(r):
    """Measured Micro cost for a radius-r disc in MODE 1."""
    r = np.maximum(r, 0)
    lines = 2 * r + 1
    byts = np.maximum(np.pi * r * r / 4.0, 1.0)
    return 666 + 90 * lines + 12 * byts


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("plots")
    ap.add_argument("--form", type=int, nargs=2, default=[352, 280])
    ap.add_argument("--grid", default="40x32")
    ap.add_argument("--stamp", default="4x8")
    ap.add_argument("--sizes", default="0,1,2")
    ap.add_argument("--name", default="")
    ap.add_argument("--dithered", action="store_true",
                    help="cost per-row dithered stamps instead of flat ones")
    a = ap.parse_args()

    fw, fh = a.form
    gw, gh = (int(v) for v in a.grid.lower().split("x"))
    sw, sh = (int(v) for v in a.stamp.lower().split("x"))
    sizes = np.array(sorted(int(v) for v in a.sizes.split(",")))

    p = np.fromfile(a.plots, dtype="<i2").reshape(-1, 5).astype(np.int64)
    t, r = p[:, 0], p[:, 3]

    # Blob radius in cells, snapped to the allowed size table.
    rc = np.round(r * gw / fw).astype(np.int64)
    idx = np.abs(sizes[None, :] - rc[:, None]).argmin(axis=1)
    rcq = sizes[idx]

    # A size-rc blob spans (2rc+1) cells each way; the stamp may exceed the
    # pitch, so extent is stamp + 2*rc*pitch. Bytes = width/2 * rows.
    pxw, pxh = CANVAS_W / gw, CANVAS_H / gh
    wpx = sw + 2 * rcq * pxw
    rows = sh + 2 * rcq * pxh
    byts = np.ceil(wpx / 2.0) * rows
    pb, pby = (PER_BLOB_D, PER_BYTE_D) if a.dithered else (PER_BLOB, PER_BYTE)
    nano = pb + pby * byts
    micro = micro_cost(r)

    nframes = int(t.max()) + 1
    fn = np.bincount(t, weights=nano, minlength=nframes)
    fm = np.bincount(t, weights=micro, minlength=nframes)
    live = fn > 0

    name = a.name or a.plots
    print(f"{name:22s} plots={len(p):7d} frames={nframes:5d} "
          f"grid={gw}x{gh} sizes={list(sizes)}")
    print(f"   size histogram: " +
          ", ".join(f"rc={s}:{int((rcq == s).sum())}" for s in sizes))
    for lab, f in (("Nano ", fn), ("Micro", fm)):
        q = np.percentile(f[live], [50, 95, 100]) if live.any() else [0, 0, 0]
        print(f"   {lab} cycles/frame  p50={q[0]:9,.0f}  p95={q[1]:9,.0f}  "
              f"max={q[2]:10,.0f}   frames over 50Hz budget: "
              f"{100.0 * (f > FRAME).mean():5.1f}%")
    print(f"   Nano is {fm.sum() / max(fn.sum(), 1):5.1f}x cheaper overall")


if __name__ == "__main__":
    main()
