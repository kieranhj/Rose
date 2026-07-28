#!/usr/bin/env python3
"""Weight the measured per-op costs (16.16 vs Micro) by a real opcode mix.

Counts and 16.16 costs come from `node bbc/tools/opcost.mjs bbc/build/everyway`;
Micro costs from `bash bbc/bench/build.sh`. Ops with no benchmarked Micro
equivalent get a conservative estimate, flagged with ~.
"""
# op            count   cyc16.16   micro   estimated?
MIX = [
    ("op_move",   4704,  1455.5,  686,  False),
    ("op_mul",    6093,   569.3,  348,  True),   # smul16 283 + 16-bit stack shuffle
    ("op_const", 28634,   116.0,   37,  False),
    ("op_rlocal",25791,   106.0,   61,  False),
    ("op_wstate",21511,   114.1,   65,  False),
    ("op_op",    13096,   141.2,   62,  False),
    ("op_fork",   1157,  1518.3,  700,  True),   # 32 B state copy + arg pushes
    ("op_neg",    4992,   173.0,   90,  True),
    ("op_when",   6480,   114.0,   70,  True),
    ("op_proc",   5728,   112.0,   90,  True),   # mostly index work, not width
    ("op_wlocal",  5091,  122.0,   66,  True),
    ("op_wait",    1379,  270.1,  190,  True),
    ("op_rstate",   877,  116.0,   62,  True),
    ("dispatch", 138618,   28.8, 28.8,  False),  # unchanged by the numeric model
]

print(f"{'op':<10} {'count':>8} {'16.16 Mcyc':>11} {'micro Mcyc':>11}  per-op")
a = b = 0
for name, n, c32, c16, est in MIX:
    t32, t16 = n * c32 / 1e6, n * c16 / 1e6
    a += t32; b += t16
    print(f"{name:<10} {n:>8} {t32:>11.2f} {t16:>11.2f}  {c32:>6.0f} -> {c16:>5.0f}{' ~' if est else ''}")
print(f"\ntotal      {'':>8} {a:>11.2f} {b:>11.2f}   speedup {a/b:.2f}x")
nd = MIX[-1]
print(f"handlers only (no dispatch):     {a-nd[1]*nd[2]/1e6:.2f} -> {b-nd[1]*nd[3]/1e6:.2f}"
      f"   speedup {(a-nd[1]*nd[2]/1e6)/(b-nd[1]*nd[3]/1e6):.2f}x")
