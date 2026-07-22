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
MAXT        = 32            ; max live turtles
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
LOGCHK      = &7002         ; 32-bit order-independent checksum
LOGBUF      = &7008         ; plot record prefix, 10 bytes each
LOGLIMIT    = &7C           ; stop logging when lptr hi reaches this

; State block layout (byte offsets; all fields 32-bit 16.16 except pc):
;   0  pc/proc (bytes 0,1) + saved stack height in bytes (byte 2)
;   4  x    8  y    12 size   16 tint   20 rand   24 dir   28 time
;   32 wires (8 x 4)
;   64 unified stack (16 x 4): locals are the bottom slots, expression
;      temporaries above them — one stack, persists across WAIT (as on ARM,
;      where r3 points into the state block).
ST_PC       = 0
ST_X        = 4
ST_SIZE     = 12
ST_TINT     = 16
ST_RAND     = 20
ST_DIR      = 24
ST_TIME     = 28
ST_LOCALS   = 64            ; base of the unified per-turtle stack
ST_HEIGHT   = 2             ; saved stack height byte (inside pc slot)

; --- Zero page (&70-&8F user area) ------------------------------------------
ip          = &70           ; bytecode instruction pointer
st          = &72           ; current turtle state base
evx         = &74           ; turtle stack height in bytes (0..60)
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
defh        = &8B           ; deferred list head (wait >= 256 frames)
deft        = &8C           ; deferred list tail
scr         = &8D           ; screen write pointer (renderer)

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
REC         = SCRATCH+26    ; 10-byte plot record being built
RH          = SCRATCH+36    ; 32-bit per-record hash
DVS         = SCRATCH+40    ; divisor (u16) + remainder (3 bytes at +2)
QSIGN       = SCRATCH+45    ; division result sign
; renderer scratch
RCX         = SCRATCH+48    ; blob centre x (cropped to screen), s16
RCY         = SCRATCH+50    ; blob centre y, s16
RRAD        = SCRATCH+52    ; radius (clamped to MAXRADIUS)
RFILL       = SCRATCH+53    ; 4-pixel fill byte for the tint
RY          = SCRATCH+54    ; current scanline, s16
RX0         = SCRATCH+56    ; span left, s16 (reused as *8 temp)
RX1         = SCRATCH+58    ; span right, s16
RCNT        = SCRATCH+60    ; scanlines remaining
RHW         = SCRATCH+61    ; current half-width
SQF         = SCRATCH+62    ; 1 = square (PLOT)
C0          = SCRATCH+63    ; left byte column (0-79)
C1          = SCRATCH+64    ; right byte column, then span byte count
ML          = SCRATCH+65    ; left/combined edge mask
MR          = SCRATCH+66    ; right edge mask
TMPB        = SCRATCH+67    ; masked-write temp

OSWRCH      = &FFEE
ACCCON      = &FE34         ; Master: bit 2 (X) maps &3000-&7FFF to LYNNE
SCREEN      = &3000
DONEFLAG    = &7006         ; set to &FF when the run completes

ORG &1000

; ============================================================================
; Entry
; ============================================================================
.entry
    lda #22                         ; MODE 129 (shadow MODE 1)
    jsr OSWRCH
    lda #129
    jsr OSWRCH
    ldx #0                          ; cursor off
.vduloop
    lda vdutab,x
    jsr OSWRCH
    inx
    cpx #10
    bne vduloop
    stz DONEFLAG
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
    stz LOGCHK
    stz LOGCHK+1
    stz LOGCHK+2
    stz LOGCHK+3
    lda #<LOGBUF
    sta lptr
    lda #>LOGBUF
    sta lptr+1
    lda #&FF
    sta defh
    sta deft

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
    lda defh                        ; re-attach deferred (future-lap) turtles
    cmp #&FF
    beq bucket_done
    sta BHEAD,y
    lda deft
    sta BTAIL,y
    lda #&FF
    sta defh
    sta deft
.bucket_done
    ; next frame
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
    lda #&FF                        ; signal completion, keep screen up
    sta DONEFLAG
.spin
    jmp spin

.vdutab
    EQUB 23,1,0,0,0,0,0,0,0,0

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
    bne frame_defer
    iny
    lda (st),y
    cmp frame+1
    beq frame_ok
.frame_defer                        ; due on a later lap of this bucket
    ldx cur
    lda #&FF
    sta TNEXT,x
    lda defh
    cmp #&FF
    bne defer_tail
    lda cur                         ; deferred list empty
    sta defh
    sta deft
    jmp sched
.defer_tail
    ldx deft
    lda cur
    sta TNEXT,x
    sta deft
    jmp sched
.frame_ok
    lda (st)                        ; ip = state pc
    sta ip
    ldy #1
    lda (st),y
    sta ip+1
    ldy #ST_HEIGHT                  ; restore stack height
    lda (st),y
    sta evx
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
    EQUW err_unimpl, op_else, op_end, op_rand       ; DONE ELSE END RAND
    EQUW op_draw, op_tail, op_plot, op_proc         ; DRAW TAIL PLOT PROC
    EQUW op_pop, op_div, op_wait, op_sine           ; POP DIV WAIT SINE
    EQUW op_seed, op_neg, op_move, op_mul           ; SEED NEG MOVE MUL

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
.push_RA                            ; turtle stack lives in the state block
    lda evx
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
    lda evx
    adc #4                          ; carry clear (64+60+3 < 256)
    sta evx
    rts

.pop_RA
    lda evx
    sec
    sbc #4
    sta evx
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
    rts

.pop_RB
    lda evx
    sec
    sbc #4
    sta evx
    clc
    adc #ST_LOCALS
    tay
    lda (st),y
    sta RB
    iny
    lda (st),y
    sta RB+1
    iny
    lda (st),y
    sta RB+2
    iny
    lda (st),y
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
    beq rstate_proc
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
.rstate_proc                        ; field 0: pc only (byte 2 = height)
    lda (st)
    sta RA
    ldy #1
    lda (st),y
    sta RA+1
    stz RA+2
    stz RA+3
    jsr push_RA
    jmp next_op

.op_wstate                          ; pop -> state[field]
    jsr pop_RA
    lda opsave
    and #15
    beq wstate_proc
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
.wstate_proc                        ; field 0: don't clobber height byte
    lda RA
    sta (st)
    ldy #1
    lda RA+1
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
    jsr neg32RA
    jsr push_RA
    jmp next_op

.neg32RA
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
    rts

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

.op_plot                            ; square: c = ~tint
    jsr build_rec
    lda REC+8
    eor #&FF
    sta REC+8
    lda REC+9
    eor #&FF
    sta REC+9
    bra emit_rec
.op_draw                            ; circle: c = tint
    jsr build_rec
.emit_rec
    ; per-record hash: h = rol32(h,1) ^ byte, over the 10 bytes
    stz RH
    stz RH+1
    stz RH+2
    stz RH+3
    ldx #0
.hash_loop
    asl RH
    rol RH+1
    rol RH+2
    rol RH+3
    lda RH
    adc #0                          ; carry (old bit 31) into bit 0
    eor REC,x
    sta RH
    inx
    cpx #10
    bne hash_loop
    clc                             ; checksum += hash (order-independent)
    lda LOGCHK
    adc RH
    sta LOGCHK
    lda LOGCHK+1
    adc RH+1
    sta LOGCHK+1
    lda LOGCHK+2
    adc RH+2
    sta LOGCHK+2
    lda LOGCHK+3
    adc RH+3
    sta LOGCHK+3
    inc LOGCNT
    bne rec_log
    inc LOGCNT+1
.rec_log
    lda lptr+1                      ; prefix log until full
    cmp #LOGLIMIT
    bcs rec_done
    ldy #9
.rec_copy
    lda REC,y
    sta (lptr),y
    dey
    bpl rec_copy
    clc
    lda lptr
    adc #10
    sta lptr
    bcc rec_done
    inc lptr+1
.rec_done
    sei                             ; page in shadow screen and draw
    lda ACCCON
    ora #4
    sta ACCCON
    jsr render_blob
    lda ACCCON
    and #&FB
    sta ACCCON
    cli
    jmp next_op

.build_rec                          ; REC = t,x,y,r,c (int16 LE each)
    ldy #ST_TIME+2
    lda (st),y
    sta REC
    iny
    lda (st),y
    sta REC+1
    ldy #ST_X+2
    lda (st),y
    sta REC+2
    iny
    lda (st),y
    sta REC+3
    ldy #ST_X+4+2
    lda (st),y
    sta REC+4
    iny
    lda (st),y
    sta REC+5
    ldy #ST_SIZE+2
    lda (st),y
    sta REC+6
    iny
    lda (st),y
    sta REC+7
    ldy #ST_TINT+2
    lda (st),y
    sta REC+8
    iny
    lda (st),y
    sta REC+9
    rts

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
    lda ip                          ; save continue address + stack height
    sta (st)
    ldy #1
    lda ip+1
    sta (st),y
    ldy #ST_HEIGHT
    lda evx
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
    lda opsave                      ; child stack height = nargs * 4
    and #15
    asl a
    asl a
    ldy #ST_HEIGHT
    sta (ptr),y
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
    jsr umul16
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
    bpl mul_sdone
    sec
    lda PR+2
    sbc XM1
    sta PR+2
    lda PR+3
    sbc XM1+1
    sta PR+3
.mul_sdone
    rts

.umul16                             ; PR = M1 * M2 unsigned (destroys M1)
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
    rts

; ============================================================================
; MUL / DIV / RAND / SEED / SINE
; ============================================================================
.op_mul                             ; (a<<8>>16) * (b<<8>>16), 16.16 result
    jsr pop_RA
    jsr pop_RB
    lda RA+1
    sta M1
    lda RA+2
    sta M1+1
    lda RB+1
    sta M2
    lda RB+2
    sta M2+1
    jsr smul16
    lda PR
    sta RA
    lda PR+1
    sta RA+1
    lda PR+2
    sta RA+2
    lda PR+3
    sta RA+3
    jsr push_RA
    jmp next_op

.op_div                             ; a / (b<<8>>16), result << 8
    jsr pop_RA                      ; dividend (left, top of stack)
    jsr pop_RB
    lda RB+1                        ; divisor = b<<8>>16
    sta DVS
    lda RB+2
    sta DVS+1
    lda RA+3                        ; quotient sign
    eor DVS+1
    and #&80
    sta QSIGN
    lda RA+3                        ; |dividend|
    bpl div_absd
    jsr neg32RA
.div_absd
    lda DVS+1                       ; |divisor|
    bpl div_go
    sec
    lda #0
    sbc DVS
    sta DVS
    lda #0
    sbc DVS+1
    sta DVS+1
.div_go
    stz DVS+2                       ; remainder = 0 (17 bits used)
    stz DVS+3
    stz DVS+4
    ldx #32
.div_loop
    asl RA
    rol RA+1
    rol RA+2
    rol RA+3
    rol DVS+2
    rol DVS+3
    rol DVS+4
    lda DVS+4                       ; rem >= divisor?
    bne div_sub
    lda DVS+3
    cmp DVS+1
    bcc div_next
    bne div_sub
    lda DVS+2
    cmp DVS
    bcc div_next
.div_sub
    sec
    lda DVS+2
    sbc DVS
    sta DVS+2
    lda DVS+3
    sbc DVS+1
    sta DVS+3
    lda DVS+4
    sbc #0
    sta DVS+4
    inc RA                          ; quotient bit (bit 0 is clear)
.div_next
    dex
    bne div_loop
    lda QSIGN
    beq div_shift
    jsr neg32RA
.div_shift                          ; result = quotient << 8
    lda RA+2
    sta RA+3
    lda RA+1
    sta RA+2
    lda RA
    sta RA+1
    stz RA
    jsr push_RA
    jmp next_op

.op_rand                            ; iterate seed, push (seed>>16)&FFFF raw
    ldy #ST_RAND
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
    jsr rand_iter
    ldy #ST_RAND
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
    lda RA+2
    sta RA
    lda RA+3
    sta RA+1
    stz RA+2
    stz RA+3
    jsr push_RA
    jmp next_op

.op_seed                            ; seed = iter(iter(v))
    jsr pop_RA
    jsr rand_iter
    jsr rand_iter
    ldy #ST_RAND
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

.rand_iter                          ; RA = (RA&FFFF)*&9D3D + wordswap(RA)
    lda RA
    sta M1
    lda RA+1
    sta M1+1
    lda #&3D
    sta M2
    lda #&9D
    sta M2+1
    jsr umul16
    lda RA+2                        ; RB = wordswap(RA)
    sta RB
    lda RA+3
    sta RB+1
    lda RA
    sta RB+2
    lda RA+1
    sta RB+3
    clc                             ; RA = PR + RB
    lda PR
    adc RB
    sta RA
    lda PR+1
    adc RB+1
    sta RA+1
    lda PR+2
    adc RB+2
    sta RA+2
    lda PR+3
    adc RB+3
    sta RA+3
    rts

.op_sine                            ; sin((x&FFFF)>>2) << 2
    jsr pop_RA
    lda RA
    sta IDX14
    lda RA+1
    sta IDX14+1
    lsr IDX14+1
    ror IDX14
    lsr IDX14+1
    ror IDX14
    jsr sinlook
    lda TSIN
    sta RA
    lda TSIN+1
    sta RA+1
    and #&80                        ; sign extend to 32 bits
    beq sine_pos
    lda #&FF
    bne sine_ext
.sine_pos
    lda #0
.sine_ext
    sta RA+2
    sta RA+3
    asl RA                          ; << 2
    rol RA+1
    rol RA+2
    rol RA+3
    asl RA
    rol RA+1
    rol RA+2
    rol RA+3
    jsr push_RA
    jmp next_op

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

; ============================================================================
; MODE 1 renderer. Runs with the shadow screen paged in (ACCCON X set), so
; everything it touches — code, tables, REC, scratch — must live below &3000.
; Coordinates: form 352x280 cropped to 320x256 (offset -16,-12).
; ============================================================================
.render_blob
    lda REC+7                       ; negative radius: ignore
    bpl rb_go
    rts
.rb_go
    bne rb_clamp                    ; >255: clamp
    lda REC+6
    cmp #MAXRADIUS+1
    bcc rb_rok
.rb_clamp
    lda #MAXRADIUS
.rb_rok
    sta RRAD
    stz SQF
    lda REC+9                       ; c < 0 -> square, tint = ~c
    bpl rb_circle
    lda #1
    sta SQF
    lda REC+8
    eor #&FF
    bra rb_col
.rb_circle
    lda REC+8
.rb_col
    and #3
    tax
    lda ctab,x
    sta RFILL
    ldx RRAD                        ; half-width row for this radius
    lda circ_lo,x
    sta ptr
    lda circ_hi,x
    sta ptr+1
    sec                             ; cx = x - 16
    lda REC+2
    sbc #16
    sta RCX
    lda REC+3
    sbc #0
    sta RCX+1
    sec                             ; cy = y - 12
    lda REC+4
    sbc #12
    sta RCY
    lda REC+5
    sbc #0
    sta RCY+1
    sec                             ; first scanline = cy - r
    lda RCY
    sbc RRAD
    sta RY
    lda RCY+1
    sbc #0
    sta RY+1
    lda RRAD                        ; 2r+1 scanlines
    asl a
    adc #1                          ; carry clear (r <= 70)
    sta RCNT
.rb_line
    lda SQF
    bne rb_hwsq
    lda (ptr)
    bra rb_hw
.rb_hwsq
    lda RRAD
.rb_hw
    sta RHW
    lda RY+1                        ; line on screen? (0 <= y < 256)
    bne rb_next
    sec                             ; x0 = cx - hw
    lda RCX
    sbc RHW
    sta RX0
    lda RCX+1
    sbc #0
    sta RX0+1
    clc                             ; x1 = cx + hw
    lda RCX
    adc RHW
    sta RX1
    lda RCX+1
    adc #0
    sta RX1+1
    bmi rb_next                     ; x1 < 0: fully off left
    lda RX0+1                       ; x0 clip
    bmi rb_x0neg
    beq rb_x0ok
    cmp #1
    bne rb_next                     ; x0 >= 512: off right
    lda RX0
    cmp #&40
    bcs rb_next                     ; x0 >= 320: off right
    bra rb_x0ok
.rb_x0neg
    stz RX0
    stz RX0+1
.rb_x0ok
    lda RX1+1                       ; x1 clamp to 319
    beq rb_x1ok
    cmp #1
    bne rb_x1clamp
    lda RX1
    cmp #&40
    bcc rb_x1ok
.rb_x1clamp
    lda #&3F
    sta RX1
    lda #1
    sta RX1+1
.rb_x1ok
    jsr fill_span
.rb_next
    lda SQF
    bne rb_noadv
    inc ptr
    bne rb_noadv
    inc ptr+1
.rb_noadv
    inc RY
    bne rb_ynext
    inc RY+1
.rb_ynext
    dec RCNT
    beq rb_done
    jmp rb_line
.rb_done
    rts

; fill scanline RY, pixels RX0..RX1 (both on-screen), colour byte RFILL
.fill_span
    ldx RY
    lda row_lo,x
    sta scr
    lda row_hi,x
    sta scr+1
    lda RX0                         ; C0 = x0 >> 2 (0-79)
    lsr a
    lsr a
    sta C0
    lda RX0+1
    beq fs_c0ok
    lda C0
    ora #64
    sta C0
.fs_c0ok
    lda RX1                         ; C1 = x1 >> 2
    lsr a
    lsr a
    sta C1
    lda RX1+1
    beq fs_c1ok
    lda C1
    ora #64
    sta C1
.fs_c1ok
    lda RX0                         ; edge masks
    and #3
    tax
    lda maskL,x
    sta ML
    lda RX1
    and #3
    tax
    lda maskR,x
    sta MR
    lda C0                          ; scr += C0 * 8
    sta RX0
    stz RX0+1
    asl RX0
    rol RX0+1
    asl RX0
    rol RX0+1
    asl RX0
    rol RX0+1
    clc
    lda scr
    adc RX0
    sta scr
    lda scr+1
    adc RX0+1
    sta scr+1
    lda C1                          ; C1 = byte count - 1
    sec
    sbc C0
    sta C1
    bne fs_multi
    lda ML                          ; single byte: combined mask
    and MR
    sta ML
    jmp fs_masked
.fs_multi
    jsr fs_masked                   ; left edge
    jsr fs_adv
    dec C1
    beq fs_last
.fs_mid
    lda RFILL                       ; solid middle bytes
    sta (scr)
    jsr fs_adv
    dec C1
    bne fs_mid
.fs_last
    lda MR
    sta ML
    ; fall through
.fs_masked                          ; new = old ^ ((old ^ fill) & mask)
    lda (scr)
    sta TMPB
    eor RFILL
    and ML
    eor TMPB
    sta (scr)
    rts
.fs_adv
    clc
    lda scr
    adc #8
    sta scr
    bcc fs_advok
    inc scr+1
.fs_advok
    rts

; ============================================================================
; Renderer tables (must stay below &3000)
; ============================================================================
.ctab                               ; 4 pixels of colour c (MODE 1)
    EQUB &00, &0F, &F0, &FF
.maskL                              ; pixels >= x&3 within byte
    EQUB &FF, &77, &33, &11
.maskR                              ; pixels <= x&3 within byte
    EQUB &88, &CC, &EE, &FF
.row_lo
FOR y, 0, 255
    EQUB <(SCREEN + (y DIV 8)*640 + (y MOD 8))
NEXT
.row_hi
FOR y, 0, 255
    EQUB >(SCREEN + (y DIV 8)*640 + (y MOD 8))
NEXT
INCLUDE "circle_tables.asm"

ASSERT P% <= &3000                  ; render path must not cross into shadow

ALIGN &100
.sine_quarter
INCBIN "sine_quarter.bin"

.rose_data_start
INCLUDE "rose_data.asm"

SAVE "CODE", &1000, rose_data_end
