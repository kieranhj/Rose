#!/usr/bin/env python3
"""Render a Rose plot stream under Rose Nano rules (see bbc/docs/rose-nano.md §3-§4).

Experiment 3: does a fixed-size, byte-aligned, dithered blob on a coarse grid
still look like Rose?

Nano rules applied here:
  * radius is discarded  -- every plot paints one fixed stamp (§3)
  * position is snapped to a grid cell (§3.2)
  * colour is 8 physical BBC colours, dithered in pairs inside the stamp (§4.1)
  * no layers, no blending: a stamp overwrites (§3.1)
  * trails persist: everything with t <= frame is on screen (§1.5 of the port)

Grid pitch and stamp size are independent. The byte-alignment law only requires
that the stamp's *width* and *x position* be whole bytes (2 MODE 2 pixels), so a
4x8 stamp can sit on an 80x64 position grid.

  nanorender.py <plots.bin> <out.png> --frame N [--grid 80x64] [--stamp 2x4]
                [--form W H] [--cs FILE] [--steps 4] [--radius] [--stats]

Output is a 160x256 MODE 2 canvas written at 320x256 so the 2:1 pixels have
their real aspect.
"""
import argparse
import struct
import sys

import numpy as np
from PIL import Image, ImageDraw

CANVAS_W, CANVAS_H = 160, 256

# The BBC's eight physical colours, as 12-bit RGB.
BBC = [0x000, 0xF00, 0x0F0, 0xFF0, 0x00F, 0xF0F, 0x0FF, 0xFFF]
BBC_NAME = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]


def rgb24(v):
    r, g, b = (v >> 8) & 0xF, (v >> 4) & 0xF, v & 0xF
    return (r * 17, g * 17, b * 17)


def load_plots(path):
    with open(path, "rb") as f:
        return np.frombuffer(f.read(), dtype="<i2").reshape(-1, 5)


def load_colorscript(path):
    try:
        with open(path, "rb") as f:
            raw = f.read()
    except OSError:
        return np.zeros((0, 3), dtype="<i2")
    return np.frombuffer(raw, dtype="<i2").reshape(-1, 3)


def palette_at(cs, frame, ntints=256):
    pal = [0] * ntints
    for t, i, rgb in cs:
        if t > frame:
            break
        if 0 <= i < ntints:
            pal[i] = int(rgb) & 0xFFF
    return pal


# ---------------------------------------------------------------- dithering

def bayer(w, h):
    """Rank order 0..w*h-1 over a w x h cell, dispersed, tiling cleanly."""
    n = 1
    while n < max(w, h):
        n *= 2
    m = np.zeros((1, 1), dtype=np.int64)
    k = 1
    while k < n:
        m = np.block([[4 * m, 4 * m + 2], [4 * m + 3, 4 * m + 1]])
        k *= 2
    sub = m[:h, :w]
    order = np.argsort(sub, axis=None, kind="stable")
    rank = np.empty(w * h, dtype=np.int64)
    rank[order] = np.arange(w * h)
    return rank.reshape(h, w)


def srgb_to_lin(c):
    return (np.asarray(c, dtype=float) / 255.0) ** 2.2


def lin_to_srgb(c):
    return np.clip(c, 0, 1) ** (1 / 2.2) * 255.0


BBC_LIN = np.array([srgb_to_lin(rgb24(c)) for c in BBC])
WEIGHT = np.array([2.0, 4.0, 3.0])


def dither_for(target12, steps, npix, fuse=0.0):
    """Best (colour_a, colour_b, level) approximating a 12-bit RGB target.

    level counts how many of the stamp's npix pixels take colour_b; only
    multiples of npix/steps are allowed, so steps=4 means solids plus 1:3,
    1:1 and 3:1 -- the mixes §4.1 claims.
    """
    tgt = np.array(rgb24(target12), dtype=float)
    srgb = [np.array(rgb24(c), dtype=float) for c in BBC]
    levels = [round(i * npix / steps) for i in range(steps + 1)]
    best, bestd = (0, 0, 0), 1e18
    for a in range(8):
        for b in range(8):
            for lv in levels:
                f = lv / npix
                mix = lin_to_srgb(BBC_LIN[a] * (1 - f) + BBC_LIN[b] * f)
                d = float((((mix - tgt) * WEIGHT) ** 2).sum())
                # Fusion penalty: two colours far apart do not blend at a
                # MODE 2 pixel, they read as speckle. Weight how far apart
                # the pair is, scaled by how much of the minority colour
                # there is (a solid never speckles).
                if fuse and lv not in (0, npix):
                    frac = min(lv, npix - lv) / npix
                    sep = float((((srgb[a] - srgb[b]) * WEIGHT) ** 2).sum())
                    d += fuse * sep * (frac / 0.5)
                if d < bestd - 1e-9:
                    bestd, best = d, (a, b, lv)
    return best, bestd


# ---------------------------------------------------------------- rendering

DISC = {}


def cell_disc(rc, col, row):
    """Cells covered by a blob of cell-radius rc, centred on (col, row)."""
    m = DISC.get(rc)
    if m is None:
        m = tuple((dx, dy)
                  for dy in range(-rc, rc + 1)
                  for dx in range(-rc, rc + 1)
                  if dx * dx + dy * dy <= rc * rc + rc)
        DISC[rc] = m
    return tuple((col + dx, row + dy) for dx, dy in m)


def render(plots, frame, form, grid, stamp, cs, steps=4, radius=False,
           stats=None, phase="locked", sizes=(0, 1, 2, 3), fuse=0.0):
    fw, fh = form
    gw, gh = grid
    sw, sh = stamp
    npix = sw * sh
    rank = bayer(sw, sh)

    # Cell pitch in canvas pixels. The stamp may be larger than the pitch.
    px = CANVAS_W / gw
    py = CANVAS_H / gh

    pal = palette_at(cs, frame)
    cache = {}

    # The canvas starts as the background tint, dithered and phase-locked, so
    # a background-tint stamp is invisible exactly as it is in the reference.
    (ba, bb, blv), _ = dither_for(pal[0], steps, npix, fuse)
    tile = np.where(np.tile(rank, (CANVAS_H // sh + 1, CANVAS_W // sw + 1))
                    [:CANVAS_H, :CANVAS_W] < blv, bb, ba)
    scr = tile.astype(np.uint8)  # physical colour index
    sel = plots[plots[:, 0] <= frame]

    touched = set()
    nstamp = 0
    for t, x, y, r, c in sel:
        c = int(c) & 511
        tint = 511 - c if c >= 256 else c
        mix = cache.get(tint)
        if mix is None:
            mix, _ = dither_for(pal[tint] if tint < len(pal) else 0,
                                steps, npix, fuse)
            cache[tint] = mix
        a, b, lv = mix

        col = int(int(x) * gw // fw)
        row = int(int(y) * gh // fh)
        if not (0 <= col < gw and 0 <= row < gh):
            continue
        # Cells covered by this plot: one, unless --radius lets the blob span
        # several cells. Cell radius is snapped to `sizes` -- a small table of
        # allowed blob sizes, so cost stays a lookup rather than a law.
        if radius:
            rc = int(int(r) * gw / fw + 0.5)
            rc = min(sizes, key=lambda s: abs(s - rc))
            cells = cell_disc(rc, col, row)
        else:
            cells = ((col, row),)

        nstamp += len(cells)
        touched.update(cells)
        for cc, rr2 in cells:
            x0 = int(round(cc * px)) - (sw - int(round(px))) // 2
            y0 = int(round(rr2 * py)) - (sh - int(round(py))) // 2
            x0 = max(0, min(CANVAS_W - sw, x0))
            y0 = max(0, min(CANVAS_H - sh, y0))
            if phase == "locked":
                # Dither phase follows absolute screen position, so stamps of
                # the same tint tile into one coherent field instead of
                # interfering. On the 6502 this is a handful of extra pattern
                # variants selected by the low bits of (col, row).
                r0 = np.roll(np.roll(rank, -y0 % sh, axis=0), -x0 % sw, axis=1)
            else:
                r0 = rank
            scr[y0:y0 + sh, x0:x0 + sw] = np.where(r0 < lv, b, a)

    if stats is not None:
        stats["plots"] = int(len(sel))
        stats["cells"] = len(touched)
        stats["grid_cells"] = gw * gh
        stats["tints"] = len(cache)
        stats["stamps"] = nstamp
        stats["pairs"] = {t: (BBC_NAME[a], BBC_NAME[b], lv, npix)
                          for t, (a, b, lv) in cache.items()}

    lut = np.array([rgb24(c) for c in BBC], dtype=np.uint8)
    img = Image.fromarray(lut[scr], "RGB")
    return img.resize((CANVAS_W * 2, CANVAS_H), Image.NEAREST)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("plots")
    ap.add_argument("out")
    ap.add_argument("--frame", type=int, required=True)
    ap.add_argument("--form", type=int, nargs=2, default=[352, 280])
    ap.add_argument("--grid", default="80x64")
    ap.add_argument("--stamp", default=None, help="default: one cell")
    ap.add_argument("--cs", default=None)
    ap.add_argument("--steps", type=int, default=4)
    ap.add_argument("--radius", action="store_true",
                    help="diagnostic: let radius cover several cells")
    ap.add_argument("--stats", action="store_true")
    ap.add_argument("--phase", choices=["locked", "stamp"], default="locked")
    ap.add_argument("--fuse", type=float, default=0.0,
                    help="penalty for pairs that will not fuse (0 = off)")
    ap.add_argument("--sizes", default="0,1,2,3",
                    help="allowed blob cell-radii for --radius")
    a = ap.parse_args()

    gw, gh = (int(v) for v in a.grid.lower().split("x"))
    if a.stamp:
        sw, sh = (int(v) for v in a.stamp.lower().split("x"))
    else:
        sw, sh = CANVAS_W // gw, CANVAS_H // gh

    st = {} if a.stats else None
    img = render(load_plots(a.plots), a.frame, a.form, (gw, gh), (sw, sh),
                 load_colorscript(a.cs or a.plots + ".cs"), a.steps,
                 a.radius, st, a.phase,
                 tuple(int(v) for v in a.sizes.split(',')), a.fuse)
    img.save(a.out)
    if st:
        print(f"plots={st['plots']} cells={st['cells']}/{st['grid_cells']} "
              f"({100.0 * st['cells'] / st['grid_cells']:.1f}% covered) "
              f"collapse={st['plots'] / max(st['cells'], 1):.1f} plots/cell "
              f"tints={st['tints']}")
    print("wrote", a.out)


if __name__ == "__main__":
    main()
