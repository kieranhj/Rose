#!/bin/sh
# Build and run the Rose Micro primitive benchmarks (experiment 2).
set -e
cd "$(dirname "$0")"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
python - <<'PY'
import math, struct
n = 1024
# Q7 in a signed byte: 1.0 == 128, so the peak clamps to 127 (a 0.8% shrink
# at the extremes) and the product shifts right 7.
q8  = [max(-128, min(127, round(math.sin(2*math.pi*i/n) * 128))) for i in range(n)]
q12 = [round(math.sin(2*math.pi*i/n) * 4096) for i in range(n)]
open("sin8.bin","wb").write(bytes((v & 0xFF) for v in q8))
open("sin12lo.bin","wb").write(bytes((v & 0xFF) for v in q12))
open("sin12hi.bin","wb").write(bytes(((v >> 8) & 0xFF) for v in q12))
PY
printf '*RUN BENCH\r' > boot.txt
rm -f bench.ssd
"$BEEBASM" -i micro.asm -do bench.ssd -opt 3 > beebasm.log 2>&1 || { cat beebasm.log; exit 1; }
grep -c SYM beebasm.log > /dev/null
node run.mjs
