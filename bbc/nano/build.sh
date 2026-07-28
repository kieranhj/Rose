#!/bin/sh
# Build a Rose Nano program for the BBC Model B.
#   bbc/nano/build.sh <name> [maxframes]
# expects bbc/nano/examples/<name>.nano, produces bbc/nano/build/<name>.ssd
set -e
cd "$(dirname "$0")"
NAME="$1"
FRAMES="${2:-0}"
BEEBASM="${BEEBASM:-/c/Users/khcon/OneDrive/BEEB/Repos/beebasm/beebasm.exe}"
mkdir -p build
python nanoc.py "examples/$NAME.nano" "build/$NAME.asm"
rm -f "build/$NAME.ssd"
printf '*RUN NANO\r' > build/boot.txt
"$BEEBASM" -i "build/$NAME.asm" -do "build/$NAME.ssd" -opt 3 \
    -D MAXFRAMES="$FRAMES" -D NOVSYNC="${NOVSYNC:-0}" -title "NANO" > "build/$NAME.log" 2>&1 || {
        cat "build/$NAME.log"; exit 1; }
grep -E "SYM|SIZE|FREE" "build/$NAME.log" || true
echo "OK: build/$NAME.ssd"
