; ============================================================================
; paint.asm — precompiled brush painter benchmark (experiment 3, R6).
;
; Compares generated straight-line blob painters against the engine's generic
; render_blob (measured separately by bbc/tools/rendercost.mjs on real demos).
; The painters themselves come from genpaint.py; this file is the harness:
; a fake MODE 1 framebuffer, the shared per-line address walk, and the blob
; setup a caller would do.
;
; Build+run: bash bbc/bench/paintbuild.sh
; ============================================================================

CPU 1

LOOPN_X = 0
LOOPN_Y = 8

dst         = &70               ; -> current line's centre byte, minus YBIAS
TM          = &72               ; scanlines left in this character row
FILL        = &73               ; 4-pixel fill byte for the current tint
MF0         = &74               ; FILL masked by each of the 10 in-byte runs
MF1         = &75
MF2         = &76
MF3         = &77
MF4         = &78
MF5         = &79
MF6         = &7A
MF7         = &7B
MF8         = &7C
MF9         = &7D

RX          = &7E               ; blob centre x (16-bit), top line y
RY          = &80
TMP         = &82

YBIAS       = 128
ROWB        = 640               ; MODE 1 bytes per character row

ORG &1900
GUARD &7000

.entry
    sei
    lda #&7F
    sta &FE4E
    sta &FE6E
    jsr init
    jsr clear_buffer            ; validation blob: one painter call into a
    jsr setup_blob              ; cleared buffer, compared by run.mjs
    jsr paint_validate

.bs_empty
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_empty
    dex
    bne l_empty
    dey
    bne l_empty

.bs_scaffold
    ldx #LOOPN_X
    ldy #LOOPN_Y
.l_scaffold
    phy
    phx
    jsr nullsub
    plx
    ply
    dex
    bne l_scaffold
    dey
    bne l_scaffold

INCLUDE "paint.inc.asm"

; ============================================================================
; nextline — the only per-line work a precompiled painter cannot bake: MODE 1
; puts consecutive scanlines +1 apart inside a character row and +ROWB-7 at
; the row boundary, and a blob's phase in the row is a runtime property.
; ============================================================================
.nextline
    dec TM
    beq nl_cross
    inc dst
    bne nl_done
    inc dst+1
.nl_done
    rts
.nl_cross
    lda #8
    sta TM
    clc
    lda dst
    adc #LO(ROWB-7)
    sta dst
    lda dst+1
    adc #HI(ROWB-7)
    sta dst+1
    rts

; ============================================================================
; setup_blob — what the caller does per blob: point dst at the top line's
; centre byte (biased), set the character-row phase, and expand the tint.
; The MF table only changes when the tint does, so it is NOT per blob; it is
; built once in init (the cost of rebuilding it is measured by bs_scaffold
; being free of it, and noted in the report).
; ============================================================================
.setup_blob                     ; what a caller must do per blob: MODE 1 screen
    lda RY                      ; address of the top line's centre byte, and
    and #7                      ; the blob's phase within the character row
    sta TMP
    lda #8
    sec
    sbc TMP
    sta TM
    lda RY
    lsr a
    lsr a
    lsr a
    tax
    clc
    lda rowlo,x                 ; row base (already biased by -YBIAS)
    adc TMP
    sta dst
    lda rowhi,x
    adc #0
    sta dst+1
    lda RX+1                    ; byte column = x >> 2
    lsr a
    lda RX
    ror a
    lsr a
    tax
    clc
    lda dst
    adc col8lo,x                ; + 8 * column
    sta dst
    lda dst+1
    adc col8hi,x
    sta dst+1
    rts

.nullsub
    rts

.clear_buffer
    lda #0
    tay
.cb1
    sta buffer,y
    sta buffer+256,y
    sta buffer+512,y
    sta buffer+768,y
    sta buffer+1024,y
    sta buffer+1280,y
    sta buffer+1536,y
    sta buffer+1792,y
    sta buffer+2048,y
    sta buffer+2304,y
    sta buffer+2560,y
    sta buffer+2816,y
    sta buffer+3072,y
    sta buffer+3328,y
    sta buffer+3584,y
    sta buffer+3840,y
    iny
    bne cb1
    rts

.init
    lda #LO(VX)                 ; a representative blob position
    sta RX
    lda #HI(VX)
    sta RX+1
    lda #VY
    sta RY
    lda #&55                    ; tint 1 in MODE 1: bit 0 of each pixel
    sta FILL
    ldx #0
.init_mf
    lda FILL
    and mftab,x
    sta MF0,x
    inx
    cpx #10
    bne init_mf
    rts

.rowlo                          ; MODE 1 character-row bases, biased by -YBIAS
FOR i, 0, 31
    EQUB LO(buffer + i*ROWB - YBIAS)
NEXT
.rowhi
FOR i, 0, 31
    EQUB HI(buffer + i*ROWB - YBIAS)
NEXT
.col8lo                         ; 8 * byte column
FOR i, 0, 79
    EQUB LO(i*8)
NEXT
.col8hi
FOR i, 0, 79
    EQUB HI(i*8)
NEXT

.mftab                          ; the 10 contiguous in-byte pixel runs, in the
    EQUB &88, &CC, &EE, &FF     ; order genpaint.py indexes them
    EQUB &44, &66, &77
    EQUB &22, &33
    EQUB &11

ALIGN &100
.buffer
    SKIP BUFN
.prog_end

PRINT "SYM entry", ~entry
PRINT "SYM bs_empty", ~bs_empty
PRINT "SYM bs_scaffold", ~bs_scaffold
PRINT "SYM buffer", ~buffer
PRINT "SYM prog_end", ~prog_end

SAVE "BENCH", entry, prog_end, entry
PUTTEXT "boot.txt", "!BOOT", 0
