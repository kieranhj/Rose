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
cycles ≈ 666  +  90 · (2r + 1)  +  12 · bytes        bytes ≈ π r² / 4
         └ per-blob ┘  └ per-line ┘   └ per-byte ┘
```

*(Corrected in §10 from direct measurement — `bbc/tools/rendercost.mjs` times
render_blob per radius on real demos. The original model here had no per-blob
term and used 5.4 cycles/byte, which understated small blobs by 2×.)*

What one 50Hz frame (40,000 cycles) actually buys, measured:

| radius | lines | bytes | cycles/blob (measured) | blobs per 50Hz frame |
|---|---|---|---|---|
| 0 | 1 | 1 | 514 | 77 |
| 2 | 5 | 3 | 1,117 | 35 |
| 4 | 9 | 13 | 1,773 | 22 |
| 8 | 17 | 50 | 3,183 | 12 |
| 10 | 21 | 79 | 4,085 | 9 |
| 20 | 41 | 314 | 8,772 | 4 |
| 30 | 61 | 707 | 15,034 | 2 |
| 45 | 91 | 1,590 | ~26,000 | **1** |

A one-pixel blob costs 514 cycles to paint.

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
— 1.75% of a 50Hz frame for one turtle taking one step. *(§9 measured it: the real
figure is 1,456 cycles, twice this estimate.)* The profile ranked umul16 at
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

*(All of the above are now measured — see §9.3. The directions are right; `move`
goes 1,456 → 686 and a state copy 2,576 → 560, but the overall interpreter
speedup is **1.75×**, not the 2–2.5× claimed next, because dispatch does not
improve.)*

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

### R5 — No runtime division; fused, byte-operand opcodes  ⭐ promoted by §9.5

*(Measurement promoted this from a nice-to-have to the second pillar: dispatch is
13% of interpreter time and is the one cost the 16-bit word does nothing for.
Everyway executes 138,618 dispatches at 28.8 cycles — 4.0M cycles that fusing
`const`+`op` and `rlocal`+`op` would largely remove.)*

- Division costs ~400 cycles and is rare. Restrict to compile-time-constant divisors
  → reciprocal multiply. A `div` by a runtime value becomes a compile error.
- Add `const8` (inline byte operand, sign-extended) — most constants are small.
- Add superinstructions for the profiled hot patterns: `move+draw`, `turn+move`,
  `add local, const`, `loop` (counter in a local, decrement-and-branch). Each fused
  op removes a dispatch (29 cyc) and 2–4 stack ops (~50–100 cyc).
- Consider a **register/direct-operand model** instead of a pure eval stack: ops name
  their local slot directly. Push/pop is 13.5% of interpreter time and most of it is
  moving values between adjacent slots.

**Measured in §13, and it changes the shape of the advice.** Fusion is worth
109 cycles when it keeps a value out of the eval stack and 7 when it only
removes a dispatch — so the superinstructions to build are producer→consumer
pairs (`rlocal+op`, `const+move`, `rlocal+wait`), not the frequent-but-idle
push/push pairs. The last bullet is the right one: every worthwhile fusion in
the measured top fifteen is an op naming its operand directly, which is what a
direct-operand encoding gives you for free and in one byte. On the 16.16 engine
the whole set is worth 9.3% of interpreter time, at the bottom of the estimate
above; the value for Micro comes from the one-byte encoding, not from the pairs.

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

**Measured (§10): 2.0–3.2×, best at small radii, ~510 B per variant at r=8.**
Code cost is the constraint: ~900 B per variant at r=12, ×4 offsets. So this is
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

**Amended by §11.6: N ≈ 4–8 is far too small.** Measured against every demo, the
smallest queue depth that holds a 25Hz contract is 32–512 frames where it is
attainable at all, and for five of ten demos no depth up to 512 works. The overruns
are not jitter, they are whole scenes arriving at once — seconds wide, not frames.
A queue still helps (depth 8 absorbs 35–60% of the peak) but it cannot be the
mechanism that makes 50Hz a guarantee. R8 is.

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

**Built and validated — see §11.** `bbc/tools/budget.py` predicts the mean frame
within ±2% and picks out the same worst frames the machine does.

### R9 — Cheaper record ordering (new, from §11.3)

Every frame that draws anything pays ~6,000 cycles to `flush_sorted` before a single
pixel is written — a radix scan that puts records in (y−r) order so overlapping
blobs composite correctly. That is **15% of a 50Hz frame as a fixed tax**, paid by a
frame with one blob in it just as much as by a frame with forty.

It was invisible to every earlier measurement because it is not an opcode and not
part of the renderer; it only appeared when frames were costed individually. Options,
in increasing order of disruption: keep the buckets live across the frame instead of
rebuilding them (the emit path already knows each record's key); drop to a single
pass by clamping the key to a byte (R1 makes the screen 8-bit-addressable in y
anyway); or drop ordering entirely for material that does not overlap within a frame,
which the toolchain can prove offline.

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
| 2 | ~~Microbenchmark a 10.6 `move` handler in isolation under jsbeeb~~ **DONE — see §9** | Is the 2–2.5× interpreter estimate real? | small |
| 3 | ~~Generate one precompiled brush painter (r=8, offset 0–3), benchmark vs `render_blob`~~ **DONE — see §10** | Is R6's 2–3× real, and what is the true code size per variant? | small |
| 4 | ~~Budget checker against the measured cost model~~ **DONE — see §12** | Which existing demos are already inside a 25/50Hz contract? | small |
| 5 | ~~Fuse the hot opcode pairs; measure one for real~~ **DONE — see §13** | Is R5's 8–12% real, and does the encoding have room? | small |
| 6 | Lag-queue prototype on the current engine (no dialect change needed) | How much of the p50/p95 gap does it actually absorb? | medium |
| 7 | S2 dual-write fillers on the current engine, ball + teaser | True cost of tear-free double buffering | medium |

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

## 9. Experiment 2 results — measured interpreter costs (2026-07-28)

Experiment 1 asked whether the 16-bit model *looks* right. This one asks whether it
is *fast* enough to be worth the disruption — specifically whether §R1's estimated
"2–2.5× interpreter speedup" survives contact with a real 6502.

### 9.1 What was built

Two tools, both reusable beyond this experiment:

- **`bbc/tools/opcost.mjs`** — per-execution cost of every opcode handler on a real
  demo run. `profile.mjs` answers "where do the cycles go"; this answers "what does
  one `move` cost". A per-instruction hook charges cycles to the last *handler*
  entered, so helper subroutines (`sinlook`, `smul16`, `push_RA`) land on their
  caller. `OPCOST_EXTRA=sinlook,smul16` splits helpers out when wanted.
- **`bbc/bench/`** — a standalone 65C12 benchmark (`micro.asm`, built and run by
  `build.sh` via `run.mjs`) implementing the Micro primitives with the *same*
  quarter-square tables and calling conventions as `engine/interp.asm`. Each
  benchmark is bracketed by `.bs_*` labels; the harness runs to each in turn and
  diffs the cycle counter, subtracting an empty loop and a call scaffold.
  `move16q8` is **validated** against a JS replay of the identical integer
  arithmetic (256 stepped moves must land on the same x,y) — a fast `move` that is
  wrong proves nothing, and the check caught two real bugs while writing it.

### 9.2 What the current engine actually costs

Measured with `opcost.mjs` (ball, circle and Everyway agree to within a cycle or
two on the shared handlers):

| handler | executions (Everyway) | mean cycles |
|---|---|---|
| `op_move` | 4,704 | **1,456** |
| `op_div` | 1 (ball) | 2,565 |
| `op_fork` | 1,157 | 1,518 |
| `op_mul` | 6,093 | 569 |
| `op_wait` | 1,379 | 270 |
| `op_neg` | 4,992 | 173 |
| `op_op` (add/sub/and/or) | 13,096 | 141 |
| `op_wlocal` | 5,091 | 122 |
| `op_const` | 28,634 | 116 |
| `op_wstate` | 21,511 | 114 |
| `op_when` | 6,480 | 114 |
| `op_rlocal` | 25,791 | 106 |
| dispatch | 138,618 | 28.8 |

First correction to §1.2: a `move` costs **1,456 cycles, not the ~700 estimated** —
3.6% of a 50Hz frame for one turtle taking one step. Of that, ~433 is the two
`sinlook` calls (a polynomial evaluation, not a table read — it exists to stay
bit-exact with the visualizer's `sin()`), and ~570 the two `smul16` calls.

### 9.3 What the Micro primitives cost

Measured in `bbc/bench` on the same emulated Master:

| primitive | 16.16 | Micro 16-bit | ratio |
|---|---|---|---|
| add, zero page | 38 | **20** | 1.9× |
| push + pop one stack slot | 95 | **51** | 1.9× |
| signed multiply | 283 (16×16→32) | **160** (16×8→24) | 1.8× |
| `op_const` | 116 | **37** | 3.1× |
| `op_rlocal` | 106 | **61** | 1.7× |
| `op_wstate` | 114 | **65** | 1.8× |
| `op_op` (add) | 141 | **62** | 2.3× |
| `move` | 1,456 | **686** (Q7 byte sine) | **2.1×** |
| `move` | 1,456 | 1,193 (Q12 word sine) | 1.2× |
| state copy | 2,576 (144 B) | **560** (32 B) | 4.6× |
| dispatch | 28.8 | 28.8 | **1.0×** |

The Micro `move` is a straight-line handler: pop a 10.6 distance, take `dir >> 6`
as a 1024-step table index, read sine and cosine (the cosine is the *same* X one
page along — a quarter turn is exactly 256 entries), two signed multiplies with
rounding, two 16-bit position adds.

### 9.4 Q7 byte sine vs Q12 word sine — the one real design choice

A byte sine table halves the multiply (two partial products instead of four) and
that alone is worth **507 cycles per move** — the difference between 2.1× and 1.2×.
It costs accuracy two ways: 1024 entries of 8 bits instead of 16, and a signed byte
cannot hold +128, so the peak clamps to 127 (a 0.8% shrink at the extremes — a
uniform scale error, which preserves shape and closure).

Measured drift for the byte table, against the 32-bit reference:

| | teaser | Chiperia | Everyway |
|---|---|---|---|
| Q12 word sine | 0.16 px | 0.34 px | 0.14 px |
| Q7 byte sine | 0.31 px | 0.52 px | 0.15 px |

Both are comfortably sub-pixel. **Take the byte table**: 1KB, half the multiply
cost, and drift that experiment 1's own criterion calls invisible. Keep Q12 as the
build option for anything that turns out to need it.

### 9.5 The honest overall number: 1.75×, not 2–2.5×

Weighting the measured per-op costs by Everyway's real opcode mix
(`bbc/tools/interpmix.py`; ops with no benchmarked Micro equivalent get a
conservative estimate):

```
total                     29.76M -> 17.06M cycles    speedup 1.74x
handlers only (no dispatch)     25.77M -> 13.07M     speedup 1.97x
```

So **§R1's estimate was optimistic: the interpreter gets ~1.75×, not 2–2.5×.** The
handlers themselves do hit ~2×, but dispatch is 13% of interpreter time and the
numeric model does nothing for it — 138,618 dispatches at 28.8 cycles is the second
largest line item in the table after `move`.

Two consequences for the spec:

1. **R5 (fused superinstructions) is promoted from nice-to-have to the second
   pillar.** Every fused op removes a 29-cycle dispatch *and* the push/pop pair
   around it; `const`+`op` and `rlocal`+`op` alone would remove a large share of
   the 138K dispatches. This is where the rest of the 2.5× lives.
2. **The capacity win is bigger than the speed win, and it is the one that changes
   what is possible.** 32-byte states put 280 turtles in main RAM with no paging,
   no address handles, and no coprocessor — 4.6× cheaper forks as a side effect.

Also worth noting: `sched` (the per-frame turtle list walk plus state save/restore)
costs 3,402 cycles per execution and 8.9% of Everyway's whole run. It is not in the
table above because it is not an opcode, but it shrinks with state size too — it
pages banks and copies `ip`/`evx`/state fields that all halve under Micro.

### 9.6 Verdict

The 16-bit model is worth building, but for a corrected reason. It buys:

- **~1.75× on the interpreter** (~2× on the handlers), measured, not estimated;
- **4.6× on turtle state**, which retires the entire capacity apparatus;
- and it makes dispatch the next thing to attack, which R5 already covers.

What it does *not* buy is a 50Hz Everyway: at 1.75× the interpreter, Everyway's
interpreter+emit half goes from ~5.8fps-equivalent to ~10, and the renderer — 44%
of that run and untouched by any of this — still needs R6. The two levers are
independent and both are needed.

Reproduce:
```
node bbc/tools/opcost.mjs bbc/build/everyway 150     # 16.16 per-op costs
bash bbc/bench/build.sh                              # Micro primitives + validation
python bbc/tools/interpmix.py                        # weighted comparison
```

## 10. Experiment 3 results — precompiled brush painters (2026-07-28)

R6 claims that generating straight-line 6502 per (radius, x-offset) removes the
per-line setup that dominates small blobs. This measures both halves of the
claim: how much faster, and how many bytes.

### 10.1 What was built

- **`bbc/tools/rendercost.mjs`** — charges every cycle spent in the render code
  (render_blob, the SWRAM span fillers, the shared store chain) to the *radius*
  of the record being drawn, read from `REC` at each `render_blob` entry. This
  is what produced the corrected cost law in §1.1.
- **`bbc/bench/genpaint.py`** — the painter generator. For a radius and offset
  it resolves every span's byte count, edge masks and column offsets at
  generation time and emits straight-line code. Output is validated
  **byte-exact against a Python model of the same blob** (a 4KB framebuffer
  compared in full), so the speed numbers are for a painter that draws the
  right pixels.
- **`bbc/tools/paintbudget.py`** — combines painter sizes, measured costs and a
  demo's real radius histogram into a SWRAM-budget table.

The one thing a painter cannot bake is the *vertical* walk: MODE 1 puts
consecutive scanlines +1 apart inside a character row and +633 at the row
boundary, and a blob's phase within the row is only known at draw time. So each
line ends with `jsr nextline` (a countdown plus a 16-bit increment) and
everything else — which byte, which mask, which column — is compiled in.

### 10.2 Measured

Painter figures include a realistic per-blob setup (screen address from x,y via
row/column tables, character-row phase — ~110 cycles), because the generic
figures include theirs:

| radius | painter, off 0 | painter, off 1 | generic (measured) | speedup | code, 4 offsets |
|---|---|---|---|---|---|
| 2 | 408 | 348 | 1,117 | **2.7–3.2×** | 388 B |
| 4 | 649 | 722 | 1,773 | **2.5–2.7×** | 872 B |
| 8 | 1,387 | 1,474 | 3,183 | **2.2–2.3×** | 2,040 B |
| 12 | 2,324 | 2,453 | 4,857 | **2.0–2.1×** | 3,648 B |

So R6's "2–3×" is real, and — importantly — **the win grows as the blob shrinks**,
which is the right shape: 60–85% of plots in every demo are r ≤ 10. Fitted, a
painter costs `29 + 73.5·lines + 4.1·bytes` against the generic
`666 + 90·lines + 12·bytes`: the per-blob term nearly vanishes and the per-byte
term drops 3×, but the per-line term only drops from 90 to 73.5.

That residual is where the next lever is: **12 of those 73.5 cycles are the
`jsr nextline` call overhead itself.** Inlining the walk costs ~7 bytes per line
and would take r=8 from 1,387 to ~1,190 (another 15%). Above r≈13 the painter
and the generic path converge, so painters are worth generating only up to
r≈12 — which is exactly where R3's brush cap sits anyway.

### 10.3 Code size and what it covers

Per-radius cost of all four x-offsets, cumulative from r=0:

| radii | SWRAM | | radii | SWRAM |
|---|---|---|---|---|
| 0–4 | 2.1 KB | | 0–11 | 16.5 KB |
| 0–6 | 4.5 KB | | 0–12 | 20.1 KB |
| 0–8 | 8.2 KB | | 0–15 | 33.6 KB |

Under R1 the turtle states leave sideways RAM for main RAM, which frees a whole
16KB bank — enough for **radii 0–11**. Against real demos:

| demo | painters | plots covered | render time saved |
|---|---|---|---|
| logicos | 2.1 KB (r≤4) | 95.6% | **46.5%** |
| logicos | 8.2 KB (r≤8) | 98.2% | 49.8% |
| Chiperia | 13.3 KB (r≤10) | 98.5% | **52.9%** |
| teaser | 20.1 KB (r≤12) | 100% | **52.2%** |
| Everyway | 13.3 KB (r≤10) | 64.8% | 10.8% |
| Everyway | 33.6 KB (r≤15) | 74.0% | 15.8% |

### 10.4 The honest limit: R6 only fixes the small-blob half

Everyway is the outlier and it is the important one. Three quarters of its plots
are r ≤ 16, but they are a small fraction of its *render bill* — the cost is
quadratic in radius, so its r=20–70 blobs dominate, and no amount of generated
code touches them. **Painters cannot fix a demo made of big discs.**

This is §1.1's two-problems split, now with numbers on both:

- **small blobs** — R6 removes 2–3× of the cost, and for demos authored to small
  brushes that is ~50% of the entire render bill for 2–20KB of sideways RAM;
- **big blobs** — only R3 (cap the radius) fixes them, by not having them.

R3 and R6 are therefore a package, not alternatives: capping the radius is what
makes *all* plots painter-eligible, and once they are, the saving is ~50% of
render time. Applied to a demo authored for the dialect, that plus §9's 1.75×
interpreter is what a 50Hz budget is built from.

Two limitations of the generated painters to design around:

1. **No clipping.** A painter draws its whole blob unconditionally, so it can
   only be used when the blob is fully on-screen — a bounding-box test at setup,
   with the generic path as the fallback. The engine already culls fully
   off-screen blobs, so this only affects blobs straddling an edge.
2. **Circles only.** `plot` (square) blobs need their own generated variants;
   they are cheaper per line (constant width) so the case is at least as good.

Reproduce:
```
REC_ADDR=c9a node bbc/tools/rendercost.mjs bbc/build/everyway 120
bash bbc/bench/paintbuild.sh 2 4 8 12
python bbc/tools/paintbudget.py <plots.bin>
```

## 11. Experiment 4 results — the budget checker, and what it says about the demos (2026-07-28)

Experiments 1–3 measured *pieces*. This one assembles them into a model of a whole
frame, checks that model against the machine, and then asks the question the spec
exists to answer: **which of our own demos are already inside a 25Hz or 50Hz
contract, and what stops the rest?**

### 11.1 What was built

- **`bbc/tools/budget.py`** — replays a build's bytecode through `pyinterp` and costs
  every frame: per-opcode handler costs (§9.2) + dispatch, the record emit path, the
  measured render law per radius (§10), and the per-frame scheduler and sort terms.
  Reports mean / p50 / p95 / worst against a 25Hz or 50Hz tick, names the worst frame
  and what was in it, and with `--fail` exits non-zero — R8 as an actual build gate.
  `--micro` re-costs the same program under the Rose Micro projection, `--tube` under
  the coprocessor split, `--lag N` under an R7 draw queue.
- **`bbc/tools/frametime.mjs`** — the ground truth. `profile.mjs` aggregates regions
  over chunks of frames; this one flushes a row at every `frame_tick`, so each frame's
  interp / emit / render / idle cost is recorded separately. Without it the model
  would be a plausible-looking spreadsheet.
- **`pyinterp.py`** gained a `stats=` hook: per frame, a counter of executed opcode
  bytes plus turtle activations and live turtles. Three inserted lines, no change to
  the semantics it exists to verify.

### 11.2 Validating the model — this is the part that matters

A budget checker nobody has checked is worse than no budget checker. Predicted
against measured, per frame, on four single-CPU builds spanning the range (ball is
render-bound, teaser is nearly idle with rare spikes, JeSuisRose is fill-heavy,
Everyway is the monster):

| demo | predicted mean/frame | measured | bias | per-frame error (median) | (p95) |
|---|---|---|---|---|---|
| ball | 52,797 | 52,585 | **+0.4%** | 2.5% of a 25Hz frame | 3.0% |
| teaser | 3,044 | 2,813 | **+8.2%** | 0.3% | 0.3% |
| JeSuisRose | 29,529 | 29,134 | **+1.4%** | 0.3% | 29.9% |
| Everyway | 163,284 | 161,492 | **+1.1%** | 4.3% | 36.5% |

More important than the mean: **the model picks out the same worst frames the machine
does**, and costs them to within 1–9% (teaser frame 70: predicted 608,660, measured
616,716; Everyway frame 1474: 536,825 vs 520,845). Its one known weakness is ball,
whose measured frames alternate between ~52K and ~74K on a period the model does not
capture — there it under-predicts the peak by 24%.

Two things fell out of doing this properly:

- **Frame alignment.** Predicted frame *f* corresponds to the measured row *f+1* —
  the engine reaches `frame_tick` after the frame's work, not before. Scanning
  offsets −2..+2 lifted Everyway's correlation from 0.939 to **0.995** and cut its
  median per-frame error from 19,175 cycles to 3,400. An off-by-one in the time base
  is indistinguishable from "the model is roughly right", which is exactly why it has
  to be looked for.
- The per-*activation* scheduler term fits to **zero**. That matched `opcost.mjs`
  measuring the scheduler proper at 30 cycles per entry — the 3,400 cycles previously
  attributed to `sched` were something else entirely (§11.3).

### 11.3 Two corrections to the cost model

**(a) Squares and discs are different laws.** `PLOT` records are squares, and they
were being costed with the disc law. Fitted over 43 measured square radii:

```
square:  261 + 86.9 · lines + 7.62 · bytes        bytes = lines² / 4
disc:    379 + 143.7 · lines + 8.07 · bytes       bytes = π r² / 4
```

This matters more than it sounds: 85% of Everyway's records and 79% of JeSuisRose's
are squares. The §1.1 law also over-charges small discs badly (768 predicted vs 514
measured at r=0), so `budget.py` uses the measured per-radius table for r ≤ 26 and
the fit only beyond it.

**(b) `flush_sorted` is a ~6,000-cycle fixed tax on every frame that draws.** Split
out with `OPCOST_EXTRA=flush_sorted`, it costs 6,694 cycles/frame on ball (two
records), 9,815 on Everyway (seventeen) and 806 on teaser (which mostly draws
nothing) — i.e. almost all of it is a fixed radix scan, not per-record work. The
fitted model is `6,070 per drawing frame + 740 per record`.

Nothing before this experiment could see it. It is not an opcode, so `opcost.mjs`
folded it into `sched`; it is not in the renderer, so `rendercost.mjs` never saw it;
and averaged over a whole run it hides inside "interp". **It is 15% of a 50Hz frame,
paid before a single pixel is written** — and it is now R9.

### 11.4 Which demos are inside a contract today

Stock Master, current 16.16 engine, as a share of the tick:

| demo | 25Hz mean | p95 | worst frame | frames over 25Hz budget | verdict |
|---|---|---|---|---|---|
| circle | 26% | 26% | 33% | 0% | **50Hz** |
| ball | 66% | 71% | 71% | 0% | **25Hz** |
| teaser | 3% | 1% | 761% | 0.6% | — |
| JeSuisRose | 41% | 295% | 503% | 13.0% | — |
| chiperia | 82% | 414% | 680% | 19.0% | — |
| frustration | 95% | 595% | 1,490% | 28.4% | — |
| euphoria | 150% | 606% | 788% | 57.2% | — |
| logicos | 172% | 572% | 895% | 49.7% | — |
| tree | 287% | 1,095% | 3,993% | 54.7% | — |
| Everyway | 341% | 621% | 1,807% | 86.1% | — |

Two of ten. And the two that pass are the two simplest programs in the set.

The interesting column is the gap between **mean** and **worst**. teaser spends 97%
of its run at 1% of budget and then hits one frame at 761%; frustration's median
frame is 18% of budget and its p95 is 595%. This is not a machine that is uniformly
too slow — it is material whose *density is wildly uneven*, which is precisely the
authoring property R8 exists to expose. Everyway is the exception: it is over budget
on 86% of its frames and no amount of scheduling saves it.

Under the projections, same programs, worst-frame basis:

| demo | 16.16 stock | Micro stock | 16.16 Tube | Micro Tube |
|---|---|---|---|---|
| ball | 25Hz | **50Hz** | 25Hz | **50Hz** |
| circle | 50Hz | 50Hz | 50Hz | 50Hz |
| chiperia | — | — | — | — |
| Everyway | — | — | — | — |

(Micro + Tube brings chiperia's *mean* to 19% of a 25Hz tick and 38% of a 50Hz one —
comfortably inside — but its worst frame is still 234%. Every demo except ball and
circle fails on peaks, not on averages, in every configuration.)

### 11.5 The interpreter is what fails, not the renderer

Per-demo split of the predicted bill, interp+emit vs render:

```
logicos 91/9   tree 85/15   circle 83/17   teaser 79/21   chiperia 74/26
JeSuisRose 69/31   euphoria 67/33   frustration 60/40   Everyway 59/41   ball 29/71
```

**Ball is the only render-bound program in the set**, and it is the one demo whose
entire content is two large discs. For everything else the interpreter is 60–91% of
the cost — which reorders the spec's priorities: R1 (16-bit) and R5 (fused opcodes)
are the levers that matter for real material, and R6, whose 2–3× is the most
spectacular number in this document, only helps the minority of the bill for nine of
ten demos.

The worst frames say the same thing more bluntly. tree's worst frame is 3.13M cycles
of interpreter for **10,648 opcodes and 256 forks** against 46K of rendering;
frustration's is 945K of interpreter for 3,757 opcodes against 197K of rendering.
Nothing done to the renderer touches those frames.

### 11.6 R7 needs 32–512 frames of lag, not 4–8

`budget.py` reports the smallest draw-queue depth that would hold each contract:

| demo | 16.16 stock @25Hz | 16.16 Tube @25Hz | Micro Tube @25Hz | Micro Tube @50Hz |
|---|---|---|---|---|
| teaser | 256 | 64 | **32** | 128 |
| JeSuisRose | none ≤512 | 256 | **64** | none ≤512 |
| chiperia | none ≤512 | 256 | **32** | 256 |
| frustration | none ≤512 | none ≤512 | none ≤512 | none ≤512 |

At 25Hz, 32 frames is 1.3 seconds of visual lag and 256 frames is ten seconds. The
spec's N ≈ 4–8 was calibrated against the p50/p95 gap; the actual overruns are not
statistical jitter but **whole scenes arriving in one tick** — teaser's frame 70 forks
18 turtles and emits 40 records at once. A depth-8 queue does help (it absorbs 35–60%
of the peak: teaser 761%→496%, frustration 1,490%→596%) and it is cheap, so keep it.
But it is a smoother, not a guarantee. The guarantee has to come from R8 refusing the
build.

### 11.7 Verdict

R8 is no longer a proposal; it exists, it is validated to ±2% on the mean and it
finds the same bad frames the hardware does. What it reports is uncomfortable and
useful:

1. **Two of ten demos meet a contract today**, and only on a stock machine at 25Hz.
2. **The failures are peaks, not averages** — for six demos the median frame is
   comfortably inside budget. That is an authoring problem with a tool-shaped
   solution, which is the entire thesis of §2.
3. **The interpreter dominates for 9 of 10 demos**, so R1/R5 outrank R6 for real
   material even though R6 has the better headline number.
4. **R7 as specced does not work** at any plausible lag depth, and
5. **R9 exists**: a 6,000-cycle-per-frame record sort that no previous measurement
   could see.

Reproduce:
```
node bbc/tools/frametime.mjs bbc/build/everyway ft-everyway.csv 400
python bbc/tools/budget.py bbc/build/everyway --validate ft-everyway.csv
python bbc/tools/budget.py bbc/build/teaser --report --lag 8
python bbc/tools/budget.py bbc/build/ball --hz 25 --fail
```

---

## 12. Recommendations after experiments 1–4 (2026-07-28)

Four experiments in, the evidence supports a different plan from the one §3 proposed.
This section says what to do about the demos we have, and what to build for the
material we would author next.

### 12.0 The record is more expensive than the drawing

Two things found by reading the engine while writing §11, both of which reorder
everything below:

**`emit_rec` is 100% verification.** All 370–470 cycles of it are the rol32 record
hash and the prefix log — the apparatus that lets `runverify.mjs` prove a build
bit-exact. Only `build_rec` (~125 cycles) actually constructs the record. It is
unconditional, in every build, including ones nobody will ever verify.

**`flush_sorted` scans all 256 buckets** whether or not anything was filed in them
(`ldx #0 … inx / bne so_bloop`, ~12 cycles per empty bucket, once or twice per
frame). Measured over every demo, the span of bucket keys actually used in a drawing
frame is far narrower than the array:

| demo | records/frame | mean key span | scan wasted |
|---|---|---|---|
| circle | 2.0 | 2 | 99% |
| ball | 2.0 | 6 | 98% |
| logicos | 18.1 | 21 | 92% |
| teaser | 7.5 | 21 | 92% |
| JeSuisRose | 15.9 | 26 | 90% |
| chiperia | 10.1 | 48 | 81% |
| tree | 20.5 | 60 | 77% |
| euphoria | 15.8 | 82 | 68% |
| Everyway | 22.7 | 84 | 67% |

Put together with §11.3, one record costs **1,585 cycles of bookkeeping before a
pixel is drawn** — 125 to build, 400 to hash and log, 320 of bank glue, 740 in the
sort — against **514 cycles to paint an r=0 blob**. For the small-blob material that
is 60–85% of every demo, *the engine spends three times more on bookkeeping than on
drawing*. That is the leak, and neither the numeric model (R1) nor the painters (R6)
touch it.

### 12.1 The existing demo set

Framing first: **this set is the benchmark corpus, not the port target.** It was
authored for a machine roughly 20× faster, and §11.4 shows its overruns are
structural — Everyway is over budget on 86% of its frames, tree's worst frame is
3.13M cycles of interpreter for 10,648 opcodes. No engine work puts this material
inside a contract. What engine work can do is raise the average frame rate:

| lever | removes | worth (of a 50Hz frame) | risk |
|---|---|---|---|
| `IF VERIFY` around the hash and prefix log ✅ | 237–400 cyc/record, always paid | **measured 3–15%** (§12.5) | none — verification builds keep it |
| Scan only the filed bucket range ✅ | 67–99% of a 256-entry scan, ×1–2 per frame | **measured 10–14%** (§12.5) | none — ordering unchanged |
| R5 fusion (`const`+`op`, `rlocal`+`op`) on the 16.16 engine | ~⅓ of 138K dispatches plus their push/pop pairs | ~~8–12% (estimated)~~ **9.3% of interpreter, measured — §13** | low — arithmetic identical |
| R6 painters | 46–53% of *render* | 4% (logicos) to 14% (chiperia) | 2–20KB of sideways RAM |

**Without a coprocessor** the first three are worth ~20–30% together. That moves
nothing across a contract boundary: ball stays locked at 25Hz, circle at 50Hz, and
everything else stays variable-rate. R6 is the weakest lever here and should be
skipped — painters do not reach ball's r=30/45 blobs, and ball is the only
render-bound demo in the set (§11.5).

**With the coprocessor** the measured 1.93× already puts teaser, JeSuisRose,
chiperia and frustration *means* inside a 25Hz tick; the first three levers take
chiperia's mean to roughly 30% of it. What remains is entirely peaks, so the
coprocessor configuration's outstanding work is peak-shaving — a depth-8 queue and
the sort fix — not throughput. Everyway is out of reach in every configuration.

### 12.2 Rose Micro: revised priority order

§3 leads with R1 and R6. The measurement says lead with R1 and with everything that
attacks the fixed per-record and per-frame costs, because interp+emit is 60–91% of
the bill for nine of ten programs (§11.5).

1. **R1 (16-bit)** — 1.75× on the interpreter, 4.6× on state. Unchanged; it is the
   foundation and it retires the entire capacity apparatus.
2. **R5 (fused opcodes)** — dispatch is 13% of interpreter time and R1 does nothing
   for it.
3. **R9 plus a narrow record path** — design the sort out rather than optimise it:
   emit in y order by construction, or keep the offline-verdict-bit mechanism
   (already built twice — the t4 drop mask) to mark frames whose records provably
   cannot overlap and skip ordering entirely. Make the record 4 bytes and the emit
   path straight-line, and ship the hash behind `VERIFY`.
4. **R3 + R6 as a package** — and as much for *predictability* as for speed: a capped
   radius with a precompiled painter makes each blob's cost a known constant, which
   is what makes a build-time guarantee possible at all.
5. **R7 at depth 8** — a smoother, explicitly not a guarantee (§11.6).

### 12.3 What the author is buying

Per-plot cost under the Micro projection, from §11.4:

| configuration | cycles/plot | blobs per 50Hz frame | per 25Hz frame |
|---|---|---|---|
| Micro, stock Master | 4,700–6,500 | **6–9** | 12–17 |
| Micro + Tube | 2,000–3,100 | **13–20** | 26–40 |

Everyway's authored density is 21.1 plots/frame. So **Micro + Tube reaches roughly
Archimedes-authored density at 50Hz, and Micro on a stock Master reaches it at
25Hz** — which is exactly the target this document opened with, and it holds.

The corollary matters more than the numbers: cost is dominated by interpreter work
*per blob*, not by blob *size*. The authoring discipline is "fewer, cheaper turtle
steps", not "smaller blobs". Concretely, budget about **8 blobs and at most 8 forks
per frame at 50Hz on a stock Master** — a fork costs ~700 cycles under Micro, so 57
of them is an entire frame, and tree's 256-fork frame is 4.5 frames of work on its
own.

### 12.4 The contract

Gate on the **worst frame**, not the mean: peaks are the failure mode and no
plausible queue absorbs them. With a depth-8 queue the right check is a worst
8-frame window inside budget *plus* a single-frame ceiling of about 4× budget.
`budget.py --hz 50 --lag 8 --fail` implements both today. Wire it into the Micro
build as a hard gate; leave it advisory for the legacy 16.16 builds, where eight of
ten demos would fail it.

### 12.5 The two zero-risk changes, built and measured (2026-07-28)

Both changes from §12.1's top two rows are in. Neither alters what the engine draws
or the order it draws it in, so the whole verification contract still applies
unchanged — and does: **all 15 builds bit-exact, all 10 pixel-perfect.**

**`-D VERIFY=0`.** `emit_rec`'s entire body is now inside `IF VERIFY`. Verification
builds are the default (`build.sh` and `buildtube.sh` pass `VERIFY=1` unless the
environment overrides it), so `runverify.mjs` is unaffected; a release build drops
the per-record rol32 hash and the prefix log and keeps everything else.

**Narrow the emit scan.** `flush_sorted` now tracks the lowest and highest bucket
each pass actually files (`SMIN`/`SMAX`, in two free zero-page slots) and walks only
that range. Two details made it fit: the range trackers had to be zero page rather
than `SCRATCH` — logicos-tube's parasite had 14 bytes of headroom and the first
version overran it — and the "nothing filed this pass" case needs no test, because
`SMIN`/`SMAX` of 255/0 walks bucket 255 then bucket 0, both necessarily empty, and
stops. Net cost is 23 bytes.

Measured with `frametime.mjs`, mean busy cycles per frame over the same frames:

| demo | baseline | + scan range | + `VERIFY=0` | saved |
|---|---|---|---|---|
| ball | 52,586 | 47,777 (−9.1%) | 46,946 (**−10.7%**) | 5,640 |
| Everyway | 140,368 | 135,809 (−3.2%) | 130,422 (**−7.1%**) | 9,946 |
| JeSuisRose | 29,131 | 28,192 (−3.2%) | 26,987 (**−7.4%**) | 2,145 |
| teaser | 2,813 | 2,719 (−3.3%) | 2,616 (**−7.0%**) | 197 |

The percentages understate it, because both savings land only on frames that draw
and are otherwise flat. Normalised to a drawing frame:

| demo | drawing frames | saved per drawing frame | as % of a 50Hz budget |
|---|---|---|---|
| Everyway | 84% | 11,855 | **29.6%** |
| JeSuisRose | 22% | 9,930 | **24.8%** |
| teaser | 2.4% | 8,208 | **20.5%** |
| ball | 100% | 5,640 | **14.1%** |

So a drawing frame is **5,600–11,900 cycles cheaper — 14–30% of a 50Hz tick** — for
23 bytes of code and a build flag. ball, the only demo that was already inside a
contract on a stock machine, goes from 66% of its 25Hz tick to 59%.

Two things worth recording:

- **The fixed sort tax is gone.** Refitting the model against the new engine gives
  `830 per drawing frame + 910 per record`, where it was `6,070 + 740`. The remaining
  per-frame constant is small enough to stop being a design concern; what is left
  scales with records, which is what R9 wanted.
- **The hash is the expensive half of the verification cost, not the log.** Everyway
  saves 5,387 cycles/frame over 22.7 records = 237 per record, below `emit_rec`'s
  measured 368, because its prefix log fills early and most records only pay the
  hash after that.

`budget.py` has been refitted to the new engine (biases +0.3% to +8.6% across the
four demos, and ball's median per-frame error improves from 2.5% to 0.6% of a 25Hz
frame) and gained `--release` to cost a `VERIFY=0` build.

---

## 13. Experiment 5 results — R5 fusion, explored and measured (2026-07-28)

§12.1 listed R5 fusion as the last unmeasured lever for the existing demo set,
at an estimated 8–12%. This section replaces the estimate with a measurement:
one fused opcode built for real and run on the machine, and a calibrated model
that says what the rest of the set would buy.

### 13.1 What was built

**`bbc/tools/pairs.py`** — the fusion analyser. It replays a build through the
reference model and counts every *statically adjacent* executed opcode pair.
Three things had to be got right before the numbers meant anything:

- **Only fall-through pairs count.** A branch target, tail, proc entry or wait
  resume landing on the second op of a pair makes that pair unencodable. A new
  `pairs=` hook in `pyinterp` records both the fall-through counts and the set
  of offsets ever reached any other way, so the fusible/blocked split is
  *observed* rather than assumed. It is also nearly free: **99.3% of all
  fall-throughs across the ten demos are fusible**, and the DONE marker (which
  `rose2bbc.py` resolves away, and which is always a control-flow join)
  accounts for most of the rest.
- **Pairs overlap.** In `const rlocal op` a compiler may take `const+rlocal` or
  `rlocal+op`, never both. `--tile` runs a DP over each fall-through chain,
  weighted by execution count, so the answer is what a compiler could actually
  claim rather than a sum of competing counts.
- **Most pairs are worth almost nothing** (§13.3).

**`interp.asm`: opcode `&32` = `op_rlop`**, the fused `rlocal[i] + op(o)`, with
`ROSE_FUSE=1` making `rose2bbc.py` emit it. 44 bytes, behind `-D FUSE` and off
by default. It loads the local straight into `RA` and joins `op_op` at the new
`op_op_go` label, so the value never touches the eval stack; net stack effect
is zero, exactly as the pair it replaces.

### 13.2 The encoding has 15 free bytes, and they are free by construction

The 16.16 opcode space is fully allocated — 16 low ops, seven 16-wide class
ranges, and 128 constants with an escape at 126 that logicos reaches. Union
across all ten demos leaves 32 unused bytes, but most are unused by accident
and a new demo would claim them.

Fifteen are different. `when` defines six condition codes out of sixteen and
`op` defines eleven out of sixteen, so **ten `when` slots and five `op` slots
can never be emitted by any program**. `&32` (the absent ROXR) is one of them.
That is the real fusion budget on the current engine, and it needs no
re-encoding, no toolchain version flag and no change to any existing build.

### 13.3 Fusion is only worth it when it keeps a value off the eval stack

Ranking pairs by frequency is misleading. `const + rlocal` executes 998,030
times — second most of any pair — and fusing it saves almost nothing, because
both halves still push. What a fusion can remove is:

| what the fusion removes | cycles | example |
|---|---|---|
| producer → consumer: the whole push/pop round-trip | 50 + 52 | `rlocal + op` |
| in-place producer → consumer: the result write and its read-back | 40 + 52 | `op + wlocal` |
| the dispatch | 28.8 | every fusion |
| *less* the fused operand byte it must carry | −22 | every fusion |

With no free 16-slot *range* left, every fused opcode is two bytes, so the
operand fetch is unavoidable. That makes a dispatch-only fusion worth **7
cycles** and a round-trip fusion worth **109** — a factor of fifteen. The
fifteen highest-value fusions are, without exception, producer→consumer.

### 13.4 Measured: 108 cycles per fusion, on the machine

`rlocal+op` built, verified and measured with `frametime.mjs` over identical
frame ranges. **All four A/B builds are bit-exact** (ball, teaser, JeSuisRose,
Everyway).

| demo | fusions | interp base | interp fused | saved/frame | of interp | of busy frame |
|---|---|---|---|---|---|---|
| ball | 24,575 | 8,601 | 8,070 | 530 | **6.2%** | 1.1% |
| JeSuisRose | 17,735 | 20,064 | 19,680 | 383 | **1.9%** | 1.2% |
| teaser | 1,606 | 1,460 | 1,441 | 19 | **1.3%** | 0.9% |

All three give **108 cycles per fusion** — the same number to within a cycle,
against a model that predicted 109. The model's stack terms are therefore
sound, and `pairs.py` is calibrated (`FETCH = 22`, the one term that had to be
fitted: the operand fetch and nibble split, net of the `opsave` decode it
replaces).

### 13.5 What the whole set would buy

With the calibrated model, greedy selection by *marginal* gain (ranking by
standalone value picks wrong — `op + wlocal` is second by value and adds 0.02
Mcyc, because `rlocal+op` has already claimed its partner):

| opcodes | share of interpreter |
|---|---|
| 1 (`rlocal+op`) | 4.5% |
| 5 | 6.3% |
| 10 | **9.3%** |
| 15 (the whole free budget) | 9.6% |
| unlimited | 11.0% |

Ten opcodes get 85% of the ceiling; the set is `rlocal+op`, `rlocal+wstate`,
`const+wait`, `rlocal+wait`, `rstate+op`, `rlocal+mul`, `const+move`,
`const+wstate`, `rlocal+move`, `rlocal+when`. Per demo, 7.4% (teaser) to 18.1%
(ball) of interpreter time.

### 13.6 The constraint is code space, not opcode space

`op_rlop` costs **44 bytes**, so ten cost ~440. logicos-tube's parasite has
**242 bytes spare** — adding the single prototype unconditionally broke its
`ASSERT rose_data_end <= SORTBASE` immediately, which is why `-D FUSE` exists.
So on the tightest build the affordable set is about five opcodes (6.3%), not
ten, unless space is reclaimed first.

### 13.7 Verdict

**R5 on the 16.16 engine lands at the bottom of §12.1's estimated range: 9.3%
of interpreter time, not 8–12% of the frame.** Interpretation is 60–91% of the
bill for nine of ten demos, so that is ~6–8% of a busy frame for the
interpreter-bound ones and ~2% for render-bound ball. Like every other lever in
§12, it moves no demo across a contract boundary, with or without the Tube.

It is a different proposition for Rose Micro, and the reason is arithmetic, not
enthusiasm:

- A from-scratch encoding can reserve a **full 16-slot range**, so fused
  opcodes are one byte and the 22-cycle operand penalty disappears.
- Micro's push+pop is 51 cycles against 16.16's 95 (§9.3), but its *handlers*
  are ~2× cheaper too, so fusion's share of the remaining interpreter is
  roughly unchanged — while the absolute cost of *not* fusing is now a larger
  fraction of a much smaller total.
- Stacking the measured numbers: R1's 1.75× times R5's ~1.10× ≈ **1.9× on the
  interpreter**, which is where §9.5's missing "2–2.5×" actually lives.

The prototype stays in the tree behind `-D FUSE` / `ROSE_FUSE=1` — bit-exact,
measured, and costing nothing when off. Turning it on for real means building
the ten-opcode set and re-running the full fifteen-build sweep, which is only
worth doing as part of Rose Micro's encoding, where the operand byte goes away.

Reproduce:
```
python bbc/tools/pairs.py --all --tile 10 --greedy     # the analysis
ROSE_FUSE=1 bash bbc/bin/build.sh ball-fz ball         # the prototype
node bbc/tools/runverify.mjs bbc/build/ball-fz
node bbc/tools/frametime.mjs bbc/build/ball-fz out.csv 400
```

## 14. Bottom line

The three things that cost us most on the BBC are all *width* problems, not algorithm
problems: 32-bit words for a 320×256 screen, 144-byte turtles, and unbounded radii.
Fixing all three is a ~2–2.5× interpreter win, a 2–3× small-blob render win, a 4×
capacity win, and it frees the 20KB that makes double buffering possible — without
touching the parts of Rose that make it Rose (persistent trails, forking turtles,
time buckets, colorscripts).

The remaining gap to *guaranteed* 50Hz is not an engine property. It is a contract
between the composer and the machine, and §R8 is how the toolchain enforces it —
built and validated in §11, where it reports that two of our ten demos are inside a
contract today, that the rest fail on peaks rather than averages, and that for nine
of ten the *interpreter*, not the renderer, is what has to get cheaper.
