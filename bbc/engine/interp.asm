; ============================================================================
; Rose bytecode interpreter for the BBC Master (65C12).
; Phase 2: off-screen core — executes Rose bytecode with exact 16.16
; semantics and logs every DRAW as a 10-byte record (t,x,y,r,c int16 LE)
; for bit-exact comparison against the visualizer's plot list.
;
; Bytecode is the rose2bbc.py transformed encoding:
;   WHEN/ELSE carry 2-byte absolute targets, PROC carries a 2-byte address,
;   DONE is removed. Everything else matches visualizer/bytecode.h.
;
; Build: beebasm -i interp.asm -do rose.ssd
; Run:   *LOAD CODE : CALL &2000 — returns to BASIC when all turtles die.
; ============================================================================

CPU 1                       ; 65C12

; --- Configuration ----------------------------------------------------------
MAXT        = 16            ; max live turtles
FRAMES      = 10000         ; frame cap (matches visualizer)
STATE_SIZE  = 128           ; bytes per turtle state block

; --- Memory map -------------------------------------------------------------
EVSTACK     = &0900         ; evaluation stack (64 x 32-bit)
BHEAD       = &0A00         ; per-bucket FIFO head (turtle idx, &FF = empty)
BTAIL       = &0B00         ; per-bucket FIFO tail
TNEXT       = &0C00         ; per-turtle next link (MAXT entries)
SCRATCH     = &0C80         ; MOVE/mul scratch (see below)
STATES      = &5900         ; MAXT x 128-byte state blocks
LOGCNT      = &7000         ; 16-bit plot count
LOGBUF      = &7002         ; plot records, 10 bytes each
LOGLIMIT    = &7C           ; stop logging when lptr hi reaches this

; State block layout (byte offsets; all fields 32-bit 16.16 except pc):
;   0  pc/proc (2 bytes used; RSTATE/WSTATE 0 uses full 4-byte slot)
;   4  x    8  y    12 size   16 tint   20 rand   24 dir   28 time
;   32 wires (8 x 4)   64 locals (16 x 4)
ST_PC       = 0
ST_X        = 4
ST_SIZE     = 12
ST_TINT     = 16
ST_RAND     = 20
ST_DIR      = 24
ST_TIME     = 28
ST_LOCALS   = 64

; --- Zero page (&70-&8F user area) ------------------------------------------
ip          = &70           ; bytecode instruction pointer
st          = &72           ; current turtle state base
evx         = &74           ; eval stack index (x4)
RA          = &75           ; 32-bit accumulator A (top of stack pops here)
RB          = &79           ; 32-bit accumulator B
opsave      = &7D           ; current opcode
cur         = &7E           ; current turtle index
frame       = &7F           ; 16-bit current frame
tcount      = &81           ; live turtle count
freeh       = &82           ; free-list head
ptr         = &83           ; 16-bit scratch pointer
sgn         = &85           ; scratch: sign flag
zres        = &86           ; scratch: zero-test result
lptr        = &87           ; 16-bit log write pointer
cnt         = &89           ; loop counter (fork args)
tmpidx      = &8A           ; scratch turtle index

; --- Scratch block (abs) -----------------------------------------------------
IDX14       = SCRATCH+0     ; 14-bit sine index
TSIN        = SCRATCH+2     ; sinlook result (s16)
SAV         = SCRATCH+4     ; sin(dir) (s16)
CAV         = SCRATCH+6     ; cos(dir) (s16)
VAL16       = SCRATCH+8     ; move distance operand (s16)
MSAVE       = SCRATCH+10    ; saved move distance (s32)
M1          = SCRATCH+14    ; multiplier (destroyed)
M2          = SCRATCH+16    ; multiplicand (preserved)
XM1         = SCRATCH+18    ; original M1 for sign correction
PR          = SCRATCH+20    ; 32-bit product
HPFLAG      = SCRATCH+24    ; 1 = high-precision move (>>8)

ORG &2000

; ============================================================================
; Entry
; ============================================================================
.entry
    ; buckets all empty
    lda #&FF
    ldx #0
.initb
    sta BHEAD,x
    sta BTAIL,x
    inx
    bne initb
    ; free list: 0 -> 1 -> ... -> MAXT-1 -> &FF
    ldx #0
.initn
    txa
    clc
    adc #1
    sta TNEXT,x
    inx
    cpx #MAXT
    bne initn
    lda #&FF
    sta TNEXT+MAXT-1
    stz freeh
    stz tcount
    stz frame
    stz frame+1
    ; log
    stz LOGCNT
    stz LOGCNT+1
    lda #<LOGBUF
    sta lptr
    lda #>LOGBUF
    sta lptr+1

    ; ---- create turtle 0 running proc 0 (main) ----
    jsr alloc                       ; A = idx (0), ptr = state base
    ldy #0
    lda #0
.zeroloop
    sta (ptr),y
    iny
    bpl zeroloop                    ; zero all 128 bytes
    lda #<rose_p0
    sta (ptr)
    ldy #1
    lda #>rose_p0
    sta (ptr),y
    ldy #ST_SIZE+2                  ; size = 2.0
    lda #2
    sta (ptr),y
    ldy #ST_TINT+2                  ; tint = 1.0
    lda #1
    sta (ptr),y
    ldy #ST_RAND                    ; seed = &BABEFEED
    lda #&ED
    sta (ptr),y
    iny
    lda #&FE
    sta (ptr),y
    iny
    lda #&BE
    sta (ptr),y
    iny
    lda #&BA
    sta (ptr),y
    lda #1
    sta tcount
    lda #0                          ; turtle 0 -> bucket 0
    ldy #0
    jsr append
    ; fall through to scheduler

; ============================================================================
; Scheduler: FIFO bucket per (frame & 255)
; ============================================================================
.sched
    ldy frame                       ; bucket = frame low byte
    lda BHEAD,y
    cmp #&FF
    bne run_turtle
    ; bucket empty -> next frame
    lda tcount
    beq exit
    inc frame
    bne nowrap
    inc frame+1
.nowrap
    lda frame+1                     ; frame == FRAMES -> exit
    cmp #>FRAMES
    bne sched
    lda frame
    cmp #<FRAMES
    bne sched
.exit
    rts

.run_turtle
    sta cur
    tax
    lda TNEXT,x                     ; pop head
    sta BHEAD,y
    cmp #&FF
    bne headok
    sta BTAIL,y
.headok
    ldx cur
    lda stbase_lo,x
    sta st
    lda stbase_hi,x
    sta st+1
    ldy #ST_TIME+2                  ; turtle due this frame?
    lda (st),y
    cmp frame
    bne frame_bad
    iny
    lda (st),y
    cmp frame+1
    beq frame_ok
.frame_bad
    jmp err_frame
.frame_ok
    lda (st)                        ; ip = state pc
    sta ip
    ldy #1
    lda (st),y
    sta ip+1
    stz evx
    ; fall through to dispatcher

; ============================================================================
; Dispatcher
; ============================================================================
.next_op
    jsr fetch
    cmp #&80                        ; &80+ = CONST (fetch's INC trashes N)
    bcc not_const
    jmp op_const
.not_const
    sta opsave
    lsr a
    lsr a
    lsr a
    and #&1E
    tax
    jmp (classtab,x)

.classtab
    EQUW cls0, op_when, op_fork, op_op
    EQUW op_wlocal, op_wstate, op_rlocal, op_rstate

.cls0
    lda opsave
    asl a
    and #&1E
    tax
    jmp (op0tab,x)

.op0tab
    EQUW err_unimpl, op_else, op_end, err_unimpl    ; DONE ELSE END RAND
    EQUW op_draw, op_tail, err_unimpl, op_proc      ; DRAW TAIL PLOT PROC
    EQUW op_pop, err_unimpl, op_wait, err_unimpl    ; POP DIV WAIT SINE
    EQUW err_unimpl, op_neg, op_move, err_unimpl    ; SEED NEG MOVE MUL

.fetch
    lda (ip)
    inc ip
    bne fetchok
    inc ip+1
.fetchok
    rts

; ============================================================================
; Eval stack
; ============================================================================
.push_RA
    ldx evx
    lda RA
    sta EVSTACK,x
    lda RA+1
    sta EVSTACK+1,x
    lda RA+2
    sta EVSTACK+2,x
    lda RA+3
    sta EVSTACK+3,x
    inx
    inx
    inx
    inx
    stx evx
    rts

.pop_RA
    ldx evx
    dex
    dex
    dex
    dex
    stx evx
    lda EVSTACK,x
    sta RA
    lda EVSTACK+1,x
    sta RA+1
    lda EVSTACK+2,x
    sta RA+2
    lda EVSTACK+3,x
    sta RA+3
    rts

.pop_RB
    ldx evx
    dex
    dex
    dex
    dex
    stx evx
    lda EVSTACK,x
    sta RB
    lda EVSTACK+1,x
    sta RB+1
    lda EVSTACK+2,x
    sta RB+2
    lda EVSTACK+3,x
    sta RB+3
    rts

; ============================================================================
; Opcodes
; ============================================================================
.op_const                           ; A = &80 + index (bit 7 set)
    and #&7F
    stz ptr+1
    cmp #126                        ; big-constant escape
    bne const_small
    jsr fetch
    clc
    adc #126
    bcc const_small
    inc ptr+1
.const_small
    sta ptr
    asl ptr                         ; index * 4
    rol ptr+1
    asl ptr
    rol ptr+1
    clc
    lda ptr
    adc #<rose_constants
    sta ptr
    lda ptr+1
    adc #>rose_constants
    sta ptr+1
    lda (ptr)
    sta RA
    ldy #1
    lda (ptr),y
    sta RA+1
    iny
    lda (ptr),y
    sta RA+2
    iny
    lda (ptr),y
    sta RA+3
    jsr push_RA
    jmp next_op

.op_rstate                          ; push state[field]
    lda opsave
    and #15
    asl a
    asl a
    tay
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
    jsr push_RA
    jmp next_op

.op_wstate                          ; pop -> state[field]
    jsr pop_RA
    lda opsave
    and #15
    asl a
    asl a
    tay
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
    jmp next_op

.op_rlocal                          ; push local[i]
    lda opsave
    and #15
    asl a
    asl a
    clc
    adc #ST_LOCALS
    tay
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
    jsr push_RA
    jmp next_op

.op_wlocal                          ; pop -> local[i]
    jsr pop_RA
    lda opsave
    and #15
    asl a
    asl a
    clc
    adc #ST_LOCALS
    tay
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
    jmp next_op

.op_op                              ; RA = top (left), RB = below (right)
    jsr pop_RA
    jsr pop_RB
    lda opsave
    and #15
    cmp #13                         ; OP_ADD
    beq do_add
    cmp #9                          ; OP_SUB
    beq do_sub
    cmp #11                         ; OP_CMP (push difference)
    beq do_sub
    cmp #12                         ; OP_AND
    beq do_and
    cmp #8                          ; OP_OR
    beq do_or
    jmp err_unimpl                  ; shifts/rotates: not yet
.do_add
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
    jsr push_RA
    jmp next_op
.do_sub
    sec
    lda RA
    sbc RB
    sta RA
    lda RA+1
    sbc RB+1
    sta RA+1
    lda RA+2
    sbc RB+2
    sta RA+2
    lda RA+3
    sbc RB+3
    sta RA+3
    jsr push_RA
    jmp next_op
.do_and
    lda RA
    and RB
    sta RA
    lda RA+1
    and RB+1
    sta RA+1
    lda RA+2
    and RB+2
    sta RA+2
    lda RA+3
    and RB+3
    sta RA+3
    jsr push_RA
    jmp next_op
.do_or
    lda RA
    ora RB
    sta RA
    lda RA+1
    ora RB+1
    sta RA+1
    lda RA+2
    ora RB+2
    sta RA+2
    lda RA+3
    ora RB+3
    sta RA+3
    jsr push_RA
    jmp next_op

.op_neg
    jsr pop_RA
    sec
    lda #0
    sbc RA
    sta RA
    lda #0
    sbc RA+1
    sta RA+1
    lda #0
    sbc RA+2
    sta RA+2
    lda #0
    sbc RA+3
    sta RA+3
    jsr push_RA
    jmp next_op

.op_pop
    jsr pop_RA
    jmp next_op

.op_when                            ; pop value, branch by negated condition
    jsr pop_RA
    jsr fetch                       ; target lo
    sta ptr
    jsr fetch                       ; target hi
    sta ptr+1
    lda RA+3
    and #&80
    sta sgn                         ; &80 if negative
    lda RA
    ora RA+1
    ora RA+2
    ora RA+3
    sta zres                        ; 0 if zero
    lda opsave
    and #15
    cmp #6                          ; branch if != 0
    beq w_ne
    cmp #7                          ; branch if == 0
    beq w_eq
    cmp #12                         ; branch if >= 0
    beq w_ge
    cmp #13                         ; branch if < 0
    beq w_lt
    cmp #14                         ; branch if > 0
    beq w_gt
    cmp #15                         ; branch if <= 0
    beq w_le
    jmp err_unimpl
.w_ne
    lda zres
    bne take_branch
    jmp next_op
.w_eq
    lda zres
    beq take_branch
    jmp next_op
.w_ge
    lda sgn
    beq take_branch
    jmp next_op
.w_lt
    lda sgn
    bne take_branch
    jmp next_op
.w_gt
    lda sgn
    bne w_no
    lda zres
    bne take_branch
.w_no
    jmp next_op
.w_le
    lda sgn
    bne take_branch
    lda zres
    beq take_branch
    jmp next_op
.take_branch
    lda ptr
    sta ip
    lda ptr+1
    sta ip+1
    jmp next_op

.op_else                            ; unconditional jump
    jsr fetch
    sta ptr
    jsr fetch
    sta ip+1
    lda ptr
    sta ip
    jmp next_op

.op_proc                            ; push 2-byte proc address as 32-bit
    jsr fetch
    sta RA
    jsr fetch
    sta RA+1
    stz RA+2
    stz RA+3
    jsr push_RA
    jmp next_op

.op_tail                            ; jump to state proc slot
    lda (st)
    sta ip
    ldy #1
    lda (st),y
    sta ip+1
    jmp next_op

.op_draw
    lda lptr+1                      ; log overflow guard
    cmp #LOGLIMIT
    bcs draw_skip
    ldy #ST_TIME+2                  ; t
    lda (st),y
    sta (lptr)
    iny
    lda (st),y
    ldy #1
    sta (lptr),y
    ldy #ST_X+2                     ; x
    lda (st),y
    tax
    iny
    lda (st),y
    ldy #3
    sta (lptr),y
    dey
    txa
    sta (lptr),y
    ldy #ST_X+4+2                   ; y
    lda (st),y
    tax
    iny
    lda (st),y
    ldy #5
    sta (lptr),y
    dey
    txa
    sta (lptr),y
    ldy #ST_SIZE+2                  ; r
    lda (st),y
    tax
    iny
    lda (st),y
    ldy #7
    sta (lptr),y
    dey
    txa
    sta (lptr),y
    ldy #ST_TINT+2                  ; c
    lda (st),y
    tax
    iny
    lda (st),y
    ldy #9
    sta (lptr),y
    dey
    txa
    sta (lptr),y
    clc                             ; lptr += 10
    lda lptr
    adc #10
    sta lptr
    bcc drawcnt
    inc lptr+1
.drawcnt
    inc LOGCNT
    bne draw_skip
    inc LOGCNT+1
.draw_skip
    jmp next_op

.op_wait
    jsr pop_RA                      ; wait amount
    lda RA+3
    bmi wait_done                   ; negative wait: ignored (warning in ref)
    clc                             ; time += wait
    ldy #ST_TIME
    lda (st),y
    adc RA
    sta (st),y
    iny
    lda (st),y
    adc RA+1
    sta (st),y
    iny
    lda (st),y
    adc RA+2
    sta (st),y
    iny
    lda (st),y
    adc RA+3
    sta (st),y
    ldy #ST_TIME+3                  ; new frame >= FRAMES -> turtle dies
    lda (st),y
    cmp #>FRAMES
    bcc wait_sched
    bne wait_free
    ldy #ST_TIME+2
    lda (st),y
    cmp #<FRAMES
    bcc wait_sched
.wait_free
    jsr free_cur
    jmp sched
.wait_sched
    lda ip                          ; save continue address
    sta (st)
    ldy #1
    lda ip+1
    sta (st),y
    ldy #ST_TIME+2                  ; bucket = frame low byte
    lda (st),y
    tay
    lda cur
    jsr append
    jmp sched
.wait_done
    jmp next_op

.op_end
    jsr free_cur
    jmp sched

.op_fork                            ; stack: [args..., proc] (proc on top)
    jsr pop_RA                      ; proc address
    jsr alloc                       ; ptr = child state
    sta tmpidx
    lda RA                          ; child pc = proc
    sta (ptr)
    ldy #1
    lda RA+1
    sta (ptr),y
    ldy #ST_X                       ; copy x..wires (4..63) from parent
.fork_copy
    lda (st),y
    sta (ptr),y
    iny
    cpy #ST_LOCALS
    bne fork_copy
    lda opsave                      ; pop args in reverse into locals
    and #15
    sta cnt
.fork_args
    lda cnt
    beq fork_link
    dec cnt
    jsr pop_RA
    lda cnt                         ; local offset = 64 + k*4
    asl a
    asl a
    clc
    adc #ST_LOCALS
    tay
    lda RA
    sta (ptr),y
    iny
    lda RA+1
    sta (ptr),y
    iny
    lda RA+2
    sta (ptr),y
    iny
    lda RA+3
    sta (ptr),y
    bra fork_args
.fork_link
    ldy #ST_TIME+2                  ; child runs in its (== parent's) frame
    lda (ptr),y
    tay
    lda tmpidx
    jsr append
    inc tcount
    jmp next_op

; ============================================================================
; MOVE — exact replica of interpret.h caseAMoveStatement
; ============================================================================
.op_move
    jsr pop_RA                      ; m
    lda RA
    sta MSAVE
    lda RA+1
    sta MSAVE+1
    lda RA+2
    sta MSAVE+2
    lda RA+3
    sta MSAVE+3

    ; idx14 = (dir >> 10) & &3FFF  (= dir bytes 2:1 as u16 >> 2)
    ldy #ST_DIR+1
    lda (st),y
    sta IDX14
    iny
    lda (st),y
    sta IDX14+1
    lsr IDX14+1
    ror IDX14
    lsr IDX14+1
    ror IDX14
    jsr sinlook                     ; sa = sin(idx14)
    lda TSIN
    sta SAV
    lda TSIN+1
    sta SAV+1
    clc                             ; ca = sin((idx14 + 4096) & 16383)
    lda IDX14+1
    adc #&10
    and #&3F
    sta IDX14+1
    jsr sinlook
    lda TSIN
    sta CAV
    lda TSIN+1
    sta CAV+1

    ; path select: high precision iff -32.0 < m < 32.0
    clc                             ; s = m + &00200000
    lda MSAVE+2
    adc #&20
    sta RA+2
    lda MSAVE+3
    adc #0
    bne move_hd                     ; s byte3 != 0 -> high distance
    lda RA+2
    cmp #&40
    bcs move_hd                     ; s >= &400000 -> high distance
    ora MSAVE+1
    ora MSAVE                       ; s == 0 (m == -32.0 exactly) -> hd
    beq move_hd
    ; high precision: val16 = (m >> 6) & &FFFF, product >> 8
    lda #1
    sta HPFLAG
    lda MSAVE                       ; (bytes 2:1:0 << 2), take top two
    sta PR
    lda MSAVE+1
    sta PR+1
    lda MSAVE+2
    sta PR+2
    bra move_val
.move_hd
    ; high distance: val16 = (m >> 14) & &FFFF, product used as-is
    stz HPFLAG
    lda MSAVE+1
    sta PR
    lda MSAVE+2
    sta PR+1
    lda MSAVE+3
    sta PR+2
.move_val
    asl PR
    rol PR+1
    rol PR+2
    asl PR
    rol PR+1
    rol PR+2
    lda PR+1
    sta VAL16
    lda PR+2
    sta VAL16+1

    ; x += scale(val16 * ca)
    lda VAL16
    sta M1
    lda VAL16+1
    sta M1+1
    lda CAV
    sta M2
    lda CAV+1
    sta M2+1
    jsr smul16
    jsr scale_product               ; RB = product (>>8 if high precision)
    clc
    ldy #ST_X
    lda (st),y
    adc RB
    sta (st),y
    iny
    lda (st),y
    adc RB+1
    sta (st),y
    iny
    lda (st),y
    adc RB+2
    sta (st),y
    iny
    lda (st),y
    adc RB+3
    sta (st),y

    ; y += scale(val16 * sa)
    lda VAL16
    sta M1
    lda VAL16+1
    sta M1+1
    lda SAV
    sta M2
    lda SAV+1
    sta M2+1
    jsr smul16
    jsr scale_product
    clc
    ldy #ST_X+4
    lda (st),y
    adc RB
    sta (st),y
    iny
    lda (st),y
    adc RB+1
    sta (st),y
    iny
    lda (st),y
    adc RB+2
    sta (st),y
    iny
    lda (st),y
    adc RB+3
    sta (st),y
    jmp next_op

; RB = PR >> 8 (arithmetic) if HPFLAG else PR
.scale_product
    lda HPFLAG
    beq scale_raw
    lda PR+1
    sta RB
    lda PR+2
    sta RB+1
    lda PR+3
    sta RB+2
    and #&80
    beq scale_pos
    lda #&FF
    sta RB+3
    rts
.scale_pos
    stz RB+3
    rts
.scale_raw
    lda PR
    sta RB
    lda PR+1
    sta RB+1
    lda PR+2
    sta RB+2
    lda PR+3
    sta RB+3
    rts

; ============================================================================
; sinlook: TSIN = sin_q14(IDX14), signed 16-bit, exact interpret.h sin()
; ============================================================================
.sinlook
    lda IDX14+1
    and #&20                        ; bit 13 = sign
    sta sgn
    lda IDX14+1
    and #&1F                        ; na13 = idx & &1FFF
    sta ptr+1
    lda IDX14
    sta ptr
    ; fold: if na13 > 4096 then na13 = 8192 - na13
    lda ptr+1
    cmp #&10
    bcc sin_nofold
    bne sin_fold
    lda ptr
    beq sin_nofold
.sin_fold
    sec
    lda #0
    sbc ptr
    sta ptr
    lda #&20
    sbc ptr+1
    sta ptr+1
.sin_nofold
    asl ptr                         ; table offset = na13 * 2
    rol ptr+1
    clc
    lda ptr
    adc #<sine_quarter
    sta ptr
    lda ptr+1
    adc #>sine_quarter
    sta ptr+1
    lda (ptr)
    sta TSIN
    ldy #1
    lda (ptr),y
    sta TSIN+1
    lda sgn
    beq sin_pos
    sec                             ; negate
    lda #0
    sbc TSIN
    sta TSIN
    lda #0
    sbc TSIN+1
    sta TSIN+1
.sin_pos
    rts

; ============================================================================
; smul16: PR = M1 * M2, signed 16x16 -> 32. Destroys M1 (saved in XM1).
; ============================================================================
.smul16
    lda M1
    sta XM1
    lda M1+1
    sta XM1+1
    lda #0
    sta PR+2
    sta PR+3
    ldx #16
.mul_loop
    lsr M1+1
    ror M1
    bcc mul_noadd
    clc
    lda PR+2
    adc M2
    sta PR+2
    lda PR+3
    adc M2+1
    sta PR+3
.mul_noadd
    ror PR+3
    ror PR+2
    ror PR+1
    ror PR
    dex
    bne mul_loop
    ; sign corrections
    lda XM1+1
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
    bpl mul_done
    sec
    lda PR+2
    sbc XM1
    sta PR+2
    lda PR+3
    sbc XM1+1
    sta PR+3
.mul_done
    rts

; ============================================================================
; Turtle alloc/free, bucket append
; ============================================================================
.alloc                              ; -> A = idx, ptr = state base
    lda freeh
    cmp #&FF
    beq err_nofree
    tax
    lda TNEXT,x
    sta freeh
    lda stbase_lo,x
    sta ptr
    lda stbase_hi,x
    sta ptr+1
    txa
    rts

.free_cur
    ldx cur
    lda freeh
    sta TNEXT,x
    lda cur
    sta freeh
    dec tcount
    rts

.append                             ; A = idx, Y = bucket
    sta tmpidx
    tax
    lda #&FF
    sta TNEXT,x
    lda BTAIL,y
    cmp #&FF
    bne app_tail
    lda tmpidx                      ; empty bucket
    sta BHEAD,y
    sta BTAIL,y
    rts
.app_tail
    tax
    lda tmpidx
    sta TNEXT,x
    sta BTAIL,y
    rts

; ============================================================================
; Errors (BRK returns to BASIC with visible message)
; ============================================================================
.err_unimpl
    brk
    EQUB &80
    EQUS "UNIMPL OP"
    EQUB 0
.err_nofree
    brk
    EQUB &81
    EQUS "NO FREE TURTLE"
    EQUB 0
.err_frame
    brk
    EQUB &82
    EQUS "FRAME MISMATCH"
    EQUB 0

; ============================================================================
; Tables
; ============================================================================
.stbase_lo
FOR n, 0, MAXT-1
    EQUB <(STATES + n*STATE_SIZE)
NEXT
.stbase_hi
FOR n, 0, MAXT-1
    EQUB >(STATES + n*STATE_SIZE)
NEXT

ALIGN &100
.sine_quarter
INCBIN "sine_quarter.bin"

.rose_data_start
INCLUDE "rose_data.asm"

SAVE "CODE", &2000, rose_data_end
