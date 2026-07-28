# Rose Nano — a BBC-native dialect designed from the machine up

Written 2026-07-28, alongside `rose-micro.md` and before any Micro implementation work.

`feasibility.md` asked *"can the Master run Rose?"* (yes, 8–25fps).
`rose-micro.md` asked *"what would Rose look like if designed for a 2MHz 8-bit machine?"*
and answered it by **squeezing**: narrower words, capped radii, precompiled painters,
a lag queue, a budget checker. Every reduction there is measured, and the result is a
real dialect — but it is still recognisably Rose viewed through a smaller aperture.

This document asks a third question: **what would you build if you started from the
BBC Micro's strengths rather than from Rose's requirements?**

Target: **stock BBC Model B with sideways RAM** (not a Master, no coprocessor),
**MODE 2**, **locked 50Hz**, with the appearance of far more happening on screen —
and far more than 8 colours — than the hardware nominally offers.

> **Status: nothing in this document is measured.** Every cycle count below is an
> estimate derived from the *measured* constants in `rose-micro.md` §9–§13. §10 lists
> the experiments that would turn them into facts. This is deliberately the opposite
> of the Micro doc's evidentiary standard, and the reader should treat it that way.

---

## 1. The thesis: constant costs, not smaller ones

Rose Micro's headline problem is not that things are expensive. It is that
**every cost is variable**:

- render cost is *quadratic in radius* (§1.1: 514 cycles for one pixel, 26,000 at r=45)
- interpreter cost depends on word width and on which ops happen to run (§1.2)
- frame cost depends on how many turtles happened to wake (§1.4: Everyway p50 100K,
  p95 240K cycles)

Almost every piece of machinery in the Micro design exists to cope with that variance:

| Micro apparatus | exists because |
|---|---|
| R3 radius cap + `disc` escape | blob cost is unbounded |
| R6 demand-driven painter generation, D3d generation set | blob cost varies by radius *and* x-offset |
| D3c clipping cases | blobs straddle screen edges at arbitrary offsets |
| R7 bounded-lag draw queue | worst frame ≫ median frame |
| R8 compile-time budget checker | a demo can silently exceed the tick |
| D5 adaptive cadence | the budget cannot always be met |
| beam-raced `(t, y−r)` emission | overruns must degrade gracefully |

Rose Nano's premise: **make every cost constant and that entire column disappears.**

- One blob = one fixed-size byte stamp at a grid-aligned address. Always the same cost.
- One turtle = at most one blob per frame. Blobs/frame ≤ turtles, by construction.
- Frame cost = turtles × constant + fixed overhead. There is no worst case.

No budget checker, no lag queue, no cadence adaptation, no clipping cases, no painter
generation set. Not because they were optimised away — because the problem they solve
does not exist.

This is not a smaller Rose. It is a different bargain, and §9 states the price.

---

## 2. The constraint sheet

| | value | note |
|---|---|---|
| Machine | BBC Model B + sideways RAM | 2MHz 6502 (not 65C12 — no `(zp)`, no `bra`, no `phx`) |
| RAM timing | full 2MHz | video reads on the opposite phase; **no display contention** ⚠️verify |
| Frame | 40,000 cycles @ 50Hz | same budget as Micro |
| MODE 2 | 160×256, 4bpp, 8 colours + 8 flashing | 2 px/byte, pixels 2:1 wide |
| Screen RAM | **20,480 bytes** | &3000–&7FFF |
| Main RAM free | **~8.5KB** (&0E00–&2FFF) | with DFS workspace |
| Sideways RAM | 16–64KB at &8000–&BFFF | one bank paged at a time |

**The binding constraint is bytes, not cycles.** Micro's constraints were cycles;
Nano has cycles to spare (§8) and almost no main RAM. Every design decision below
should be read with 8.5KB in mind.

Two escape valves, both cheap and both worth costing in experiment 2:

**Shrink the screen via CRTC.** Reducing the displayed rows is a handful of 6845
register writes and reclaims RAM linearly:

| canvas | screen bytes | main RAM free |
|---|---|---|
| 160×256 | 20,480 | ~8.5KB |
| 160×200 | 16,000 | ~13KB |
| 160×176 | 14,080 | ~15KB |

A letterboxed canvas is an aesthetic decision, not a compromise, and it roughly
doubles working RAM. `_SCREEN_MODE 97` on the Archimedes side already establishes
widescreen as a legitimate Rose format.

**MODE 5 as the honest alternative** (160×256, 2bpp, 10,240 bytes): 4 colours instead
of 8, but **+10KB of RAM and half the stamp bytes**. Dithering 4 colours still yields
~10 apparent tints (§4). MODE 2 is the recommendation, but the MODE 5 numbers belong
in the comparison — if experiment 2 says MODE 2 does not fit, this is where it goes.

---

## 3. The primitive: byte-aligned cell stamps

### 3.1 The law

**No read-modify-write, ever.** A blob's width is a whole number of bytes and its
position is byte-aligned, so painting is pure `sta` — no load, no mask, no merge.

This single law is what removes the per-line setup term (Micro §1.1: 90 cycles/line,
92% of the cost at r=4), the four x-offset painter variants (D3d), the edge masks, and
every clipping special case. It also means blobs **overwrite** rather than blend, which
§7.4 turns into an asset rather than a limitation.

### 3.2 Grid tiers

MODE 2 pixels are 2:1 (wide), so a square blob needs twice as many rows as pixel
columns. ⚠️ The byte *ordering* within a character cell needs confirming under jsbeeb
(experiment 1); the byte *counts* below hold regardless.

| grid | blob (px × rows) | bytes | physical shape | est. cycles | cells |
|---|---|---|---|---|---|
| 40×32 | 4 × 8 | 16 | square, chunky | ~160 | 1,280 |
| **80×64** | **2 × 4** | **4** | **square** | **~70** | 5,120 |
| 80×128 | 2 × 2 | 2 | wide rectangle | ~45 | 10,240 |

A 1-pixel-wide blob would be half a byte and require RMW — so **2 pixels is the
minimum blob width**, and that is the whole reason the grid exists.

### 3.3 Where ~70 cycles comes from

For the 80×64 tier, per blob:

```
row base lookup   lda rowlo,y / sta p / lda rowhi,y / sta p+1     ~16
column offset     add col×4 to p (table or shifts)                 ~8
4 byte stores     ldy #n / lda #pat / sta (p),y  ×4, lda amortised ~40
                                                                  ────
                                                                   ~64
```

Call it **70 cycles, flat, for every blob the engine will ever draw.** The 40×32 tier
is the same address arithmetic plus 16 stores ≈ **~160**.

Against Micro's *measured* render costs (§1.1, `bbc/tools/rendercost.mjs`):

| | Micro (measured) | Nano 80×64 (est.) | ratio |
|---|---|---|---|
| r=0 (1 px) | 514 | 70 | 7.3× |
| r=2 | 1,117 | 70 | 16× |
| r=4 | 1,773 | 70 | 25× |
| r=8 | 3,183 | 70 | 45× |
| r=45 | ~26,000 | n/a | — |

The ratio is less interesting than the fact that **the Nano column is a single
number**. Micro's R6 painter generation buys 2.0–3.2× (§10.2) at ~510–900 bytes of
generated code *per variant*, demand-driven, filling two 16KB banks to cover ~70% of
plots. Nano needs one stamp routine and a table of patterns.

### 3.4 What clipping becomes

Grid coordinates are a 7-bit column and a 6-bit row. Clipping is a range check on two
small integers before the address lookup — perhaps 8 cycles, no partial-blob path,
no masks. D3c's entire discussion is retired.

---

## 4. Colour: getting well past 8

MODE 2's 4bpp gives 16 logical entries over 8 physical colours (plus flash). Four
independent mechanisms stack, and three of them are free.

### 4.1 Spatial dither — free by construction ⭐

A blob is a fixed byte pattern. A *dithered* blob is a different fixed byte pattern.
**Identical cycle cost.** Tint is simply an index into a stamp-pattern table.

- 8 solid tints
- 28 two-colour 50/50 checkerboards (C(8,2))
- over a 4-row cell, 1:3 and 3:1 mixes as well → roughly **90 apparent tints**

The 4-row blob is exactly big enough for a 2×4 ordered dither and small enough that
the pattern reads as a colour rather than as texture. This is the single strongest
argument for the 80×64 tier.

Cost: **zero cycles, ~4 bytes of pattern table per tint.**

### 4.2 Raster palette splits ⭐

The engine already draws in raster order to beam-race (§6.3). Palette writes to the
video ULA at &FE21 are one byte per logical colour, so a full 8-entry reload is a few
dozen cycles — and it can be an entry in the *same* per-row display list as the blobs.
One mechanism, no special case, no separate interrupt apparatus.

8 vertical bands × 8 physical colours = **up to 64 colours on screen at once**, for a
few hundred cycles a frame. Combined with §4.1 the apparent palette runs into the
hundreds.

The catch: bands are horizontal and the split is a *scene* property, not a per-blob
one. Compositions have to be authored with vertical colour structure in mind — sky
over ground, depth bands, heat gradients. That is a real authoring constraint and also
a strong aesthetic prompt.

### 4.3 Palette cycling as a language primitive

Reserve logical colours 8–15 as an animated set and give the language a `cycl` op that
rotates them. Fire, water, plasma, pulsing, flowing trails — **motion with zero CPU and
zero blobs drawn.**

This is the first thing in any Rose dialect that makes the screen change without
drawing to it, and it directly serves the "lots happening" goal: the *interpreter* is
the scarce resource (Micro §11.5), and this consumes none of it.

### 4.4 Temporal dither via the flash bit

The ULA flashes logical colours 8–15 between a colour and its complement; `*FX9,1` /
`*FX10,1` sets 1-frame alternation. Red/yellow reads as orange at 50Hz. Free extra
tints, genuine flicker risk on a CRT and worse on an LCD.

Worth exactly one experiment (§10) to decide whether it is a tool or a curiosity. Do
not design around it until then.

---

## 5. Maths: delete the multiply, not just the divide

Micro's R5 removes runtime division. Nano should remove the **multiply** too.

### 5.1 Direction is one byte

256 units per circle, `turn` is a byte add, wrapping is free, no range check.

Micro §8.4 found a 256-step sine to be the single largest error term in its model —
but Micro's error budget is *half a pixel*. Nano's is **one cell**: 2×4 pixels on the
80×64 grid, or 32× coarser. Coarse output provably licenses coarse maths.

That reasoning retires, in one stroke: R2's 1024-step Q12 sine and its 512-byte table,
§8.3's mandatory round-to-nearest, and §8.5's 24-bit position variant.

### 5.2 Quantised speed makes movement a table lookup ⭐

Restrict `move` to **8 speeds**. Then `(direction, speed) → (dx, dy)` is a pure lookup:

```
256 directions × 8 speeds × 2 bytes = 4,096 bytes per axis, 8KB total, in SWRAM
```

`move` becomes two table lookups and two 16-bit adds:

```
ldx dir / ldy spd  → index      ~8
lda dxlo,i / adc xlo / sta xlo  ~14
lda dxhi,i / adc xhi / sta xhi  ~13
(same for y)                    ~27
                                ───
                                ~62 cycles, no multiply
```

Compare **Micro's measured 686-cycle `move`** (§9.3) and the port's measured 1,456
(§9.2). There is no `umul16` in the Nano engine at all — Micro's profile ranked it at
12.5% of interpreter time.

If 8 speeds is too few, 16 costs 16KB of tables — affordable in a dedicated SWRAM bank,
and worth pricing.

### 5.3 Everything else is a byte

Position is 8.8 per axis (integer part = cell index, fraction = subcell). Tint, life,
counters, RNG state, direction, speed index: all one byte. The VM is 8-bit, and 8-bit
is what the 6502 is actually good at.

Turtle state:

| field | bytes |
|---|---|
| x, y (8.8) | 4 |
| direction | 1 |
| speed index | 1 |
| tint | 1 |
| life | 1 |
| PC | 2 |
| RNG | 1 |
| **total** | **11** |

Against the port's **144** and Micro's **32**. 64 turtles = **704 bytes** of main RAM.
The capacity wall (§1.3) — SWRAM paging, 16-bit handles, the Tube parasite, the whole
engineering effort — does not exist.

---

## 6. Turtles, scheduling, and execution

### 6.1 Fixed pool, structure of arrays

64 turtles, hard cap, one array per field indexed by X: `lda xlo,x`. This is the
6502's native data shape and it makes `fork` a slot search plus ~11 `lda`/`sta` pairs:

| | fork cost |
|---|---|
| BBC port (measured) | ~1,500 |
| Micro (measured, §9.3) | ~560 |
| **Nano (est.)** | **~90** |

### 6.2 Turtles die on their own

A `life` byte decrements each frame; at zero the slot returns to the pool. Rose relies
on programs terminating to bound turtle count; Nano makes recycling first-class.

This is what lets 64 slots feel like hundreds: `waytoorude` wants 451 *simultaneous*
turtles, but a composition authored for Nano spawns short-lived turtles continuously
against a fixed pool. The pool is the budget, and it is enforced by the allocator
rather than by a compile-time checker.

Overflow policy is a real design decision — reject the fork, or evict the oldest
turtle. Recommend **evict-oldest**: it degrades a dense scene gracefully instead of
silently dropping the newest (and most visually salient) material.

### 6.3 Frame-locked round robin

Time is frames. Each frame, every live turtle runs until it hits a `wait`. `wait n`
sleeps n frames. There is no absolute-time ring scheduler and no time buckets.

Optionally: a hard per-turtle op quota between waits (say 32 ops), which makes the
frame budget *provably* bounded rather than merely likely. That is the last piece of
R8 and it is enforced by a counter, not by an offline analysis.

Drawing order falls out for free: bucket the live turtles by grid row (a 6-bit key,
32 or 64 buckets — a counting sort with no comparisons) and walk top to bottom in step
with the beam. Palette splits (§4.2) are entries in the same walk. Nothing tears,
nothing needs double buffering, and Micro's `(t, y−r)` ordering contract is preserved
in a much cheaper form.

### 6.4 Compile, don't interpret ⭐

This is where Nano should diverge hardest from Micro's conclusions.

Micro §11.5's finding: for nine of ten demos, **the interpreter is what fails, not the
renderer**. §9.5's finding: dispatch is ~13% of interpreter time and is *the one cost
that word-width reduction does nothing for* — 138,618 dispatches at 28.8 cycles in
Everyway alone.

A 62-cycle `move` (§5.2) should not pay 29 cycles of dispatch plus stack traffic.
So: **compile Rose Nano to straight-line 6502 ahead of time.** Turtle state in zero
page, `wait` implemented as a coroutine yield that saves PC, procedures inlined or
`JSR`ed. Dispatch goes to zero. The code lives in sideways RAM, which is precisely the
resource Nano has spare and main RAM does not.

Micro chose an interpreter for a good reason — it is porting existing Archimedes
material of unbounded size. Nano has no such obligation: its programs are small by
construction.

Fallback if code size bites: **call-threaded** — a stream of `JSR`s, 6 bytes and ~12
cycles per op. Still 2.5× better than a jump table and trivially compact.

Estimated per-turtle per-frame cost, compiled: `move` (62) + stamp (70) + life/PC
housekeeping (~30) ≈ **~160 cycles**, versus Micro's measured 686 for `move` alone.

---

## 7. Free-lunch multipliers

These are the ideas that make a 64-turtle machine *look* like a 500-turtle one. Every
one is cheap specifically on this hardware, and most would be expensive on an
Archimedes — which is the point of the exercise.

### 7.1 Hardware scroll

Two 6845 register writes scroll the entire persistent canvas. Endless rain, drift,
tunnels, rising smoke, parallax-by-band. **~20 cycles a frame for whole-screen
motion.** Combined with persistent trails this gives Rose something it has never had:
an infinite canvas.

Byte-granular offsets mean 2-pixel horizontal steps and 1-row vertical steps — which
is exactly the Nano grid, so scrolling is grid-coherent and the shadow grid (§7.4)
scrolls with it by index arithmetic.

### 7.2 Symmetry as a turtle attribute

`symm 4` stamps the same blob at 4 mirrored grid positions. Cost: 4 stamps (~280
cycles) for **one** interpretation step. Instant kaleidoscope, and the actual
bottleneck — the interpreter — does not notice.

### 7.3 Herds

One program instance drives N turtles at fixed offsets: a flock sharing a PC and a
direction, with per-member position deltas. **8× the screen activity for 1× the
interpreter cost.**

Stacked with §7.2 the perceived-density multiplier is 10–30× over the naive turtle
count, and it costs stamps — the cheap resource — rather than interpretation.

### 7.4 The shadow grid ⭐

One byte per cell, mirroring the screen: 1,280 bytes at 40×32, 5,120 at 80×64 (which
needs a shrunk screen, §2). It buys three things at once:

1. **Decaying trails.** Sweep K cells per frame, decrement an age nibble, restamp a
   dimmer dither pattern. At 40×32 and K=100 (~5,000 cycles) the whole screen fades
   every 13 frames. Rose has never had trails that decay — persistence is the soul of
   the port, but *managed* persistence is new expressive territory.
2. **Trail-aware turtles.** A `read` op returns what is in the cell ahead: grow toward
   empty space, avoid your own path, follow another turtle's colour, eat trails. This
   is a genuinely new primitive for Rose, and it is cheap *only* because the grid is
   coarse — on a 320×256 canvas with variable radii the query is meaningless.
3. **Clean erase** without a second bitplane.

Point 2 is the most artistically interesting idea in this document. It turns the canvas
from an output into a medium the turtles inhabit.

### 7.5 Dual playfield — available, probably not worth it

MODE 2 supports the Micro §S4 trick (pixel = `(l1<<2)|l0`, palette computed so layer 1
occludes layer 0) with exact erase-reveals-layer-0 semantics. But writing one plane
requires read-modify-write, breaking §3.1's law at ~2.5× stamp cost.

The shadow grid does the same job more cheaply. **Recommend skipping it**, and noting
it here so the decision is explicit rather than forgotten.

---

## 8. Budget — back of envelope

50Hz = 40,000 cycles. 80×64 grid, compiled (§6.4), 64 turtles, one blob each:

| item | est. cycles | % |
|---|---|---|
| 64 × turtle step (move + stamp + housekeeping ≈ 160) | 10,240 | 26% |
| raster palette splits, 8 bands | ~400 | 1% |
| music (SN76489 player) | ~1,500 | 4% |
| scheduler, row bucketing, scroll, VSync | ~1,200 | 3% |
| **total** | **~13,300** | **33%** |

**~26,700 cycles of headroom.** Spent on herds and symmetry (§7.2–7.3) at ~70 cycles
per extra stamp, that is **another ~380 blobs**, landing at **300–450 blobs per frame
at a locked 50Hz** — or spent on the shadow-grid fade sweep, or on more turtles.

The chunky 40×32 tier at ~160/stamp lands around 120–180 blobs per frame with the same
headroom split.

For scale, Micro's *measured* ceiling is **12–35 blobs per frame** at r=2–8, and §11.4
reports that only two of ten demos are inside a 25Hz contract today.

The important property is not the multiple. It is that **the Nano figure is a fixed
budget known at design time**, not a distribution with a p95.

---

## 9. What this costs — stated honestly

- **No variable blob size.** No `ball`, no title-screen discs, no `size s*0.88`. Micro
  §14 D3d notes that eight of ten existing demos *compute* their sizes. **None of the
  existing corpus ports.** Nano is a new body of work or it is nothing.
- **Coarse space.** 80×64 or 40×32 is a chunky, blocky aesthetic. Fine linework is
  gone; text is impossible (`hoffman-demos.md` already found MODE 2's 2:1 pixels
  destroy legibility, and the grid makes it moot). `logicos` cannot exist here.
- **No bit-exact verification against the visualizer.** Micro §6 calls the bit-exact +
  pixel-perfect harness "the port's superpower" and makes inheriting it
  non-negotiable. Nano *cannot* inherit it directly — different geometry, different
  plot semantics, different everything. It needs its own reference implementation
  (a Nano mode in the visualizer, as `visualizer/micro.h` already does for Micro) plus
  pixel-perfect jsbeeb compares, and per §6's logic that must be built **first**.
- **8.5KB of main RAM will hurt before cycles do.** Expect to shrink the screen. The
  80×64 shadow grid and the 80×64 grid tier may not be simultaneously affordable.
- **Vertical colour structure is mandatory** if raster splits are used (§4.2).
- **Speed is quantised to 8 values** and direction to 256 — smooth acceleration curves
  and slow drifts need care.

What survives, and it is the part that matters: persistent trails, forking turtles,
colorscripts, 4-letter keywords, first-procedure-is-entry, deterministic replay,
the offline toolchain. **What dies is precision.**

---

## 10. Experiments, cheapest first

None of §1–§9 is measured. In dependency order:

| # | Experiment | Answers | Effort |
|---|---|---|---|
| 1 | Confirm MODE 2 byte-order within a character cell; time a 4-byte and a 16-byte stamp under jsbeeb | Is 70/160 cycles real? **Everything hangs on this** | small |
| 2 | RAM budget spreadsheet: MODE 2 full / 160×200 / MODE 5, against turtle arrays + speed tables + shadow grid + code | Which configuration is even possible | small |
| 3 | **Render the existing demos onto an 80×64 and a 40×32 grid in the visualizer, dithered to the §4.1 tint set** | **Does it look good?** | small |
| 4 | Time a compiled turtle step vs a call-threaded one vs Micro's jump table | Is §6.4 worth the code space | small |
| 5 | 8-band raster palette split under jsbeeb | True cost of 64-colours-on-screen | small |
| 6 | Dither-pair study: which of the 36 pairs read as distinct colours rather than as texture | The apparent palette is the whole colour pitch | small |
| 7 | Shadow-grid fade sweep prototype | Does managed persistence look like Rose or like something else | medium |

**Experiment 3 decides whether Nano is worth building at all**, and it costs nothing
but visualizer work — exactly the shape of Micro's §8, which is where the Micro
proposal earned its credibility. Do it before writing a line of 6502.

Experiments 1 and 5 are jsbeeb microbenchmarks in the mould of §9 and §10 and can run
in parallel with 3.

---

## 11. Bottom line

Rose Micro is a **width** argument: 32-bit words, 144-byte turtles and unbounded radii
are the three things that cost the port most, and narrowing all three buys ~2× on the
interpreter, 2–3× on small blobs, 4× on capacity. It is measured, it is real, and it
keeps the existing corpus in play.

Rose Nano is a **variance** argument: fix the blob size to a byte-aligned grid cell,
fix the turtle count, fix one blob per turtle per frame, and the frame cost becomes a
constant known at design time. Then spend the resulting headroom on the things this
specific machine gives away free — dither patterns, palette splits, palette cycling,
hardware scroll, symmetry, herds — to buy back the apparent colour depth and apparent
density that the reductions took away.

The two are not competitors. Micro is how the existing work reaches the BBC. Nano is
what you would write *for* the BBC, and the honest summary is that it is a different
instrument that happens to share Rose's grammar.

The decision gate is experiment 3. If a 2×4-pixel dithered grid does not look like
Rose in the visualizer, nothing in §3–§8 matters.
