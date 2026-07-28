#!/usr/bin/env python3
"""Render a Rose plot stream to PNG offline, matching the visualizer's rules.

  plotrender.py <plots.bin> <out.png> --frame N [--form W H] [--layers L D]
                [--cs <plots.bin.cs>] [--scale S] [--label TEXT]
                [--compare <other.bin> [--label2 TEXT]]

Coverage rules copied from the GL shaders (visualizer/shaders.h):
  * c < 256                 -> disc,   covered iff dx^2+dy^2 < (r+0.5)^2
  * c >= 256 (from `plot`)  -> square, tint = 511-c, covered iff |dx|,|dy| <= r
Layers composite top-down; a tint that is a multiple of layer_depth is
transparent within its layer (so tint 4 in layer 1 erases back to layer 0).
"""
import argparse
import struct
import sys

import numpy as np
from PIL import Image, ImageDraw

DISC_CACHE = {}


def disc_mask(r):
    m = DISC_CACHE.get(r)
    if m is None:
        d = np.arange(-r, r + 1)
        dy2 = (d * d)[:, None]
        m = (dy2 + (d * d)[None, :]) < (r + 0.5) ** 2
        DISC_CACHE[r] = m
    return m


def load_plots(path):
    with open(path, "rb") as f:
        raw = f.read()
    return np.frombuffer(raw, dtype="<i2").reshape(-1, 5)


def load_colorscript(path):
    try:
        with open(path, "rb") as f:
            raw = f.read()
    except OSError:
        return []
    return np.frombuffer(raw, dtype="<i2").reshape(-1, 3)


def palette_at(cs, frame, ntints):
    """12-bit RGB per tint index, as of `frame`."""
    pal = [0] * max(ntints, 256)
    for t, i, rgb in cs:
        if t > frame:
            break
        if 0 <= i < len(pal):
            pal[i] = int(rgb) & 0xFFF
    return pal


def rgb24(v):
    r, g, b = (v >> 8) & 0xF, (v >> 4) & 0xF, v & 0xF
    return (r * 17, g * 17, b * 17)


def render(plots, frame, w, h, layers, depth, cs, xoff=0, yoff=0):
    # One index plane per layer, cleared to that layer's transparent tint.
    plane = [np.full((h, w), l * depth, dtype=np.uint8) for l in range(layers)]
    sel = plots[plots[:, 0] <= frame]
    for t, x, y, r, c in sel:
        c = int(c) & 511
        if c >= 256:
            tint, square = 511 - c, True
        else:
            tint, square = c, False
        layer = tint // depth
        if layer >= layers:
            continue
        r = int(r)
        x, y = int(x) - xoff, int(y) - yoff
        x0, x1 = x - r, x + r + 1
        y0, y1 = y - r, y + r + 1
        cx0, cy0 = max(x0, 0), max(y0, 0)
        cx1, cy1 = min(x1, w), min(y1, h)
        if cx0 >= cx1 or cy0 >= cy1:
            continue
        dst = plane[layer][cy0:cy1, cx0:cx1]
        if square:
            dst[:] = tint
        else:
            m = disc_mask(r)[cy0 - y0:cy1 - y0, cx0 - x0:cx1 - x0]
            np.copyto(dst, np.uint8(tint), where=m)

    pal = palette_at(cs, frame, layers * depth)
    out_idx = plane[0].copy()
    for l in range(1, layers):
        opaque = (plane[l] % depth) != 0
        np.copyto(out_idx, plane[l], where=opaque)

    lut = np.zeros((256, 3), dtype=np.uint8)
    for i in range(min(256, layers * depth)):
        lut[i] = rgb24(pal[i])
    return Image.fromarray(lut[out_idx], "RGB")


def label(img, text, scale):
    if not text:
        return img
    bar = 14
    out = Image.new("RGB", (img.width, img.height + bar), (0, 0, 0))
    out.paste(img, (0, bar))
    ImageDraw.Draw(out).text((3, 2), text, fill=(200, 200, 200))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("plots")
    ap.add_argument("out")
    ap.add_argument("--frame", type=int, required=True)
    ap.add_argument("--form", type=int, nargs=2, default=[352, 280])
    ap.add_argument("--layers", type=int, nargs=2, default=[1, 4],
                    metavar=("COUNT", "DEPTH"))
    ap.add_argument("--cs", default=None)
    ap.add_argument("--scale", type=int, default=1)
    ap.add_argument("--label", default=None)
    ap.add_argument("--compare", default=None)
    ap.add_argument("--label2", default=None)
    ap.add_argument("--cs2", default=None)
    a = ap.parse_args()

    w, h = a.form
    lc, ld = a.layers
    imgs = []
    for path, cspath, lab in ((a.plots, a.cs or a.plots + ".cs", a.label),
                              (a.compare, a.cs2 or (a.compare or "") + ".cs", a.label2)):
        if path is None:
            continue
        img = render(load_plots(path), a.frame, w, h, lc, ld, load_colorscript(cspath))
        if a.scale != 1:
            img = img.resize((w * a.scale, h * a.scale), Image.NEAREST)
        imgs.append(label(img, lab, a.scale))

    if len(imgs) == 1:
        imgs[0].save(a.out)
    else:
        gap = 8
        tw = sum(i.width for i in imgs) + gap * (len(imgs) - 1)
        th = max(i.height for i in imgs)
        sheet = Image.new("RGB", (tw, th), (32, 32, 32))
        x = 0
        for i in imgs:
            sheet.paste(i, (x, 0))
            x += i.width + gap
        sheet.save(a.out)
    print("wrote", a.out)


if __name__ == "__main__":
    main()
