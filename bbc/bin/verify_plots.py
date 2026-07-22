#!/usr/bin/env python3
# Compare a BBC engine plot log against the visualizer's ground truth.
# Both files are sequences of 10-byte records: t,x,y,r,c as int16 LE.
import struct
import sys

e = open(sys.argv[1], "rb").read()
a = open(sys.argv[2], "rb").read()
n = min(len(e), len(a)) // 10
bad = 0
for i in range(n):
    pe = struct.unpack("<5h", e[i * 10:i * 10 + 10])
    pa = struct.unpack("<5h", a[i * 10:i * 10 + 10])
    if pe != pa:
        if bad < 10:
            print(f"plot {i}: expected (t,x,y,r,c)={pe} actual={pa}")
        bad += 1
if len(e) != len(a):
    print(f"length mismatch: expected {len(e)} bytes, actual {len(a)}")
if bad == 0 and len(e) == len(a):
    print(f"BIT-EXACT: all {n} plots match")
else:
    print(f"{bad} mismatches out of {n}")
    sys.exit(1)
