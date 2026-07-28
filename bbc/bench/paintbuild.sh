#!/bin/sh
# Build and run the precompiled brush painter benchmark (experiment 3).
set -e
cd "$(dirname "$0")"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
python genpaint.py "$@"
printf '*RUN BENCH\r' > boot.txt
rm -f paint.ssd
"$BEEBASM" -i paint.asm -do paint.ssd -opt 3 > paintasm.log 2>&1 || { cat paintasm.log; exit 1; }
node run.mjs bench.json paintasm.log
