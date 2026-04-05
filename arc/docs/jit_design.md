# Rose Arc JIT Compiler — Technical Design Document

## 1. Overview

`jit.asm` is a single-pass, ahead-of-time ARM code generator for the Rose bytecode engine on the Acorn Archimedes. It converts the program's entire bytecode stream into native ARM machine code once at startup, immediately before `InitStates` and the main render loop begin.

The output is functionally identical to the code that `rose2arc.py` would emit at build time (the AOT path), but it runs on the target machine at load time. This allows the engine to carry only compact bytecode in ROM/the binary and expand it to native ARM in BSS.

The JIT is conditionally compiled via the `-D_JIT` assembler flag. Without that flag the engine interprets `instructions.asm` directly via the original bytecode interpreter in `engine.asm`.

---

## 2. Build Integration and Sizing

### 2.1 How the JIT fits into the build

The build pipeline is:

```
.rose source
    --> rose2arc.py (host tool)
        --> bytecodes.bin, constants.bin, colorscript.bin
        --> instructions.asm  (includes .bin files + sizing equates)
    --> vasm -D_JIT rose.asm
        --> includes jit.asm, then instructions.asm
    --> vlink
    --> RISC OS app
```

### 2.2 Sizing equates

`rose2arc.py` simulates the JIT output word-for-word (via `jit_verify.py` logic) and writes four sizing equates into `instructions.asm`:

| Equate | Meaning |
|---|---|
| `_JIT_CODE_WORDS` | Exact size (in 32-bit words) of the native code buffer |
| `_JIT_MAX_PROCS`  | Number of procedures (proc_table entries needed) |
| `_JIT_MAX_FIXUPS` | Number of forward PROC-address fixups |
| `_JIT_MAX_LABELS` | Maximum WHEN/ELSE nesting depth (label stack entries) |

`jit.asm` picks these up via `.equ` aliases. The BSS tables in `rose.asm` are sized from them, so there is zero wasted BSS.

---

## 3. Memory Layout

All JIT working storage lives in the BSS section (`rose.asm`):

```
jit_code_buffer_no_adr:  .skip _JIT_CODE_WORDS * 4   ; native ARM code output
jit_proc_table_no_adr:   .skip JIT_MAX_PROCS  * 4    ; proc index -> code address
jit_fixup_table_no_adr:  .skip JIT_MAX_FIXUPS * 8    ; {patch_addr, proc_idx}
jit_label_stack_no_adr:  .skip JIT_MAX_LABELS * 8    ; {branch_word_addr, branch_top}
```

The label stack is used as a software stack, growing upward, with `R9` as the write head. Each WHEN/ELSE frame is 8 bytes: the address of the branch word (for back-patching) and a copy of the branch's top byte (to reconstruct the condition).

After `jit_compile` returns, `jit_code_buffer` contains fully-linked ARM code. `r_Instructions` (the word that `InitMainTurtle` reads as the initial `st_proc` of the first turtle) is set to `jit_code_buffer_no_adr`, so the first turtle immediately begins executing compiled code.

---

## 4. Runtime Register Convention (Compiled Code)

The compiled procedures share the runtime register convention established by `engine.asm`'s `RunFrame`:

| Register | Role at runtime |
|---|---|
| R3  | `p_StateStack` — current turtle's value stack (grows downward) |
| R4  | `r_Constants` base address |
| R5  | `p_State` — pointer to current turtle's state block |
| R6  | `p_StateLists` base |
| R7  | `r_Sinus` — sine table base |
| LR  | Return address into `RunFrame` (the `.3:` label) |

These registers are set up by `RunFrame` before every call to `st_proc` and must be preserved across all operations that don't explicitly change them.

---

## 5. JIT Compiler Working Registers

During `jit_compile` the following registers are used by the compiler itself:

| Register | Role during compilation |
|---|---|
| R3  | `jit_out` — write pointer into `jit_code_buffer` |
| R4  | `bc_ptr` — read pointer into the bytecode stream |
| R5  | `const_ptr` — `r_Constants` base (for constant folding) |
| R6  | `proc_no` — current procedure index |
| R7  | `proc_tbl` — pointer to `jit_proc_table` |
| R8  | `fix_ptr` — fixup table write head |
| R9  | `lbl_ptr` — label stack write head |
| R10 | Scratch |
| R11 | `push_pending` — deferred-push optimization flag (0 or 1) |
| R12 | `load_without_op` — flags that last value was loaded but not yet consumed by an operation |

---

## 6. Instruction Encoding Constants (`jit_insns`)

The table `jit_insns` (107 words) holds precomputed ARM instruction words. Each entry is a fixed 32-bit ARM encoding that the compiler either emits verbatim or uses as a base that is ORRed with a computed field (offset, immediate, condition code, etc.).

Entries are accessed by a PC-relative `ldr rN, ji_<name>` pattern. They are **not** indexed by the runtime; the assembler resolves them all to exact offsets. This means there is no indirection cost in the compiled procedures, but the compiler code itself is slightly longer than it would be with a register-indexed table.

Key groups within `jit_insns`:

- **Stack operations** — `STR r0,[r3,#-4]!` (push), `LDR r0,[r3],#4` (pop r0), `LDR r1,[r3],#4` (pop r1).
- **Literal loads** — `LDR r0,[pc,#0]` and `LDR r1,[pc,#0]` for constant/address values that cannot be encoded as ARM immediates. Used with a following `B .+8` + literal word pattern.
- **PLOT/DRAW** — `LDR r10,[r6,#-12]` (circle instruction) and `LDR r10,[r6,#-8]` (square instruction template).
- **WaitState inline** — ten words covering `STR r1,[r5,#0]` through `MOV pc,lr` that implement the turtle suspension protocol without calling `WaitState`.
- **FreeState inline** — three words (`LDR r2,[r6,#-4]` / `STR r2,[r5,#0]` / `STR r5,[r6,#-4]`) that free a turtle without a branch.
- **RAND/SEED** — seven words for one LFSR iteration, with `ldr r2,[pc,#0]; b .+8; .long 0x9D3D` to load the non-ARM-encodable multiplier constant via a literal pool.
- **Base encodings** — `MOV r0,#imm` / `LDR r0,[r4,#imm]` / `LDR r0,[r5,±imm]` / `STR r0,[r5,±imm]` without the immediate field, so the compiler can ORR in the offset/value at compile time.

---

## 7. Instruction Encoding Notes

### ARM LDR/STR immediate offset (imm12)

For load/store instructions the 12-bit immediate occupies bits[11:0] and the destination register occupies bits[15:12]. The base register encoding constants have these fields zeroed, allowing the compiler to ORR in the offset. The U-bit (bit 23) distinguishes positive (`0xE595xxxx`) from negative (`0xE515xxxx`) offsets.

### ARM MOV immediate (imm12 rotated)

`MOV r0, #imm` encodes the 8-bit value in bits[7:0] and a right-rotation (in units of two bits) in bits[11:8]. `jit_const` tries each rotation in turn, trying to fit the constant into 8 bits. If it cannot fit in 16 attempts it falls back to `LDR r0,[r4,#offset]` which reads from `r_Constants` at runtime (R4 holds the constants base).

### ARM branch offset (B / BL)

Branch and branch-with-link instructions encode a signed 24-bit word offset (PC+8 relative) in bits[23:0]. `jit_do_emit_bl` computes this from the target address and the current `jit_out` pointer. `jit_patch_branch` does the same for forward branches that are emitted with offset=0 and patched once the target address is known.

### ARM MUL constraint

ARM MUL requires Rd ≠ Rm and bits[15:12] = 0. The `ji_MUL_R0_R1_R0` and `ji_MUL_R1_R2_R1` encodings respect this.

---

## 8. Stack Optimization (push_pending / load_without_op)

Rather than emitting a push and then an immediate pop for every constant or variable load, the compiler implements a one-slot register window:

- When a value is loaded (`BC_CONST`, `BC_RSTATE`, `BC_RLOCAL`), `push_pending` (R11) is set to 1 and the value is left in R0. No push instruction is emitted yet.
- The next operation that needs the TOS calls `jit_do_pop_r0`. If `push_pending` is 1 it clears the flag and returns with R0 already holding the value — no instruction emitted. If `push_pending` is 0 it emits `LDR r0,[r3],#4`.
- If a second load arrives before an operation, `jit_do_load_var` emits the deferred `STR r0,[r3,#-4]!` first, then sets `push_pending` for the new value.

This eliminates ~50% of push/pop pairs for typical expressions like `const op const`.

`load_without_op` (R12) tracks whether the most recently computed value was produced by a simple load rather than an ALU instruction that set the condition flags. `BC_WHEN` needs condition flags to branch; if `load_without_op` is set it emits a `MOVS r0,r0` before the conditional branch.

---

## 9. Bytecode Handlers

The main dispatch loop (`jit_loop`) reads one bytecode, classifies it by range, and branches to the appropriate handler. Opcodes 0x00–0x0F are dispatched via a 16-entry jump table (`jit_low_table`). Higher opcode ranges (WHEN, FORK, OP, WLOCAL, WSTATE, RLOCAL, RSTATE, CONST) are classified by cascaded `CMP/BHS` pairs.

### 9.1 BC_CONST (0x80–0xFF)

Reads the low 7 bits as a constant index. If the index is >= 126, reads an extra byte and adds it for the extended range. Loads the 32-bit constant value from `r_Constants[index]`. Tries to encode it as a `MOV r0,#imm12`; falls back to `LDR r0,[r4,#index*4]` if the value cannot be expressed as a rotated 8-bit immediate. Sets `push_pending`.

Emits: **1 word**.

### 9.2 BC_RLOCAL (0x60–0x6F)

Reads field index from low nibble. Emits `LDR r0,[r5,#-(index+1)*4]` — local variables live below the state block base address (the stack grows down from p_State). Sets `push_pending`.

Emits: **1 word** (after any deferred push).

### 9.3 BC_RSTATE (0x70–0x7F)

Reads field index from low nibble. Emits `LDR r0,[r5,#index*4]` — state fields live at positive offsets from p_State. Sets `push_pending`.

Emits: **1 word** (after any deferred push).

### 9.4 BC_WLOCAL (0x40–0x4F)

Pops TOS into R0. Emits `STR r0,[r5,#-(index+1)*4]`.

Emits: **0–1 words** (pop) + **1 word** (store).

### 9.5 BC_WSTATE (0x50–0x5F)

Pops TOS into R0. Emits `STR r0,[r5,#index*4]`.

Emits: **0–1 words** (pop) + **1 word** (store).

### 9.6 BC_OP (0x30–0x3F)

Pops R0 (TOS) and R1 (NOS). For shift opcodes (0–7) emits:

```
mov r1, r1, lsr #16   ; shift amount (high 16 bits of 16.16 value)
and r1, r1, #63
movs r0, r0, <shift> r1
```

For arithmetic/logical opcodes (ADD, SUB, OR, AND, CMP) emits a single instruction. CMP does not set `push_pending` since it only updates flags; all others do.

Emits: **1–3 words** depending on opcode.

### 9.7 BC_WHEN (0x10–0x1F)

Optionally emits `MOVS r0,r0` (if `load_without_op`). Looks up the negated ARM condition code from `jit_when_conds`. Emits a forward conditional branch with offset=0 and pushes `{branch_addr, branch_top}` onto the label stack. `push_pending` and `load_without_op` are cleared so the body compiles with a clean state.

Emits: **0–1 words** (MOVS) + **1 word** (branch).

### 9.8 BC_ELSE (0x01)

Pops the WHEN entry from the label stack. Patches the WHEN branch to skip over the B instruction about to be emitted. Emits an unconditional `B .+0` (placeholder). Pushes the new branch address for DONE to patch.

Emits: **1 word** (B placeholder).

### 9.9 BC_DONE (0x00)

Pops the label stack entry (from WHEN or ELSE). Patches its branch to point to the current output position.

Emits: **0 words**.

### 9.10 BC_END (0x02) — End of procedure

Inlines `FreeState` (3 words) and emits `MOV pc,lr`. Increments `proc_no` and records the current output pointer in `proc_table[proc_no]` as the start of the next procedure.

Emits: **4 words**.

### 9.11 BC_PROC (0x07) — Push procedure address

Reads the next bytecode as a procedure index. Emits `LDR r0,[pc,#0]; B .+8; .long 0` and records a fixup `{literal_addr, proc_index}`. The placeholder `.long 0` is filled in by the fixup pass at the end. Sets `push_pending`.

Emits: **3 words** + 1 fixup entry.

### 9.12 BC_FORK (0x20–0x2F)

Pops TOS (procedure address into R0). Emits `MOV r1,#num_args; STR lr,[sp,#-4]!; BL ForkState; LDR lr,[sp],#4`.

Emits: **4 words**.

### 9.13 BC_MOVE (0x0E)

Pops TOS into R0. Emits `STR lr,[sp,#-4]!; BL DoMove; LDR lr,[sp],#4`.

Emits: **3 words**.

### 9.14 BC_DRAW (0x04) — Draw circle

Inlines the DRAW sequence without a BL:

```
add  r2, r5, #4
ldmia r2, {r8-r11}         ; load st_x, st_y, st_size, st_tint
mov  r0, r8, asr #16       ; X integer
mov  r1, r9, asr #16       ; Y integer
mov  r2, r10, asr #16      ; radius integer
mov  r9, r11, lsr #16      ; tint integer
ldr  r10, [r6, #-12]       ; plot_circle_instruction
str  lr, [sp, #-4]!
bl   link_circle
ldr  lr, [sp], #4
```

Emits: **10 words**.

### 9.15 BC_PLOT (0x06) — Draw square

Same as DRAW but adds two extra words: `LDR r10,[r6,#-8]` (square instruction template) and `ORR r10,r10,r2` (bake radius into the MOV-immediate instruction).

Emits: **11 words**.

### 9.16 BC_TAIL (0x05)

Emits `LDR r2,[r5,#0]; MOV pc,r2` — loads `st_proc` (the next-procedure address stored in the state block) and jumps to it. This is the tail-call/loop mechanism.

Emits: **2 words**.

### 9.17 BC_WAIT (0x0A)

Pops TOS into R0 (wait amount). Inlines `WaitState` entirely:

```
ldr  r1, [pc, #0]           ; load continue_addr literal
b    .+8
.long continue_addr         ; <-- patched to point past the mov pc,lr
str  r1, [r5, #0]           ; st_proc = continue_addr
str  r5, [r3, #-4]!         ; push p_State onto StateStack
ldr  r2, [r5, #28]          ; st_time
add  r2, r2, r0             ; st_time += wait_frames
str  r2, [r5, #28]
bic  r2, r2, #0xc000        ; remove fractional time bits
ldr  r1, [r6, r2, lsr #14]  ; StateLists[frame]
str  r1, [r3, #-4]!         ; push existing StateList entry
str  r3, [r6, r2, lsr #14]  ; install new StateStack for that frame
mov  pc, lr                 ; return to RunFrame
```

The `continue_addr` literal is backpatched immediately after emission: `r3` at that point is the address of the first instruction after the `MOV pc,lr`.

Emits: **12 words** (including the literal).

### 9.18 BC_NEG (0x0D)

Pops R0. Emits `RSB r0, r0, #0`.

Emits: **1 word**.

### 9.19 BC_POP (0x08)

Calls `jit_do_pop_r0` which either cancels `push_pending` (no instruction) or emits `LDR r0,[r3],#4`. The loaded value is then discarded.

Emits: **0–1 words**.

### 9.20 BC_MUL (0x0F)

16.16 fixed-point multiply. Pops R0 (TOS) and R1 (NOS), then:

```
mov r0, r0, asl #8
mov r0, r0, asr #16    ; r0 = integer part of TOS
mov r1, r1, asl #8
mov r1, r1, asr #16    ; r1 = integer part of NOS
mul r0, r1, r0         ; result in 16.16
```

Emits: **5 words**.

### 9.21 BC_DIV (0x09)

Pops R0 (TOS) and R1 (NOS). Prepares divisor in R1 (`asl #8; asr #16`), then calls `divide` via BL, scales result back. Division is handled by the existing `divide` routine in the engine.

Emits: **6 words**.

### 9.22 BC_SINE (0x0B)

Pops R0 (angle in 16.16). Emits:

```
mov r1, #0x10000
sub r1, r1, #4          ; r1 = 0xFFFC (table mask)
and r0, r0, r1          ; index into sine table
ldr r0, [r7, r0]        ; load sine value (r7 = r_Sinus)
mov r0, r0, asl #2      ; scale to 16.16
```

Emits: **5 words**.

### 9.23 BC_RAND (0x03)

Emits `LDR r0,[r5,#20]` (load `st_rand`), then calls `jit_emit_rand_iter` once (9 words), then emits `STR r0,[r5,#20]` (save updated seed) and `MOV r0,r0,lsr #16` (return high 16 bits as the random value).

Emits: **11 words** total.

### 9.24 BC_SEED (0x0C)

Pops TOS into R0 (new seed). Calls `jit_emit_rand_iter` twice, then saves the result to `st_rand`. The double iteration provides seeding quality (analogous to the interpreter's behaviour).

Emits: **19 words** total.

### 9.25 jit_emit_rand_iter (helper, not a bytecode)

Emits one LFSR step for the Rose RNG:

```
bic  r1, r0, #0xff000000   ; r1 = r0 & 0x00ffffff
bic  r1, r1, #0x00ff0000   ; r1 = r0 & 0x0000ffff (low 16 bits)
mov  r2, r0, lsl #16        ; r2 = r0 << 16
orr  r0, r2, r0, lsr #16   ; r0 = byteswapped halves
ldr  r2, [pc, #0]           ; load 0x9D3D via literal
b    .+8
.long 0x9D3D
mul  r1, r2, r1             ; r1 = 0x9D3D * low16(r0)
add  r0, r0, r1             ; r0 = rotated + multiplied
```

The 0x9D3D constant cannot be encoded as an ARM 8-bit rotated immediate, so it is always loaded via the literal pool pattern.

Emits: **9 words**.

---

## 10. Fixup Resolution

After END_OF_SCRIPT is encountered, `jit_end` walks the fixup table backward from the current write head to the base. Each entry is `{patch_addr, proc_idx}`; it reads `proc_table[proc_idx]` and stores it at `patch_addr`. This resolves all forward procedure-address references left by BC_PROC.

---

## 11. Helper Routines

| Routine | Purpose |
|---|---|
| `jit_do_load_var` | Flush deferred push if `push_pending`; set `load_without_op`. |
| `jit_do_pop_r0` | Consume TOS into R0 without push if `push_pending`; else emit `LDR r0,[r3],#4`. |
| `jit_do_pop_r1` | Always emit `LDR r1,[r3],#4` (second operand always comes from stack). |
| `jit_do_emit_bl` | Compute and emit a `BL target` from R0 (target addr). |
| `jit_patch_branch` | Patch a forward branch word at R0 to reach target R1. |
| `jit_emit_rand_iter` | Emit one LFSR iteration (9 words). Used by RAND and SEED. |

---

## 12. Key Design Decisions and Trade-offs

**No instruction cache flush.** The Archimedes ARM2/ARM3 does not have an instruction cache (or has a transparent one), so writing ARM words into BSS and immediately executing them requires no cache maintenance. This would not be portable to ARM7 or later CPUs without adding cache flush SWIs.

**No optimisation between instructions.** The compiler handles each bytecode independently. Neighbouring instructions do not combine — for example, an `ADD` followed by `WSTATE` emits a separate `STR` rather than trying to fold the result directly into the store. This keeps the compiler simple and its output predictable, matching the AOT output exactly.

**Push-pending window is one slot only.** The deferred push is only one value deep. A two-slot window would eliminate more push/pop pairs but would complicate the compiler state.

**All BL targets via label constants.** `ForkState`, `DoMove`, `divide`, and `link_circle` are called by computing the BL offset at compile time. There is no runtime dispatch table for these.

---

## 13. Suggestions for Future Improvement

### 13.1 Code size reductions (compiler code in jit.asm)

**a) Replace `jit_insns` PC-relative loads with a register-indexed table.**
Currently each `ldr rN, ji_xxx` is a separate PC-relative load. If `jit_insns` base were held in a free register (e.g., R10 could be repurposed as the table base between bytecodes since it is currently scratch), emissions could use `ldr r1, [r10, #offset]` with an 8-bit immediate offset. This would save 2–3 bytes per emission site and is particularly valuable for heavily-used constants like `ji_STR_LR_SP` / `ji_LDR_LR_SP` which appear in almost every handler.

**b) Share DRAW/PLOT preamble.**
`jit_draw` and `jit_plot` share the first 6 emitted words (ADD + LDMIA + 4× MOV) and differ only from word 7 onward. Extracting the common preamble into a helper would save ~40 bytes of compiler code.

**c) Merge RAND/SEED load/store framing.**
`jit_rand` and `jit_seed` both end with `STR r0,[r5,#20]`. `jit_rand` also adds `MOV r0,r0,lsr #16` after. The framing code could be a shared helper with a flag argument.

**d) Use `STMFD/LDMFD` for push/pop pairs in handlers.**
Several handlers do `STR lr,[sp,#-4]!` at entry and `LDR pc,[sp],#4` or `LDR lr,[sp],#4` at exit. These could be replaced with a common prologue/epilogue macro (they are already inline ARM so the saving would only be in the jit.asm source size, not the compiled binary).

**e) Collapse `jit_const_use_ldr` path.**
The `LDR r0,[r4,#offset]` fallback for non-encodable constants is already as tight as it can be (1 instruction). However, the constant-encoding search loop in `jit_const_try` iterates up to 16 times one step at a time. Replacing it with a lookup into a precomputed 256-entry byte table (8-bit value → rotation, or 0xFF = not encodable) would make the common case branchless and save ~20 words of compiler loop code.

### 13.2 Code size reductions (JIT output — runtime code)

**f) RAND literal pool deduplication.**
Every `BC_RAND` and `BC_SEED` emits the literal `0x9D3D` inline via the `ldr r2,[pc,#0]; b .+8; .long 0x9D3D` pattern (3 words). If the literal were placed once at the start of each procedure and accessed with a fixed negative-offset LDR (since the offset from the instruction to the start of the proc is known at compile time), each rand iteration would shrink from 9 to 8 words. For programs with many RAND calls this is a measurable saving.

**g) Share DRAW/PLOT preamble in output.**
The 6-word `add r2,r5,#4; ldmia r2,{r8-r11}; mov r0,r8,asr #16; ...` block before `link_circle` is identical for DRAW and PLOT. If this were a shared subroutine called via BL, each DRAW call would shrink from 10 words to 4 words (BL preamble sub + link_circle BL + LDR lr) and each PLOT from 11 to 5. The trade-off is two extra levels of call stack depth and the overhead of an extra BL/LDR lr pair.

**h) Inline FreeState with fewer instructions.**
The inlined FreeState is 3 stores (LDR r2 + STR r2 + STR r5). If each procedure that ends with BC_END could be guaranteed to only be called from `RunFrame` via `MOV pc,r1`, R6 is already live at the call site and these 3 words are hard to reduce further. No improvement possible here.

### 13.3 Correctness and robustness

**i) Overflow detection for BSS tables.**
The fixup table, label stack, and proc table are sized exactly by `rose2arc.py`. A programming error or change to rose2arc.py's sizing logic could cause silent overflows at runtime. Adding bounds checks (in a DEBUG build at minimum) when writing to these tables would catch this early.

**j) ROXR/ROXL approximation.**
`OP_ROXR` and `OP_ROXL` are mapped to `ROR` and `LSL` respectively. These are approximate (ROXR should rotate through the carry flag). If any Rose script depends on the precise extended-rotate behaviour, it will produce wrong results silently.

**k) Cache maintenance hook.**
A `jit_flush_cache` stub (even if currently a NOP) would make the JIT correct on ARM7+ targets. The Archimedes ARM2/ARM3 does not need this, but it makes the design future-proof.

### 13.4 Performance

**l) Omit redundant `push_pending` flush for DRAW/PLOT.**
`jit_draw` and `jit_plot` both call `jit_do_load_var` to flush any pending push before emitting the state-load sequence. In practice BC_DRAW/BC_PLOT are rarely preceded by a dangling push (they read directly from the state block, not from the value stack). It may be possible to assert that no push can be pending at a DRAW/PLOT site and remove the call, saving the branch cost.

**m) Combine the two-step BIC for RAND.**
`bic r1,r0,#0xff000000; bic r1,r1,#0x00ff0000` requires two instructions to isolate the low 16 bits of R0. `AND r1,r0,#0xffff` cannot be encoded directly as an ARM immediate. However `UXTH r1,r0` (available on ARMv6+) would achieve the same in one instruction — not applicable to the Archimedes ARM2/ARM3, but worth noting for any future ARM port.
