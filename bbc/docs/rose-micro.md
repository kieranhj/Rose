# Rose Micro — a 6502-native dialect of Rose

Written 2026-07-28, after the full BBC port (14 builds bit-exact, 9 pixel-perfect,
two speed passes, Tube split). This document asks a different question from
`feasibility.md`: not *"can the Master run Rose?"* (answered: yes, at 8–25fps for
Archimedes-authored material) but *"what would the language and runtime look like if
they had been designed for a 2MHz 8-bit machine in the first place?"*

Target: **50Hz consistently on a Master Turbo, 25Hz consistently on a stock Master**,
for material authored to the dialect.

---

## 1. What the port actually taught us

Everything below is measured on our own engine, not estimated.

### 1.1 The render cost law

After the §7c speed pass the renderer costs, per blob:

```
cycles ≈ 90 · (2r + 1)   +   5.4 · bytes        bytes ≈ π r² / 4
         └ per-line ┘         └ per-byte ┘
```

Validation: ball's two r=45 blobs → 33.6K predicted, **38.9K measured** (host
render+tick per frame). Good enough to design against.

What one 50Hz frame (40,000 cycles) buys:

| radius | lines | bytes | cycles/blob | blobs per 50Hz frame |
|---|---|---|---|---|
| 2 | 5 | 3 | 470 | 85 |
| 4 | 9 | 13 | 880 | 45 |
| 8 | 17 | 50 | 1,800 | 22 |
| 10 | 21 | 79 | 2,300 | 17 |
| 20 | 41 | 314 | 5,400 | 7 |
| 45 | 91 | 1,590 | 16,800 | **2** |

**Cost is quadratic in radius and the machine has no headroom for the tail.** ball —
two blobs, one turtle, the simplest demo in the set — is *render-bound at 25fps* and
gains nothing from a 4MHz coprocessor. Meanwhile 60–85% of plots in every demo have
r ≤ 10, where the *per-line* term (90 cycles of setup for ~4 bytes of payload)
dominates: at r=4, 92% of the cost is setup, 8% is pixels.

So there are two distinct render problems and they need different fixes:
- **small blobs** (the bulk): per-line setup overhead — fix with generated code.
- **big blobs** (the tail): raw area — can only be fixed by *not having them*.

### 1.2 The interpreter cost law

16.16 fixed point on an 8-bit CPU means every value is 4 bytes and every operation is
a 4-byte loop. Measured, after the §7d speed pass:

| operation | cycles |
|---|---|
| dispatch (jump table, 65C12) | 29 |
| push / pop (4 bytes via `(st),y`) | ~35 / ~30 |
| 32-bit add/sub, zp | ~45 |
| 16×16→32 multiply (quarter-square tables) | ~215 |
| 32÷16 divide (shift-subtract) | ~400 |
| sine lookup | ~40 |
| fork (144-byte state copy) | ~1,500 |

A typical `move` is dispatch + 2 sine lookups + 2 multiplies + 4 adds ≈ **700 cycles**
— 1.75% of a 50Hz frame for one turtle taking one step. The profile ranked umul16 at
12.5% and push/pop at 13.5% of interpreter time: **a quarter of the interpreter is
paying for word width we don't use.** Screen space is 320×256. We are computing
positions to 1/65536th of a pixel.

### 1.3 The capacity wall

Turtle state = 8 fields + 8 wires + 20 stack slots × 4 bytes = **144 bytes**. That
number, alone, forced:

- SWRAM bank paging for states (bank 7, MAXT=128),
- then 16-bit address-handles and the Tube parasite's flat 64K for the demos needing
  200–280 turtles (tree, Chiperia, Euphoria, Frustration, and waytoorude at 451 is
  still out of reach),
- ~1,500 cycles per `fork`.

At 32 bytes/turtle the same 280 turtles are 9KB — *main RAM, no paging, no
coprocessor*. The entire capacity engineering effort exists because of word width.

### 1.4 The timing model

Trails persist, so **no plot can ever be skipped** — a slow frame delays the demo
rather than dropping detail. That makes the *worst* frame set the tick, and the
worst-to-median gap is enormous (Everyway: p50 100K, p95 240K cycles). We currently
absorb this by beam-racing (records emit in `y−r` = raster order, so overruns degrade
to one horizontal seam) which is good, but it is damage control: the demo still
*slows down*, and slowing down is what breaks music sync.

Two structural facts we have not exploited:
- Overrun is a *variance* problem, not a throughput problem, for anything authored
  near budget. A bounded-lag draw queue converts "worst frame must fit" into
  "average frame must fit".
- We have never used the Master's second 20KB screen buffer.

### 1.5 What was right and must be kept

- **No screen clear.** Clearing 20KB/frame would cost more than everything else
  combined. Persistent trails are the reason this port works at all.
- Time-bucketed cooperative turtles, absolute `time`, ring scheduler.
- Single-byte opcodes, side constants table, offline resolution of jump targets.
- `(t, y−r)` stable emission order — it is simultaneously the correctness contract
  *and* raster order.
- The offline toolchain and the **bit-exact + pixel-perfect verification harness**.
  This is the port's superpower and any new dialect must inherit it (§6).

---

## 2. Design principles for the dialect

1. **The word is 16 bits.** Nothing in a 320×256 display justifies 32.
2. **Nothing scales quadratically at runtime.** Radius is bounded and, where possible,
   precompiled.
3. **Per-item fixed costs are compiled away, not optimised.** We have already
   optimised the generic per-line path twice; the remaining ~90 cycles/line is
   irreducible *as data-driven code*.
4. **The budget is a compile-time contract, not a runtime hope.** The toolchain
   already has the entire plot stream offline. It should refuse to build a demo that
   cannot hold its tick.
5. **Reductions must buy something visible.** Each restriction below is paired with
   what it funds.

---

## 3. Proposed reductions, with what each buys

### R1 — 16-bit fixed point (10.6) everywhere  ⭐ biggest single win

Range ±512 (screen is 0–319), resolution 1/64 px. Random-walk drift over 1,000 steps
is well under half a pixel.

| | 16.16 | 10.6 | gain |
|---|---|---|---|
| add/sub | 45 | ~19 | 2.4× |
| multiply | 215 | ~90 (3 partials) | 2.4× |
| push/pop | 35/30 | ~19/16 | 1.9× |
| turtle state | 144 B | 32 B | 4.5× |
| fork | ~1,500 | ~350 | 4× |

Expected interpreter speedup **2–2.5×** overall, plus §1.3's capacity wall
disappearing. Cost: bit-exactness with the *current* visualizer is lost — the
visualizer and pyinterp need a Micro numeric mode (§6). This is the price of
admission and should be paid first.

**Measured (§8):** 10.6 positions are confirmed — drift is 0.1–0.5 px mean across
the corpus and 11.5 (1/32 px) is visibly worse, so 6 fractional bits is the floor
*and* the ceiling. Two amendments: every reduction must **round to nearest**, never
truncate (§8.3), and applying 10.6 to *all values* rather than just geometry breaks
bit-pattern code and needs a language decision first (§8.6). The 24-bit position
variant is not needed.

### R2 — Direction is a 16-bit 8.8 register; sine is a 1024-step table

*(Amended by measurement — see §8.4. The original proposal here was a one-byte
direction and a 256-entry sine; the byte direction is fine but a 256-step sine is
the single largest error term in the whole model.)*

Direction is a 16-bit register in units of 1/256 circle with 8 fractional bits, so
`turn` is a 16-bit add and wrapping is free. Sine is a **1024-step, Q12** table —
on the 6502 a 256-entry quarter table of 16-bit entries (**512 bytes**) with the
usual quadrant mirroring, and the same single 16×16 multiply a Q8 table would need.
Going from 256 to 1024 steps cuts Everyway's drift 2.7× for half a kilobyte.

### R3 — Radius is a 4-bit brush index, max 15 (escape hatch for big discs)

The r≤15 restriction is the one that makes 50Hz *achievable* rather than *lucky*: it
caps a single blob at ~3.3K cycles (current model) and lets us precompile painters
(R6). A `disc` opcode keeps large filled circles available for the rare deliberate
use (title screens, ball-class demos) at the generic path's cost, with the budget
checker (R8) accounting for them honestly.

The brush table is per-demo: the compiler collects the radii actually used and assigns
indices. Most demos use fewer than 8 distinct radii.

### R4 — Stack ≤ 8 slots, locals ≤ 8, no wires by default (4 optional)

Measured max stack across the nine examples is 18, but that is Archimedes-authored
recursion; 8 slots × 2 bytes = 16 B and the compiler can *prove* the bound offline
(it already walks the call graph). No example uses wires; logicos does, so keep 4
slots as an opt-in build flag rather than a per-turtle tax.

### R5 — No runtime division; fused, byte-operand opcodes

- Division costs ~400 cycles and is rare. Restrict to compile-time-constant divisors
  → reciprocal multiply. A `div` by a runtime value becomes a compile error.
- Add `const8` (inline byte operand, sign-extended) — most constants are small.
- Add superinstructions for the profiled hot patterns: `move+draw`, `turn+move`,
  `add local, const`, `loop` (counter in a local, decrement-and-branch). Each fused
  op removes a dispatch (29 cyc) and 2–4 stack ops (~50–100 cyc).
- Consider a **register/direct-operand model** instead of a pure eval stack: ops name
  their local slot directly. Push/pop is 13.5% of interpreter time and most of it is
  moving values between adjacent slots.

### R6 — Precompiled brush painters (replaces per-line setup)  ⭐ biggest render win

Generate, offline, straight-line 6502 for each (brush radius, x-offset 0–3) pair the
demo actually uses, into sideways RAM — exactly as we already generate span fillers,
but per *blob* instead of per *span*.

Shape: 2–3 self-modified base addresses per blob (one per character row band), then
`ldy #imm : sta BASE,y` chains (7 cyc/byte interior, ~13 for the two masked edge
bytes). Per-line setup goes to zero.

| radius | current | precompiled | gain |
|---|---|---|---|
| 4 | 880 | ~300 | 2.9× |
| 8 | 1,800 | ~800 | 2.3× |
| 10 | 2,300 | ~1,200 | 1.9× |

Code cost is the constraint: ~900 B per variant at r=10, ×4 offsets. So this is
demand-driven — the toolchain knows the frequency of every (r, offset) pair from the
plot stream and fills the available SWRAM greedily, hottest first, with the generic
path as fallback. Two 16KB banks ≈ all offsets of r ≤ 8 plus the hot offsets of
r ≤ 12, which typically covers >70% of plots.

*Cheaper variant if code space is tight:* quantise blob x to byte boundaries (4px in
MODE 1). One variant per radius instead of four, no edge masks, whole-byte stores at
5 cyc/byte. Costs positional smoothness — probably fine for organic/blobby material,
definitely not for text (see the MODE 2 verdict in `hoffman-demos.md`).

### R7 — Bounded-lag draw queue (decouple simulation time from draw time)

The interpreter runs the frame clock; the renderer drains a record ring at whatever
rate it manages, permitted to lag up to N frames (N ≈ 4–8, 6 B/record → 1.5KB at 256
records). Music and simulation stay locked to the tick; only pixels lag, and because
trails are additive and persistent, a few frames of lag on a dense scene is close to
invisible.

This converts the tick contract from **worst frame < budget** to **mean frame <
budget, worst burst < N × budget** — which, given the p50/p95 gaps we measured, is
the difference between "25fps with dips to 8" and "locked 25fps".

Ordering is preserved (the ring is FIFO), so erase-class records still behave.

### R8 — Compile-time budget enforcement

The toolchain already replays the whole program offline (`roseplots`, `pyinterp`,
`expected_plots.bin`). It should apply the §1.1/§1.2 cost model per frame and report:

```
tick 20ms (50Hz): mean 61%, p95 88%, worst frame 1,247 = 104%  ← FAIL
  frame 1247: 31 plots (r=12 ×4, r=6 ×27) + 9 forks
```

with `--budget 50 | 25` as a build flag that *fails the build*. Consistency at 50Hz
is not an engine property, it is an authoring property; this is the tool that makes
it one. Combined with R7 the check is on the *windowed mean*, which is far less
brittle than a per-frame ceiling.

---

## 4. Screen and buffering options

These are orthogonal to §3 and can be mixed; the cost model above is MODE 1.

**S1 — MODE 1, single buffer, beam-raced (today's model).** 320×256, 4 colours, 20KB
in shadow, 29KB main free. Overruns show one horizontal seam. Best resolution, best
proven. Default.

**S2 — MODE 1, double-buffered (shadow + main).** Display buffer selected by ACCCON
bit 0, CPU buffer by bit 2. Because trails persist, *every record must be drawn
twice* — either dual-write per line (flip ACCCON per span pair, ~8 cyc/line extra,
setup shared) or replay the previous frame's ring into the new back buffer. Costs
~1.6–2× render and 20KB of main RAM.

What it buys is not smoothness but **determinism**: an overrunning frame shows the
*previous complete frame* instead of a partial one, so a 25Hz cadence latch is
genuinely rock-solid and never seams. Only affordable because R1 frees the main RAM
that turtle state used to need. Recommended as a per-demo flag, not a default.

**S3 — MODE 5/4 (160×256).** Halves bytes per blob at the same physical size; if you
also author at 160 wide, blob cost drops ~3× (fewer lines *and* fewer bytes). 10KB
buffers mean **double buffering fits with room to spare**, and a stock Model B
becomes a plausible target. Costs horizontal resolution — the MODE 2 mock-ups showed
that 2:1 X destroys text but graphics-led scenes survive fine. Strong candidate for
new BBC-native compositions that lean organic rather than typographic.

**S4 — MODE 2 (160×256, 4bpp) dual playfield.** Pixel = `(l1<<2)|l0`, 16 palette
entries computed as `l1 ? colour(l1) : colour(l0)` — the ULA does dual-playfield
compositing for free, with exact erase-reveals-layer-0 semantics and all 8 tints.
Same byte count as MODE 1. Rejected for logicos on text legibility; **the right
choice for a graphics-led two-layer demo** authored for it.

**S5 — 1bpp-per-layer in MODE 1.** bit 0 = layer 0, bit 1 = layer 1, full 320 width,
exact dual-playfield semantics, no drop-mask apparatus. Costs: one foreground colour
per layer at a time. Cleanest option for text-and-graphics dual-layer work.

---

## 5. Three packaged configurations

### Config A — "Rose-B 25" (stock Master, no coprocessor, locked 25Hz)
R1–R6, R8; S1. Single buffer, beam-raced, 25Hz cadence latch.
Expected: the mid-tier corpus (teaser, Chiperia, tree, logicos-class) at **locked
25Hz**; newly-authored material at 50Hz with the budget checker holding the line.
Everyway/Euphoria/Frustration still need authoring down — no dialect fixes 19,000
framebuffer bytes in a frame.

### Config B — "Rose-M 50" (Master, coprocessor-free, 50Hz for authored material)
A + R7 (lag queue) + tighter budget (r ≤ 8 brushes, ~25 plots/frame). Optional S2 or
S3 for tear-free output. This is the *design-for-the-machine* target: new
compositions, 50Hz, no dips, music locked.

### Config C — "Rose-T" (Master Turbo, 50Hz at Archimedes-ish density)
Same dialect, existing split: interpreter on the parasite, renderer on the host. With
R1 the parasite becomes almost free (its share was 15–72% at 32-bit widths), so the
host runs a pure render loop — and with R6 the render side is 2–3× faster too.
Realistic expectation: **most of the existing corpus at 25Hz locked, authored
material at 50Hz**, and S2 double-buffering affordable because the host has one job.

---

## 6. Non-negotiable first step: keep verification

The port's reliability comes entirely from bit-exact plot logs and pixel-perfect
screen compares against the visualizer. A new numeric model breaks that on day one
unless it is implemented *upstream first*:

1. ~~Add a Micro mode to `visualizer/interpret.h`~~ **DONE** (`visualizer/micro.h`,
   env-driven, default output bit-identical — see §8.1); still to do in
   `bbc/tools/pyinterp.py` when the engine work starts.
2. Re-baseline `expected_plots.bin` / `pyplots.bin` under Micro semantics.
3. Only then write 6502.

Steps 1–2 are also where the *artistic* question gets answered cheaply: run the
existing demos through Micro semantics in the visualizer and look at them. If 1/64px
and 15-pixel brushes look wrong there, no amount of 6502 will help.

---

## 7. Recommended order of investigation

Cheap experiments that de-risk the expensive decisions, roughly in dependency order:

| # | Experiment | Answers | Effort |
|---|---|---|---|
| 1 | ~~Micro numeric mode in the visualizer; replay all 9 demos + logicos~~ **DONE — see §8** | Does 10.6 / byte-direction / brush-radius *look* right? Drift? | small |
| 2 | Microbenchmark a 10.6 `move` handler in isolation under jsbeeb | Is the 2–2.5× interpreter estimate real? | small |
| 3 | Generate one precompiled brush painter (r=8, offset 0–3), benchmark vs `render_blob` | Is R6's 2–3× real, and what is the true code size per variant? | small |
| 4 | Budget checker in `rose2bbc.py` against the current cost model | Which existing demos are already inside a 25/50Hz contract? | small |
| 5 | Lag-queue prototype on the current engine (no dialect change needed) | How much of the p50/p95 gap does it actually absorb? | medium |
| 6 | S2 dual-write fillers on the current engine, ball + teaser | True cost of tear-free double buffering | medium |

Experiments 4 and 5 need no new dialect at all and would improve the *existing*
engine — worth doing regardless of whether Rose Micro gets built.

---

## 8. Experiment 1 results — the 16-bit model, measured (2026-07-28)

### 8.1 What was built

`visualizer/micro.h` + hooks in `interpret.h` let the **reference** interpreter
emulate the 16-bit machine, driven by environment variables so the visualizer,
`roseplots` and anything else calling `translate()` all pick it up:

```
ROSE_MICRO=1  ROSE_POSQ=6  ROSE_DIRQ=8  ROSE_SINB=10  ROSE_SINA=12
ROSE_ROUND=1  ROSE_RMAX=0  ROSE_VALQ=0
```

`POSQ` = fractional bits of x,y; `DIRQ` = fractional bits of the direction
register (unit = 1/256 circle); `SINB`/`SINA` = sine table index bits / amplitude
bits; `ROUND` = round-to-nearest instead of truncate; `RMAX` = brush radius cap;
`VALQ` = fractional bits of *every* expression value. With `ROSE_MICRO` unset the
output is bit-identical to before (regression-checked against the committed
`expected_plots.bin` for ball, circle and JeSuisRose).

Supporting tools, both new:
- `bbc/tools/plotdiff.py` — pairs two plot streams index-for-index, reports
  per-frame count agreement, positional drift percentiles, and drift by time band
  (so accumulation is visible).
- `bbc/tools/plotrender.py` — offline PNG renderer for a plot stream, using the
  GL shaders' exact coverage rules (disc `dx²+dy² < (r+0.5)²`, square for `plot`,
  layer compositing, colorscript palette). `roseplots` now also dumps a `.cs`
  colorscript sidecar and prints `LAYERS`.

### 8.2 Headline: the geometry model works

Final configuration — **10.6 position, 8.8 direction, 1024-entry Q12 sine,
round-to-nearest** — against the 32-bit reference over all ten programs:

| demo | plots | mean drift | p95 | max | plots identical | final-screen pixels differing |
|---|---|---|---|---|---|---|
| ball | 20,000 | 0.00 px | 0.00 | 0 | 100% | 0 |
| JeSuisRose | 17,374 | 0.00 | 0.00 | 0 | 100% | 0 |
| logicos | 166,944 | 0.01 | 0.00 | 1 | 99.4% | 0 |
| circle | 257 | 0.08 | 1.00 | 1 | 92.2% | 35 (0.04%) |
| euphoria | 77,169 | 0.14 | 1.00 | 6 | 91.9% | 0 |
| Everyway | 186,679 | 0.14 | 1.00 | 4 | 88.5% | 333 (0.34%) |
| frustration | 39,614 | 0.14 | 1.00 | 2 | 86.5% | 1,895 (1.9%) |
| teaser | 1,547 | 0.16 | 1.00 | 1 | 84.6% | 571 (0.6%) |
| Chiperia | 14,096 | 0.34 | 1.41 | 2 | 68.3% | 3,403 (3.5%) |
| tree | 4,144 | 0.46 | 1.41 | 1 | 56.6% | 6,952 (7.1%) |

Three demos are **pixel-identical** and one (logicos, a font engine with
one-pixel glyph strokes and 1-pixel-wide UI chrome) is pixel-identical too — the
strictest legibility test in the corpus survives untouched, because those demos
position absolutely (`jump`) rather than by turtle walking. The rest differ only
where organic squiggles are inherently chaotic; the composition, density and
character are indistinguishable (`mockups/micro-chiperia-1563.png`).

`tree` is the outlier and it is *not* a precision failure: a rand-driven branch
flips at frame 90, so from there it grows a different — equally valid — tree.
logicos likewise loses 7 plots of 166,987 to one late branch flip.

### 8.3 Round-to-nearest is not optional

Truncating toward −infinity (what a naive `>>` gives you) puts a systematic
−0.5 LSB bias on every position update, which integrates into linear drift.
Rounding costs one add before the shift and turns it into a zero-mean random walk:

| | circle | teaser | Chiperia | frustration | Everyway |
|---|---|---|---|---|---|
| truncating, mean drift | 1.39 px | 0.69 | 0.70 | 0.28 | 0.17 |
| rounding, mean drift | **0.08** | **0.16** | **0.34** | **0.14** | **0.14** |
| truncating, pixels differing | 786 | 1,896 | 6,223 | 3,470 | 295 |
| rounding, pixels differing | **35** | **571** | **3,403** | **1,895** | 333 |

The visible symptom is closure: a turtle walking a full circle with truncation
does not return to its start, leaving a seam
(`mockups/micro-circle-closure.png`). With rounding the circle closes.
**Spec rule: every fixed-point reduction in the engine rounds, never truncates.**

### 8.4 Which reduction actually costs accuracy

Ablations on teaser / Chiperia / Everyway (mean drift, truncating build):

| variant | teaser | Chiperia | Everyway | reading |
|---|---|---|---|---|
| full micro, 256-entry sine | 0.79 | 0.96 | 0.46 | baseline |
| position kept 32-bit | 0.59 | 0.75 | 0.44 | **10.6 position costs almost nothing** |
| direction kept 32-bit | 0.79 | 0.96 | 0.43 | **8.8 direction accumulation is free** |
| position 11.5 (1/32 px) | 1.37 | 1.43 | 0.48 | 1/32 px is visibly worse — 1/64 is the floor |
| sine 512-entry Q10 | 0.75 | 0.71 | 0.26 | |
| sine 1024-entry Q12 | 0.69 | 0.70 | **0.17** | |
| sine/direction kept 32-bit | 0.65 | 0.68 | 0.08 | sine resolution is the dominant term |

So: **the sine table's index resolution is the error budget, not the word width.**
Direction can be a 16-bit 8.8 register (its accumulation precision is irrelevant),
positions want exactly 6 fractional bits, and the table should be 1024 steps per
circle at Q12 — which on the 6502 is a 256-entry quarter table of 16-bit entries
(**512 bytes**) and the same single 16×16 multiply as a Q8 table. Cheap, and it
cuts Everyway's drift by 2.7×.

### 8.5 Two range findings that change the spec

**Position range ±512 is not always enough.** Turtles fly well off-canvas:
Euphoria overflows 10.6 on 2,915 of 80,182 position updates (3.6%), Everyway on
2,026 (0.6%), Frustration and logicos a handful. On a real 16-bit engine those
wrap and would drag blobs back into view as garbage. Options: saturating adds on
x/y only, an offline range check in the budget checker (§R8 — it already replays
the whole program), or authoring inside the canvas. This is cheap to detect and
should be a compile-time error rather than a runtime surprise.

**The brush cap needs its escape hatch, as suspected.** Share of plots clamped at
`RMAX=15`: circle/tree/teaser/Chiperia **0%**, logicos 0.4%, Euphoria 14%,
JeSuisRose 15%, Frustration 31%, Everyway 26%, ball **100%**. The small-blob
demos are untouched; the demos that use big discs to *fill area* fall apart —
JeSuisRose's final flood-fill leaves holes (`mockups/micro-jesuisrose-brush.png`).
R3's `disc` opcode is therefore mandatory, not optional.

### 8.6 The one reduction that needs redesign: 16-bit *values*

Applying 10.6 to every expression value (`VALQ=6`) is the aggressive half of R1,
and it breaks two things:

- **logicos loses 23% of its plots** (166,987 → 128,678) and the font engine
  visibly disintegrates — glyphs corrupt, icons distort, text turns to noise
  (`mockups/micro-logicos-values.png`). Cause: the font engine holds glyph rows as
  integer bit patterns and rotates them (`>><`). Rose stores an integer *N* as
  *N*<<16, so in 10.6 only the top 6 bits of a pattern survive.
- **tree overflows 18% of its multiplies** (1,199 of 6,590); Euphoria 2% and the
  rest under 0.1%.

Everything else survives VALQ with negligible damage. The conclusion is not
"16-bit values are impossible" but "**a single 10.6 interpretation of all values
is wrong**". The dialect needs either a distinct integer/bitwise domain (bitwise
ops and shifts treat the 16-bit word as a bit pattern, arithmetic treats it as
10.6 — which is natural on a machine whose word *is* 16 bits, and makes a 16-bit
glyph row fit exactly), or a documented convention that bit-pattern data lives in
the low bits. Either way it is a language decision to make deliberately, and the
geometry win (R1's state-size and speed gains) does not depend on it.

### 8.7 Verdict

The artistic question is answered: **yes**. 10.6 positions, a 16-bit direction
register and a 1024-entry sine give drift of ~0.1–0.5 px mean and ≤1 px p95
across the whole corpus, four of ten demos come out pixel-identical, and the
text-heavy demo is untouched. Two amendments to §3 fall out of the measurement
(round-to-nearest everywhere; sine at 1024/Q12 rather than 256/Q8), two range
issues get pushed into the compile-time budget checker (§R8), and the value model
(§8.6) is the one piece that needs a language decision before any 6502 is written.

Reproduce:
```
ROSE_MICRO=1 ROSE_POSQ=6 ROSE_DIRQ=8 ROSE_SINB=10 ROSE_SINA=12 ROSE_ROUND=1 \
  bbc/tools/roseplots.exe examples/Chiperia5intro.rose micro.bin 10000
python bbc/tools/plotdiff.py ref.bin micro.bin
python bbc/tools/plotrender.py ref.bin out.png --frame 1563 --label ref \
  --compare micro.bin --label2 micro
```

## 9. Bottom line

The three things that cost us most on the BBC are all *width* problems, not algorithm
problems: 32-bit words for a 320×256 screen, 144-byte turtles, and unbounded radii.
Fixing all three is a ~2–2.5× interpreter win, a 2–3× small-blob render win, a 4×
capacity win, and it frees the 20KB that makes double buffering possible — without
touching the parts of Rose that make it Rose (persistent trails, forking turtles,
time buckets, colorscripts).

The remaining gap to *guaranteed* 50Hz is not an engine property. It is a contract
between the composer and the machine, and §R8 is how the toolchain enforces it.
