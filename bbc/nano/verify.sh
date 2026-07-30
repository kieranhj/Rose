#!/bin/sh
# Check every example against the reference model, at every grid.
#   bbc/nano/verify.sh [name ...]
#
# For each program: build it with a MAXFRAMES halt, run it under jsbeeb, dump
# screen RAM, and compare all 20480 bytes against nanoref.py's own rendering.
#
# The halt matters.  Without it the dump lands wherever the cycle budget ran
# out -- typically mid-scheduler-pass, with some turtles moved and others not --
# and the comparison is against a frame the machine was still halfway through
# drawing.  MAXFRAMES stops it on a frame boundary, which is the only moment
# the two implementations are supposed to agree.
set -e
cd "$(dirname "$0")"
FRAMES="${FRAMES:-120}"
NAMES="$*"
[ -n "$NAMES" ] || NAMES=$(cd examples && ls *.nano | sed 's/\.nano$//')

fail=0
for grid in 40x32 80x64; do
    for n in $NAMES; do
        printf '%-10s %-6s ' "$n" "$grid"
        NANOGRID=$grid sh build.sh "$n" "$FRAMES" > /dev/null
        node run.mjs "$n" $((FRAMES + 80)) > /dev/null
        if NANOGRID=$grid python nanoref.py "examples/$n.nano" "$FRAMES" \
                --check "build/$n.screen.bin" | grep -q "matches"; then
            echo "ok"
        else
            echo "FAILED"
            fail=1
        fi
    done
done
[ $fail -eq 0 ] && echo "all match" || { echo "divergence"; exit 1; }
