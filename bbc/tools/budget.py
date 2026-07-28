#!/usr/bin/env python3
"""budget.py — offline frame-budget checker for the BBC engine (rose-micro.md R8).

Replays a build's bytecode through the reference model (pyinterp), costs every
frame with the *measured* cost model, and reports the result against a 25Hz or
50Hz contract. `--hz 50 --fail` makes it a build gate.

Consistency at 50Hz is not an engine property, it is an authoring property; this
is the tool that turns it into one — the author sees the overrun before the
machine does, and sees which frame and which plots caused it.

Every constant below is measured, not estimated:
  * per-opcode handler costs   `node bbc/tools/opcost.mjs bbc/build/<name>`
  * render_blob per radius     `node bbc/tools/rendercost.mjs bbc/build/<name>`
  * emit and scheduler terms   fitted against per-frame ground truth from
                               `node bbc/tools/frametime.mjs` (see --validate)

Usage:
  python bbc/tools/budget.py bbc/build/ball --hz 25
  python bbc/tools/budget.py bbc/build/teaser --hz 50 --lag 8 --fail
  python bbc/tools/budget.py bbc/build/ball --validate ft-ball.csv
"""
import argparse
import collections
import math
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pyinterp  # noqa: E402

CPU_HZ = 2_000_000
_PLOTS = []

# --- measured costs, 16.16 engine -------------------------------------------
# Handler cost per opcode, excluding dispatch. Where demos disagree slightly
# (different operand mixes) the value is the mid-point across ball, teaser,
# jesuisrose and Everyway.
OPCOST = {
    0x00: 0,      # DONE   — resolved offline by rose2bbc.py, no runtime cost
    0x01: 65,     # ELSE
    0x02: 66,     # END
    0x03: 575,    # RAND
    0x04: 6,      # DRAW   — the record cost is EMIT + REC below
    0x05: 21,     # TAIL
    0x06: 6,      # PLOT
    0x07: 112,    # PROC
    0x08: 65,     # POP
    0x09: 2450,   # DIV
    0x0A: 270,    # WAIT
    0x0B: 351,    # SINE
    0x0C: 919,    # SEED
    0x0D: 173,    # NEG
    0x0E: 1450,   # MOVE
    0x0F: 573,    # MUL
}
CLASS = [(0x80, 116, "const"), (0x70, 116, "rstate"), (0x60, 106, "rlocal"),
         (0x50, 114, "wstate"), (0x40, 122, "wlocal"), (0x30, 141, "op"),
         (0x20, 1700, "fork"), (0x10, 105, "when")]
DISPATCH = 28.8
EMIT = 500          # emit_rec + build_rec, per record
REC = 320           # rec_done (bank/ACCCON glue), per record, charged to render
FRAME_FIX = 570     # q_drain + frame_tick + cs_loop + sched proper, per frame
# flush_sorted: every frame that draws anything pays a fixed radix-sort scan
# before it draws, then a per-record cost. Non-negative least squares against
# per-frame ground truth from frametime.mjs on ball / teaser / jesuisrose /
# Everyway (§11.2) — the per-*activation* term fits to zero, which matches
# opcost.mjs measuring the scheduler proper at 30 cycles per entry.
SORT_BASE = 6070    # per frame that emits at least one record
SORT_REC = 740      # per record

# Measured render_blob cost per radius (rendercost.mjs on Everyway, which spans
# r=0..26 with enough samples to be stable). Beyond the table, the fit below.
DISC = {0: 514, 1: 811, 2: 1117, 3: 1434, 4: 1773, 5: 2119, 6: 2498, 7: 2847,
        8: 3180, 9: 3675, 10: 4107, 11: 4402, 12: 4843, 13: 5387, 14: 5892,
        15: 6231, 16: 6722, 17: 7275, 19: 8183, 20: 8685, 21: 9370, 22: 10025,
        23: 10450, 24: 10926, 25: 11684, 26: 12413}
# Least-squares over that table: a + b*lines + c*bytes, bytes = pi r^2 / 4.
DISC_FIT = (379, 143.7, 8.07)
# Squares (PLOT) are a different law — same lines, more bytes, cheaper per byte.
# Fitted over 43 measured square radii from Everyway and JeSuisRose.
SQ_FIT = (261, 86.9, 7.62)

# Micro projection: per-op ratios measured in bbc/bench (§9.3), painter costs
# measured in bbc/bench/paint.asm (§10.2). A projection, not a measurement of a
# Micro engine that does not exist yet.
MICRO_RATIO = {"const": 37 / 116, "rstate": 62 / 116, "rlocal": 61 / 106,
               "wstate": 65 / 114, "wlocal": 66 / 122, "op": 62 / 141,
               "fork": 700 / 1700, "when": 70 / 105}
MICRO_OP = {0x0E: 686, 0x0F: 348, 0x09: 2450, 0x03: 300, 0x0B: 120, 0x0C: 480,
            0x0A: 190, 0x0D: 90, 0x07: 90}
MICRO_STATE = 0.55   # sched/emit shrink roughly with state and record width


def op_class(op):
    for base, cost, name in CLASS:
        if op >= base:
            return base, cost, name
    return None, OPCOST.get(op, 0), "misc"


def render_cost(r, square):
    """Measured render_blob cost, per record (rec_done added by the caller)."""
    r = max(r, 0)
    lines = 2 * r + 1
    if square:
        a, b, c = SQ_FIT
        return a + b * lines + c * (lines * lines / 4.0)
    if r in DISC:
        return DISC[r]
    a, b, c = DISC_FIT
    return a + b * lines + c * max(math.pi * r * r / 4.0, 1)


def painter_cost(r, square):
    """Precompiled painter (§10.2 fit): 29 + 73.5*lines + 4.1*bytes."""
    r = max(r, 0)
    lines = 2 * r + 1
    b = lines * lines / 4.0 if square else max(math.pi * r * r / 4.0, 1)
    return 29 + 73.5 * lines + 4.1 * b


def frame_costs(stats, plots, nframes, micro=False, rmax=15, painter_max=11):
    """Per-frame (interp, emit, render) cycle cost."""
    by_frame = collections.defaultdict(list)
    for (f, x, y, r, tint) in plots:
        if 0 <= f < nframes:
            by_frame[f].append((r, tint < 0))
    interp, emit, render = [], [], []
    for f in range(nframes):
        C, acts, live = stats[f]
        recs = by_frame.get(f, [])
        sort = (SORT_BASE + SORT_REC * len(recs)) if recs else 0
        ic = FRAME_FIX + sort * (MICRO_STATE if micro else 1.0)
        nops = 0
        for op, n in C.items():
            nops += n
            base, cost, name = op_class(op)
            if micro:
                cost = (cost * MICRO_RATIO[name] if base is not None
                        else MICRO_OP.get(op, cost * 0.6))
            ic += n * cost
        ic += nops * DISPATCH
        interp.append(ic)
        emit.append(len(recs) * EMIT * (MICRO_STATE if micro else 1.0))
        rc = len(recs) * REC * (MICRO_STATE if micro else 1.0)
        for (r, sq) in recs:
            if micro:
                rr = min(r, rmax)
                rc += painter_cost(rr, sq) if rr <= painter_max else render_cost(rr, sq)
            else:
                rc += render_cost(r, sq)
        render.append(rc)
    return interp, emit, render


def pct(v, n):
    v = sorted(v)
    return v[min(len(v) - 1, int(n * len(v)))]


def windowed(v, n):
    """Worst n-frame mean — the R7 lag-queue contract."""
    if n <= 1:
        return max(v)
    n = min(n, len(v))
    run = sum(v[:n])
    worst = run
    for i in range(n, len(v)):
        run += v[i] - v[i - n]
        worst = max(worst, run)
    return worst / n


def load(build, frames):
    bc = open(os.path.join(build, "bytecodes.bin"), "rb").read()
    cb = open(os.path.join(build, "constants.bin"), "rb").read()
    constants = [struct.unpack(">i", cb[i:i + 4])[0] for i in range(0, len(cb), 4)]
    stats = []
    plots = pyinterp.run(bc, constants, frames, stats=stats)
    return stats, plots


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("build")
    ap.add_argument("--hz", type=int, default=25, choices=(25, 50))
    ap.add_argument("--frames", type=int, default=10000)
    ap.add_argument("--lag", type=int, default=1, help="R7 draw-queue depth (frames)")
    ap.add_argument("--micro", action="store_true", help="cost under the Rose Micro projection")
    ap.add_argument("--rmax", type=int, default=15, help="Micro brush radius cap (R3)")
    ap.add_argument("--tube", action="store_true", help="Tube split: max((interp+emit)/2, render)")
    ap.add_argument("--fail", action="store_true", help="exit 1 if the contract is missed")
    ap.add_argument("--validate", help="frametime.mjs CSV to check the model against")
    ap.add_argument("--csv", help="write per-frame predicted costs here")
    ap.add_argument("--quiet", action="store_true", help="one summary line only")
    ap.add_argument("--report", action="store_true",
                    help="one row per configuration (stock/Tube x 16.16/Micro)")
    args = ap.parse_args()

    stats, plots = load(args.build, args.frames)
    global _PLOTS
    _PLOTS = plots
    nframes = len(stats)
    if args.report:
        report(args, stats, plots, nframes)
        return
    interp, emit, render = frame_costs(stats, plots, nframes, args.micro, args.rmax)

    if args.validate:
        validate(args.validate, interp, emit, render, stats)
        return

    if args.tube:
        total = [max((i + e) / 2.0, r) for i, e, r in zip(interp, emit, render)]
    else:
        total = [i + e + r for i, e, r in zip(interp, emit, render)]

    if args.csv:
        with open(args.csv, "w") as f:
            f.write("frame,interp,emit,render\n")
            for i in range(nframes):
                f.write(f"{i},{interp[i]:.0f},{emit[i]:.0f},{render[i]:.0f}\n")

    budget = CPU_HZ / args.hz
    name = os.path.basename(os.path.abspath(args.build))
    worst = windowed(total, args.lag)
    ok = worst <= budget
    if args.quiet:
        print(f"{name:<12} {args.hz}Hz {'micro' if args.micro else '16.16'}"
              f"{' tube' if args.tube else '     '} mean {100*sum(total)/nframes/budget:6.1f}%"
              f"  p95 {100*pct(total,.95)/budget:7.1f}%  worst {100*max(total)/budget:8.1f}%"
              f"  {'PASS' if ok else 'FAIL'}")
        if args.fail and not ok:
            sys.exit(1)
        return

    model = "Rose Micro (projected)" if args.micro else "current engine (measured)"
    print(f"{name}: {nframes} frames, {len(plots)} plots — {model}"
          f"{', Tube split' if args.tube else ''}")
    print(f"  tick {1000/args.hz:.0f}ms ({args.hz}Hz) = {budget:,.0f} cycles")
    wf = total.index(max(total))
    print(f"  mean {100*sum(total)/nframes/budget:5.1f}%   p50 {100*pct(total,.50)/budget:5.1f}%"
          f"   p95 {100*pct(total,.95)/budget:5.1f}%"
          f"   worst frame {wf} = {max(total):,.0f} = {100*max(total)/budget:.0f}%")
    if args.lag > 1:
        print(f"  worst {args.lag}-frame mean (R7 lag queue) = {worst:,.0f}"
              f" = {100*worst/budget:.0f}%")
    over = sum(1 for t in total if t > budget)
    share = (sum(interp) + sum(emit)) / max(sum(total), 1)
    print(f"  frames over budget: {over}/{nframes} ({100*over/nframes:.1f}%)"
          f"   split interp+emit {100*share:.0f}% / render {100-100*share:.0f}%")

    C, acts, live = stats[wf]
    rad = collections.Counter(r for (f, x, y, r, t) in plots if f == wf)
    top = ", ".join(f"r={r} x{n}" for r, n in sorted(rad.items(), reverse=True)[:6])
    print(f"  frame {wf}: {sum(rad.values())} plots ({top or 'none'}), "
          f"{acts} activations of {live} live turtles, {sum(C.values())} ops, "
          f"{sum(n for op, n in C.items() if 0x20 <= op < 0x30)} forks")
    print(f"    interp {interp[wf]:,.0f}  emit {emit[wf]:,.0f}  render {render[wf]:,.0f}")
    print(f"  {'PASS' if ok else 'FAIL'} at {args.hz}Hz")
    if args.fail and not ok:
        sys.exit(1)


def report(args, stats, plots, nframes):
    """One line per configuration — the §11.4 table."""
    name = os.path.basename(os.path.abspath(args.build)).replace("-tube", "")
    cache = {}
    print(f"{name:<12} {'engine':<7} {'split':<6} {'lag':>4} "
          f"{'25Hz mean':>10} {'p95':>7} {'worst':>8}   "
          f"{'50Hz mean':>10} {'p95':>7} {'worst':>8}  verdict")
    for micro in (False, True):
        for tube in (False, True):
            for lag in (1, args.lag) if args.lag > 1 else (1,):
                if micro not in cache:
                    cache[micro] = frame_costs(stats, plots, nframes, micro, args.rmax)
                i, e, r = cache[micro]
                t = ([max((a + b) / 2.0, c) for a, b, c in zip(i, e, r)] if tube
                     else [a + b + c for a, b, c in zip(i, e, r)])
                w = windowed(t, lag)
                cells = []
                verdict = []
                for hz in (25, 50):
                    B = CPU_HZ / hz
                    cells.append(f"{100*sum(t)/nframes/B:9.0f}% {100*pct(t,.95)/B:6.0f}%"
                                 f" {100*w/B:7.0f}%")
                    verdict.append("pass" if w <= B else "fail")
                print(f"{'':<12} {'micro' if micro else '16.16':<7} "
                      f"{'tube' if tube else 'stock':<6} {lag:>4} "
                      f"{cells[0]}   {cells[1]}  "
                      f"{'50Hz' if verdict[1]=='pass' else ('25Hz' if verdict[0]=='pass' else '—')}")
    # Smallest R7 queue depth that would hold the contract, where the mean can
    # hold it at all — the input to experiment 5.
    for micro in (False, True):
        i, e, r = cache[micro]
        for tube in (False, True):
            t = ([max((a + b) / 2.0, c) for a, b, c in zip(i, e, r)] if tube
                 else [a + b + c for a, b, c in zip(i, e, r)])
            for hz in (25, 50):
                B = CPU_HZ / hz
                if sum(t) / nframes > B:
                    continue                      # no queue depth can save it
                need = min_lag(t, B)
                tag = f"{'micro' if micro else '16.16'}/{'tube' if tube else 'stock'}"
                print(f"{'':<12} {tag} at {hz}Hz: " +
                      (f"needs a {need}-frame draw queue (R7)" if need else
                       "no queue depth in 1..512 is enough — the peaks are too wide"))
    clamped = sum(1 for p in plots if p[3] > args.rmax)
    if clamped:
        print(f"{'':<12} note: the micro rows assume R3's radius cap — it clamps "
              f"{100*clamped/max(len(plots),1):.1f}% of this program's plots (r>{args.rmax}), "
              f"which changes what it looks like.")


def min_lag(t, B, cap=512):
    """Smallest window whose worst mean fits the budget (0 = none up to cap)."""
    if max(t) <= B:
        return 1
    n = 1
    while n <= cap and n <= len(t):
        if windowed(t, n) <= B:
            return n
        n *= 2
    return 0


def validate(csv, interp, emit, render, stats):
    """Compare the model's per-frame prediction against measured ground truth.

    Error is reported as a share of the 25Hz budget (80,000 cycles), not as a
    ratio: a 300-cycle error on a frame that spent 40 cycles is 750% and means
    nothing, while 4,000 cycles on a 78,000-cycle frame is what decides a build.
    """
    # frametime.mjs flushes a row when the engine *reaches* frame_tick, so the
    # row that follows frame f's work is row f+1: shift the measurement back one
    # frame before comparing. (Verified by scanning offsets -2..+2 — +1 lifts
    # Everyway's correlation from 0.939 to 0.995.)
    B = CPU_HZ / 25
    rows = [l.split(",") for l in open(csv).read().splitlines()[1:] if l][1:]
    meas = {"interp": [float(r[1]) for r in rows],
            "emit": [float(r[2]) for r in rows],
            "render": [float(r[3]) + float(r[4]) for r in rows]}
    n = min(len(rows), len(interp))
    pred = {"interp": interp, "emit": emit, "render": render}
    pred["total"] = [interp[i] + emit[i] + render[i] for i in range(n)]
    meas["total"] = [meas["interp"][i] + meas["emit"][i] + meas["render"][i] for i in range(n)]
    print(f"{os.path.basename(csv)}: {n-1} frames compared (frame 0 skipped — it carries init)")
    for k in ("interp", "emit", "render", "total"):
        p, m = pred[k], meas[k]
        pm = sum(p[1:n]) / (n - 1)
        mm = sum(m[1:n]) / (n - 1)
        err = sorted(abs(p[i] - m[i]) for i in range(1, n))
        print(f"  {k:<7} predicted {pm:9,.0f}  measured {mm:9,.0f}  bias {100*(pm-mm)/max(mm,1):+6.1f}%"
              f"   |err| as % of a 25Hz frame: median {100*err[len(err)//2]/B:5.2f}%"
              f"  p95 {100*err[int(.95*len(err))]/B:5.2f}%  max {100*err[-1]/B:6.2f}%")

    # Refit the scheduler terms on this demo: residual = live*a + acts*b.
    try:
        import numpy as np
    except ImportError:
        return
    nrec = [0] * n
    for (f, x_, y_, r, t) in _PLOTS:
        if 0 <= f < n:
            nrec[f] += 1
    base = [interp[i] - (SORT_BASE + SORT_REC * nrec[i] if nrec[i] else 0) for i in range(1, n)]
    A = np.array([[1.0 if nrec[i] else 0.0, float(nrec[i])] for i in range(1, n)])
    y = np.array([meas["interp"][i] - base[i - 1] for i in range(1, n)])
    x, *_ = np.linalg.lstsq(A, y, rcond=None)
    print(f"  sort refit on this demo: {x[0]:,.0f}/drawing frame + {x[1]:,.0f}/record"
          f"   (model uses {SORT_BASE:,} + {SORT_REC:,})")


if __name__ == "__main__":
    main()
