
; ============================================================================
; Per-frame tick: wait for the frame timer, apply due colorscript events.
;
; The tick point is NOT vsync: timer_init phase-locks System VIA T1 to the
; raster so it fires as the beam leaves the last visible scanline. Palette
; writes land in the bottom border (invisible), and drawing starts with the
; whole vertical blank as a head start — records arrive in (y-r) order, so
; the write front races the beam down the screen like the Archimedes.
; T1 free-runs at 19968us = 312 lines = one PAL field, exactly the CRTC
; frame (same crystal), so the phase set once at init holds forever.
; ============================================================================
.frame_tick
    lda #&40                        ; clear T1 flag, wait for the tick point
    sta SYSVIA_IFR
.vsync_wait
    lda SYSVIA_IFR
    and #&40
    beq vsync_wait
.cs_loop
    lda CSPTR
    sta ptr
    lda CSPTR+1
    sta ptr+1
    lda (ptr)                       ; event frame == current frame?
    cmp frame
    bne cs_done
    ldy #1
    lda (ptr),y
    cmp frame+1
    bne cs_done
    ldy #2
    lda (ptr),y
    sta CSVAL
    lsr a                           ; logical colour 0-3
    lsr a
    lsr a
    lsr a
    and #3
    tax
    lda CSVAL                       ; ULA value = index<<4 | (phys EOR 7)
    and #7
    eor #7
    ora ulabase,x
    sta ULACOL                      ; MODE 1: registers base+{0,1,4,5}
    clc
    adc #&10
    sta ULACOL
    adc #&30
    sta ULACOL
    adc #&10
    sta ULACOL
    clc                             ; next event
    lda CSPTR
    adc #3
    sta CSPTR
    bcc cs_loop
    inc CSPTR+1
    bra cs_loop
.cs_done
    rts
.ulabase                            ; MODE 1 ULA index base per logical colour
    EQUB &00, &20, &80, &A0

; ============================================================================
; Phase-lock T1 to the raster. CA1 vsync fires at scanline R7*8; the last
; visible line ends R6*8 lines into the next field, so the first interval is
; (312 - R7*8 + R6*8)*64 us, after which the latches free-run one field.
; (T1 continuous period = latch + 2, hence the -2s.)
; ============================================================================
IF WIDE = 1
TICKFIRST   = (312 - 33*8 + 29*8) * 64 - 2  ; overscan CRTC: R6=29, R7=33
ELIF WIDE = 2
TICKFIRST   = (312 - 30*8 + 23*8) * 64 - 2  ; letterbox: R6=23, R7=30
ELSE
TICKFIRST   = (312 - 34*8 + 32*8) * 64 - 2  ; standard MODE 1: R6=32, R7=34
ENDIF
TICKPERIOD  = 312 * 64 - 2

.timer_init
    lda #&40                        ; T1 continuous, PB7 off, no latching
    sta SYSVIA_ACR
    lda #&02                        ; sync: clear CA1, wait for a real vsync
    sta SYSVIA_IFR
.ti_wait
    lda SYSVIA_IFR
    and #&02
    beq ti_wait
    lda #<TICKFIRST                 ; first fire: end of last visible line
    sta SYSVIA_T1LL
    lda #>TICKFIRST
    sta SYSVIA_T1CH                 ; load + start, clears T1 flag
    lda #<TICKPERIOD                ; then reload one PAL field per lap
    sta SYSVIA_T1LL
    lda #>TICKPERIOD
    sta SYSVIA_T1LH                 ; latch only — no restart
    rts
