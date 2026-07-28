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

> **Status.** §1–§11 were written before any measurement; every cycle count in them is
> an estimate derived from the *measured* constants in `rose-micro.md` §9–§13, and §10
> lists the experiments that would turn them into facts.
>
> **Experiments 3 and 1 have since run — see §13 and §14.** Experiment 3 passes the
> look test and refutes §3's central reduction; experiment 1 confirms the MODE 2 layout
> the whole design rests on and corrects the cost constants (they were optimistic by
> ~46% per byte). Read §13 and §14 before treating §1, §3 or §8 as the design; the
> amendment boxes in those sections say what survived.
>
> **v1 is built and running** — compiler, runtime and a byte-exact verification
> harness, on a stock Model B. See **`rose-nano-v1.md`**, which also closes
> experiments 2, 4 and 6. One correction it makes to this document: §2's claim
> that bytes are the binding constraint does not survive contact — v1 fits in
> 2.6KB of the 5.9KB actually available.

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

> **Amended by §13.** The premise half-survives. Blob cost does not become a single
> constant — a fixed one-cell blob cannot draw the corpus at all — but it does become
> a **four-row lookup table** whose worst entry is bounded and known at design time,
> which retires every row of the table above except the radius cap. The engine still
> has no worst case it cannot name in advance; it simply names four numbers instead of
> one. Measured: three of nine demos never miss a 50Hz render frame and four more are
> inside 6% (§14.3).

---

## 2. The constraint sheet

| | value | note |
|---|---|---|
| Machine | BBC Model B + sideways RAM | 2MHz 6502 (not 65C12 — no `(zp)`, no `bra`, no `phx`) |
| RAM timing | full 2MHz | video reads on the opposite phase; no display contention (consistent with §14.2) |
| Frame | 40,000 cycles @ 50Hz | same budget as Micro |
| MODE 2 | 160×256, 4bpp, 8 colours | 2 px/byte, pixels 2:1 wide; flash unused (§4.3) |
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
columns. The byte ordering within a character cell was confirmed under jsbeeb — see
§14.1 — and it decides which tier to use.

| grid | blob (px × rows) | bytes | physical shape | measured cycles | cells |
|---|---|---|---|---|---|
| **40×32** | **4 × 8** | **16** | **square, chunky** | **183** | **1,280** |
| 80×64 | 2 × 4 | 4 | square | — | 5,120 |
| 80×128 | 2 × 2 | 2 | wide rectangle | — | 10,240 |

> **§14.1 chose the top row.** A character row is 8 scanlines, so only the 40×32 tier's
> cells align with it; the finer tiers straddle bands, splitting every contiguous run in
> two. The hardware picks the grid.

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

> **Measured in §14.2: 183 cycles for the 40×32 tier** — the estimate above was close
> for this shape, and the address setup is 29 rather than 24. What the estimate got
> wrong was the *per-byte* rate at scale: 8.79, not the ~6 implied here, because
> `sta (P),y` + `iny` is 8 cycles and there is no cheaper general form.

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

> **Amended by §13.** The single-number column is what experiment 3 refuted. A blob
> fixed at one cell cannot render the corpus — it turns filled material into speckle
> and a 45-pixel disc into a dot. What actually pays here is **byte alignment and grid
> snapping**, which remove the masks, the per-line setup and the clipping cases; those
> survive intact when the blob is allowed to span several cells. The law becomes
> `cycles ≈ 57 + 8.79 · bytes` (measured, §14.2) over a **four-entry size table**,
> 2.2–7.0× cheaper than Micro measured across the corpus, and still a lookup rather
> than a quadratic. See §13.3 and §14.3.

### 3.4 What clipping becomes

Grid coordinates are a 7-bit column and a 6-bit row. Clipping is a range check on two
small integers before the address lookup — perhaps 8 cycles, no partial-blob path,
no masks. D3c's entire discussion is retired.

---

## 4. Colour: getting well past 8

MODE 2's 4bpp gives 16 logical entries over 8 physical colours. Two mechanisms carry
the whole colour argument, and both are free. Two more were considered and rejected
(§4.3).

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

> **Amended by §13.4.** The mechanism works and the cost really is zero, but 36 pairs
> is the *nominal* count, not the usable one. A MODE 2 pixel is 4 units wide on a
> 320-unit screen; complementary pairs (red/green for gold, black/cyan for navy) do
> not fuse at that size, they read as speckle. Constraining the search to pairs that
> fuse costs a little accuracy and transforms the result — see §13.4 for the measured
> penalty term. Two further rules came out of the same experiment: the dither phase
> must be **locked to screen position**, not to the stamp, and **backgrounds must be a
> solid physical colour**, because a full-screen 50% dither reads as a checkerboard,
> not as a mid-tone.

### 4.2 Palette cycling — first-class ⭐

**This is a language primitive, not an effect.** The palette is a first-class piece of
turtle-visible state, alongside position and tint.

The whole 16-entry logical palette is available; the natural split is a static set for
structural colour and an animated set the composition rotates. A `cycl` op rotates a
named range of logical entries; the colorscript gains the ability to *animate* rather
than merely to change. Fire, water, plasma, pulsing trails, flow along a path already
drawn — **motion with zero CPU and zero blobs drawn.**

Cost: 16 writes to &FE21, once a frame, at VSync. Call it ~100 cycles, and note that
it happens outside the raster walk entirely, so it introduces no timing jitter.

Two things make this more important in Nano than it would be in any other Rose:

- The *interpreter* is the scarce resource (Micro §11.5), and this consumes none of it.
  Palette animation is the only way to add on-screen motion that costs literally
  nothing per frame.
- Trails are persistent (§1.5 of the Micro doc — the reason the port works at all).
  A persistent trail drawn in a cycling tint keeps moving after the turtle that drew
  it is gone. That composes with §4.1's dither pairs: a trail dithered between one
  static and one cycling colour shimmers rather than strobes.

That last combination is worth an experiment on its own, and it is the most
Nano-specific expressive idea in this document: **the canvas stays alive after the
turtles stop.**

### 4.3 Rejected: raster splits and temporal dither

Recorded so the decisions are explicit rather than forgotten.

**Raster palette splits** (palette reloads at band boundaries during the raster walk)
would give up to 64 colours on screen for a few hundred cycles. Rejected on **cycle
jitter**: the writes have to land in specific scanlines, which means the render walk
becomes timing-critical rather than merely raster-ordered. That reintroduces exactly
the class of variance §1 exists to eliminate, and it does so in the one loop that must
stay a flat, predictable, constant-cost sweep. Not worth 64 colours.

**Temporal dither via the ULA flash bit** (`*FX9,1` / `*FX10,1`, colours alternating
with their complements at 1-frame rate) is free but looks poor — flicker on a CRT and
worse on an LCD. Rejected on appearance.

Neither is a close call, and neither should be revisited without a specific
composition asking for it.

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
with the beam. Nothing tears, nothing needs double buffering, and Micro's `(t, y−r)`
ordering contract is preserved in a much cheaper form.

Because §4.3 rejects raster splits, this walk stays what it should be: a flat sweep
with no timing-critical work in it. The only cycle-accurate obligation in the whole
engine is *staying ahead of the beam*, and that has slack by construction.

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

## 7. Free-lunch multipliers — deferred past v1

These are the ideas that make a 64-turtle machine *look* like a 500-turtle one. Every
one is cheap specifically on this hardware, and most would be expensive on an
Archimedes — which is the point of the exercise.

> **None of them are v1.** They are recorded here because they are the reason the
> headroom in §8 is worth having, and because each one constrains the core design in a
> small way that is cheap to honour now and expensive to retrofit. v1 is §3–§6 plus
> §4.1–§4.2: fixed stamps, fixed pool, dither, palette cycling. Nothing below blocks
> it, and nothing below should be built until it runs.

What v1 owes them is only this: keep grid coordinates as separate column and row bytes
(so §7.1's scroll and §7.2's mirroring are index arithmetic), and keep the stamp
routine callable with an explicit cell address rather than reading the turtle's own
position (so §7.2 and §7.3 are loops around it rather than rewrites of it). Both are
free.

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

### 7.5 Rejected: dual playfield

MODE 2 supports the Micro §S4 trick (pixel = `(l1<<2)|l0`, palette computed so layer 1
occludes layer 0) with exact erase-reveals-layer-0 semantics. But writing one plane
requires read-modify-write, breaking §3.1's law at ~2.5× stamp cost — and §3.1 is the
law the whole design rests on.

The shadow grid (§7.4) does the same job more cheaply, and it costs bytes rather than
cycles, which is the wrong resource but the recoverable one (§2). **Rejected**, and
recorded here so the decision is explicit rather than forgotten.

---

## 8. Budget — back of envelope

> **Superseded by §13.3**, which measures render cost over the corpus under the
> corrected law. The turtle-step and overhead lines below stand; the stamp line is now
> a size-table lookup averaging rather more than one cell per blob, so the render share
> is larger than the 11% assumed here. The budget should be rebuilt after experiment 1
> confirms the cost constants.

50Hz = 40,000 cycles. 80×64 grid, compiled (§6.4), 64 turtles, one blob each — **v1
only**, i.e. §3–§6 plus §4.1–§4.2, with nothing from §7:

| item | est. cycles | % |
|---|---|---|
| 64 × turtle step (move + stamp + housekeeping ≈ 160) | 10,240 | 26% |
| palette cycling, at VSync | ~100 | <1% |
| music (SN76489 player) | ~1,500 | 4% |
| scheduler, row bucketing, VSync | ~1,200 | 3% |
| **total** | **~13,000** | **33%** |

**~27,000 cycles of headroom, unspent in v1.** That is the point of the deferral in
§7: v1 should ship at a third of the frame and leave the rest visibly on the table,
because every §7 multiplier converts it into on-screen density at ~70 cycles per extra
stamp. Herds and symmetry alone would add ~380 blobs, landing at **300–450 blobs per
frame at a locked 50Hz**; the shadow-grid fade sweep would take ~5,000 of it instead.

The chunky 40×32 tier at ~160/stamp lands around 120–180 blobs per frame with the same
headroom split.

For scale, Micro's *measured* ceiling is **12–35 blobs per frame** at r=2–8, and §11.4
reports that only two of ten demos are inside a 25Hz contract today.

The important property is not the multiple. It is that **the Nano figure is a fixed
budget known at design time**, not a distribution with a p95.

---

## 9. What this costs — stated honestly

- ~~**No variable blob size.**~~ **Retired by §13.2.** Size is a four-entry table, not
  an absence: `size` still works, computed sizes still work, they quantise to four
  values. This was the harshest line in the document and the experiment removed it —
  and with it the claim that none of the corpus ports. Most of it does, recognisably
  (§13.2), which changes what Nano is for: not only new work, but a genuinely cheaper
  way to render the old work.
- **Coarse space, and a real tension inside it.** 80×64 or 40×32 is a chunky, blocky
  aesthetic. §13.2 found that mass and line want *opposite* size models: filled
  material needs blobs that span cells, typographic material needs single-cell blobs
  or the strokes merge. JeSuisRose is legible at one size model and illegible at the
  other. Text is not impossible after all — but it and painterly material cannot be
  authored the same way.
- **No bit-exact verification against the visualizer.** Micro §6 calls the bit-exact +
  pixel-perfect harness "the port's superpower" and makes inheriting it
  non-negotiable. Nano *cannot* inherit it directly — different geometry, different
  plot semantics, different everything. It needs its own reference implementation
  (a Nano mode in the visualizer, as `visualizer/micro.h` already does for Micro) plus
  pixel-perfect jsbeeb compares, and per §6's logic that must be built **first**.
- **8.5KB of main RAM will hurt before cycles do.** Expect to shrink the screen. The
  80×64 shadow grid and the 80×64 grid tier may not be simultaneously affordable.
- **8 physical colours, and that is the end of it.** With raster splits and temporal
  dither both rejected (§4.3), the entire colour argument rests on dither pairs and
  palette cycling. Experiment 6 is therefore load-bearing, not a nicety: if the 36
  pairs read as texture rather than as colour, Nano is an 8-colour system.
- **Speed is quantised to 8 values** and direction to 256 — smooth acceleration curves
  and slow drifts need care.

What survives, and it is the part that matters: persistent trails, forking turtles,
colorscripts, 4-letter keywords, first-procedure-is-entry, deterministic replay,
the offline toolchain. **What dies is precision.**

---

## 10. Experiments, cheapest first

Nothing in §1–§9 was measured when it was written. In dependency order:

| # | Experiment | Answers | Effort |
|---|---|---|---|
| 1 | ~~Confirm MODE 2 byte-order within a character cell; time a 16-byte and a 144-byte stamp under jsbeeb~~ **DONE — see §14** | Are 25 + 6/byte real? (No: 57 + 8.79) | small |
| 2 | ~~RAM budget: MODE 2 full / 160×200 / MODE 5~~ **DONE — see `rose-nano-v1.md` §2** | Which configuration is possible (all of them: v1 uses 2.6KB of 5.9KB) | small |
| 3 | ~~Render the existing demos onto an 80×64 and a 40×32 grid in the visualizer, dithered to the §4.1 tint set~~ **DONE — see §13** | **Does it look good?** | small |
| 4 | ~~Dither-pair study~~ **DONE — 27 distinct of 36: 8 solids + 19 dithers (`rose-nano-v1.md` §2)** | The apparent palette is the whole colour pitch (§9) | small |
| 5 | **NEXT — the only feasibility experiment left.** Cycling-tint study: persistent trails drawn in rotating palette entries, incl. static/cycling dither pairs | Is §4.2 the expressive win it looks like | small |
| 6 | ~~Time a compiled turtle step~~ **DONE — measured on the finished engine: a whole step costs ~700 cycles plus the blob (`rose-nano-v1.md` §5)** | Is §6.4 worth the code space (yes) | small |
| 7 | *(deferred, §7)* shadow-grid fade sweep prototype | Does managed persistence look like Rose or like something else | medium |

**Experiment 3 decides whether Nano is worth building at all**, and it costs nothing
but visualizer work — exactly the shape of Micro's §8, which is where the Micro
proposal earned its credibility. Do it before writing a line of 6502.

Experiment 1 is now the critical path: §13.3's cost law rests on the assumption that
consecutive addresses are consecutive scanlines within a character row, which makes a
blob a few contiguous byte runs. If that is wrong the law is wrong.

---

## 12. Bottom line

Rose Micro is a **width** argument: 32-bit words, 144-byte turtles and unbounded radii
are the three things that cost the port most, and narrowing all three buys ~2× on the
interpreter, 2–3× on small blobs, 4× on capacity. It is measured, it is real, and it
keeps the existing corpus in play.

Rose Nano is an **alignment** argument. It was written as a variance argument — fix the
blob size, fix the turtle count, one blob per turtle per frame — and §13 measured that
and found the variance framing was aiming at the wrong target. Fixing the *size* buys
nothing and costs the corpus. What buys the speed is putting blobs on a byte-aligned
grid, which deletes the masks, the read-modify-write, the per-line setup and the
clipping cases, and keeps deleting them when a blob spans several cells.

The result, measured on a Model B, is a render law of `57 + 8.79·bytes` over a
four-entry size table: **2.2–7.0× cheaper than Micro measured**, with three of nine
demos never missing a 50Hz render frame and four more inside 6% — including ball,
which Micro §1.1 calls render-bound at 25fps and immune to a coprocessor, and which
Nano draws in 13,897 cycles flat.

v1 buys back the apparent colour depth with the two mechanisms that cost nothing and
introduce no timing risk — **dither pairs and palette cycling** — and buys back nothing
of the density, deliberately, leaving two-thirds of the frame unspent. The density
multipliers in §7 are real and they are cheap, but they are a second phase; a v1 that
runs at 33% of a frame is a machine you can then *compose* for, and that is the harder
half of the problem.

The two dialects are not competitors. Micro is how the existing work reaches the BBC.
Nano is what you would write *for* the BBC, and the honest summary is that it is a
different instrument that happens to share Rose's grammar.

The decision gates were experiments 3 and 1, and **both passed** — experiment 3 on the
look, experiment 1 on the one hardware fact everything rests on. Experiment 3: the grid, the eight colours and
the dither reproduce the corpus recognisably, and Frustration and Chiperia are
genuinely good (`bbc/docs/mockups/`). What it also did was refute the reduction the
document is built on, which is what a cheap experiment is for. Experiment 1 then confirmed the MODE 2 layout exactly as §3 needed it, and corrected
the cost constants downward by about half — a smaller claim, still a strong one.

Both of those gates are now cleared too: v1 fits in 2.6KB and a compiled turtle step
costs ~700 cycles plus its blob (`rose-nano-v1.md` §2, §5). What is left is not a
feasibility question at all — it is whether anyone composes for the instrument.

---

## 13. Experiment 3 results — the grid render, measured (2026-07-28)

### 12.1 What was built

- `bbc/tools/nanorender.py` — renders a plot stream under Nano rules: radius
  discarded or snapped to a size table, position snapped to a grid, colour reduced to
  the eight BBC physicals via a dithered pair inside the stamp, no layers, overwrite
  only, trails persistent. Output is a 160×256 MODE 2 canvas written at 320×256 so
  the 2:1 pixels have their real aspect.
- `bbc/tools/nanobudget.py` — per-frame render cost of the same stream under the Nano
  cost law and under Micro's *measured* law, side by side.
- Contact sheets for all nine examples, three frames each, four columns: the
  352×280 reference, and three Nano variants. Five are in `bbc/docs/mockups/`:
  `nano-frustration-3way.png` (the best result), `nano-jesuisrose-3way.png` (the
  typographic counter-case), `nano-chiperia-3way.png`, `nano-everyway-3way.png`,
  `nano-ball-3way.png` (the fixed-size failure at its starkest).

Reproduce with:

```sh
bbc/tools/roseplots.exe examples/tree.rose /tmp/tree.bin 10000
python bbc/tools/nanorender.py /tmp/tree.bin out.png --frame 200 \
    --grid 40x32 --stamp 4x8 --radius --sizes 0,1,2,3 --fuse 0.25 --steps 8 --stats
python bbc/tools/nanobudget.py /tmp/tree.bin --grid 40x32 --sizes 0,1,2,3
```

Grid pitch and stamp size are independent parameters, which turned out to matter:
the byte-alignment law (§3.1) only constrains the stamp's *width* and *x position* to
whole bytes, so a 4×8 stamp can sit on an 80×64 position grid. The variants were:

| | pitch | stamp | size model |
|---|---|---|---|
| **A** | 80×64 | 4×8 | fixed, one cell — §3 as written |
| **B** | 80×64 | 4×8 | 0–3 cells |
| **C** | 40×32 | 4×8 | 0–2 cells |

### 12.2 Headline: the grid is fine, the fixed size is not

**Rose survives the grid and the eight colours.** Frustration, Euphoria, Chiperia and
Everyway all read as themselves in variants B and C — Frustration in particular is
close to the reference and, in eight colours, arguably better. The coarse grid, the
2:1 pixels and the loss of 4,096 palette entries are all survivable.

**The fixed-size blob is not.** Variant A — §3 exactly as proposed — fails on seven of
the nine demos, and it fails in two distinct ways:

- *Filled material becomes speckle.* Frustration paints large areas with overlapping
  blobs. One cell per plot cannot fill an area, so the screen becomes noise
  (`mockups/nano-frustration-3way.png`, second column, is the clearest picture of
  this in the set).
- *Large single objects vanish.* ball is one r=45 disc. Fixed size renders 20,000
  plots as **18 cells** — the demo becomes a thin vertical line.

The collapse is measurable. Plots per occupied cell, final frame, variant A:

| demo | plots | cells touched | collapse |
|---|---|---|---|
| ball | 19,982 | 18 | 1,110 : 1 |
| Chiperia | 14,096 | 2,980 | 4.7 : 1 |
| tree | 4,138 | 1,197 | 3.5 : 1 |

**The one counter-case is typographic material, and it is instructive.** JeSuisRose
draws letterforms; at f3700 the word "GOTH" is *legible under variant A and illegible
under B and C*, because a size-aware blob thickens strokes until they merge. So the
two size models have opposite failure modes — mass needs size, line needs restraint —
which is an argument for the author choosing, not for either being a law of the
engine.

### 12.3 The corrected render law

What actually pays on this machine is **byte alignment and grid snapping**, not fixed
size. Those remove the masks, the read-modify-write, the four x-offset painter
variants and the clipping cases, and they keep doing so when a blob spans several
cells. Assuming consecutive addresses are consecutive scanlines within a character
row (experiment 1 — since **confirmed**, §14.1), a blob is a few contiguous byte runs
and the law is:

```
Nano   cycles ≈ 25 + 6 · bytes                     (estimated)
Micro  cycles = 666 + 90 · lines + 12 · bytes      (measured, §10)
```

No per-blob 666, no per-line 90 — that is the whole difference, and it is structural
rather than an optimisation. Run over the corpus at 40×32 with a **four-entry size
table {0,1,2,3 cells}**, against the 40,000-cycle 50Hz budget:

| demo | Nano p50 | Nano p95 | over budget | Micro p50 | Micro p95 | over budget | ratio |
|---|---|---|---|---|---|---|---|
| circle | 242 | 242 | 0.0% | 2,762 | 2,762 | 0.0% | 11.4× |
| tree | 3,677 | 12,777 | 0.0% | 18,230 | 78,336 | 21.7% | 5.8× |
| Chiperia | 726 | 32,246 | 0.1% | 4,968 | 127,011 | 7.5% | 4.7× |
| Teaser | 1,778 | 32,004 | 0.0% | 6,279 | 153,834 | 0.3% | 4.7× |
| ball | 9,458 | 9,458 | 0.0% | 37,674 | 42,579 | 27.2% | 4.0× |
| JeSuisRose | 7,381 | 36,375 | 0.0% | 50,189 | 119,339 | 12.5% | 3.4× |
| Euphoria | 9,438 | 39,647 | 3.6% | 31,830 | 148,441 | 34.4% | 3.7× |
| Frustration | 1,778 | 55,365 | 8.0% | 21,148 | 176,626 | 20.2% | 3.3× |
| Everyway | 22,714 | 85,238 | 17.7% | 96,401 | 253,280 | 78.9% | 4.2× |

Three things follow.

1. **Six of nine demos never miss a 50Hz render frame** at Archimedes authoring
   density, and a seventh (Euphoria) misses 3.6%. Micro §11.4 reports that two of ten
   are inside a *25Hz* contract. This is a much stronger position than §8 claimed, and
   it is claimed for variable-size blobs.
2. **ball is the sharpest single result.** Micro §1.1 calls it render-bound at 25fps
   and immune to a 4MHz coprocessor. Under Nano it costs 9,458 cycles a frame, flat,
   and never misses 50Hz — the demo that best resists Micro is trivial here.
3. **Four sizes are enough.** The measured histogram over the whole corpus uses
   rc=0 and rc=1 for the bulk, rc=2 for Frustration and JeSuisRose, and rc=3 only for
   ball (all 20,000 plots) and Everyway (29,546). Nothing wants a fifth entry. So the
   cost of a blob remains a **four-row lookup table**, which preserves §1's variance
   argument nearly intact — the frame cost is bounded and known, it is simply not a
   single constant.

### 12.4 Three colour findings, one of them large

**Dither pairs must be constrained to pairs that fuse.** Matching a target colour by
minimising error in linear light is numerically correct and visually wrong: it renders
gold as a 3:1 red/green checkerboard and navy as sparse cyan on black. At a MODE 2
pixel — 4 units wide on a 320-unit screen — complementary pairs do not blend, they
speckle. Adding a penalty proportional to the pair's own separation, scaled by how
much of the minority colour there is:

```
cost = colour_error² + fuse · separation² · (minority_fraction / 0.5)
```

`fuse = 0` gives red/green gold. `fuse = 0.25` gives red/yellow gold on a dark blue
ground and is the setting used for every sheet in `mockups/`. `fuse = 1.0` collapses
everything to solids. **The usable pair set is much smaller than 36**, and the useful
mixes are between neighbours (red/yellow, blue/cyan, white/yellow), not across the
wheel. Experiment 4 should now enumerate exactly which survive.

**Dither phase must be locked to screen position, not to the stamp.** Otherwise
overlapping stamps of the same tint interfere and a filled area shimmers. Locking is
free on the 6502: with grid-aligned stamps there are only two or four phases, selected
by the low bits of (col, row).

**Backgrounds must be solid.** A mid-grey background rendered as a 50% white/black
dither is a full-screen checkerboard — the single ugliest thing produced in this
experiment. Chiperia's grey-blue ground only became acceptable when it resolved to
sparse blue on black. This is an authoring rule, not an engine change: dither is for
blobs, not for fields.

A fourth, smaller finding: the canvas must be *cleared to the background tint's
pattern* at startup, so that a background-tint stamp is invisible exactly as it is in
the reference. Several demos paint background-coloured blobs to erase; without this
they show up as white noise.

### 12.5 Verdict

**Experiment 3 passes, and it invalidates §3.**

Nano's look is real: the coarse grid, the byte-aligned stamps and eight dithered
colours reproduce the corpus recognisably and in places beautifully. The decision gate in §12 is cleared.

But the specific reduction that §1 and §3 build on — one fixed stamp per plot — is
refuted by seven of nine demos, and it was never the thing paying for the speed. Byte
alignment and grid snapping are. Those give a `25 + 6·bytes` law that is 3.3–11.4×
cheaper than Micro measured, with a four-entry size table that keeps the frame cost
bounded and known at design time. *(§14 measured that law: `57 + 8.79·bytes`, and the
ratio is 2.2–7.0×. The shape of the argument holds; the numbers shrink.)*

So the design changes shape rather than dying:

- §3's "one blob = one stamp" becomes **"one blob = one entry in a four-size table"**.
- §6.3's "one blob per turtle per frame" survives as a *budget* rule but no longer
  implies a constant frame cost; the constant becomes a four-row table.
- §1's table of retired Micro apparatus survives except for one row: the radius cap
  becomes a size *table* rather than an absence, which is D3a's conclusion arrived at
  from the other direction.
- §8's budget needs redoing on the corrected law before it means anything.

The next thing to run is **experiment 1**, because every number in §13.3 rests on the
MODE 2 byte-order assumption, and the whole argument now rests on §13.3.

*(Run — see §14. The layout assumption is confirmed; the cost constants were
optimistic by ~46%, and §13.3's table is superseded by §14.3.)*

---

## 14. Experiment 1 results — the stamp, measured on a Model B (2026-07-28)

### 14.1 The MODE 2 layout is confirmed, with one correction

Probed interactively under jsbeeb on a `B-DFS1.2` by drawing a known line and reading
screen RAM back out-of-band (printing the dump would have overwritten the memory being
dumped — the screen *is* the buffer).

A 7-pixel vertical line at x=0 sets `&3000`–`&3006`, **consecutive addresses**. A
horizontal line sets `&3000, &3008, &3010, &3018, &3020, &3028, &3030` — **stride 8**.

```
+1    next scanline          (within a character row only)
+8    next 2-pixel column
32 B  character cell         8 px x 8 rows
+640  next character row     20 cells x 32 bytes
```

So §3.1's premise holds: a blob is a set of *contiguous byte runs* and needs no masks.
The correction is that **contiguity stops at 8 rows**. A blob taller than one character
row is not one long run; it is one run per (byte-column, character row) pair, and each
band needs its own base pointer — which is exactly what Micro §R6 found ("2–3
self-modified base addresses per blob, one per character row band").

**This settles the grid choice.** A 40×32 grid over a 160×256 canvas gives cells of
4 px × 8 rows — 8 rows is precisely the character row height, so **a grid cell never
straddles a band** and every run is a full 8 bytes. The 80×64 tier's 4-row cells
straddle, splitting every run in two and roughly doubling the per-run overhead. §3.2
offered 80×64 as the recommended tier; the hardware prefers 40×32.

### 14.2 The measured cost law

`bbc/bench/nanostamp.mjs` generates the stamp code, pokes it into a real machine and
times it against the cycle counter. 256 iterations per shape, empty loop subtracted.

| shape | bytes | flat | cyc/byte | per-row dithered | cyc/byte |
|---|---|---|---|---|---|
| address setup alone | — | 29 | — | — | — |
| rc=0, 4×8 px | 16 | 183 | 11.5 | 215 | 13.5 |
| rc=1, 12×24 px | 144 | 1,333 | 9.3 | 1,628 | 11.3 |
| rc=2, 20×40 px | 400 | 3,582 | 9.0 | 4,410 | 11.0 |
| rc=3, 28×56 px | 784 | 6,939 | 8.9 | 8,566 | 10.9 |

```
flat        cycles ≈  57 + 8.79 · bytes      (measured)
dithered    cycles ≈  54 + 10.86 · bytes     (measured)
§13.3 est.  cycles ≈  25 + 6 · bytes         (wrong by ~46% per byte)
```

The per-byte floor is `sta (P),y` + `iny` = 8 cycles, and 8.79 is that plus the `ldy`
per run and the base rebase per band. There is no cheaper general form: `sta ABS,y`
saves a cycle but needs its operand self-modified per store, which costs more than it
saves when the blob's position changes every frame. **8.79 is the floor, not a first
attempt.**

The flat/dithered split is a real design choice. "Flat" means the dither pattern varies
only *within* a byte — the two pixels of a byte differ, but every byte of the blob is
the same value, so the `lda` hoists out of the loop. That still buys the 50% pair mixes,
which §13.4 found are most of the usable set anyway. Per-row variation, needed for the
25%/75% levels, costs **24% more**. Recommend flat as the default and per-row as an
opt-in for material that needs the extra levels.

### 14.3 What this does to the budget

Re-running `nanobudget.py` on the corpus with the measured constants (40×32, sizes
{0,1,2,3}, flat), against the 40,000-cycle 50Hz frame:

| demo | Nano p50 | Nano p95 | frames over budget | vs Micro |
|---|---|---|---|---|
| circle | 395 | 395 | 0.0% | 7.0× |
| tree | 5,511 | 19,344 | 0.0% | 3.7× |
| ball | 13,897 | 13,897 | 0.0% | 2.7× |
| Teaser | 2,646 | 47,619 | 0.1% | 3.1× |
| JeSuisRose | 12,056 | 53,595 | 3.6% | 2.3× |
| Chiperia | 1,186 | 48,015 | 5.9% | 3.1× |
| Euphoria | 14,292 | 58,551 | 7.9% | 2.5× |
| Frustration | 2,767 | 82,027 | 19.4% | 2.2× |
| Everyway | 33,480 | 125,648 | 40.7% | 2.8× |

**§13.3 over-claimed and this is the correction.** The win is **2.2–7.0×** over Micro's
measured law, not 3.3–11.4×. **Three** demos never miss a 50Hz render frame, not six —
though four more are inside 6%, which a 25Hz cadence or modest authoring-down clears
easily.

What survives intact:

- **ball still never misses.** 13,897 cycles a frame, flat, for the demo Micro §1.1
  calls render-bound at 25fps and immune to a coprocessor. This was the sharpest result
  in §13 and the measurement did not touch it.
- **The cost is still a four-row table**, still bounded, still known at design time.
  §1's amended premise is unaffected.
- **Byte alignment is still the thing that pays.** Removing the 666-cycle per-blob term
  and the 90-cycle per-line term is what produces the 2.2–7.0×; the per-byte rate is
  only marginally better than Micro's 12 (8.79 flat).

What does not:

- §8's headline of ~33% of a frame, and §13.3's "six of nine". Both were built on the
  optimistic per-byte figure.
- The 80×64 grid as the recommended tier (§14.1).

### 14.4 Verdict

**Experiment 1 passes on the assumption and fails the estimate.** The MODE 2 layout is
exactly what §3 needed it to be, which is the load-bearing fact; the cost constants
were optimistic by about half, which moves the numbers without moving the argument.

Nano renders the existing corpus 2.2–7.0× cheaper than Micro at the same authoring
density, with a bounded four-entry cost table, on a machine with half the RAM and no
coprocessor. That is a smaller claim than §13 made and still a strong one.

The open items are now §9's ordering, not the renderer: **8.5KB of main RAM**
(experiment 2) is the next thing that can kill this, and the interpreter — which Micro
§11.5 found is what actually fails — has not been measured at all (experiment 6).

---
