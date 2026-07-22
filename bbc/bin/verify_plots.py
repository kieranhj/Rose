#!/usr/bin/env python3
# Verify a BBC engine run against the visualizer's ground truth.
#
# Full mode (log fits in RAM):
#   verify_plots.py expected.bin actual.bin [--ordered]
# Checksum mode (BBC log overflowed; pass LOGCNT/LOGCHK read from &7000/&7002):
#   verify_plots.py expected.bin actual_prefix.bin --count N --chk HEX [--ordered]
#
# The checksum is order-independent: per 10-byte record h = rol32(h,1) ^ byte
# (into the low byte), summed mod 2^32 across records — matching interp.asm.
import struct
import sys


def rec_hash(rec):
    h = 0
    for b in rec:
        h = ((h << 1) | (h >> 31)) & 0xFFFFFFFF
        h ^= b
    return h


args = [a for a in sys.argv[1:] if not a.startswith("--")]
opts = sys.argv[1:]
e = open(args[0], "rb").read()
a = open(args[1], "rb").read()
count = int(opts[opts.index("--count") + 1]) if "--count" in opts else None
chk = int(opts[opts.index("--chk") + 1], 16) if "--chk" in opts else None
ordered = "--ordered" in opts

ne = len(e) // 10
ok = True

if count is not None:
    if count != ne:
        print(f"COUNT MISMATCH: expected {ne}, actual {count}")
        ok = False
    else:
        print(f"count ok: {ne}")

if chk is not None:
    echk = 0
    for i in range(ne):
        echk = (echk + rec_hash(e[i * 10:i * 10 + 10])) & 0xFFFFFFFF
    if echk != chk:
        print(f"CHECKSUM MISMATCH: expected {echk:08X}, actual {chk:08X}")
        ok = False
    else:
        print(f"checksum ok: {echk:08X}")

# Record-level compare: full when sizes match, else ordered prefix if asked.
na = len(a) // 10
if count is None or ordered:
    n = min(ne, na)
    bad = 0
    for i in range(n):
        pe = struct.unpack("<5h", e[i * 10:i * 10 + 10])
        pa = struct.unpack("<5h", a[i * 10:i * 10 + 10])
        if pe != pa:
            if bad < 10:
                print(f"plot {i}: expected (t,x,y,r,c)={pe} actual={pa}")
            bad += 1
    if bad:
        print(f"{bad} record mismatches in first {n}")
        ok = False
    else:
        print(f"records ok: first {n} match")
    if count is None and len(e) != len(a):
        print(f"length mismatch: expected {len(e)}, actual {len(a)}")
        ok = False

print("PASS" if ok else "FAIL")
sys.exit(0 if ok else 1)
