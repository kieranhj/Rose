; ============================================================================
; micro.asm — Rose Micro primitive benchmarks (experiment 2, bbc/docs/rose-micro.md)
;
; Measures the 16-bit (10.6) replacements for the interpreter's hot primitives
; against the 32-bit (16.16) originals, on the same machine, with the same
; multiply tables and the same calling style as engine/interp.asm.
;
; Each benchmark is bracketed by a .bs_* label; bench/run.mjs walks the labels
; in order and diffs the cycle counter, so a benchmark's cost is
;   (cycles between its label and the next) - (empty-loop cycles).
; Every loop runs LOOPN iterations.
;
; Build+run: bash bbc/bench/build.sh
; ============================================================================

CPU 1                           ; 65C12

LOOPN_X = 0                     ; inner counter start (0 => 256)
LOOPN_Y = 8                     ; outer
LOOPN   = 256 * LOOPN_Y

; --- zero page (mirrors interp.asm where the code is shared) -----------------
MS1L        = &50               ; quarter-square table pointers
MS1H        = &52
MS2L        = &54
MS2H        = &56
MNBL        = &58
MNBH        = &59
MT1         = &5A
MT2         = &5C

M1          = &60               ; multiply operands
M2          = &62
PR          = &64               ; 32-bit product
RA          = &68               ; 32-bit accumulators (16.16 side)
RB          = &6C

st          = &70               ; -> turtle state block
evx         = &72               ; eval stack index (pre-biased, as in interp)
T0          = &73
T1          = &74
T2          = &75
SA          = &76               ; sine / cosine values
CA          = &78
DX          = &7A               ; position delta
DY          = &7C
ip          = &80               ; bytecode pointer
opsave      = &82               ; current opcode
srcp        = &88               ; state-copy pointers
dstp        = &8A

; --- micro turtle state layout (16-bit fields) -------------------------------
MST_X       = 0
MST_Y       = 2
MST_DIR     = 4
MST_SIZE    = 6
MST_TINT    = 8
MST_SEED    = 10
MST_TIME    = 12
MST_PC      = 14
MST_LOCALS  = 16                ; unified locals + eval stack, 2 bytes/slot

; --- 32-bit state layout (as interp.asm) -------------------------------------
ST_X        = 0
ST_DIR      = 12
ST_LOCALS   = 64

ORG &1900
GUARD &7000

.entry
    sei
    lda #&7F                    ; mask every VIA interrupt source, as the
    sta &FE4E                   ; engine does — no handler can perturb timing
    sta &FE6E
    jsr init
    jsr validate

; ============================================================================
; 1. empty loop (subtracted from everything else)
; ============================================================================
.bs_empty
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_empty
    dex
    bne l_empty
    dey
    bne l_empty

; ============================================================================
; 1b. call scaffold: what the phy/phx/jsr/rts/plx/ply wrapper costs on its own,
;     so the jsr-based benchmarks below can be reported net of it.
; ============================================================================
.bs_scaffold
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_scaffold
    phy
    phx
    lda #MST_LOCALS+8           ; re-arm the eval stack so every iteration
    sta evx                     ; multiplies the same operands (mirrored in
                                ; the scaffold, so it cancels out)
    jsr nullsub
    plx
    ply
    dex
    bne l_scaffold
    dey
    bne l_scaffold

; ============================================================================
; 2. 32-bit add, zero page (the 16.16 workhorse)
; ============================================================================
.bs_add32
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_add32
    clc
    lda RA
    adc RB
    sta RA
    lda RA+1
    adc RB+1
    sta RA+1
    lda RA+2
    adc RB+2
    sta RA+2
    lda RA+3
    adc RB+3
    sta RA+3
    dex
    bne l_add32
    dey
    bne l_add32

; ============================================================================
; 3. 16-bit add, zero page
; ============================================================================
.bs_add16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_add16
    clc
    lda RA
    adc RB
    sta RA
    lda RA+1
    adc RB+1
    sta RA+1
    dex
    bne l_add16
    dey
    bne l_add16

; ============================================================================
; 4. push+pop of one 32-bit stack slot (interp.asm's push_RA/pop_RA shape)
; ============================================================================
.bs_pushpop32
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_pushpop32
    phy
    ldy evx                     ; push
    lda RA
    sta (st),y
    iny
    lda RA+1
    sta (st),y
    iny
    lda RA+2
    sta (st),y
    iny
    lda RA+3
    sta (st),y
    iny
    ldy evx                     ; pop (evx unchanged: net zero)
    lda (st),y
    sta RA
    iny
    lda (st),y
    sta RA+1
    iny
    lda (st),y
    sta RA+2
    iny
    lda (st),y
    sta RA+3
    ply
    dex
    bne l_pushpop32
    dey
    bne l_pushpop32

; ============================================================================
; 5. push+pop of one 16-bit stack slot
; ============================================================================
.bs_pushpop16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_pushpop16
    phy
    ldy evx
    lda RA
    sta (st),y
    iny
    lda RA+1
    sta (st),y
    ldy evx
    lda (st),y
    sta RA
    iny
    lda (st),y
    sta RA+1
    ply
    dex
    bne l_pushpop16
    dey
    bne l_pushpop16

; ============================================================================
; 6. signed 16x16 -> 32 multiply (interp.asm's smul16, verbatim)
; ============================================================================
.bs_smul16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_smul16
    phy
    phx
    jsr smul16
    plx
    ply
    dex
    bne l_smul16
    dey
    bne l_smul16

; ============================================================================
; 7. signed 16x8 -> 24 multiply (what a Q8 sine needs)
; ============================================================================
.bs_smul168
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_smul168
    phy
    phx
    jsr smul168
    plx
    ply
    dex
    bne l_smul168
    dey
    bne l_smul168

; ============================================================================
; 8. micro `move`, Q8 sine, 1024-step table
; ============================================================================
.bs_move16q8
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_move16q8
    phy
    phx
    lda #MST_LOCALS+8           ; re-arm the eval stack so every iteration
    sta evx                     ; multiplies the same operands (mirrored in
                                ; the scaffold, so it cancels out)
    jsr move16q8
    plx
    ply
    dex
    bne l_move16q8
    dey
    bne l_move16q8

; ============================================================================
; 9. micro `move`, Q12 sine, 1024-step table
; ============================================================================
.bs_move16q12
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_move16q12
    phy
    phx
    lda #MST_LOCALS+8           ; re-arm the eval stack so every iteration
    sta evx                     ; multiplies the same operands (mirrored in
                                ; the scaffold, so it cancels out)
    jsr move16q12
    plx
    ply
    dex
    bne l_move16q12
    dey
    bne l_move16q12

; ============================================================================
; 10. the other hot handlers, micro-sized (compare with the engine's measured
;     op_const 116, op_rlocal 106, op_wstate 114, op_op 141)
; ============================================================================
.bs_const16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_const16
    phy
    phx
    lda #MST_LOCALS+8
    sta evx
    jsr op_const16
    plx
    ply
    dex
    bne l_const16
    dey
    bne l_const16

.bs_rlocal16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_rlocal16
    phy
    phx
    lda #MST_LOCALS+8
    sta evx
    jsr op_rlocal16
    plx
    ply
    dex
    bne l_rlocal16
    dey
    bne l_rlocal16

.bs_wstate16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_wstate16
    phy
    phx
    lda #MST_LOCALS+8
    sta evx
    jsr op_wstate16
    plx
    ply
    dex
    bne l_wstate16
    dey
    bne l_wstate16

.bs_op16
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_op16
    phy
    phx
    lda #MST_LOCALS+8
    sta evx
    jsr op_op16
    plx
    ply
    dex
    bne l_op16
    dey
    bne l_op16

; ============================================================================
; 11. fork state copy: 144 bytes (16.16) vs 32 bytes (micro)
; ============================================================================
.bs_copy144
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_copy144
    phy
    phx
    ldy #0
.c144
    lda (srcp),y
    sta (dstp),y
    iny
    cpy #144
    bne c144
    plx
    ply
    dex
    bne l_copy144
    dey
    bne l_copy144

.bs_copy32
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_copy32
    phy
    phx
    ldy #0
.c32
    lda (srcp),y
    sta (dstp),y
    iny
    cpy #32
    bne c32
    plx
    ply
    dex
    bne l_copy32
    dey
    bne l_copy32

.bs_end
    jmp bs_end

; ============================================================================
; Micro move — Q8 sine
;   m (10.6) popped off the stack; dir is a 16-bit 8.8 register in units of
;   1/256 turn; the sine table has 1024 steps, so idx = dir >> 6 and cos is
;   the same X one page along. Products round (add half before the shift) —
;   with Q8 the shift is free, the result is just bytes 1:2.
; ============================================================================
.move16q8
    ldy evx                     ; pop m
    dey
    lda (st),y
    sta M1+1
    dey
    lda (st),y
    sta M1
    sty evx

    ldy #MST_DIR                ; idx10 = dir >> 6, as (dir << 2) >> 8
    lda (st),y
    sta T0
    iny
    lda (st),y
    sta T1
    stz T2
    asl T0
    rol T1
    rol T2
    asl T0
    rol T1
    rol T2

    lda T2                      ; sin page
    clc
    adc #>sin8
    sta ms1+2
    lda T2                      ; cos page = sin page + 1 (mod 4)
    inc a
    and #3
    clc
    adc #>sin8
    sta mc1+2
    ldx T1
.ms1
    lda &FF00,x
    sta SA
.mc1
    lda &FF00,x
    sta CA

    lda CA                      ; x += round(m * cos / 128)
    sta M2
    jsr smul168
    jsr shr7
    clc
    ldy #MST_X
    lda (st),y
    adc DX
    sta (st),y
    iny
    lda (st),y
    adc DX+1
    sta (st),y

    lda SA                      ; y += round(m * sin / 128)
    sta M2
    jsr smul168
    jsr shr7
    clc
    ldy #MST_Y
    lda (st),y
    adc DX
    sta (st),y
    iny
    lda (st),y
    adc DX+1
    sta (st),y
    rts

; ============================================================================
; Micro move — Q12 sine (16-bit table entries, full 16x16 multiply, >>12)
; ============================================================================
.move16q12
    ldy evx
    dey
    lda (st),y
    sta M1+1
    dey
    lda (st),y
    sta M1
    sty evx

    ldy #MST_DIR
    lda (st),y
    sta T0
    iny
    lda (st),y
    sta T1
    stz T2
    asl T0
    rol T1
    rol T2
    asl T0
    rol T1
    rol T2

    lda T2
    clc
    adc #>sin12lo
    sta qs1+2
    adc #4
    sta qs2+2
    lda T2
    inc a
    and #3
    clc
    adc #>sin12lo
    sta qc1+2
    adc #4
    sta qc2+2
    ldx T1
.qs1
    lda &FF00,x
    sta SA
.qs2
    lda &FF00,x
    sta SA+1
.qc1
    lda &FF00,x
    sta CA
.qc2
    lda &FF00,x
    sta CA+1

    lda CA                      ; x += round(m * cos / 4096)
    sta M2
    lda CA+1
    sta M2+1
    jsr smul16
    jsr shr12
    clc
    ldy #MST_X
    lda (st),y
    adc DX
    sta (st),y
    iny
    lda (st),y
    adc DX+1
    sta (st),y

    lda SA                      ; y += round(m * sin / 4096)
    sta M2
    lda SA+1
    sta M2+1
    jsr smul16
    jsr shr12
    clc
    ldy #MST_Y
    lda (st),y
    adc DX
    sta (st),y
    iny
    lda (st),y
    adc DX+1
    sta (st),y
    rts

; DX = round(PR / 128), signed: add half, then >>7 == (<<1 then take bytes 1:2).
.shr7
    clc
    lda PR
    adc #64
    sta PR
    lda PR+1
    adc #0
    sta PR+1
    lda PR+2
    adc #0
    sta PR+2
    asl PR
    rol PR+1
    rol PR+2
    lda PR+1
    sta DX
    lda PR+2
    sta DX+1
    rts

; DX = round(PR / 4096), signed: add half, then take the 32-bit product's
; bytes 1..3 shifted right another 4.
.shr12
    clc
    lda PR
    adc #&00
    lda PR+1
    adc #&08
    sta T0
    lda PR+2
    adc #0
    sta T1
    lda PR+3
    adc #0
    sta T2
    ldx #4
.shr12l
    lda T2
    cmp #&80                    ; arithmetic shift right of the 24-bit value
    ror T2
    ror T1
    ror T0
    dex
    bne shr12l
    lda T0
    sta DX
    lda T1
    sta DX+1
    rts

; ============================================================================
; smul168: PR (24-bit, sign-extended into PR+3) = M1 (s16) * M2 (s8)
; Same quarter-square tables as umul16, two partial products instead of four.
; ============================================================================
; a bare rts, for the scaffold benchmark
.nullsub
    rts

.smul168
    lda M2                      ; point all four tables at b
    sta MS1L
    sta MS1H
    sta MS2L
    sta MS2H
    lda M1
    eor #&FF
    sta MNBL
    lda M1+1
    eor #&FF
    sta MNBH
    ldy M1                      ; P0 = b*al -> PR 0:1
    lda (MS1L),y
    ldy MNBL
    sec
    sbc (MS2L),y
    sta PR
    ldy M1
    lda (MS1H),y
    ldy MNBL
    sbc (MS2H),y
    sta PR+1
    ldy M1+1                    ; P1 = b*ah -> MT1
    lda (MS1L),y
    ldy MNBH
    sec
    sbc (MS2L),y
    sta MT1
    ldy M1+1
    lda (MS1H),y
    ldy MNBH
    sbc (MS2H),y
    sta MT1+1
    clc                         ; PR += MT1 << 8
    lda PR+1
    adc MT1
    sta PR+1
    lda MT1+1
    adc #0
    sta PR+2
    lda M1+1                    ; sign corrections
    bpl s168_b
    sec
    lda PR+2
    sbc M2
    sta PR+2
.s168_b
    lda M2
    bpl s168_done
    sec
    lda PR+1
    sbc M1
    sta PR+1
    lda PR+2
    sbc M1+1
    sta PR+2
.s168_done
    rts

; ============================================================================
; smul16 / umul16 — copied verbatim from engine/interp.asm
; ============================================================================
.smul16
    jsr umul16
    lda M1+1
    bpl mul_m2sign
    sec
    lda PR+2
    sbc M2
    sta PR+2
    lda PR+3
    sbc M2+1
    sta PR+3
.mul_m2sign
    lda M2+1
    bpl mul_sdone
    sec
    lda PR+2
    sbc M1
    sta PR+2
    lda PR+3
    sbc M1+1
    sta PR+3
.mul_sdone
    rts

.umul16
    lda M1
    sta MS1L
    sta MS1H
    sta MS2L
    sta MS2H
    lda M2
    eor #&FF
    sta MNBL
    lda M2+1
    eor #&FF
    sta MNBH
    ldy M2
    lda (MS1L),y
    ldy MNBL
    sec
    sbc (MS2L),y
    sta PR
    ldy M2
    lda (MS1H),y
    ldy MNBL
    sbc (MS2H),y
    sta PR+1
    ldy M2+1
    lda (MS1L),y
    ldy MNBH
    sec
    sbc (MS2L),y
    sta MT1
    ldy M2+1
    lda (MS1H),y
    ldy MNBH
    sbc (MS2H),y
    sta MT1+1
    lda M1+1
    sta MS1L
    sta MS1H
    sta MS2L
    sta MS2H
    ldy M2
    lda (MS1L),y
    ldy MNBL
    sec
    sbc (MS2L),y
    sta MT2
    ldy M2
    lda (MS1H),y
    ldy MNBL
    sbc (MS2H),y
    sta MT2+1
    ldy M2+1
    lda (MS1L),y
    ldy MNBH
    sec
    sbc (MS2L),y
    sta PR+2
    ldy M2+1
    lda (MS1H),y
    ldy MNBH
    sbc (MS2H),y
    sta PR+3
    clc
    lda MT1
    adc MT2
    sta MT1
    lda MT1+1
    adc MT2+1
    sta MT1+1
    lda #0
    adc #0
    sta MT2
    clc
    lda PR+1
    adc MT1
    sta PR+1
    lda PR+2
    adc MT1+1
    sta PR+2
    lda PR+3
    adc MT2
    sta PR+3
    rts

; ============================================================================
; Micro handlers, same shape as interp.asm's but 16-bit wide. Each ends with
; rts where the engine would `jmp next_op` (dispatch is measured separately
; and is unchanged by the numeric model).
; ============================================================================
.op_const16                     ; push constant #(opcode & 7F)
    lda opsave
    and #&7F
    tax
    ldy evx
    lda cst_lo,x
    sta (st),y
    iny
    lda cst_hi,x
    sta (st),y
    iny
    sty evx
    rts

.op_rlocal16                    ; push local[operand]
    lda (ip)
    inc ip
    bne rl_ok
    inc ip+1
.rl_ok
    tay
    lda (st),y
    sta T0
    iny
    lda (st),y
    sta T1
    ldy evx
    lda T0
    sta (st),y
    iny
    lda T1
    sta (st),y
    iny
    sty evx
    rts

.op_wstate16                    ; pop into state field [operand]
    lda (ip)
    inc ip
    bne ws_ok
    inc ip+1
.ws_ok
    sta T2
    ldy evx
    dey
    lda (st),y
    sta T1
    dey
    lda (st),y
    sta T0
    sty evx
    ldy T2
    lda T0
    sta (st),y
    iny
    lda T1
    sta (st),y
    rts

.op_op16                        ; fused binary add, in place on the below-slot
    ldy evx
    dey
    lda (st),y
    sta T1
    dey
    lda (st),y
    sta T0
    sty evx
    dey
    dey
    clc
    lda (st),y
    adc T0
    sta (st),y
    iny
    lda (st),y
    adc T1
    sta (st),y
    rts

; ============================================================================
; validate: 256 moves with a stepping direction, from a known start. run.mjs
; recomputes the same arithmetic in JS and compares — a fast `move` that is
; wrong proves nothing.
; ============================================================================
.validate
    stz state+MST_X
    stz state+MST_X+1
    stz state+MST_Y
    stz state+MST_Y+1
    stz state+MST_DIR
    stz state+MST_DIR+1
    ldx #0
.val_l
    clc
    lda state+MST_DIR
    adc #<397
    sta state+MST_DIR
    lda state+MST_DIR+1
    adc #>397
    sta state+MST_DIR+1
    lda #MST_LOCALS+8           ; m = &0123 on top of the eval stack
    sta evx
    lda #&23
    sta state+MST_LOCALS+8-2
    lda #&01
    sta state+MST_LOCALS+8-1
    phx                         ; move16q8 uses X for the sine index
    jsr move16q8
    plx
    inx
    bne val_l
    rts

; ============================================================================
.init
    lda #>sq1_lo
    sta MS1L+1
    lda #>sq1_hi
    sta MS1H+1
    lda #>sq2_lo
    sta MS2L+1
    lda #>sq2_hi
    sta MS2H+1

    lda #<state                 ; turtle state / stack
    sta st
    lda #>state
    sta st+1
    lda #MST_LOCALS+8           ; a few slots down the eval stack
    sta evx

    lda #<state                 ; fork copy source/destination
    sta srcp
    lda #>state
    sta srcp+1
    lda #<state2
    sta dstp
    lda #>state2
    sta dstp+1

    lda #&23                    ; representative operands: m = 4.55 (10.6),
    sta M1                      ; multiplier a mid-table sine value
    lda #&01
    sta M1+1
    lda #&C1
    sta M2
    lda #&0E
    sta M2+1
    lda #&11                    ; 32-bit accumulators
    sta RA
    sta RA+1
    sta RA+2
    sta RA+3
    lda #&12                    ; bytecode pointer + opcode for the handlers
    sta ip
    lda #>state
    sta ip+1
    lda #&93
    sta opsave
    lda #&37
    sta RB
    sta RB+1
    sta RB+2
    sta RB+3

    ldy #0                      ; a plausible turtle state
    lda #&40                    ; x = 128.0 in 10.6
    sta state+MST_X
    lda #&20
    sta state+MST_X+1
    lda #&00
    sta state+MST_Y
    lda #&18
    sta state+MST_Y+1
    lda #&37                    ; dir = 89.21 units
    sta state+MST_DIR
    lda #&59
    sta state+MST_DIR+1
    lda #&23                    ; m on the eval stack
    sta state+MST_LOCALS+8-2
    lda #&01
    sta state+MST_LOCALS+8-1
    rts

; ============================================================================
ALIGN &100
.sq1_lo
; sq1_lo/sq1_hi double as stand-in constant tables for op_const16
cst_lo = sq1_lo
FOR i, 0, 511
    EQUB <((i*i) DIV 4)
NEXT
.sq1_hi
cst_hi = sq1_hi
FOR i, 0, 511
    EQUB >((i*i) DIV 4)
NEXT
ALIGN &100
.sq2_lo
FOR i, 0, 511
    EQUB <(((i-255)*(i-255)) DIV 4)
NEXT
.sq2_hi
FOR i, 0, 511
    EQUB >(((i-255)*(i-255)) DIV 4)
NEXT

ALIGN &100
.sin8                           ; 1024-step sine, Q8 signed bytes
INCBIN "sin8.bin"
ALIGN &100
.sin12lo                        ; 1024-step sine, Q12, lo bytes then hi bytes
INCBIN "sin12lo.bin"
.sin12hi
INCBIN "sin12hi.bin"

ALIGN &100
.state
    SKIP 160
.state2
    SKIP 160
.prog_end

PRINT "SYM state", ~state
PRINT "SYM entry", ~entry
PRINT "SYM bs_empty", ~bs_empty
PRINT "SYM bs_scaffold", ~bs_scaffold
PRINT "SYM bs_add32", ~bs_add32
PRINT "SYM bs_add16", ~bs_add16
PRINT "SYM bs_pushpop32", ~bs_pushpop32
PRINT "SYM bs_pushpop16", ~bs_pushpop16
PRINT "SYM bs_smul16", ~bs_smul16
PRINT "SYM bs_smul168", ~bs_smul168
PRINT "SYM bs_move16q8", ~bs_move16q8
PRINT "SYM bs_move16q12", ~bs_move16q12
PRINT "SYM bs_const16", ~bs_const16
PRINT "SYM bs_rlocal16", ~bs_rlocal16
PRINT "SYM bs_wstate16", ~bs_wstate16
PRINT "SYM bs_op16", ~bs_op16
PRINT "SYM bs_copy144", ~bs_copy144
PRINT "SYM bs_copy32", ~bs_copy32
PRINT "SYM bs_end", ~bs_end
PRINT "SYM prog_end", ~prog_end

SAVE "BENCH", entry, prog_end, entry
PUTTEXT "boot.txt", "!BOOT", 0
