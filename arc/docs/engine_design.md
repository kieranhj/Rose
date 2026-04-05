# Rose Engine — Technical Design Document

## 1. Overview

`engine.asm` is the runtime core of the Rose Archimedes port. It is responsible for:

- Startup and hardware initialisation
- The main per-frame loop
- Turtle (state) lifecycle: allocation, scheduling, execution, freeing
- Every fundamental Rose command (move, turn, face, size, tint, draw, plot, wait, fork, rand, seed, sine, divide)
- The colour script playback (`RunColorScript`)

`engine.asm` is included by `rose.asm` which also includes `sinus.asm`, `circles.asm`, `spans.asm`, and (in JIT mode) `jit.asm` before the program data in `instructions.asm`.

---

## 2. Fixed-Point Representation

All turtle state values and Rose arithmetic use **16.16 fixed-point**: the upper 16 bits are the integer part and the lower 16 bits are the fractional part. One integer unit is `0x00010000`.

- `NUMBER_TO_INT(n)` = `n >> 16` (signed)
- `MAKE_NUMBER(n)` = `n << 16`

This applies to every field in the state block: x, y, size, tint, direction, time, wires, and locals.

---

## 3. Turtle State Block

Each turtle's complete execution state is a contiguous block of words in `r_StateSpace`. The layout is defined in `roseconfig.h.asm`:

```
Offset  Field        Description
  0     ST_PROC (0)  Pointer to the ARM code for the current procedure entry point.
  4     ST_X    (1)  X position in screen pixels (16.16).
  8     ST_Y    (2)  Y position in screen pixels (16.16).
 12     ST_SIZE (3)  Pen/circle radius (16.16).
 16     ST_TINT (4)  Colour index (16.16).
 20     ST_RAND (5)  32-bit LFSR random state.
 24     ST_DIR  (6)  Direction (16.16, units = 1/65536 of full circle).
 28     ST_TIME (7)  Scheduled wakeup time (16.16; integer part = frame number).
 32..   Wire slots   WIRE_CAPACITY (default 8) × 4-byte wire variable slots.
 ...    Local stack  MAX_STACK (default 20) × 4-byte local variable slots.
        Prev-free    1 × 4-byte pointer to next free state block (free list link).
```

`STATE_SIZE = (ST_MAX + WIRE_CAPACITY + MAX_STACK + 2) * 4`

The local variable stack grows downward from `p_State` (negative offsets). This means `local[0]` is at `[r5, #-4]` and `local[n]` is at `[r5, #-(n+1)*4]`. Wire variables follow the state fields at positive offsets beginning at `[r5, #32]`.

The initial turtle state is:
- x=0, y=0, size=2, tint=1, dir=0, time=0, rand=0xBABEFEED
- `st_proc` = address of the first compiled procedure

---

## 4. The State Space and Free List

`r_StateSpace` (BSS) is a flat array of `(MAX_TURTLES+1) * STATE_SIZE` bytes. At startup `InitStates` links them into a singly-linked free list: the first word of each block (`[r5, #0]`) is used as the `next-free` pointer. The last block points to the one before it, and so on; the sentinel at the head points to 0. `r_FreeState` (at `[r6, #-4]`) always holds the pointer to the first available block.

Allocation (`ForkState`) pops from the head of the free list:
```
r_FreeState -> block_A -> block_B -> block_C -> ...
```

Freeing (`FreeState`) pushes back onto the head:
```
[r5, #0] = r_FreeState (current head)
r_FreeState = r5 (this block becomes new head)
```

This is an O(1) alloc/free with no fragmentation since all blocks are identical size.

---

## 5. The State Lists — Temporal Scheduling

`r_StateLists` is an array of `(MAX_FRAMES + MAX_WAIT)` pointers, one per frame number. Each entry is the head of a linked stack of state stack entries for turtles scheduled to execute on that frame.

A **state stack entry** is a pair of words pushed downward relative to the state block:

```
[r3, #0]  ptr to previous state stack entry for the same frame (linked list link)
[r3, #4]  ptr to the state block (p_State)
```

`r_StateLists[frame]` → state_stack_entry_1 → state_stack_entry_2 → 0

This design allows multiple turtles to wake on the same frame, processed in reverse-push order by `RunFrame`.

---

## 6. Global Register Convention at Runtime

During `RunFrame` and all compiled/interpreted procedures the following registers are preserved across calls:

| Register | Value |
|---|---|
| R3 | `p_StateStack` — current turtle's value stack pointer (grows down, below `p_State`) |
| R4 | `r_Constants` base address |
| R5 | `p_State` — current turtle's state block |
| R6 | `p_StateLists` base (= `r_StateLists_no_adr`) |
| R7 | `r_Sinus` — precomputed sine table base |

The word at `[r6, #-4]` is `r_FreeState`. Words at `[r6, #-8]` and `[r6, #-12]` are the square and circle plot instruction templates used by `plot_all_circles`.

---

## 7. Startup Sequence (`main` in `rose.asm`)

The program entry point `main` performs:

1. **BSS zero** — clears the entire BSS section (state space, sinus table, circle buffers, etc.) with `STMIA` in 16-byte chunks.
2. **Screen mode** — sets the RISC OS screen mode via `OS_Write0` VDU sequences.
3. **Screen memory** — allocates screen memory for the configured number of banks via `OS_ChangeDynamicArea` (Archimedes requires explicit allocation for larger modes).
4. **Music load** — if `_ENABLE_MUSIC`, loads the QTM module, sets sample rate and mono output.
5. **Screen address** — reads the physical VIDC screen start address via `OS_ReadVduVariables`.
6. **Table generation** — calls:
   - `gen_code` — generates the span-drawing ARM routines in BSS (see `spans.asm`)
   - `MakeSinus` — fills the sine table
   - `MakeReciprocal` (if enabled) — fills the reciprocal lookup table
7. **JIT compile** — if `_JIT`, calls `jit_compile` to translate bytecodes to ARM code in BSS.
8. **`InitStates`** — links the state space free list and places the initial turtle.
9. **Interrupt handlers** — claims `ErrorV` and `EventV`, enables the VSync event.
10. **Main loop entry** — enters `main_loop`.

---

## 8. Main Loop (`main_loop`)

Each iteration of the main loop corresponds to one animation frame:

```
1. debug_controls (DEBUG only)
2. Check Escape key → exit
3. RunFrame          — execute all turtles scheduled for this frame
4. Wait for VSync    — spin on vsync_count until it increments
5. RunColorScript    — apply next palette change(s) from the colour script
6. plot_all_circles  — rasterise all pending circles/squares to the screen
7. Increment r_FrameCounter
8. Check MAX_FRAMES → exit
9. Loop
```

Frame rate is locked to 50 Hz by waiting for at least one VSync interrupt. A dropped-frames counter tracks whether the previous frame took more than one VSync interval.

---

## 9. `RunFrame`

```asm
RunFrame:
    str lr, [sp, #-4]!
    ldr r4, p_Constants     ; set up r4 (r_Constants base)
    ldr r7, p_Sinus         ; set up r7 (sinus table base)
    ldr r6, p_StateLists    ; set up r6 (state lists base)
.1:
    ldr r2, r_FrameCounter
    ldr r3, [r6, r2, lsl #2]   ; p_StateStack = StateLists[current_frame]
    cmp r3, #0
    beq .2                      ; no more turtles this frame
    ldr r1, [r3], #4            ; pop ptr to next state stack entry
    str r1, [r6, r2, lsl #2]   ; update StateLists[frame]
    ldr r5, [r3], #4            ; pop p_State
    ldr r1, [r5, #ST_PROC*4]   ; load st_proc (procedure address)
    adr lr, .3
    mov pc, r1                  ; call st_proc
.3:
    b .1
.2:
    ldr pc, [sp], #4
```

Each call to `st_proc` executes the compiled (or interpreted) body of one procedure for one turtle. The procedure returns to `.3:` when it is done for this frame — either because it called `wait` (suspending itself to a future frame) or because it reached the end of the procedure body (`done` / `end`).

Because the state list head is updated before the call (popping the entry from `StateLists[frame]`) the procedure can freely push itself to a future frame via `WaitState` without interfering with the current scan.

---

## 10. `InitStates` and `InitMainTurtle`

### `InitStates`

Walks `r_StateSpace` and builds the free list. For `MAX_TURTLES-1` iterations it writes a pointer from the **end** of each block to the **start** of the previous block (i.e., the free-list link is stored at `[block+STATE_SIZE, #0]`). On exit R5 points to the last block (= the initial turtle's state block) and the free list is fully formed.

### `InitMainTurtle`

- In JIT mode sets `st_proc` to `jit_code_buffer_no_adr` (the first procedure's compiled address).
- In interpreter mode sets `st_proc` to `r_Instructions` (the bytecode array).
- Sets `st_rand` to `0xBABEFEED`.
- Pushes the initial turtle state stack entry into `StateLists[0]`.

---

## 11. Turtle Lifecycle

### 11.1 Spawning (`ForkState`)

`ForkState` is called when a `fork` statement executes. Inputs:

- R0 = address of the forked procedure (its compiled code address)
- R1 = number of arguments
- R3 = current turtle's value stack pointer
- R5 = current turtle's state block

Steps:

1. Pops the next free state block from `r_FreeState`.
2. Sets `p_NewState.st_proc = R0`.
3. Copies the entire state from the parent (`st_x` through the last wire slot) — 15 words (4+4+4+3) via `LDMIA/STMIA`.
4. Copies `num_args` argument values from the parent's value stack into the new state's local stack area (below `p_NewState`).
5. Reads `p_CurrentState.st_time`, computes the index into `StateLists`, and inserts the new turtle's state stack entry at the head of `StateLists[current_frame]`.

The new turtle therefore begins execution on the **same frame** as the fork, and inherits the parent's full position/direction/size/tint/rand/wire state. Arguments become the first locals of the new procedure.

### 11.2 Suspension (`WaitState`)

`WaitState` (or its inline equivalent in compiled code) is called when a `wait` statement executes. Inputs:

- R0 = wait amount (16.16, integer part = frames to wait)
- R1 = continue address (address of the instruction following the wait in compiled code)

Steps:

1. Stores `R1` into `st_proc` — this is where the turtle will resume.
2. Pushes `p_State` onto the current value stack (`STR r5, [r3, #-4]!`).
3. Computes the wake frame: `st_time += wait_amount`, then `frame = st_time >> 16` (fractional bits masked off via `BIC r2, r2, #0xc000`).
4. Loads the existing head of `StateLists[frame]` and pushes both the pointer and the state stack entry into `StateLists[frame]`.
5. Returns to `RunFrame` via `MOV pc, lr`.

On the wake frame `RunFrame` finds this turtle's entry in `StateLists[wake_frame]`, pops it, and calls `st_proc` which now points to the continuation.

### 11.3 Freeing (`FreeState`)

`FreeState` is inlined at the end of every compiled procedure (`BC_END`). It pushes the state block back onto the free list:

```asm
ldr r2, [r6, #-4]       ; old r_FreeState head
str r2, [r5]             ; state[0] = old head (free-list link)
str r5, [r6, #-4]        ; r_FreeState = this state block
mov pc, lr
```

The turtle is now dead. Execution returns to `RunFrame`'s `.3:` label, which loops to process the next turtle on this frame.

### 11.4 Tail Call (`BC_TAIL`)

A `tail` instruction re-executes the current procedure from its top-level entry point, looping without consuming any stack. `st_proc` is loaded and jumped to directly:

```asm
ldr r2, [r5, #0]    ; load st_proc
mov pc, r2
```

Because `st_proc` still points to the start of the current procedure, this is a free, non-returning jump — no `BL`, no stack growth. Tail calls are the primary mechanism for recursive loops in Rose.

---

## 12. Fundamental Command Implementations

### 12.1 `wait N`

Suspends the turtle for `N` frames. Delegates entirely to `WaitState` (see §11.2). The continue address is the instruction immediately following the `WAIT` block in the compiled code.

### 12.2 `fork proc(args...)`

Delegates to `ForkState` (see §11.1). The forked turtle is scheduled immediately for the current frame and begins executing `proc` with the supplied arguments as its locals.

### 12.3 `move N` (`DoMove`)

Moves the turtle `N` units in the direction `st_dir`. The displacement is computed as:

```
dx = N * cos(st_dir)
dy = N * sin(st_dir)
```

`DoMove` uses the precomputed sine table (`r_Sinus`). Direction is encoded as a 32-bit value where a full circle is 2²⁴ (since the table has `DEGREES=16384` entries and the direction is used at `[r7, r1, lsl #2]` with `r1 = dir >> 10`, i.e., index into 16384 entries).

The calculation uses two precision modes:

**Small move** (|N| < 32 integer units):

```asm
mov r0, r0, asr #6          ; [6.10] — keep 10 fractional bits
mul r8, r0, r8              ; r8 = N * sin [6.24]
mul r9, r0, r9              ; r9 = N * cos [6.24]
mov r8, r8, asr #8          ; [6.16]
mov r9, r9, asr #8          ; [6.16]
```

**Large move** (|N| ≥ 32 integer units):

```asm
mov r0, r0, asr #14         ; [14.2] — keep only 2 fractional bits
mul r8, r0, r8              ; [14.16]
mul r9, r0, r9              ; [14.16]
```

The two modes trade fractional precision for integer range to avoid overflow in the `MUL` instruction (ARM MUL takes 32×32→32). The result is added to `st_x` and `st_y`.

Cosine is obtained by reading the sine table at `dir + 90°` (adding `0x00400000` to the direction before masking and indexing).

### 12.4 `turn N`

Adds `N` (16.16) to `st_dir`. No boundary check is needed; the direction wraps naturally at 2³² since the sine table lookup masks off the upper byte (`BIC r1, r1, #0xff000000`) and shifts down.

Compiled code (AOT/JIT inlined):
```asm
ldr  r0, [r5, #ST_DIR*4]
add  r0, r0, <N>
str  r0, [r5, #ST_DIR*4]
```

### 12.5 `face N`

Sets `st_dir = N` directly. Same store as `turn` but without the add.

### 12.6 `size N`

Sets `st_size = N`. The value is stored as 16.16; the integer part is used as the radius passed to `link_circle`.

### 12.7 `tint N`

Sets `st_tint = N`. The integer part is passed to `link_circle` as the colour index and determines which palette entry the circle uses. In dual-playfield mode tint values 0–3 go to layer 0 and 4–7 go to layer 1.

### 12.8 `draw` (BC_DRAW)

Draws a circle at the current position using the current size and tint. The inline sequence:

```asm
add  r2, r5, #4              ; point past st_proc to st_x
ldmia r2, {r8-r11}           ; r8=st_x, r9=st_y, r10=st_size, r11=st_tint
mov  r0, r8, asr #16         ; integer X
mov  r1, r9, asr #16         ; integer Y
mov  r2, r10, asr #16        ; integer radius
cmp  r2, #0
blt  .1                      ; skip if negative radius
mov  r9, r11, lsr #16        ; integer tint
ldr  r10, [r6, #-12]         ; plot_circle_instruction = LDRB r1,[r12],#1
bl   link_circle
.1:
```

`plot_circle_instruction` (`0xe4dc1001`) is the ARM encoding of `LDRB r1,[r12],#1` — the instruction that will be self-modified into `circle_loop` when the circles are rasterised. It advances through the per-row width table from the precomputed circle data.

### 12.9 `plot` (BC_PLOT)

Draws a filled square at the current position. Identical to `draw` up to the loading of R10:

```asm
ldr  r10, [r6, #-8]          ; plot_square_instruction = MOV r1, #0
orr  r10, r10, r2             ; bake radius into immediate field → MOV r1, #radius
```

`plot_square_instruction` (`0xe3a01000`) is the ARM encoding of `MOV r1, #0`. ORRing in R2 (the integer radius) sets the immediate field, making it `MOV r1, #radius`. This encoded instruction is stored directly into `circle_loop`'s instruction word at rasterisation time via `str r10, circle_loop` in `plot_all_circles`. Both circles and squares are queued to the same `link_circle` / `plot_all_circles` pipeline.

In the visualizer, `draw` passes `tint` to the output and `plot` passes `~tint` (bitwise complement). The Archimedes engine does not distinguish them at the scheduling level — the distinction is entirely in the instruction baked into R10.

### 12.10 `sine(x)` (BC_SINE)

Computes sin(2π·x) where x is in 16.16. Result is in 16.16 in the range [−1, +1].

```asm
mov  r1, #0x10000
sub  r1, r1, #4              ; r1 = 0xFFFC (align mask for 16384-entry table × 4-byte entries)
and  r0, r0, r1              ; index = x & 0xFFFC (byte address within table)
ldr  r0, [r7, r0]            ; r0 = sinus[index] (14-bit fixed-point sine value)
mov  r0, r0, asl #2          ; scale to 16.16
```

The sine table has 16384 entries (DEGREES), indexed by the lower 16 bits of the 16.16 angle after masking to 14-bit alignment. The table stores values in [0, 0x4000] (14-bit), scaled by `asl #2` to 16-bit range for 16.16 output.

`MakeSinus` generates the table at startup using a degree-5 polynomial approximation (Horner's method):

```
r = ((((2373·a²/2¸¹⁶ − 21073)·a²/2¹⁶ + 51469)·a) >> 13
```

Values are computed only for the first quarter and mirrored to all four quadrants with sign.

### 12.11 `rand` (BC_RAND)

Advances the turtle's LFSR random state and returns the upper 16 bits:

```
state = (state & 0xFFFF) * 0x9D3D + byteswap16(state)
result = (state >> 16) & 0xFFFF
```

Where `byteswap16(state) = (state << 16) | (state >> 16)`.

The ARM implementation:

```asm
ldr  r0, [r5, #ST_RAND*4]   ; load st_rand
bic  r1, r0, #0xff000000    ; r1 = low 24 bits
bic  r1, r1, #0x00ff0000    ; r1 = low 16 bits
mov  r2, r0, lsl #16        ; r2 = r0 << 16
orr  r0, r2, r0, lsr #16    ; r0 = byteswap16(r0)
ldr  r2, [pc, #0]; b .+8; .long 0x9D3D  ; r2 = 0x9D3D (non-encodable as ARM immediate)
mul  r1, r2, r1             ; r1 = 0x9D3D * low16(old_state)
add  r0, r0, r1             ; r0 = new state
str  r0, [r5, #ST_RAND*4]
mov  r0, r0, lsr #16        ; return high 16 bits as 16.16
```

The constant `0x9D3D` cannot be encoded directly as an ARM 8-bit rotated immediate, so it is always loaded via a literal pool word.

### 12.12 `seed N` (BC_SEED)

Seeds the turtle's random state. Runs `random_iteration` twice on the input value and stores the result:

```
st_rand = random_iteration(random_iteration(N))
```

Running two iterations before storing ensures the seed is well-mixed regardless of input. The compiled code calls `jit_emit_rand_iter` twice.

### 12.13 Division (BC_DIV)

Division is handled by the `divide` routine in `sinus.asm`. The Rose semantics are 16.16 ÷ 16.16:

The caller prepares:
- R0 = dividend (as-is, 16.16)
- R1 = divisor, pre-shifted: `asl #8; asr #16` → integer part only, sign extended

`divide` returns R0 = quotient (integer), then the caller does `asl #8` to restore 16.16 scaling.

The `divide` implementation signs R0 and R1, checks for division by zero, then either:

**With reciprocal table** (`_ENABLE_RECIPROCAL_TABLE=1`): Loads the precomputed `1/(divisor)` value from `reciprocal_table` (entry = `(1<<24)/divisor`), multiplies by the dividend shifted right 8, giving the result in ~24 bits. This is much faster than the loop.

**Without reciprocal table**: Classic bit-by-bit restoring division loop from the AOS book — shifts divisor left until it exceeds dividend, then subtracts and accumulates.

The reciprocal table is `64KB × 4 = 256KB` of BSS and covers divisors 0–65535 (the 16-bit integer range of a 16.16 value).

### 12.14 Wire and Temp Variables

**`temp` (local variables)** are stored below the state block at negative offsets from `p_State`. `BC_RLOCAL` and `BC_WLOCAL` address them as `[r5, #-(index+1)*4]`. They are not cleared between calls — in the interpreter model each procedure body executes exactly once per activation, so there is no issue with stale locals provided the procedure always writes before reading.

**`wire` (global inherited variables)** are stored at positive offsets after the state fields: `[r5, #(ST_MAX + wire_index) * 4]`. `BC_RSTATE` and `BC_WSTATE` with the appropriate field index access them. Because `ForkState` copies the complete state block, wires are inherited by forked turtles.

---

## 13. `RunColorScript`

The colour script is a pre-compiled array of `{delta_frame, tint_index, xBGR}` triplets in `r_ColorScript`. A negative `delta_frame` means "not yet on this frame"; advancing through it one step per call gives palette changes at the correct frames.

```
RunColorScript:
    ldr r6, p_ColorScript
    ldr r0, [r6]           ; delta_frame
    adds r0, r0, #1        ; increment
    str r0, [r6]
    bmi .2                 ; not yet this frame, return
.1:
    ldr r2, [r6, #4]!      ; load next {tint, xBGR} word
    movs r2, r2            ; test sign
    bmi .2                 ; negative = next delta marker, stop
    mov r0, r2, lsr #24    ; tint index
    bl set_colour          ; set logical → physical via OS_Word 12
    b .1
.2:
    str r6, p_ColorScript
```

`set_colour` issues RISC OS `OS_Word 12` with an OSWORD block mapping logical colour index to physical RGB. In dual-playfield mode `set_colour` handles layer-0 and layer-1 pixel encodings separately (4 physical colour entries per logical tint value).

---

## 14. Compile-Time Configuration

| Symbol | Default | Meaning |
|---|---|---|
| `MAX_FRAMES` | 10000 | Total animation length |
| `MAX_TURTLES` | 500 | Maximum live turtles |
| `MAX_STACK` | 20 | Local variable stack depth per turtle |
| `WIRE_CAPACITY` | 8 | Number of wire variable slots per turtle |
| `MAX_WAIT` | 1000 | Extra frames beyond `MAX_FRAMES` for late-waking turtles |
| `_FORM_WIDTH` | required | Screen width in pixels |
| `_FORM_HEIGHT` | required | Screen height in pixels |
| `_SCREEN_MODE` | 9 | RISC OS screen mode number |
| `_DUAL_PLAYFIELD` | 0/1 | Enables dual playfield mode (320×180 widescreen) |
| `_ENABLE_MUSIC` | 0/1 | Enables QTM module playback |
| `_ENABLE_RECIPROCAL_TABLE` | 1 | Use lookup table for division |
| `_JIT` | optional | Enable JIT compiler |

---

## 15. Inlining Flags

Three `_Inline_*` constants in `engine.asm` control whether certain operations are inlined into compiled procedures or called as subroutines:

| Flag | Default | Effect |
|---|---|---|
| `_Inline_FreeState` | 1 | FreeState 3-word sequence inlined at `BC_END` |
| `_Inline_WaitState` | 1 | WaitState 10-word sequence inlined at `BC_WAIT` |
| `_Inline_PlotDraw`  | 1 | DRAW/PLOT sequences inlined; `PutCircle`/`PutSquare` unused |

When all three are 1 (the default) the non-inlined versions `FreeState`, `WaitState`, `PutCircle`, `PutSquare` are excluded from the build entirely (conditional assembly). The inlined paths are slightly larger in code size per call site but avoid the BL overhead on every turtle execution.

---

## 16. Debug Facilities

When `_DEBUG=1`:

- `r_NumTurtles` / `r_MaxTurtles` — live turtle count and high-water mark, updated in `ForkState` and `FreeState`.
- `r_NumCircles` / `r_MaxCircles` — circles per frame count, updated in `link_circle`.
- `debug_controls` — reads keyboard: Space (play/pause), Right/S (step), D (toggle info overlay), R (toggle rasters).
- `debug_info` — prints frame counter and vsync delta to screen.
- `_DEBUG_RASTERS` — changes the border colour to indicate which phase is executing (yellow=debug, blue=RunFrame, green=RunColorScript, red=plot_all_circles, black=idle/VSync wait).
- `_DEBUG_STOP_ON_FRAME` — automatically pauses at a specified frame number.

---

## 17. Data Flow Summary

```
main:
  ┌─ MakeSinus, gen_code, MakeReciprocal
  ├─ (JIT mode) jit_compile → fills jit_code_buffer with ARM code
  ├─ InitStates → sets up free list, places turtle 0 in StateLists[0]
  └─ main_loop:
       RunFrame:
         for each turtle in StateLists[current_frame]:
           mov pc, st_proc  ← compiled proc (or bytecode handler)
             move/turn/face/size/tint:  update state fields
             draw/plot:  → link_circle → r_CircleBuffer (sorted by Y)
             wait:  → push into StateLists[future_frame], return to RunFrame
             fork:  → ForkState → new entry in StateLists[current_frame]
             end:  → FreeState → return to RunFrame
       VSync wait
       RunColorScript → OS_Word 12 (palette changes)
       plot_all_circles:
         for Y = 0..Screen_Height:
           for each circle at this Y:
             patch circle_loop with plot instruction
             for each row in circle:
               dispatch to generated span code (gen_code_start)
```
