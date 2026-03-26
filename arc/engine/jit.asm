; ============================================================================
; jit.asm — ARM JIT compiler for Rose bytecodes
; ============================================================================
; Converts Rose bytecodes to ARM machine code at program startup.
; Produces output equivalent to rose2arc.py's AOT compiler.
;
; JIT working registers (separate from Rose runtime registers):
;   R3  = jit_out   — write pointer into JIT buffer
;   R4  = bc_ptr    — read pointer into bytecode stream
;   R5  = const_ptr — r_Constants base
;   R6  = proc_no   — current procedure number
;   R7  = proc_tbl  — jit_proc_table pointer
;   R8  = fix_ptr   — fixup table write head (8 bytes each: {patch_addr, proc_idx})
;   R9  = lbl_ptr   — label stack write head (8 bytes each: {branch_addr, top_cond_byte})
;   R11 = push_pend — push_pending flag (1=pending)
;   R12 = ld_no_op  — load_without_op flag (1=set)
;   R10 = scratch
; ============================================================================

.equ JIT_MAX_PROCS,   _JIT_MAX_PROCS   ; set by rose2arc.py in instructions.asm
.equ JIT_MAX_FIXUPS,  _JIT_MAX_FIXUPS
.equ JIT_MAX_LABELS,  _JIT_MAX_LABELS

; ============================================================================
; Instruction encoding constants (ARM words to emit into JIT buffer)
; ============================================================================
jit_insns:
ji_STR_R0_R3_M4W:   .long 0xE5230004   ; str r0, [r3, #-4]!   PUSH r0
ji_LDR_R0_R3_P4:    .long 0xE4930004   ; ldr r0, [r3], #4     POP  r0
ji_LDR_R1_R3_P4:    .long 0xE4931004   ; ldr r1, [r3], #4     POP  r1
ji_LDR_R0_LIT:      .long 0xE59F0000   ; ldr r0, [pc, #0]     load literal at pc+8
ji_LDR_R1_LIT:      .long 0xE59F1000   ; ldr r1, [pc, #0]     load literal at pc+8
ji_B_SKIP1:         .long 0xEA000000   ; b   .+8              skip next word
ji_MOV_PC_LR:       .long 0xE1A0F00E   ; mov pc, lr           return
ji_MOV_PC_R2:       .long 0xE1A0F002   ; mov pc, r2           tail jump
ji_RSB_R0_0:        .long 0xE2600000   ; rsb r0, r0, #0       negate
ji_ADDS:            .long 0xE0900001   ; adds r0, r0, r1
ji_SUBS:            .long 0xE0500001   ; subs r0, r0, r1
ji_CMP:             .long 0xE1500001   ; cmp  r0, r1
ji_ANDS:            .long 0xE0100001   ; ands r0, r0, r1
ji_ORAS:            .long 0xE1900001   ; orrs r0, r0, r1
ji_STR_LR_SP:       .long 0xE52DE004   ; str  lr, [sp, #-4]!
ji_LDR_LR_SP:       .long 0xE49DE004   ; ldr  lr, [sp], #4
ji_ADD_R2_R5_4:     .long 0xE2852004   ; add  r2, r5, #4
ji_LDMIA_R2_R8_11:  .long 0xE8920F00   ; ldmia r2, {r8-r11}
ji_MOV_R0_R8_ASR16: .long 0xE1A00848   ; mov  r0, r8, asr #16
ji_MOV_R1_R9_ASR16: .long 0xE1A01849   ; mov  r1, r9, asr #16
ji_MOV_R2_R10_A16:  .long 0xE1A0284A   ; mov  r2, r10, asr #16
ji_MOV_R9_R11_L16:  .long 0xE1A0982B   ; mov  r9, r11, lsr #16
ji_LDR_R10_R6_M12:  .long 0xE516A00C   ; ldr  r10, [r6, #-12] (circle)
ji_LDR_R10_R6_M8:   .long 0xE5168008   ; ldr  r10, [r6, #-8]  (square)
ji_ORR_R10_R10_R2:  .long 0xE18AA002   ; orr  r10, r10, r2
ji_LDR_R2_R6_M4:    .long 0xE5162004   ; ldr  r2, [r6, #-4]   (r_FreeState)
ji_STR_R2_R5_0:     .long 0xE5852000   ; str  r2, [r5]
ji_STR_R5_R6_M4:    .long 0xE5065004   ; str  r5, [r6, #-4]
ji_STR_R1_R5_0:     .long 0xE5851000   ; str  r1, [r5, #0]    (st_proc)
ji_LDR_R2_R5_28:    .long 0xE595201C   ; ldr  r2, [r5, #28]   (st_time)
ji_ADD_R2_R2_R0:    .long 0xE0822000   ; add  r2, r2, r0
ji_STR_R2_R5_28:    .long 0xE585201C   ; str  r2, [r5, #28]
ji_BIC_R2_R2_C000:  .long 0xE3C22CC0   ; bic  r2, r2, #0xc000
ji_LDR_R1_R6_R2:    .long 0xE7961722   ; ldr  r1, [r6, r2, lsr #14]
ji_STR_R1_R3_M4W:   .long 0xE5231004   ; str  r1, [r3, #-4]!
ji_STR_R3_R6_R2:    .long 0xE7863722   ; str  r3, [r6, r2, lsr #14]
ji_STR_R5_R3_M4W:   .long 0xE5235004   ; str  r5, [r3, #-4]!  (WAIT)
ji_LDR_R2_R5_0:     .long 0xE5952000   ; ldr  r2, [r5, #0]    (TAIL: st_proc)
ji_MOV_R0_ASL8:     .long 0xE1A00400   ; mov  r0, r0, asl #8
ji_MOV_R0_ASR16:    .long 0xE1A00840   ; mov  r0, r0, asr #16
ji_MOV_R1_ASL8:     .long 0xE1A01401   ; mov  r1, r1, asl #8
ji_MOV_R1_ASR16:    .long 0xE1A01841   ; mov  r1, r1, asr #16
ji_MUL_R0_R1_R0:    .long 0xE0000091   ; mul  r0, r1, r0
; SINE
ji_MOV_R1_0x10000:  .long 0xE3A01801   ; mov  r1, #0x10000
ji_SUB_R1_4:        .long 0xE2411004   ; sub  r1, r1, #4      → r1=0xFFFC
ji_AND_R0_R0_R1:    .long 0xE0000001   ; and  r0, r0, r1
ji_LDR_R0_R7_R0:    .long 0xE7970000   ; ldr  r0, [r7, r0]
ji_MOV_R0_ASL2:     .long 0xE1A00100   ; mov  r0, r0, asl #2
; RAND / SEED
ji_BIC_R1_R0_FF24:  .long 0xE3C014FF   ; bic  r1, r0, #0xff000000
ji_BIC_R1_R1_FF16:  .long 0xE3C118FF   ; bic  r1, r1, #0x00ff0000
ji_MOV_R2_R0_L16:   .long 0xE1A02800   ; mov  r2, r0, lsl #16
ji_ORR_R0_R2_R0R16: .long 0xE1820820   ; orr  r0, r2, r0, lsr #16
ji_LDR_R0_R5_20:    .long 0xE5950014   ; ldr  r0, [r5, #20]   (st_rand)
ji_STR_R0_R5_20:    .long 0xE5850014   ; str  r0, [r5, #20]
ji_MOV_R0_LSR16:    .long 0xE1A00820   ; mov  r0, r0, lsr #16
ji_MUL_R1_R2_R1:    .long 0xE0011292   ; mul  r1, r2, r1
ji_ADD_R0_R0_R1:    .long 0xE0800001   ; add  r0, r0, r1
; Shift ops
ji_MOV_R1_R1_LSR16: .long 0xE1A01821   ; mov  r1, r1, lsr #16
ji_AND_R1_R1_63:    .long 0xE201103F   ; and  r1, r1, #63
ji_MOVS_ASR_R1:     .long 0xE1B00150   ; movs r0, r0, asr r1
ji_MOVS_LSR_R1:     .long 0xE1B00130   ; movs r0, r0, lsr r1
ji_MOVS_LSL_R1:     .long 0xE1B00110   ; movs r0, r0, lsl r1
ji_MOVS_ROR_R1:     .long 0xE1B00170   ; movs r0, r0, ror r1
; WHEN movs r0, r0 (update flags)
ji_MOVS_R0_R0:      .long 0xE1B00000   ; movs r0, r0
; Rand constant 0x9D3D — not an ARM immediate; must use literal pool in output
ji_CONST_9D3D:      .long 0x00009D3D   ; 0x9D3D (little-endian, as used in runtime)
; Base instruction encodings for dynamically-built instructions (too large for ORR imm)
ji_MOV_R0_IMM_BASE: .long 0xE3A00000   ; mov r0, #imm12 base (before imm field)
ji_LDR_R0_R4_BASE:  .long 0xE5940000   ; ldr r0, [r4, #imm12] base
ji_LDR_R0_R5_NEG:   .long 0xE5150000   ; ldr r0, [r5, #-imm12] (U=0)
ji_LDR_R0_R5_POS:   .long 0xE5950000   ; ldr r0, [r5, #imm12]  (U=1)
ji_STR_R0_R5_NEG:   .long 0xE5050000   ; str r0, [r5, #-imm12] (U=0)
ji_STR_R0_R5_POS:   .long 0xE5850000   ; str r0, [r5, #imm12]  (U=1)
ji_MOV_R1_IMM_BASE: .long 0xE3A01000   ; mov r1, #imm12 base (FORK num_args)
ji_LDR_R2_PC_LIT:   .long 0xE59F2000   ; ldr r2, [pc, #0] (RAND literal load)

; ============================================================================
; Condition code table for BC_WHEN
; bc_when nibble → ARM condition field (4 bits) for negated condition
; Index: nibble value (0..15)
; ============================================================================
jit_when_conds:
    .byte 0, 0, 0, 0, 0, 0   ; 0..5 unused
    .byte 1                    ; 6 = CMP_EQ  → branch NE (ARM cond 1)
    .byte 0                    ; 7 = CMP_NE  → branch EQ (ARM cond 0)
    .byte 0, 0, 0, 0           ; 8..11 unused
    .byte 10                   ; 12 = CMP_LT → branch GE (ARM cond 10)
    .byte 11                   ; 13 = CMP_GE → branch LT (ARM cond 11)
    .byte 12                   ; 14 = CMP_LE → branch GT (ARM cond 12)
    .byte 13                   ; 15 = CMP_GT → branch LE (ARM cond 13)
    .p2align 2

; OP instruction table indexed by nibble
; Returns index into jit_insns relative to ji_ADDS
jit_op_insns:
    .long ji_MOVS_ASR_R1 - jit_insns  ; 0 = OP_ASR
    .long ji_MOVS_LSR_R1 - jit_insns  ; 1 = OP_LSR
    .long ji_MOVS_ROR_R1 - jit_insns  ; 2 = OP_ROXR (approximate)
    .long ji_MOVS_ROR_R1 - jit_insns  ; 3 = OP_ROR
    .long ji_MOVS_LSL_R1 - jit_insns  ; 4 = OP_ASL
    .long ji_MOVS_LSL_R1 - jit_insns  ; 5 = OP_LSL
    .long ji_MOVS_LSL_R1 - jit_insns  ; 6 = OP_ROXL (approximate)
    .long ji_MOVS_LSL_R1 - jit_insns  ; 7 = OP_ROL  (approximate)
    .long ji_ORAS - jit_insns         ; 8 = OP_OR
    .long ji_SUBS - jit_insns         ; 9 = OP_SUB
    .long 0                           ; 10 unused
    .long ji_CMP  - jit_insns         ; 11 = OP_CMP
    .long ji_ANDS - jit_insns         ; 12 = OP_AND
    .long ji_ADDS - jit_insns         ; 13 = OP_ADD
    .long 0                           ; 14 unused
    .long 0                           ; 15 unused

; Helper addresses
jit_addr_ForkState:   .long ForkState
jit_addr_DoMove:      .long DoMove
jit_addr_divide:      .long divide
jit_addr_link_circle: .long link_circle

; BSS pointer words (resolved at link time)
jit_p_proc_tbl:   .long jit_proc_table_no_adr
jit_p_fix_tbl:    .long jit_fixup_table_no_adr
jit_p_lbl_stk:    .long jit_label_stack_no_adr

; instructions.asm pointer words — use ldr rather than adr since the offset to
; instructions.asm may exceed what ARM can encode as an 8-bit rotated immediate
jit_p_Bytecodes:  .long r_Bytecodes
jit_p_Constants:  .long r_Constants

; ============================================================================
; jit_compile — Entry point
; ============================================================================
jit_compile:
    stmfd sp!, {r4-r12, lr}

    ; Set up working registers
    ldr r3, r_Instructions           ; r3 = JIT output write pointer (BSS buffer via pointer word)
    ldr r4, jit_p_Bytecodes          ; r4 = bytecode read pointer
    ldr r5, jit_p_Constants          ; r5 = constants array base
    mov r6, #0                       ; proc_no = 0
    ldr r7, jit_p_proc_tbl           ; r7 = proc_table
    ldr r8, jit_p_fix_tbl            ; r8 = fixup table write head
    ldr r9, jit_p_lbl_stk            ; r9 = label stack write head
    mov r11, #0                      ; push_pending = false
    mov r12, #0                      ; load_without_op = false

    ; Record proc_0 start
    str r3, [r7]                     ; proc_table[0] = jit_code_buffer start

; ---- Main dispatch loop ----
jit_loop:
    ldrb r0, [r4], #1               ; r0 = next bytecode

    cmp r0, #0xFF                    ; END_OF_SCRIPT?
    beq jit_end

    cmp r0, #0x80
    bhs jit_const
    cmp r0, #0x70
    bhs jit_rstate
    cmp r0, #0x60
    bhs jit_rlocal
    cmp r0, #0x50
    bhs jit_wstate
    cmp r0, #0x40
    bhs jit_wlocal
    cmp r0, #0x30
    bhs jit_op
    cmp r0, #0x20
    bhs jit_fork
    cmp r0, #0x10
    bhs jit_when

    ; Low opcodes via jump table
    adr r1, jit_low_table
    ldr pc, [r1, r0, lsl #2]

jit_low_table:
    .long jit_done      ; 0x00 BC_DONE
    .long jit_else      ; 0x01 BC_ELSE
    .long jit_end_proc  ; 0x02 BC_END
    .long jit_rand      ; 0x03 BC_RAND
    .long jit_draw      ; 0x04 BC_DRAW
    .long jit_tail      ; 0x05 BC_TAIL
    .long jit_plot      ; 0x06 BC_PLOT
    .long jit_proc      ; 0x07 BC_PROC
    .long jit_pop       ; 0x08 BC_POP
    .long jit_div       ; 0x09 BC_DIV
    .long jit_wait      ; 0x0A BC_WAIT
    .long jit_sine      ; 0x0B BC_SINE
    .long jit_seed      ; 0x0C BC_SEED
    .long jit_neg       ; 0x0D BC_NEG
    .long jit_move      ; 0x0E BC_MOVE
    .long jit_mul       ; 0x0F BC_MUL

; ============================================================================
; Helper: load_var
; If push_pending (R11=1): emit STR r0,[r3,#-4]! and clear R11.
; Set R12=1 (load_without_op). Clobbers R1.
; ============================================================================
jit_do_load_var:
    cmp r11, #0
    ldrne r1, ji_STR_R0_R3_M4W
    strne r1, [r3], #4
    mov r11, #0
    mov r12, #1
    mov pc, lr

; ============================================================================
; Helper: pop_var r0
; If push_pending (R11=1): clear R11, r0 already has the value.
; Else: emit LDR r0,[r3],#4.  Clobbers R1.
; ============================================================================
jit_do_pop_r0:
    cmp r11, #0
    movne r11, #0
    movne pc, lr
    ldr r1, ji_LDR_R0_R3_P4
    str r1, [r3], #4
    mov pc, lr

; ============================================================================
; Helper: pop_var r1 — always emit LDR r1,[r3],#4. Clobbers R1.
; ============================================================================
jit_do_pop_r1:
    ldr r1, ji_LDR_R1_R3_P4
    str r1, [r3], #4
    mov pc, lr

; ============================================================================
; Helper: emit BL to target. Input R0 = target addr. Uses R1. Advances R3.
; ============================================================================
jit_do_emit_bl:
    sub r1, r0, r3
    sub r1, r1, #8
    mov r1, r1, asr #2
    bic r1, r1, #0xFF000000
    orr r1, r1, #0xEB000000
    str r1, [r3], #4
    mov pc, lr

; ============================================================================
; Helper: patch a forward branch.
; R0 = address of branch word in JIT buffer (offset field is 0)
; R1 = target address to branch to
; Clobbers R2.
; ============================================================================
jit_patch_branch:
    ldr r2, [r0]                     ; load original branch word (offset=0)
    sub r1, r1, r0
    sub r1, r1, #8
    mov r1, r1, asr #2
    bic r1, r1, #0xFF000000          ; mask offset to 24 bits
    orr r2, r2, r1                   ; insert offset into branch word
    str r2, [r0]
    mov pc, lr

; ============================================================================
; BC_CONST [0x80..0xFF]
; ============================================================================
jit_const:
    str lr, [sp, #-4]!
    bl jit_do_load_var               ; emit push if pending
    and r0, r0, #0x7F                ; const_index = bc & 0x7F
    ; BIG_CONSTANT_BASE == 126: read extra byte
    cmp r0, #126
    blo jit_const_load
    ldrb r1, [r4], #1
    add r0, r0, r1
jit_const_load:
    ; Load constant value from r_Constants
    ldr r2, [r5, r0, lsl #2]         ; r2 = constants[index] (little-endian, correct)
    ; Try to encode r2 as ARM MOV r0, #imm12
    mov r10, r2
    mov r1, #0                       ; rotation counter
jit_const_try:
    cmp r10, #0x100
    blo jit_const_fits
    add r1, r1, #1
    cmp r1, #16
    bhs jit_const_use_ldr
    mov r10, r10, ror #30            ; rotate left 2
    b jit_const_try
jit_const_fits:
    ; Emit: mov r0, #imm12  (0xE3A00000 | (rot<<8) | val)
    orr r10, r10, r1, lsl #8        ; imm12 = (rot<<8) | val
    ldr r1, ji_MOV_R0_IMM_BASE      ; 0xE3A00000
    orr r10, r10, r1
    str r10, [r3], #4
    b jit_const_done
jit_const_use_ldr:
    ; Emit: ldr r0, [r4, #index*4]  (r4 = r_Constants at runtime)
    mov r10, r0, lsl #2              ; offset = index * 4
    ldr r1, ji_LDR_R0_R4_BASE        ; 0xE5940000
    orr r10, r10, r1
    str r10, [r3], #4
jit_const_done:
    mov r11, #1                      ; push_pending = true
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_RLOCAL [0x60..0x6F]  — load local variable
; ============================================================================
jit_rlocal:
    str lr, [sp, #-4]!
    bl jit_do_load_var
    and r10, r0, #0x0F               ; index
    add r10, r10, #1                 ; (index+1)
    mov r10, r10, lsl #2             ; offset = (index+1)*4
    ldr r1, ji_LDR_R0_R5_NEG         ; 0xE5150000  ldr r0, [r5, #-imm12]
    orr r10, r10, r1
    str r10, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_RSTATE [0x70..0x7F]  — load state field
; ============================================================================
jit_rstate:
    str lr, [sp, #-4]!
    bl jit_do_load_var
    and r10, r0, #0x0F               ; field index
    mov r10, r10, lsl #2             ; field*4
    ldr r1, ji_LDR_R0_R5_POS         ; 0xE5950000  ldr r0, [r5, #imm12]
    orr r10, r10, r1
    str r10, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_WLOCAL [0x40..0x4F]  — write local variable
; ============================================================================
jit_wlocal:
    str lr, [sp, #-4]!
    and r10, r0, #0x0F               ; index (saved before pop clobbers r0)
    bl jit_do_pop_r0                 ; pop r0
    add r10, r10, #1
    mov r10, r10, lsl #2             ; offset = (index+1)*4
    ldr r1, ji_STR_R0_R5_NEG         ; 0xE5050000  str r0, [r5, #-imm12]
    orr r10, r10, r1
    str r10, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_WSTATE [0x50..0x5F]  — write state field
; ============================================================================
jit_wstate:
    str lr, [sp, #-4]!
    and r10, r0, #0x0F               ; field
    bl jit_do_pop_r0
    mov r10, r10, lsl #2             ; field*4
    ldr r1, ji_STR_R0_R5_POS         ; 0xE5850000  str r0, [r5, #imm12]
    orr r10, r10, r1
    str r10, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_OP [0x30..0x3F]  — arithmetic/logic operation
; ============================================================================
jit_op:
    str lr, [sp, #-4]!
    and r10, r0, #0x0F               ; op nibble
    mov r12, #0                      ; load_without_op = false

    ; Always pop r0 (TOS) and r1 (NOS) in this order
    bl jit_do_pop_r0
    bl jit_do_pop_r1

    ; Dispatch on op
    cmp r10, #7
    bhi jit_op_non_shift             ; ops 8..13
    ; Shift ops (0..7): emit 3-word sequence
    adr r0, jit_op_insns
    ldr r1, ji_MOV_R1_R1_LSR16
    str r1, [r3], #4
    ldr r1, ji_AND_R1_R1_63
    str r1, [r3], #4
    ; movs r0, r0, <shift_type> r1
    ldr r0, [r0, r10, lsl #2]        ; offset of shift insn in jit_insns
    adr r1, jit_insns
    ldr r1, [r1, r0]                 ; load the shift instruction word
    str r1, [r3], #4
    mov r11, #1                      ; push result
    ldr lr, [sp], #4
    b jit_loop

jit_op_non_shift:
    ; ops 8,9,11,12,13
    adr r0, jit_op_insns
    ldr r0, [r0, r10, lsl #2]        ; offset in jit_insns
    adr r1, jit_insns
    ldr r1, [r1, r0]                 ; instruction word
    str r1, [r3], #4
    ; CMP (op=11) does NOT push result
    cmp r10, #11
    movne r11, #1                    ; push result for non-CMP
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_WHEN [0x10..0x1F]  — conditional branch (skip body if cond false)
; Emits: movs r0,r0 (if load_without_op), then b<cond> with forward offset.
; ============================================================================
jit_when:
    str lr, [sp, #-4]!
    ; Optionally emit movs r0,r0 to refresh flags
    cmp r12, #0
    ldrne r1, ji_MOVS_R0_R0
    strne r1, [r3], #4

    ; Look up negated ARM condition code
    and r10, r0, #0x0F               ; condition nibble
    adr r1, jit_when_conds
    ldrb r10, [r1, r10]              ; ARM condition code (4 bits)
    ; Build branch word: (cond << 28) | 0x0A000000 | 0 (offset=0)
    mov r1, r10, lsl #28
    orr r1, r1, #0x0A000000          ; branch (b<cond> .+0 placeholder)
    str r1, [r3], #4                 ; emit branch word

    ; Push {branch_word_addr, top_byte_of_branch} onto label stack
    sub r0, r3, #4                   ; address of the branch word just emitted
    str r0, [r9], #4                 ; label_stack: patch address
    ; Reconstruct top byte for patching: (cond << 4) | 0x0A = (r10 << 4) | 10
    mov r0, r10, lsl #28             ; cond in top nibble
    orr r0, r0, #0x0A000000
    str r0, [r9], #4                 ; label_stack: top byte (for reconstruction)

    mov r11, #0                      ; push_pending = false (body starts fresh)
    mov r12, #0
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_ELSE [0x01]  — end of when-body, start of else-body
; Patches the pending WHEN branch to current pos, emits unconditional B.
; ============================================================================
jit_else:
    str lr, [sp, #-4]!
    ; Pop label stack: {branch_addr, cond_top}
    sub r9, r9, #8
    ldr r0, [r9]                     ; branch_addr (the WHEN branch)
    ; Patch WHEN branch to point to here (= start of else-body + jump)
    mov r1, r3                       ; current jit_out = after the B we're about to emit
    add r1, r1, #4                   ; account for the B we're about to emit
    bl jit_patch_branch              ; patch(r0, r1)

    ; Emit unconditional B with offset 0 placeholder
    mov r1, #0xEA000000              ; B AL offset=0
    str r1, [r3], #4
    sub r0, r3, #4                   ; address of this B word
    str r0, [r9], #4                 ; push patch addr
    mov r1, #0xEA000000              ; cond top = 0xEA (unconditional B)
    str r1, [r9], #4

    mov r11, #0
    mov r12, #0
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_DONE [0x00]  — end of when/else body; patch pending branch to here
; ============================================================================
jit_done:
    str lr, [sp, #-4]!
    sub r9, r9, #8
    ldr r0, [r9]                     ; branch_addr to patch
    mov r1, r3                       ; target = current jit_out
    bl jit_patch_branch
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_END [0x02]  — end of procedure; emit FreeState inline + return
; ============================================================================
jit_end_proc:
    ; Inline FreeState:
    ldr r1, ji_LDR_R2_R6_M4
    str r1, [r3], #4
    ldr r1, ji_STR_R2_R5_0
    str r1, [r3], #4
    ldr r1, ji_STR_R5_R6_M4
    str r1, [r3], #4
    ldr r1, ji_MOV_PC_LR
    str r1, [r3], #4

    ; Advance proc_no and record new proc start
    add r6, r6, #1                   ; proc_no++
    ; Record proc_N start at current jit_out
    cmp r6, #JIT_MAX_PROCS
    bhs jit_loop                     ; safety: don't overflow table
    str r3, [r7, r6, lsl #2]         ; proc_table[proc_no] = current jit_out

    ; Reset state for new proc
    mov r11, #0
    mov r12, #0
    b jit_loop

; ============================================================================
; BC_PROC [0x07]  — push procedure address onto stack
; Emits: ldr r0,[pc,#0]; b .+8; .long 0 (fixup)
; ============================================================================
jit_proc:
    str lr, [sp, #-4]!
    bl jit_do_load_var               ; emit push if pending
    ; Read proc index from bytecode stream
    ldrb r10, [r4], #1              ; proc_index
    ; Emit: ldr r0, [pc, #0]
    ldr r1, ji_LDR_R0_LIT
    str r1, [r3], #4
    ; Emit: b .+8  (skip the literal)
    ldr r1, ji_B_SKIP1
    str r1, [r3], #4
    ; Emit: .long 0  (placeholder — will be patched with proc addr)
    ; Record fixup: {literal_addr = r3, proc_index = r10}
    str r3, [r8], #4                 ; fixup[n].patch_addr = current r3
    str r10, [r8], #4                ; fixup[n].proc_idx = proc_index
    mov r1, #0
    str r1, [r3], #4                 ; emit literal placeholder
    mov r11, #1                      ; push_pending = true
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_FORK [0x20..0x2F]  — fork a new turtle
; pop_var(0) consumes the proc address in r0 (clear push_pending).
; ============================================================================
jit_fork:
    str lr, [sp, #-4]!
    and r10, r0, #0x0F               ; num_args
    bl jit_do_pop_r0                 ; consume proc addr from r0

    ; Emit: mov r1, #num_args
    ldr r1, ji_MOV_R1_IMM_BASE       ; 0xE3A01000
    orr r1, r1, r10                  ; insert num_args into imm8 field
    str r1, [r3], #4
    ; Emit: str lr, [sp, #-4]!
    ldr r1, ji_STR_LR_SP
    str r1, [r3], #4
    ; Emit: bl ForkState
    ldr r0, jit_addr_ForkState
    bl jit_do_emit_bl
    ; Emit: ldr lr, [sp], #4
    ldr r1, ji_LDR_LR_SP
    str r1, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_MOVE [0x0E]  — move turtle forward
; ============================================================================
jit_move:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    ldr r1, ji_STR_LR_SP
    str r1, [r3], #4
    ldr r0, jit_addr_DoMove
    bl jit_do_emit_bl
    ldr r1, ji_LDR_LR_SP
    str r1, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_DRAW [0x04]  — draw circle at current position (inline)
; ============================================================================
jit_draw:
    str lr, [sp, #-4]!
    bl jit_do_load_var               ; DRAW trashes r0
    ldr r1, ji_ADD_R2_R5_4
    str r1, [r3], #4
    ldr r1, ji_LDMIA_R2_R8_11
    str r1, [r3], #4
    ldr r1, ji_MOV_R0_R8_ASR16
    str r1, [r3], #4
    ldr r1, ji_MOV_R1_R9_ASR16
    str r1, [r3], #4
    ldr r1, ji_MOV_R2_R10_A16
    str r1, [r3], #4
    ldr r1, ji_MOV_R9_R11_L16
    str r1, [r3], #4
    ldr r1, ji_LDR_R10_R6_M12
    str r1, [r3], #4
    ldr r1, ji_STR_LR_SP
    str r1, [r3], #4
    ldr r0, jit_addr_link_circle
    bl jit_do_emit_bl
    ldr r1, ji_LDR_LR_SP
    str r1, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_PLOT [0x06]  — draw square at current position (inline)
; ============================================================================
jit_plot:
    str lr, [sp, #-4]!
    bl jit_do_load_var
    ldr r1, ji_ADD_R2_R5_4
    str r1, [r3], #4
    ldr r1, ji_LDMIA_R2_R8_11
    str r1, [r3], #4
    ldr r1, ji_MOV_R0_R8_ASR16
    str r1, [r3], #4
    ldr r1, ji_MOV_R1_R9_ASR16
    str r1, [r3], #4
    ldr r1, ji_MOV_R2_R10_A16
    str r1, [r3], #4
    ldr r1, ji_MOV_R9_R11_L16
    str r1, [r3], #4
    ldr r1, ji_LDR_R10_R6_M8
    str r1, [r3], #4
    ldr r1, ji_ORR_R10_R10_R2
    str r1, [r3], #4
    ldr r1, ji_STR_LR_SP
    str r1, [r3], #4
    ldr r0, jit_addr_link_circle
    bl jit_do_emit_bl
    ldr r1, ji_LDR_LR_SP
    str r1, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_TAIL [0x05]  — tail call (jump to st_proc)
; ============================================================================
jit_tail:
    ldr r1, ji_LDR_R2_R5_0
    str r1, [r3], #4
    ldr r1, ji_MOV_PC_R2
    str r1, [r3], #4
    b jit_loop

; ============================================================================
; BC_WAIT [0x0A]  — suspend turtle for N frames (inline WaitState)
; ============================================================================
jit_wait:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0                 ; pop wait amount (r0 at runtime)
    mov r12, #0
    ; Emit: ldr r1, [pc, #0]  (load continue_addr)
    ldr r1, ji_LDR_R1_LIT
    str r1, [r3], #4
    ; Emit: b .+8
    ldr r1, ji_B_SKIP1
    str r1, [r3], #4
    ; Emit: .long 0  (continue_addr placeholder — patched below)
    mov r10, r3                      ; save address of this placeholder
    mov r1, #0
    str r1, [r3], #4
    ; Emit rest of inline WaitState (10 words)
    ldr r1, ji_STR_R1_R5_0
    str r1, [r3], #4
    ldr r1, ji_STR_R5_R3_M4W
    str r1, [r3], #4
    ldr r1, ji_LDR_R2_R5_28
    str r1, [r3], #4
    ldr r1, ji_ADD_R2_R2_R0
    str r1, [r3], #4
    ldr r1, ji_STR_R2_R5_28
    str r1, [r3], #4
    ldr r1, ji_BIC_R2_R2_C000
    str r1, [r3], #4
    ldr r1, ji_LDR_R1_R6_R2
    str r1, [r3], #4
    ldr r1, ji_STR_R1_R3_M4W
    str r1, [r3], #4
    ldr r1, ji_STR_R3_R6_R2
    str r1, [r3], #4
    ldr r1, ji_MOV_PC_LR
    str r1, [r3], #4
    ; r3 is now the continue_addr — patch the literal placeholder
    str r3, [r10]
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_NEG [0x0D]  — negate r0
; ============================================================================
jit_neg:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    ldr r1, ji_RSB_R0_0
    str r1, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_POP [0x08]  — discard top of stack
; ============================================================================
jit_pop:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_MUL [0x0F]  — multiply (16.16 × 16.16)
; ============================================================================
jit_mul:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    bl jit_do_pop_r1
    ldr r1, ji_MOV_R0_ASL8
    str r1, [r3], #4
    ldr r1, ji_MOV_R0_ASR16
    str r1, [r3], #4
    ldr r1, ji_MOV_R1_ASL8
    str r1, [r3], #4
    ldr r1, ji_MOV_R1_ASR16
    str r1, [r3], #4
    ldr r1, ji_MUL_R0_R1_R0
    str r1, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_DIV [0x09]  — divide (16.16 / 16.16)
; ============================================================================
jit_div:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    bl jit_do_pop_r1
    ldr r1, ji_MOV_R1_ASL8
    str r1, [r3], #4
    ldr r1, ji_MOV_R1_ASR16
    str r1, [r3], #4
    ldr r1, ji_STR_LR_SP
    str r1, [r3], #4
    ldr r0, jit_addr_divide
    bl jit_do_emit_bl
    ldr r1, ji_LDR_LR_SP
    str r1, [r3], #4
    ldr r1, ji_MOV_R0_ASL8
    str r1, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_SINE [0x0B]  — sine of angle (16.16)
; r0 = angle in 16.16 (full circle = 65536); result = sin(2π·r0) in 16.16
; ============================================================================
jit_sine:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    ldr r1, ji_MOV_R1_0x10000
    str r1, [r3], #4
    ldr r1, ji_SUB_R1_4
    str r1, [r3], #4
    ldr r1, ji_AND_R0_R0_R1
    str r1, [r3], #4
    ldr r1, ji_LDR_R0_R7_R0
    str r1, [r3], #4
    ldr r1, ji_MOV_R0_ASL2
    str r1, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_RAND [0x03]  — next random number (using turtle's RNG state)
; ============================================================================
jit_rand:
    str lr, [sp, #-4]!
    bl jit_do_load_var
    ; Emit: ldr r0, [r5, #ST_RAND*4]  (ST_RAND=5, 5*4=20=0x14)
    ldr r1, ji_LDR_R0_R5_20
    str r1, [r3], #4
    ; Emit: random iteration inline
    bl jit_emit_rand_iter
    ; Emit: str r0, [r5, #ST_RAND*4]
    ldr r1, ji_STR_R0_R5_20
    str r1, [r3], #4
    ; Emit: mov r0, r0, lsr #16
    ldr r1, ji_MOV_R0_LSR16
    str r1, [r3], #4
    mov r11, #1
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; BC_SEED [0x0C]  — seed the RNG
; ============================================================================
jit_seed:
    str lr, [sp, #-4]!
    bl jit_do_pop_r0
    bl jit_emit_rand_iter
    bl jit_emit_rand_iter
    ; Emit: str r0, [r5, #ST_RAND*4]
    ldr r1, ji_STR_R0_R5_20
    str r1, [r3], #4
    ldr lr, [sp], #4
    b jit_loop

; ============================================================================
; Helper: emit one random iteration:
;   bic r1, r0, #0xff000000
;   bic r1, r1, #0x00ff0000
;   mov r2, r0, lsl #16
;   orr r0, r2, r0, lsr #16
;   ldr r2, [pc,#0]; b .+8; .long 0x9D3D   (load constant via literal)
;   mul r1, r2, r1
;   add r0, r0, r1
; ============================================================================
jit_emit_rand_iter:
    str lr, [sp, #-4]!
    ldr r1, ji_BIC_R1_R0_FF24
    str r1, [r3], #4
    ldr r1, ji_BIC_R1_R1_FF16
    str r1, [r3], #4
    ldr r1, ji_MOV_R2_R0_L16
    str r1, [r3], #4
    ldr r1, ji_ORR_R0_R2_R0R16
    str r1, [r3], #4
    ; Emit ldr r2, [pc,#0]; b .+8; .long 0x9D3D
    ldr r1, ji_LDR_R2_PC_LIT         ; ldr r2, [pc, #0] = 0xE59F2000
    str r1, [r3], #4
    ldr r1, ji_B_SKIP1
    str r1, [r3], #4
    ldr r1, ji_CONST_9D3D
    str r1, [r3], #4
    ldr r1, ji_MUL_R1_R2_R1
    str r1, [r3], #4
    ldr r1, ji_ADD_R0_R0_R1
    str r1, [r3], #4
    ldr pc, [sp], #4     ; return to BL caller (jit_rand/jit_seed)

; ============================================================================
; jit_end — END_OF_SCRIPT: apply fixups and return
; ============================================================================
jit_end:
    ; Walk fixup table: for each {patch_addr, proc_idx}, write proc address
    ldr r10, jit_p_fix_tbl           ; r10 = fixup table base
jit_fixup_loop:
    cmp r8, r10                      ; any fixups remaining?
    beq jit_fixup_done
    sub r8, r8, #8
    ldr r0, [r8, #0]                 ; patch_addr (address of .long placeholder)
    ldr r1, [r8, #4]                 ; proc_idx
    ldr r2, [r7, r1, lsl #2]        ; proc_table[proc_idx]
    str r2, [r0]                     ; patch the literal
    b jit_fixup_loop

jit_fixup_done:
    ldmfd sp!, {r4-r12, pc}          ; restore and return

; ============================================================================
; JIT output buffer — proc code is written here starting at r_Instructions
; ============================================================================
; Note: r_Instructions label is placed here in rose.asm (before this .skip).
; The BSS-section JIT working tables are declared in rose.asm.

