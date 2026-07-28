#!/usr/bin/env python3
"""pairs.py — what would R5 fusion actually be worth? (rose-micro.md R5)

Replays a build through the reference model and counts every *statically
adjacent* executed opcode pair: op at offset i, then the op at i+len(i). Those
are the only pairs a compiler can fuse into one opcode, and only if the second
op is never reached any other way — a branch target, tail, proc entry or wait
resume landing in the middle of a fused pair would be unencodable. pyinterp
records both facts (`pairs=` hook), so the fusible/blocked split is observed.

Two things stop a naive pair count from being the answer:

  * Pairs overlap. In `const rlocal op` you may fuse `const+rlocal` or
    `rlocal+op`, not both. `--tile` runs a DP over each fall-through chain,
    weighted by execution count, and reports what a compiler could actually
    take with a given opcode budget.
  * Most pairs are worth almost nothing. Removing a dispatch saves 28.8
    cycles; removing a push/pop round-trip through the eval stack saves ~100.
    See SAVING below.

Usage:
  python bbc/tools/pairs.py --all                    # rank pairs by saving
  python bbc/tools/pairs.py --all --tile 8           # best 8 fused opcodes
  python bbc/tools/pairs.py bbc/build/everyway --fine
"""
import argparse
import collections
import os
import pathlib
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pyinterp  # noqa: E402

# --- cost model -------------------------------------------------------------
# Dispatch is measured (opcost.mjs, §9.2). The stack terms are counted off
# interp.asm: the inlined push in op_const is 50 cycles, op_op's inlined pop is
# 52, pop_RA as a subroutine is 64, and do_add's read-modify-write of the
# result slot is 40. FETCH is the operand byte a fused opcode must carry: with
# no free 16-slot range left in the encoding (see --slots) every fusion is a
# 2-byte opcode.
DISPATCH = 28.8
PUSH = 50           # producer writes its value to the eval stack
POP = 52            # consumer reads it back
WRITE = 40          # op/mul/... writing its result into the stack slot
FETCH = 22          # the fused operand byte: inline fetch plus splitting the
                    # nibbles apart, net of the opsave decode it replaces
# CALIBRATED: rlocal+op was built for real (opcode &32) and measured with
# frametime.mjs on ball, teaser and jesuisrose. All three give 108 cycles per
# fusion against this model's 109 — see rose-micro.md §13.

PRODUCER = {"const", "constw", "rlocal", "rstate", "proc", "rand"}
# consumes exactly one stack value as its input
CONSUMER = {"op", "mul", "div", "neg", "sine", "when", "wstate", "wlocal",
            "wait", "move", "pop", "seed"}
# produces its result *into* a stack slot rather than pushing fresh
INPLACE = {"op", "mul", "div", "neg", "sine", "rand"}

LOW = {0x00: 0, 0x01: 65, 0x02: 66, 0x03: 575, 0x04: 6, 0x05: 21, 0x06: 6,
       0x07: 112, 0x08: 65, 0x09: 2450, 0x0A: 270, 0x0B: 351, 0x0C: 919,
       0x0D: 173, 0x0E: 1450, 0x0F: 573}
LOWNAME = {0x00: "done", 0x01: "else", 0x02: "end", 0x03: "rand", 0x04: "draw",
           0x05: "tail", 0x06: "plot", 0x07: "proc", 0x08: "pop", 0x09: "div",
           0x0A: "wait", 0x0B: "sine", 0x0C: "seed", 0x0D: "neg", 0x0E: "move",
           0x0F: "mul"}
HIGH = [(0x80, 116, "const"), (0x70, 116, "rstate"), (0x60, 106, "rlocal"),
        (0x50, 114, "wstate"), (0x40, 122, "wlocal"), (0x30, 141, "op"),
        (0x20, 1700, "fork"), (0x10, 105, "when")]
OPNAME = {13: "add", 9: "sub", 11: "cmp", 12: "and", 8: "or", 0: "asr",
          1: "lsr", 3: "ror", 4: "asl", 5: "lsl", 7: "rol"}
FIELD = ["proc", "x", "y", "size", "tint", "rand", "dir", "time",
         "w0", "w1", "w2", "w3", "w4", "w5", "w6", "w7"]


def base(name):
    return name.split(".")[0].split("[")[0].replace("constw", "const")


def saving(a, b):
    """Cycles a fusion of (a, b) removes, and why."""
    x, y = base(a), base(b)
    s, why = DISPATCH - FETCH, "dispatch"
    if y in CONSUMER:
        if x in PRODUCER:               # value never reaches the stack
            s += PUSH + POP
            why = "round-trip"
        elif x in INPLACE:              # result handed over in a register
            s += WRITE + POP
            why = "result-in-reg"
    return s, why


def classify(b, fine=False):
    for lo, cost, name in HIGH:
        if b >= lo:
            n = b & 15
            if not fine:
                return name, cost
            if name == "const":
                return ("const" if (b & 0x7F) < 126 else "constw"), cost
            if name in ("rstate", "wstate"):
                return f"{name}.{FIELD[n]}", cost
            if name == "op":
                return f"op.{OPNAME.get(n, n)}", cost
            return f"{name}[{n}]", cost
    return LOWNAME[b], LOW[b]


def scan(build, frames=10000, fine=False):
    """-> (chains, blocked). A chain is [(offset, name, fallcount), ...] of
    statically adjacent ops with no entry point between them."""
    d = pathlib.Path(build)
    bc = (d / "bytecodes.bin").read_bytes()
    cb = (d / "constants.bin").read_bytes()
    constants = [struct.unpack(">i", cb[i:i + 4])[0]
                 for i in range(0, len(cb), 4)]
    p, st = {}, []
    pyinterp.run(bc, constants, frames=frames, pairs=p, stats=st)
    fall, entry = p["fall"], p["entry"]
    ops = collections.Counter()
    for c, _, _ in st:
        ops.update(c)
    interp = sum(n * (classify(b)[1] + DISPATCH) for b, n in ops.items())

    # DONE is a structural marker: rose2bbc.py resolves it away, and the op
    # after it is a control-flow join. Neither side of it can fuse.
    breaks = set(entry)
    for i in fall:
        if bc[i] == 0x00:
            breaks.add(i + 1)
            breaks.add(i)

    links = {}                              # i -> (j, count) fusible link
    blocked = collections.Counter()
    for i, n in fall.items():
        j = i + pyinterp.oplen(bc, i)
        if j in breaks or i in breaks:
            blocked[(classify(bc[i], fine)[0], classify(bc[j], fine)[0])] += n
        else:
            links[i] = (j, n)

    starts = set(links) - {j for j, _ in links.values()}
    chains = []
    for s in sorted(starts):
        ch, i = [], s
        while True:
            n = links[i][1] if i in links else 0
            ch.append((i, classify(bc[i], fine)[0], n))
            if i not in links:
                break
            i = links[i][0]
        chains.append(ch)
    return chains, blocked, interp, len(st)


def pair_totals(chains):
    c = collections.Counter()
    for ch in chains:
        for k in range(len(ch) - 1):
            c[(ch[k][1], ch[k + 1][1])] += ch[k][2]
    return c


def tile(chains, allowed):
    """Max-weight non-overlapping tiling of each chain with `allowed` pairs.
    Returns (cycles saved, Counter of fusions taken)."""
    total, taken = 0.0, collections.Counter()
    for ch in chains:
        m = len(ch)
        best = [0.0] * (m + 1)
        pick = [None] * (m + 1)
        for k in range(m - 2, -1, -1):
            best[k] = best[k + 1]
            key = (ch[k][1], ch[k + 1][1])
            if key in allowed:
                v = ch[k][2] * allowed[key] + best[k + 2]
                if v > best[k]:
                    best[k], pick[k] = v, key
        total += best[0]
        k = 0
        while k < m - 1:
            if pick[k]:
                taken[pick[k]] += ch[k][2]
                k += 2
            else:
                k += 1
    return total, taken


def builds_for(args):
    if not args.all:
        return list(args.builds)
    root = pathlib.Path(__file__).resolve().parents[1] / "build"
    seen = {}                             # a tube build shares its host twin's
    for p in sorted(root.iterdir()):      # bytecode — take one of each
        if (p / "bytecodes.bin").exists():
            seen.setdefault(p.name.replace("-tube", "").replace("-fz", ""),
                            str(p))
    return [seen[k] for k in sorted(seen)]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("builds", nargs="*")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--fine", action="store_true",
                    help="split by operand (op.add, rstate.dir, ...)")
    ap.add_argument("--tile", type=int, metavar="N",
                    help="pick the best N fused opcodes and tile with them")
    ap.add_argument("--greedy", action="store_true",
                    help="pick the opcode set by marginal gain, not by rank")
    ap.add_argument("--frames", type=int, default=10000)
    ap.add_argument("--top", type=int, default=20)
    a = ap.parse_args()

    per = {}
    for b in builds_for(a):
        per[pathlib.Path(b).name.replace("-tube", "").replace("-fz", "")] = scan(b, a.frames,
                                                             a.fine)

    tot = collections.Counter()
    for chains, _, _, _ in per.values():
        tot.update(pair_totals(chains))

    rank = sorted(tot.items(), key=lambda kv: -kv[1] * saving(*kv[0])[0])
    print(f"{'pair':26s} {'executions':>12s} {'cyc/fusion':>10s} "
          f"{'Mcyc saved':>11s}  {'kind':13s} demos")
    print("-" * 82)
    for (x, y), n in rank[:a.top]:
        s, why = saving(x, y)
        demos = sum(1 for c, _, _, _ in per.values() if pair_totals(c)[(x, y)])
        print(f"{x + ' + ' + y:26s} {n:12,d} {s:10.0f} {n * s / 1e6:11.2f}"
              f"  {why:13s} {demos}")

    if a.tile:
        if a.greedy:
            # Ranking by standalone value is a bad selection rule: pairs
            # compete for the same ops, so the second-ranked pair can be worth
            # nothing once the first is in. Pick by *marginal* gain instead.
            cand = [k for k, _ in rank[:40]]
            allowed, chosen = {}, []
            for _ in range(a.tile):
                bestk, bestv = None, 0.0
                for k in cand:
                    if k in allowed:
                        continue
                    trial = dict(allowed)
                    trial[k] = saving(*k)[0]
                    v = sum(tile(c, trial)[0] for c, _, _, _ in per.values())
                    if v > bestv:
                        bestk, bestv = k, v
                if bestk is None:
                    break
                allowed[bestk] = saving(*bestk)[0]
                chosen.append((bestk, bestv))
            print("\n  greedy selection (marginal gain per opcode added):")
            prev = 0.0
            for k, v in chosen:
                print(f"    {k[0] + ' + ' + k[1]:26s} +{(v - prev) / 1e6:6.2f}"
                      f"  cumulative {v / 1e6:7.2f} Mcyc")
                prev = v
        else:
            allowed = {k: saving(*k)[0] for k, _ in rank[:a.tile]}
        print(f"\n--- tiled with the best {a.tile} fused opcodes "
              f"(non-overlapping) ---")
        gtot, gtaken, gint = 0.0, collections.Counter(), 0.0
        print(f"  {'demo':13s} {'fusions':>9s} {'Mcyc':>8s} {'of interp':>10s}"
              f" {'cyc/frame':>10s}")
        for name, (chains, _, interp, nfr) in sorted(per.items()):
            s, taken = tile(chains, allowed)
            gtot += s
            gint += interp
            gtaken.update(taken)
            print(f"  {name:13s} {sum(taken.values()):9,d} {s / 1e6:8.2f} "
                  f"{100 * s / max(interp, 1):9.1f}% {s / max(nfr, 1):10,.0f}")
        print(f"  {'TOTAL':13s} {sum(gtaken.values()):9,d} {gtot / 1e6:8.2f} "
              f"{100 * gtot / gint:9.1f}%")
        print("\n  opcodes actually earning their slot:")
        for k, v in gtaken.most_common():
            print(f"    {k[0] + ' + ' + k[1]:26s} {v:9,d}  "
                  f"{v * allowed[k] / 1e6:6.2f} Mcyc")


if __name__ == "__main__":
    main()
