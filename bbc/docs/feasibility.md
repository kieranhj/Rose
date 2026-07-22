# Rose on the BBC Micro — Feasibility Study

Target machine: **BBC Master 128** (65C12 @ 2MHz, MODE 1 = 320×256, 2bpp / 4 colours,
shadow screen, 64KB sideways RAM). Written 2026-07-22, based on measurements of the
current visualizer, the Archimedes engine (`arc/`), and microbenchmarks run on an
emulated Master (jsbeeb).

## 1. Verdict

A BBC port is **feasible as a reimplementation of the runtime**, the same relationship
the Archimedes engine has to the Amiga original. The Rose *language model* — one-byte
opcodes, stack VM, constants in a side table, time-bucketed cooperative turtles,
persistent trails (no screen clear) — is well suited to a 6502. The Archimedes
*implementation* is not portable: it depends on 32-bit ARM arithmetic, the barrel
shifter, hardware multiply, a runtime ARM JIT, and ~450KB of lookup tables.

Measured across the nine example demos, the small and mid-tier demos (`circle`,
`ball`, `tree`, `PaintersTeaser`, `JeSuisRose`, `Chiperia5intro`) land within a
25–50fps budget with occasional dips; the heavy Archimedes demos (`Everyway`,
`PaintersEuphoria`, `PaintersFrustration`) would run at roughly 8–12fps in their
densest sections and are ports only if authored down. New compositions written for
the machine's budget are the strongest artistic target.

## 2. Measured workload — all examples

Compile-time statistics from the visualizer (`stats.print`), plus per-frame analysis
from `bbc/tools/rosestats.cpp` (clipped to the 352×280 form; MODE 1 bytes = 4px/byte):

| Demo | Bytecode | Procs | Consts | Max turtles | Max stack | Wires | Max plots/frame | Max radius |
|---|---|---|---|---|---|---|---|---|
| circle | 42 B | 2 | 9 | 2 | 5 | 0 | 2 | 3 |
| ball | 92 B | 3 | 9 | 2 | 12 | 0 | 2 | 45 |
| tree | 150 B | 3 | 17 | 261 | 8 | 0 | 146 | 8 |
| PaintersTeaser | 772 B | 18 | 61 | 21 | 15 | 0 | 40 | 12 |
| Chiperia5intro | 1,072 B | 28 | 100 | 273 | 18 | 0 | 70 | 15 |
| PaintersEuphoria | 1,908 B | 26 | 73 | 199 | 14 | 0 | 101 | 49 |
| PaintersFrustration | 1,931 B | 28 | 97 | 211 | 15 | 0 | 100 | 28 |
| JeSuisRose | 3,546 B | 20 | 45 | 21 | 10 | 0 | 70 | 70 |
| Everyway | 8,934 B | 216 | 109 | 101 | 13 | 0 | 75 | 70 |

Notable: **no example uses any wire slots** (wire capacity 0 across the board), and
stack height never exceeds 18 (vs. the ARM engine's MAX_STACK=20). The pressure
points are live turtle count (up to 273) and rendering load, not VM state.

Per-frame rendering load (over frames that draw anything; "bytes" = MODE 1
framebuffer bytes touched, the direct span-fill cost driver; "lines" = scanlines
touched, the per-line overhead driver):

| Demo | plots p50/p95/max | bytes p50/p95/max | lines p50/p95/max |
|---|---|---|---|
| circle | 2 / 2 / 2 | 25 / 26 / 26 | 14 / 14 / 14 |
| ball | 2 / 2 / 2 | 2,067 / 2,414 / 2,414 | 142 / 152 / 152 |
| tree | 11 / 66 / 146 | 229 / 489 / 650 | 96 / 327 / 452 |
| PaintersTeaser | 2 / 36 / 40 | 156 / 1,027 / 4,348 | 38 / 399 / 866 |
| Chiperia5intro | 5 / 38 / 70 | 13 / 1,636 / 3,269 | 11 / 440 / 760 |
| PaintersEuphoria | 7 / 81 / 101 | 455 / 3,509 / 7,080 | 108 / 405 / 612 |
| PaintersFrustration | 9 / 45 / 100 | 154 / 4,047 / 5,659 | 38 / 707 / 881 |
| JeSuisRose | 9 / 61 / 70 | 273 / 6,292 / 12,690 | 128 / 572 / 662 |
| Everyway | 24 / 48 / 75 | 3,586 / 9,594 / 19,254 | 411 / 900 / 2,100 |

Per-frame script-execution cost (the visualizer's built-in Amiga 68000 cycle
estimates, a proxy for interpreter load) and live turtles:

| Demo | 68k cycles p50/p95/max | turtles alive p50/p95/max |
|---|---|---|
| circle | 2,048 / 2,048 / 3,304 | 1 / 1 / 1 |
| ball | 1,198 / 1,214 / 2,748 | 1 / 1 / 1 |
| tree | 14,656 / 121,756 / 549,032 | 14 / 256 / 260 |
| PaintersTeaser | 0 / 0 / 97,056 | 1 / 1 / 20 |
| Chiperia5intro | 7,186 / 31,058 / 78,834 | 6 / 230 / 272 |
| PaintersEuphoria | 10,096 / 59,248 / 91,622 | 6 / 164 / 198 |
| PaintersFrustration | 718 / 47,366 / 175,654 | 3 / 153 / 210 |
| JeSuisRose | 0 / 22,040 / 62,002 | 1 / 10 / 20 |
| Everyway | 21,760 / 68,300 / 111,944 | 19 / 77 / 100 |

Radius distributions are dominated by small blobs: in most demos 60–85% of plots
have radius ≤ 10; the tails reach 70 (`JeSuisRose` skull, `Everyway`, `ball`).

Reproduce with:

```
g++ -O2 -std=c++11 -Ivisualizer -Ivisualizer/parser/rose bbc/tools/rosestats.cpp \
    visualizer/build/{translate,analysis,lexer,parser,node,list,typeinfo}.o -o rosestats
rosestats examples/<demo>.rose
```

## 3. Machine budget

- **CPU:** 2MHz × 1/50s = **40,000 cycles per 50Hz frame** (80,000 at 25fps,
  160,000 at 12.5fps), minus ~2–4K for vsync interrupt + music player.
- **Screen:** MODE 1, 320×256, 2bpp, 20KB at &3000–&7FFF. On the Master this lives
  in **shadow RAM (LYNNE)**, so it costs no main RAM. Byte = 4 pixels; horizontally
  adjacent 4-pixel groups are +8 bytes apart (character-row layout).
- **Main RAM:** ~29KB free (&0E00–&8000) with shadow mode on.
- **Sideways RAM:** 4 × 16KB banks for bytecode, music data, and (if needed) turtle
  state overflow.

Microbenchmarks (measured under emulation on a Master, BASIC-assembled, calibrated
against an empty CALL):

| Operation | Measured |
|---|---|
| Unrolled span fill, `STA abs,X` per byte (4 px) | **5.4 cycles/byte** |
| 32-bit add, zero page, incl. loop overhead | **45 cycles** (~40 net) |

Derived planning constants: 16×16→32 multiply via quarter-square tables ≈ 200–250
cycles; 32÷16 shift-subtract divide ≈ 400; interpreter dispatch ≈ 25; sine table
lookup ≈ 40; per-scanline span setup (row-table address computation + edge masks)
≈ 60; per-plot overhead (clip + bucket into per-Y list) ≈ 250.

### Per-frame cost model and projected frame rates

`cycles ≈ k·cpu68k + 5.4·bytes + 60·lines + 250·plots`, where k converts the
visualizer's 68000-cycle estimates to interpreted 6502 cycles. k ≈ 1.8 assumed
(68000 ops ~30 cycles each vs. ~55 for an interpreted 32-bit 6502 op); treat as
±40%. Applying this to the p50 / p95 frames:

| Demo | p50 cycles | p95 cycles | Sustained | Worst dips |
|---|---|---|---|---|
| circle | ~4K | ~4K | 50fps | — |
| ball | ~25K | ~28K | 50fps | — |
| tree | ~36K | ~260K | 50fps | ~8fps during peak growth burst |
| PaintersTeaser | ~3K | ~30K | 50fps | ~20fps momentarily (p99) |
| Chiperia5intro | ~15K | ~100K | 50fps | ~20fps in dense sections |
| JeSuisRose | ~10K | ~125K | 50fps | ~16fps in dense sections |
| PaintersFrustration | ~7K | ~160K | 50fps | ~12fps |
| PaintersEuphoria | ~30K | ~170K | 25–50fps | ~12fps |
| Everyway | ~100K | ~240K | ~12fps | ~8fps |

**Important structural constraint:** because trails persist, plots can never be
skipped — a slow frame delays the whole demo rather than dropping detail. Music
sync therefore requires the *worst* frame to fit the chosen tick, or the demo to be
authored so it does. A fixed 25fps tick (80K cycles) comfortably covers the p95
frame of everything except the three heavy Archimedes demos.

## 4. What ports directly vs. what must be rebuilt

Portable as-is (semantics from `visualizer/interpret.h` / `bytecode.h`):

- **Bytecode format** — single-byte opcodes, high-nibble dispatch, constants table.
  Programs are tiny (42B–16.5KB across all demos).
- **Numeric model** — all 16.16 fixed point, but `BC_MUL` reduces operands to 8.8
  first: only a **16×16→32 signed multiply** is ever needed (also `move` and the
  RNG). Division is 32-bit ÷ 16-bit integer. No 32×32 anywhere.
- **RNG** — `low16(seed)·$9D3D + wordswap(seed)`: one 16×16 multiply.
- **Sine** — language resolution is 256 direction units/circle; internal is 16384
  steps but a 256–1024-entry quarter table (0.5–2KB, Q14 amplitude) is visually
  indistinguishable at 320×256.
- **Scheduler** — per-frame linked lists of turtle continuations, free-list
  allocation, `wait` re-buckets by target frame. Replace the ARM engine's 44KB
  frame-indexed array with a **256-slot ring** (turtle `time` is absolute, so a
  popped turtle whose time is still in the future is simply reinserted).
- **Renderer architecture** — `arc/engine/circles.asm`'s two-stage approach
  (bucket each blob into a per-scanline list, then one Y-walk filling spans from
  per-radius half-width tables) is exactly right for a 6502. Half-width tables to
  r=70 cost Σ(2r+1) ≈ **5KB** — affordable.
- **No screen clear** — the single biggest win. Clearing 20KB would cost ~100K+
  cycles/frame on its own; Rose never clears.

Must be rebuilt:

| ARM engine feature | BBC replacement |
|---|---|
| Runtime ARM JIT (`jit.asm`) | Bytecode interpreter (v1); optional AOT 6502 codegen in `rose2bbc.py` (v2) |
| 256KB reciprocal table | Shift-subtract 32÷16 divide (~400 cycles; division is rare) |
| 64KB / 16384-entry sine table | 0.5–2KB quarter table |
| Hardware MUL | Quarter-square tables (2KB) → ~40-cycle 8×8 partials, ~220-cycle 16×16 |
| Barrel shifter (OP shifts, masks) | Loops/table tricks; shift opcodes are rare in scripts |
| Word-wide span fills, ARM addressing | Unrolled `STA abs,X` fills (5.4 cyc/byte measured), +8 stride, edge-mask tables |
| RISC OS SWIs, vsync event, QTM MOD player | OS EVNTV/direct System VIA vsync, ULA palette writes, SN76489 tracker player under IRQ |
| 12-bit RGB palette + fades | 8 fixed TTL colours (see §6) |

## 5. Proposed configuration and memory map

| Parameter | Archimedes | BBC proposal | Justification (measured) |
|---|---|---|---|
| MAX_TURTLES | 500 | 64 (v1), 128+ via sideways bank | 4 of 9 demos exceed 64; all their *p50* counts are ≤ 14 |
| MAX_STACK | 20 | 20 | Max observed 18 |
| WIRE_CAPACITY | 8 | 8 | Observed 0, but keep language-complete; 32B/turtle |
| Frame buckets | 11,000 × 4B | 256-slot ring × 2B | `time` is absolute; reinsert long waits |
| MAX_CIRCLES/frame | 200 | 128 | Max observed 146 (tree) |
| MAXRADIUS | 70 | 70 | Tables only 5KB; JeSuisRose/ball need it |
| Fixed point | 16.16 | **16.16 (unchanged)** | 8.8 can't hold x∈[0,320); keeps bit-exact verification against visualizer |

Turtle state: 8 state fields + 8 wires + 20 stack slots, 32-bit each ≈ 148B/turtle;
64 turtles ≈ 9.5KB. Store as **structure-of-arrays byte planes** (four parallel
arrays per field, turtle index in Y) so 32-bit arithmetic is straight indexed code.

Main RAM sketch (Master, shadow MODE 1):

| Region | Size |
|---|---|
| Engine (interpreter, math, renderer, scheduler) | ~6–8KB |
| Quarter-square mul tables | 2KB |
| Sine quarter table | 1–2KB |
| Circle half-width tables (r ≤ 70) + pointers | ~5.3KB |
| Turtle state (64 × 148B) | ~9.5KB |
| Scheduler ring + per-Y bucket heads + circle buffer | ~2KB |
| Colorscript + constants | ≤ 1KB typical |
| **Total** | **~27–30KB** (fits &0E00–&8000; bytecode + music in sideways RAM) |

A stock Model B (no shadow) loses 20KB to the screen and is viable only for
small demos with a CRTC-reduced display; the Master is the right primary target.

## 6. Colour — the real aesthetic constraint

All examples use `form 352 280 1 4`: one layer, four tints — a perfect match for
MODE 1's four logical colours. But the BBC ULA maps logical colours onto **8 fixed
TTL colours** (plus flashing): no intensity levels, no 12-bit RGB. Consequences:

- Palette *changes* are cheap and per-frame (ULA writes) — the colorscript format
  (frame-delta, index, RGB) ports unchanged.
- **Fades become 2–3 discrete steps** through whatever chain of the 8 colours best
  approximates the RGB ramp. `rose2bbc.py` quantises at conversion time; ports will
  want hand-tuned BBC colorscripts. Dither patterns are a possible extension but
  conflict with the solid-span renderer.
- Canvas is 320×256 vs. the 352×280 form: crop (centre window, clip in the
  renderer) for ports; new demos author at 320×256 directly.

## 7. Toolchain and verification

Pipeline mirrors the Archimedes one exactly — the visualizer already emits
`bytecodes.bin` / `constants.bin` / `colorscript.bin`, consumed by `rose2arc.py`:

```
source.rose → visualizer (compile) → .bin triple → rose2bbc.py → BeebAsm source
            → BeebAsm → .ssd disc image → jsbeeb / real Master
```

Verification strategy (the `jit_verify.py` philosophy, upgraded):

1. The visualizer's interpreter is the **ground truth**: it can dump the complete
   plot list `(t, x, y, r, c)` and headless PNGs.
2. The BBC interpreter runs in **jsbeeb via the MCP harness** (boot disc, run N
   frames, read plot log from memory, screenshot). Diff plots bit-for-bit against
   the visualizer — this is why keeping 16.16 semantics matters.
3. Microbenchmarks and per-routine cycle counts also run under jsbeeb
   (`run_for_cycles`, breakpoints), so the §3 cost model stays honest as code lands.

## 8. Phased plan

1. **`rose2bbc.py` + verification harness.** Emit BeebAsm from the .bin triple;
   build a plot-log diff script against visualizer output. No 6502 yet.
2. **Interpreter core, off-screen.** All opcodes, 32-bit math (quarter-square mul,
   shift-subtract div, sine table, RNG), SoA turtle state, fork free-list, 256-slot
   ring scheduler. Verify `circle`, `ball`, `tree` **bit-exact** in jsbeeb before
   drawing a pixel.
3. **Renderer.** Per-Y bucket lists, half-width tables, unrolled span fillers with
   edge masks, square variant, clipping. Benchmark real blobs/frame here — this
   validates or corrects the §3 projections.
4. **Frame loop + colour.** Vsync, fixed-tick pacing (50/25fps chosen per demo),
   colorscript playback with TTL quantisation.
5. **Music.** SN76489 player under IRQ (budget ~2–4K cycles/frame from day one).
6. **Optimisation.** AOT 6502 codegen (`rose2bbc.py --aot`) if interpretation shows
   up in profiles (~1.5–2× on the compute term); self-modifying fillers; sideways
   turtle-state banks to lift MAX_TURTLES.

## 8b. Measured engine performance (2026-07-22, phases 1-4 + fast filler)

Measured in jsbeeb on the working engine (frame counter sampled over exact
cycle windows, vsync-paced):

| Demo | Measured rate | Notes |
|---|---|---|
| circle | 50fps | trivial load |
| ball | **~17fps** (345 frames / 1000 slots) | 2 big blobs/frame ≈ 116K cycles |
| PaintersTeaser (dense) | **~11fps** | ~36 small blobs/frame |
| PaintersTeaser (idle) | 50fps | |

The generic renderer's per-scanline cost measured ~390 cycles (clip + span
setup + 2 masked edges + chain dispatch), not the ~60 the §3 model assumed;
middle bytes hit ~8 cycles/byte (vs 5.4 ideal).

**Update (same date): SWRAM span fillers implemented.** rose2bbc.py now
generates one fill routine per (left offset 0-3, pixel length 1-125) with
edge masks baked in — ~8KB per bank, *SRLOAD*ed into sideways banks 4/5 by
!BOOT and executable while ACCCON pages the shadow screen in. Middles jump
into a shared descending store chain fixed at &0E00. The engine is also
OS-free at runtime: vsync by polling System VIA IFR CA1, palette via direct
ULA writes (MODE 1 registers base+{0,1,4,5}), interrupts masked throughout.
Results: **ball 25fps locked** (from 17), circle 50fps, teaser dense
sections ~12-14 slots/frame — now interpreter+render bound (~36 blobs AND
heavy per-frame script work).

**Big-demo update (same date):** with turtle states in SWRAM bank 7
(MAXT=128), circle tables (full r<=70) in bank 6, a 256-entry dispatch
jump table, and an unclipped-blob fast path (per-blob phase arithmetic,
r<=62), the engine now runs and verifies **JeSuisRose** (17,374 plots) and
**Everyway** (186,679 plots, 8,838 frames, 101 concurrent turtles) —
bit-exact. Everyway paces at ~2.9 vsync slots/frame in the intro and 6-12.5
in the heaviest stretches (~12fps average vs the authored 50): playable,
correct, and the remaining gap is split between interpreter cost and
per-line render overhead, as §8b predicted. A 6845 overscan variant
(WIDE=1: R1=88, R6=29 -> 352x232, 20,416 bytes in shadow RAM) displays
Everyway's full form width. Still capacity-blocked at >128 turtles:
tree (262), Chiperia (273), Euphoria (200), Frustration (211) need wider
turtle handles plus a second state bank.

## 9. Risks

- **k-factor uncertainty** (±40% on the compute term). Mitigation: phase 2 measures
  real interpreter cycles in jsbeeb; the model self-corrects early.
- **Turtle-count spikes** (tree/Chiperia hit ~270 alive). 64-turtle v1 cap means
  those demos need authoring down or the sideways-RAM state extension; state
  copying on fork (~150B) also costs ~1K cycles per fork.
- **Per-line overhead dominates small-blob demos** (60-cycle assumption on 2,100
  lines = 126K cycles for Everyway's worst frame). If phase 3 can't hit 60,
  radius-specialised unrolled circle routines (one per r ≤ ~12, generated offline)
  are the fallback — trading a few KB of code for most of the per-line setup.
- **Music sync vs. no-skip rendering** (§3): worst frame must fit the tick. This is
  an authoring constraint, not an engine fix.

## 10. Bottom line

The Master 128 can run real Rose demos: everything up to `JeSuisRose` /
`Chiperia5intro` class fits a 25fps tick with headroom at 50fps most of the time,
using ~30KB of main RAM and standard sideways banks. The heavy Archimedes demos
don't port at full density — but Rose's trails-and-palette aesthetic, tuned to four
TTL colours and a 2MHz budget, is a natural fit for new BBC-native compositions.
