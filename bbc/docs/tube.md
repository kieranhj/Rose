# Rose on the Master Turbo — 6502 second processor over the Tube

Investigation into a two-CPU version of the BBC engine: the Rose interpreter and
all turtle maths on the parasite (Master Turbo's internal 65C102 at 4MHz, 64K of
uncontended RAM), the renderer on the 2MHz host, with draw records streamed over
the Tube. The same split the Elite Second Processor edition used: parasite
computes, host draws.

**Verdict: very feasible, with a clean seam already present in the engine, and
it unlocks the four demos currently blocked on turtle capacity.** Measured
(§5): ~2.15× for Everyway (~5.8 → ~12fps average), 2.8× for teaser/jesuisrose
in their busy stretches; ball is 85% render-bound and needs host-side render
work instead.

## 1. References studied

- **Tube ULA + protocol** — llm-beeb-wiki `hardware/tube-ula.md`, `os/tube.md`
  (NAUG ch. 18 + Master ARM ch. 12 distillation).
- **Tom Seddon, "6502 Second Processor programming"** (ffe3.com/tom/tube.html) —
  the OS-vector-hook approach; confirms OSWRCH and OSBYTE &9D are the only
  asynchronous calls, and that fully custom protocols mean replacing the Tube
  loop on the host and the client OS on the parasite.
- **Toob** (`BEEB/Repos/Toob`, Sarah Walker) — a complete bare-metal Tube game.
  Proves the custom-protocol route: parasite loader *LOADs host code with
  `&FFFF` address prefixes, host disables all Tube ULA interrupt enables
  (`&0F → &FEE0`), sync byte `&A5` over R4, then both sides poll the FIFOs
  directly with interrupts off, forever.
- **tube-demo** (`BEEB/Repos/tube-demo`, notes.txt) — prior particle-system
  experiments; measured per-dot Tube costs, and SarahW's protocol description:
  R1 parasite→host has a **24-byte FIFO**, packetize and let the parasite run
  up to 2 packets ahead.

## 2. Hardware model

Master Turbo = Master 128 + internal 65C102 co-processor:

| | Host | Parasite |
|---|---|---|
| CPU | 65C12 @ 2MHz | 65C102 @ 4MHz |
| RAM | as today (shadow screen, SWRAM banks) | 64K flat, no screen, no I/O |
| Tube regs | `&FEE0-&FEE7` (mirrored to `&FEFF`) | `&FEF8-&FEFF` |

Four register pairs. What matters for us:

| Reg | Direction/depth | Our use |
|---|---|---|
| R1 | parasite→host **24-byte FIFO**; host→parasite 1-byte latch | **draw record stream** (the dominant flow) |
| R2 | 1-byte latch each way | host→parasite frame sync / flow control |
| R3 | 2-byte FIFO (V=1), NMI-capable | v2 option: host-pulled block transfers |
| R4 | 1-byte latch each way | boot handshake only |

Status bits everywhere: bit 7 = data available (read side), bit 6 = not-full
(write side). Poll with `BIT reg : BPL/BVC`. The Tube ULA is a full 2MHz device
— **no cycle stretching** on these accesses.

Control register (host `&FEE0`): write `&0F` at takeover to clear Q/I/J/M — no
Tube interrupts on either side, pure polling, exactly Toob's runtime discipline.
This matches our existing OS-free, SEI-everywhere engine.

## 3. The work split

The engine already has the perfect seam: `rec_done` / `emit_rec`. Everything
before it (dispatcher, turtle maths, sine, RNG, scheduler, stacks, wires) knows
nothing about the screen; everything after (render_blob, span fillers, palette,
vsync) knows nothing about bytecode.

**Parasite** (interpreter core):
- Full bytecode interpreter, 256-entry dispatch, unified turtle stacks — the
  current `interp.asm` minus renderer, minus all ACCCON/ROMSEL paging (no
  paging exists; states live in flat RAM).
- Turtle states as a plain array: 65C102 runs the identical 65C02 subset we
  already use (stz/phx etc.).
- The draw hash (LOGCNT/LOGCHK) stays here — records are hashed at source, so
  **bit-exact verification methodology is unchanged**.
- `emit_rec` becomes: hash the record, then push 6 bytes into R1
  (`BIT &FEFE-style status : BVC spin : STA &FEF9` — 10 parasite cycles/byte,
  2.5µs, and the 24-byte FIFO absorbs a 4-record burst before any stall).

**Host** (render server):
- Poll R1 (`BIT &FEE0 : BPL`), read records, `render_blob` each one — the
  existing renderer, span banks 4/5, circle bank 6, fast path, all unchanged.
- Owns vsync (SYSVIA IFR poll), frame pacing, colorscript/palette (it keeps the
  colorscript table and frame counter — palette never crosses the Tube).
- Read cost ≈ 13–15 cycles/byte, ~85 cycles per 6-byte record — about the price
  of one span line. Everyway averages ~21 plots/frame, so transfer is ~2K
  cycles/frame on average; the worst measured frame (146 plots) costs ~13K,
  still well under half a slot.

### Wire protocol v1 (recommend building this first)

6-byte draw record, plus 1-byte control markers, all over R1:

```
byte 0  tag: bit7=0 → draw record follows
             bits 0-3 tint, bit 4 square-flag (SQF)
        bit7=1 → control: &80+n = END FRAME advancing n frames (n=1..111),
                 &FF = DONE (followed by count16 + chk32 = 6 bytes for the log)
byte 1-2  x  (int16 LE, pre-clip pixel coords as render_blob takes today)
byte 3-4  y  (int16 LE)
byte 5    r  (0..MAXRADIUS)
```

- Frame boundaries are stream-ordered: host renders records until END FRAME,
  then waits for vsync (its existing frame_tick), applies colorscript events,
  and continues. `&80+n` covers wait-heavy stretches in one byte.
- Flow control is automatic: the parasite blocks on R1-full, i.e. it can run
  ahead of the host by the FIFO depth plus its own look-ahead; the host never
  waits except at frame boundaries. This is the free pipelining Elite exploited.
- On DONE, the host stores the parasite's count16+chk32 at `&0B80` exactly as
  today — `verify_plots.py --count N --chk HEX` keeps working untouched.

**T2 status: implemented.** The engine now runs this protocol end-to-end on a
single Master: `q_push_rec`/`q_push_a` (parasite side) append wire records to
a RAM queue at `&0300` (draining at a high-water mark mid-frame and at every
frame boundary), and `q_drain` (host side) parses them, pages LYNNE once per
batch, feeds an untouched `render_blob`, and handles END-FRAME and DONE —
DONE carries count16+chk32 to the log header and sets DONEFLAG from the
consumer side. All five demos verify bit-exact through it (queue overhead ~3%
on Everyway). T3 is now: replace `q_push_*` with R1-FIFO writes and `q_drain`
with the host pump loop. One lesson for the memory map: `&0900` was NOT free —
the first queue placement collided with the scheduler buckets at `&0A00` and
corrupted big demos only (small ones never crossed the page); `&0300-&08FF` is
the safe block.

### Protocol v2 (only if profiling shows stalls)

Banjo-style command buffers (per tube-demo notes): parasite builds whole-frame
record buffers in its spare RAM; host pulls them with R3 block transfers
(10µs/byte, parasite serviced by NMI while its main thread keeps interpreting).
More decoupling, much more machinery. Measure v1 first — the 24-byte FIFO plus
frame-granular sync may already keep both CPUs busy.

## 4. Memory maps

**Parasite (64K flat):**

| Region | Contents |
|---|---|
| `&0000-&008F` | zp — ours entirely after takeover |
| `&0400-&1FFF` | interpreter core (~4K: no renderer, no chain, no CRTC code) |
| `&2000-&3FFF` | sine quarter table 8.2K + dispatch tables |
| `&4000-&5FFF` | bytecode + constants (Everyway ≈ 10K, the largest) |
| `&6000-&EFFF` | **turtle states: 36K = 288 turtles**, buckets/free list |
| `&F000-&F7FF` | log scratch; `&FF00+` vectors (RAM — we own NMI/IRQ/RESET) |

**This unlocks the capacity-blocked demos — DONE (T4).** The handle rework
went further than planned: handles are now the state base *addresses*
themselves (null = hi byte 0), with the list links intrusive in each state
block (bytes 32/33 = wire slot 0, unused by every example). That removes the
index→address tables entirely, makes `MAXT`/`STATE_SIZE` free per-build
parameters (`buildtube.sh <name> <rose> <wide> <maxt> <statesz>`, states
growing down from `&F800`), and drops a table lookup from the scheduler hot
path. STATE_SIZE 144 gives 20 stack slots (Chiperia needs 18). Verified
bit-exact over the Tube: **tree (262 turtles, 48M cycles), Chiperia5intro
(273, 120M), PaintersEuphoria (200, 504M, 77,169 plots), PaintersFrustration
(211, 408M, 39,614 plots)** — every Rose example now runs on the BBC.

Two traps found on the way: the plot-prefix log's limit check tests only the
record's start page, so its last 10-byte record can straddle the boundary —
on the parasite that boundary was exactly `STATES`, corrupting the first
state block (LOGLIMIT now stops a page early); and the single-CPU build's
cold exit/vdutab code had to move out of the sched→run_turtle branch window.

**Host:** bank 7 (states) is freed — spare SWRAM for whatever comes next (music
data is the obvious tenant). Main RAM below the render code is largely empty
too. The host keeps: renderer + span chain at `&0E00`, banks 4/5/6, colorscript,
boot code.

## 5. Performance model — MEASURED (T1 complete)

Tube frame cost model, per frame:

```
frame time ≈ max( I/2  +  ~10 cyc/byte send ,  R  +  ~85 cyc/record recv )
```

where I = interp+emit (moves to the parasite, ×2 clock), R = render+tick
(stays on the host). Transfer terms are noise (Everyway averages 21
records/frame ≈ 2K host cycles).

**T1 measurement**: `bbc/tools/profile.mjs` attributes *every* host cycle to
an engine region (interp / emit / rblob / rspan / rchain / tick / idle) via a
per-instruction hook in headless jsbeeb, with region boundaries taken from the
`SYM` lines `interp.asm` now prints into `beebasm.log`. This is exact
attribution, not sampling. Full runs of four demos:

| Demo | parasite side /frame | host side /frame | split | now → Tube /frame | gain |
|---|---|---|---|---|---|
| ball | 9.2K | 51.2K | 15/85 | 60.5K → 51.2K | 1.2× (stays 25fps) |
| teaser (dense f0–311) | 50.6K | 19.3K | 72/28 | 69.9K → 25.3K | **2.8×** |
| jesuisrose (full) | 24.0K | 13.3K | 64/36 | 37.2K → 13.3K | **2.8×** |
| Everyway (full, 8837 fr) | 192.3K | 133.3K | 59/41 | 325.6K → ~152K | **~2.15×** |

Everyway's gain computed per-chunk (sum of `max(I/2, R)` over 31 chunks =
1340M vs 2877M busy today): the demo alternates interpreter-bound stretches
(f1490–1970: ~355K interp vs 43K render per frame → 2.3× there) with
render-bound blob storms (f3702–4123: ~315K render per frame → only ~1.35×).
Overall ≈ 5.8fps today → **~12fps average** under the Tube, before any further
render work. Idle is only 6% of the Everyway run — the engine almost never
reaches vsync early today.

Two corrections to the pre-measurement estimates:

- **ball is 85% render-bound** — the Tube alone does *not* get it to 50fps
  (host still needs 51K > 40K). It needs render optimization, Tube or no Tube.
- **The render hot spot is per-line setup, not pixel writes.** In both ball
  and Everyway's storm sections, `rblob` (per-line setup + rec_done glue) is
  ~56–65% of render time (~165 cyc/line) vs ~35–44% for the actual stores
  (`rchain` + `rspan`, ~128 cyc/line). Shaving the per-line setup is the
  biggest host-side lever and compounds with the Tube split, since Tube frame
  cost is `max(parasite/2, host)`.

Render-bound peaks gain little from the parasite by construction; the Tube
version makes host render work *easier* to fund (the host has no other job).

Reproduce: `node bbc/tools/profile.mjs bbc/build/<name> [maxMcyc] [chunkMcyc]
[startFrame]` after a `build.sh` run (which now writes `beebasm.log`).

**T3 status: implemented and verified.** `beebasm -D TUBE=1` builds the
parasite from the same `interp.asm` (states flat at `&B800`, `q_push_*`
replaced by R1 FIFO writes); `tube.asm` assembles it as `PARA` plus the host
render server (`HOST`: R1 pump, vsync, colorscript) onto one autoboot disc
(`bin/buildtube.sh`). All five demos verify bit-exact over the emulated Tube
(`JSBEEB_TUBE=1 node tools/runverify.mjs build/<name>-tube`). Measured:
**Everyway completes in 1640M cycles vs 3160M single-CPU — 1.93×** (T1's
per-chunk model predicted 2.15× before vsync quantization); jesuisrose 296M
vs 392M; ball unchanged (render-bound, as measured in T1).

One hard-won handshake lesson: the parasite must NOT write R4 while the host
OS still owns the Tube — the write raises a host-side Tube IRQ and the MOS
consumes it as a system-control byte, wedging the boot (the trigger char
never gets read). The working order, now in §6: the *host* speaks first,
after it has been entered via the WRCHV trigger and has disabled all Tube
ULA interrupt enables; the parasite waits for that hello before its ack.

## 6. Boot sequence (the Toob recipe, adapted)

Only the loader phase uses the OS; after handshake both sides are bare metal.

1. `!BOOT`: `*SRLOAD SPANS4/SPANS5/CIRCS` into banks 4/5/6 with `Q` (star
   commands always execute host-side, Tube or not), then `*RUN PARA`.
2. `PARA` (no `&FFFF` prefix → loads and runs on the parasite): via OSCLI,
   `*LOAD HOST FFFF0E00` (host main RAM). Then the SarahW start trick: poke the
   host code's entry into WRCHV via OSWORD 6, issue one dummy OSWRCH — the host
   enters our code and never returns to the Tube loop.
3. Host side: `SEI`, write `&0F → &FEE0` (kill all Tube IRQ/NMI enables), drain
   all four read ports, poll R4 for `&A5`.
4. Parasite side: `SEI`, install own vectors, drain its ports, write `&A5 → R4`,
   fall into the interpreter.
5. Host sees `&A5`, does its existing screen/CRTC/palette init, enters the
   record-pump loop. Running.

## 7. Verification tooling — resolved

jsbeeb emulates all of this **today**: `Tube65C02` model, attached via
`opts.tube` in `fake6502()`, default `cpuMultiplier = 2` → a 4MHz parasite,
i.e. Turbo timing. Its `tube.js` models the register semantics including the
24-byte R1 FIFO. (jsbeeb boots the external 65C02 client ROM rather than the
65C102 Turbo ROM — irrelevant to us since we replace the client OS at takeover;
the CPU core and 4MHz clock are what matter.)

The jsbeeb **MCP** (npm `jsbeeb-mcp` 2.1.0, latest) doesn't expose a tube
option yet — `create_machine` passes only a model name to `MachineSession`.
Two routes, both verified viable:

1. **Now:** drive the installed jsbeeb package directly from Node. Proof of
   concept ran clean: headless `new TestMachine("Master", {tube: true})` boots
   with the parasite executing in its client ROM at 4MHz. A thin
   `bbc/tools/tubebeeb.mjs` harness (boot disc, run cycles, read host memory,
   screenshot) replicates the MCP verification loop for Tube builds.
2. **Properly:** a ~5-line PR to jsbeeb-mcp (`tube: z.boolean()` in
   `create_machine`, forward into `MachineSession`/`TestMachine` opts).

De-risking note: almost all of the port can be verified without any Tube at
all — build the parasite interpreter as a host binary that writes records to a
RAM ring instead of R1, and the host renderer as a consumer of that ring, and
both halves verify bit-exact on the existing Master MCP. Only ~100 lines of
actual Tube glue (FIFO pump + boot handshake) need the Tube-enabled harness.

## 7b. Render exactness (post-T4 bug hunt)

All nine demos now verify **pixel-perfect final screens** against the
visualizer (`tools/pixelverify.mjs`: 0/81920 mismatches on every demo), on
top of the existing bit-exact plot logs. Three distinct defects were found
after a report of unerased black-blob fringes and spiky circles:

1. **Disc coverage** — the visualizer's shader covers pixel (dx,dy) iff
   dx²+dy² < (r+0.5)² (blob centred on the pixel centre, radius r+0.5). The
   bank-6 tables used dx²+dy² ≤ r², undersizing every circle (spiky tips,
   eraser blobs missing fringes). Fix: half-width = isqrt(r²+r−dy²) in
   `make_circle_bank` — never exceeds r, rows still 2r+1, pure table change.
2. **Intra-frame draw order** — the visualizer stable-sorts each frame's
   plots by (t, y−r) before rendering (as the Archimedes engine did with its
   per-line circle buffers); execution order differs by up to a third of the
   screen (89K px on a Euphoria frame). Fix: records are staged per frame
   (`sort_add`, 8-byte entries below the parasite states / in spare bank-6
   RAM on the single build) and flushed at the frame boundary through the
   normal byte sink in stable per-line bucket order (`flush_sorted`, two
   256-bucket passes, O(N)) — the Tube host needed no changes and the
   order-independent checksum still verifies.
3. **`span_go` odd-offset dispatch** — for left offset 1 the code did
   `lsr a : bne` after which A is 0 (the bit is in carry), so offset-1 spans
   ran the offset-0 fillers: every such span painted one pixel left of true
   since the SWRAM fillers landed. This was the user-visible "black blobs
   don't erase fully" and masqueraded as an ordering bug during diagnosis.
   Fix: `bcs`.

The visualizer's own tie-break for equal (t, y−r) is its BFS-over-fork-tree
emission order, which a frame-based engine cannot cheaply reproduce — but
with the above fixes no demo shows a visible tie difference (0-pixel deltas
across the board), so frame-FIFO tie order stands.

## 7c. Render speed pass (post-exactness)

Four optimizations attacked the T1 finding that per-line setup (~165
cycles/line) was 56–65% of render time. All 14 builds re-verified bit-exact
and all nine tube builds pixel-perfect afterwards.

1. **No ROMSEL shadow, no live interrupts** — init masks every VIA IRQ
   source (`&7F → &FE4E/&FE6E`; vsync is polled via IFR, which latches
   regardless of IER), so no handler can ever run and the `&F4` ROMSEL
   shadow became dead weight: banks switch with a bare `STA &FE30`.
2. **Phase arithmetic → bank 6 tables** — the per-line `t = phase−hw`,
   `offset = t&3`, `c0 = CCX + (t>>2)` sequence is folded into per-phase
   64-entry tables indexed by half-width (`OFFTAB/D8LTAB/D8HTAB` at
   &8100/&8200/&8300, `make_circle_bank`; hw data moved to &8400, single-CPU
   SORTBASE up to &9900). D8 is the signed byte shift 8·((phase−hw)>>2), so
   span addr = centre-column base + D8 — the col8 add went away too.
3. **Incremental row addressing** — the fast path tracks the centre-column
   screen address across lines (+1, or +ROWB−7 every 8th line) instead of
   row-table + col8 lookups per line.
4. **Mirror-line pairs + square loop** — circle rows dy and −dy share
   half-width, so span length, left offset, filler vector and D8 shift are
   computed once per pair and painted twice (fillers load RFILL and set Y
   themselves and never touch `scr`); BASE walks down while BAS2 walks up,
   meeting at the centre line. Squares resolve their one filler once and
   walk `scr` itself down 2r+1 lines.

Measured (single-CPU profile, render regions only):
- **ball**: host render+tick 51.4K → **38.9K cycles/frame** — under the 40K
  50fps slot on average; total tube run 816M → **560M cycles** (−31%),
  i.e. a mix of 50fps and 25fps frames instead of a solid 25fps.
- **Everyway**: worst storm chunk ~315K → **~170K render cycles/frame**
  (~1.85×); full-run render total 903M (rblob 522M, stores 381M). Tube run
  2064M → **1776M cycles** (−14%; the demo is parasite-bound outside the
  storms, so the render win shows there and nowhere else). Note the honest
  baseline: the 1640M in §9/T3 predates the (t,y−r) frame-stage sorter,
  which cost Everyway ~26% — sorting + this speed pass nets out at +8%
  over the unsorted build, with exact rendering.
- Remaining hot spots: pair-loop setup is now ~60-90 cycles/line amortized;
  the store chains (~128 cycles/line) are the next ceiling, then the
  clipped/r>62 slow path which kept the old per-line shape.

## 7d. Interpreter speed pass (profile-guided)

`tools/opprofile.mjs` attributes cycles to every SYM-labelled handler and
helper (subroutine time lands on the subroutine). The Everyway 600M-cycle
sample ranked: umul16 12.5%, push/pop 13.5%, flush_sorted 7.8% (mostly its
unconditional 1KB bucket clear), next_op 7.1%, emit_rec 3.3%. Changes, all
semantics-preserving and verified bit-exact:

1. **Quarter-square multiply** — `umul16` was a 16-step shift-add (~770
   cycles). Now four page-aligned 512-entry tables (f(n)=n²/4; `sq1[i]=f(i)`,
   `sq2[i]=f(i−255)`) give each 8×8 partial product as
   `f(a+b)−f(a−b)` with two indexed reads: pointer setup is just storing the
   operand byte to the pointer lo bytes (&50-&5D zp block, hi bytes set once
   at init). ~215 cycles for 16×16→32, and `smul16` no longer needs the M1
   save. Floor is exact ((a±b)² are congruent mod 4).
2. **Stack ops** — `evx` now holds the stack top pre-biased by ST_LOCALS
   (raw height still stored in the state's ST_HEIGHT byte, ±64 at the
   per-slice save/restore), so push/pop index `(st),y` directly and push
   advances `evx` with its four `iny`s. push_RA is also inlined into
   `op_const`/`op_rlocal`.
3. **Fused binary ops and WHEN** — `op_op` reads the top operand into RA and
   applies add/sub/and/or **in place on the below-slot** (one net pop, no
   push); `op_when` tests sign/zero straight off the stack and only
   advances `ip` past the target bytes when the branch is not taken.
4. **Dispatch** — constants (bit 7) short-circuit to `op_const`; everything
   else goes through one interleaved word table via the 65C02
   `jmp (dtab,x)` (opcode≤127 so idx*2 fits X). ~38 → ~29 cycles. Trap that
   bit: `inc ip` between the opcode load and the sign test trashes N — test
   with `cmp #&80`, not `bmi`.
5. **flush_sorted** — the per-frame 2×512-byte bucket-table clear is gone:
   heads are cleared once at init and the emit scan clears each head as it
   consumes it (filing now keys off the head, so stale tails are harmless);
   pass 1 is skipped entirely when no record filed for it (P1F flag).
   `q_push_a` preserves X/Y on both builds (the Tube one never needed its
   `tax`), so the emit loop dropped its per-record/per-byte save-restores.
6. **emit_rec / op_move** — the 10-byte rol32-xor record hash is unrolled
   (the first step is just h=REC[0]); op_move keeps m in RA instead of
   copying to MSAVE, and span-filler edge writes use zp RFILL/TMPB
   (SPAN_RFILL/SPAN_TMPB &6E/&6F in rose2bbc.py).
7. **Whole-blob offscreen cull** — measured against expected_plots.bin,
   16% of Everyway's plots, 32% of Euphoria's and **47% of Frustration's**
   are fully offscreen, yet each still cost staging, six wire bytes and a
   host render_blob that walked every line before rejecting. sort_add now
   culls them after the hash/count/prefix-log (so verification data is
   unchanged) using the clamped radius against XOFF/YOFF/SCRW/SCRH —
   conservative and exact, since half-width never exceeds r.

Everyway single-CPU: **3104M → 2480M cycles (−20%)**; the 600M profile
window covers 2622 frames vs 2311 (+13% throughput even before the cull)
and render is the top region again. jesuisrose 392M → 368M. Ball's
parasite side halved (25.2K → 13.6K/frame; host 38.1K with zp span edges).

Tube totals after both passes (§7c render + this) — all nine still
bit-exact and pixel-perfect:

| demo | tube cycles before (post-sort) | after | Δ |
|------|-------------------------------|-------|---|
| ball | 816M | **528M** | −35% |
| Everyway | 2064M | **1448M** (~12.5fps avg) | −30% |
| jesuisrose | — | **280M** | faster than the pre-sorter 296M |
| teaser | — | 392M | |
| tree / chiperia | — | 48M / 120M | |
| euphoria / frustration | — | **456M / 360M** | cull-heavy demos |

## 8. Risks and unknowns

- **Emulator vs real ULA fidelity** — the mandated inter-byte delays in the App
  Note apply to the OS `&406` block protocol, not to status-polled access; Toob
  proves polled bare-metal works on real hardware. Still, first real-hardware
  test matters (Kieran has the Turbo advantage: it's a standard Master fit).
- **65C102 vs 65C02** — identical instruction set for everything we emit.
- **Client OS replacement** — after takeover the parasite's RAM vectors are
  ours; nothing OS-dependent remains (same discipline as the host engine now).
- **Render-bound ceilings unchanged** — the Tube buys concurrency, not a faster
  span filler. Everyway's worst sections stay render-limited.
- **16-bit turtle handles** — required for the capacity win; touches bucket
  FIFOs, free list, and FORK. Contained but real work (~a day, validate in
  pyinterp first as usual).

## 9. Suggested phases

| Phase | Work | Exit criterion |
|---|---|---|
| T1 | ~~Profile current engine → I/R split per demo; finalize record format~~ **DONE** | split table in §5; record format in §3 |
| T2 | ~~Split the engine at the record seam, joined by a RAM queue on a plain Master~~ **DONE** | circle, ball, teaser, jesuisrose, Everyway all bit-exact through the wire protocol |
| T3 | ~~Tube glue: R1 pump both sides, boot handshake; tube-capable verify harness~~ **DONE** | all five demos bit-exact over the real emulated Tube; Everyway 1640M vs 3160M cycles (1.93×) |
| T4 | ~~Address-handles + per-demo state capacity on the parasite~~ **DONE** | tree, Chiperia, Euphoria, Frustration all bit-exact over the Tube; Everyway ~10.8fps avg (1640M/8838 frames) |
| T5 | If stalls: protocol v2 (R3 block pulls). Music on the freed host | — |
