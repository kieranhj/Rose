
; ============================================================================
; Per-frame tick: wait for vsync, apply due colorscript events (VDU 19)
; ============================================================================
.frame_tick
    lda #&02                        ; clear CA1 (vsync) flag, wait for next
    sta SYSVIA_IFR
.vsync_wait
    lda SYSVIA_IFR
    and #&02
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
