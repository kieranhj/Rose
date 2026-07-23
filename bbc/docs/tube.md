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

**This unlocks the capacity-blocked demos.** tree (262), Chiperia (273),
Euphoria (200), Frustration (211) all fit in 288 states. It needs the 16-bit
turtle handle rework (bucket/next arrays become word arrays) — but on a flat
64K with no bank paging that's straightforward, and it was required for these
demos on any target.

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
| T2 | Split `interp.asm` into parasite core + host render server, joined by a RAM ring on a plain Master | circle/ball/teaser/Everyway bit-exact via ring, on the existing MCP |
| T3 | Tube glue: R1 pump both sides, boot handshake; `tubebeeb.mjs` harness (or jsbeeb-mcp patch) | same demos bit-exact over the real emulated Tube |
| T4 | Measure framerates; 16-bit handles + 288-turtle states on the parasite | tree + Chiperia running; Everyway rate report |
| T5 | If stalls: protocol v2 (R3 block pulls). Music on the freed host | — |
