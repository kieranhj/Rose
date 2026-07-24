; ============================================================================
; Rose for the BBC Master Turbo — Tube build top (beebasm -D TUBE=1).
;
; Assembles two programs onto one autoboot disc:
;   PARA — the interpreter core (interp.asm with TUBE=1), *RUN on the
;          4MHz 65C102 parasite at &0E00. Pushes 6-byte wire records
;          into Tube R1 (24-byte FIFO parasite->host).
;   HOST — this file's second half: the render server on the 2MHz host.
;          Entered via a WRCHV hook (SarahW/Toob recipe), goes bare
;          metal, pumps R1 and renders; owns vsync + colorscript.
;
; Boot: !BOOT -> *SRLOAD banks 4/5/6 -> *RUN PARA. PARA sets MODE over the
; Tube, *LOADs HOST at FFFF0E00, pokes WRCHV, fires a dummy OSWRCH, then
; both sides handshake &A5 over R4 with all Tube interrupts disabled.
; ============================================================================

INCLUDE "interp.asm"                ; parasite: ORG &E00, SAVE "PARA"

CLEAR &0E00, &8000                  ; host program overlays the same range
ORG &0E00

INCLUDE "chain.inc.asm"             ; span middle chain, fixed at &0E00

; Beam gate (gated_tick): a record's bottom screen line L has been displayed
; this refresh once T1H < GATEBASE - L/4. GATEBASE = (TICKPERIOD -
; (blank_lines + 1)*64) DIV 256 - 1: blank = 312 - R6*8 lines from the tick
; (end of display) to the top of the next display, -1 for T1H granularity.
IF WIDE
GATEBASE    = 56                    ; (19966 - 81*64) DIV 256 - 1 (R6=29)
ELSE
GATEBASE    = 62                    ; (19966 - 57*64) DIV 256 - 1 (R6=32)
ENDIF
PENDC       = SCRATCH+95            ; control byte pushed back by gated_tick
GATET       = SCRATCH+96            ; beam-gate T1H threshold

; ============================================================================
; Host entry — reached from the Tube host code's OSWRCH dispatch after the
; parasite pokes WRCHV. The OS is abandoned mid-call: reset the stack, mask
; interrupts, silence the Tube ULA, and never look back.
; ============================================================================
.host_entry
    sei
    ldx #&FF
    txs
    lda #&7F                        ; kill all VIA IRQ sources: no handler can
    sta &FE4E                       ; ever run, so bank switches need no &F4
    sta &FE6E                       ; ROMSEL shadow (vsync is polled via IFR,
                                    ; which latches regardless of IER)
    lda #&0F                        ; clear Q/I/J/M: no Tube IRQs or NMIs
    sta HTUBE_S1
.hd1                                ; drain stale bytes from R1-R3
    bit HTUBE_S1
    bpl hd2
    lda HTUBE_D1
    bra hd1
.hd2
    bit HTUBE_S2
    bpl hd3
    lda HTUBE_D2
    bra hd2
.hd3
    bit HTUBE_S3
    bpl hd4
    lda HTUBE_D3
    bra hd3
.hd4
    bit HTUBE_S4                    ; drain stale R4 too — we say hello first
    bpl hhello
    lda HTUBE_D4
    bra hd4
.hhello
    bit HTUBE_S4                    ; R4 write free?
    bvc hhello
    lda #&A5                        ; hello parasite: Tube is bare metal now
    sta HTUBE_D4
.hsync
    bit HTUBE_S4                    ; wait for the parasite's &A5 ack
    bpl hsync
    lda HTUBE_D4
    cmp #&A5
    bne hsync
    ; ---- machine init (parasite already set MODE 129 via the Tube) ----
    stz DONEFLAG
    stz PENDC
    stz LOGCNT
    stz LOGCNT+1
    stz frame
    stz frame+1
    lda #<rose_colorscript
    sta CSPTR
    lda #>rose_colorscript
    sta CSPTR+1
IF WIDE
    ldx #0                          ; 6845: R1=88 R2=102 R6=29 R7=33
.hcrtcloop
    lda hcrtctab,x
    sta &FE00
    lda hcrtctab+1,x
    sta &FE01
    inx
    inx
    cpx #8
    bne hcrtcloop
ENDIF
    lda ACCCON                      ; LYNNE stays paged for the whole run:
    ora #4                          ; the host never touches &3000-&7FFF main
    sta ACCCON
    jsr timer_init                  ; phase-lock T1 to the raster
    jsr frame_tick                  ; frame 0: tick + initial palette
    ; fall through to the pump

; ============================================================================
; Record pump: block on R1, parse wire records, render.
; ============================================================================
.pump
    lda PENDC                       ; control byte pushed back by gated_tick?
    bne pu_ctl2
    jsr rd1                         ; tag
    sta QTAG
    bmi pu_ctrl
    jsr pu_read                     ; payload -> REC
    jsr render_blob
    bra pump
.pu_ctl2
    stz PENDC
    bra pu_ctrl
.pu_read                            ; QTAG set: read payload, build REC
    jsr rd1                         ; x lo, x hi, y lo, y hi
    sta REC+2
    jsr rd1
    sta REC+3
    jsr rd1
    sta REC+4
    jsr rd1
    sta REC+5
    jsr rd1                         ; radius (pre-clamped by the parasite)
    sta REC+6
    stz REC+7
    lda QTAG                        ; rebuild c for render_blob
    and #16
    beq pu_circ
    lda QTAG
    and #15
    eor #&FF
    sta REC+8
    lda #&FF
    sta REC+9
    rts
.pu_circ
    lda QTAG
    and #15
    sta REC+8
    stz REC+9
    rts
.pu_ctrl
    cmp #&FF
    bne pu_ef0
    jmp pu_done
.pu_ef0
    and #&7F                        ; END FRAME: advance n frames
    tax
.pu_ef
    inc frame
    bne pu_t2
    inc frame+1
.pu_t2
    dex                             ; hold frames get plain ticks; only the
    beq pu_last                     ; batch's last wait may draw early
    phx
    jsr frame_tick                  ; tick wait + colorscript
    plx
    bra pu_ef
.pu_last
    jsr gated_tick                  ; owed one tick — the wait is draw time
    bra pump

; ============================================================================
; Gated tick: same contract as frame_tick (wait for the next T1 edge, then
; colorscript), but the wait drains beam-safe records for the next frame.
; T1 free-runs phase-locked to the raster, so its high byte is a beam clock:
; a record whose bottom screen line is L has been displayed this refresh
; once T1H < GATEBASE - L/4 (conservative by up to ~8 lines). Only T1C-H is
; read — reading T1C-L would clear the very T1 flag we are waiting on.
; Records arrive in (y - r) order, so the gate line only moves down.
; A control byte ends early draining: push it back to PENDC for the pump.
; ============================================================================
.gated_tick
    lda #&40                        ; clear T1 flag: wait for the NEXT edge
    sta SYSVIA_IFR
.gt_loop
    lda SYSVIA_IFR
    and #&40
    bne gt_tick                     ; tick fired: palette and done
    bit HTUBE_S1
    bpl gt_loop                     ; nothing in R1 yet
    lda HTUBE_D1                    ; next frame's first byte
    sta QTAG
    bmi gt_ctrl                     ; frame boundary / DONE: stop draining
    jsr pu_read
    lda REC+4                       ; bottom line L = y + r - YOFF
    clc                             ; (the parasite cull guarantees the blob
    adc REC+6                       ;  intersects the screen window)
    tay
    lda REC+5
    adc #0
    bne gt_hold                     ; y + r >= 256: too low, wait for tick
    tya
    sec
    sbc #YOFF
    bcc gt_now                      ; clipped at the top edge: always safe
    lsr a
    lsr a                           ; L/4
    sta GATET
    lda #GATEBASE
    sec
    sbc GATET
    bcc gt_hold                     ; near the bottom: gate can't clear
    beq gt_hold                     ; (t = 0 means T1H < 0 — never true)
    sta GATET
.gt_gate
    lda SYSVIA_IFR
    and #&40
    bne gt_hold2                    ; tick beat the gate: draw after palette
    lda SYSVIA_T1CH                 ; beam clock: high byte ONLY
    cmp GATET
    bcs gt_gate
.gt_now
    jsr render_blob                 ; region already displayed: draw early
    bra gt_loop
.gt_ctrl
    sta PENDC                       ; push back for the pump
.gt_hold                            ; REC read but not drawable early:
    lda SYSVIA_IFR                  ; wait out the tick
    and #&40
    beq gt_hold
.gt_hold2
    jsr cs_loop                     ; palette first (it's the frame boundary)
    lda PENDC
    bne gt_out                      ; control byte: nothing pending to draw
    jmp render_blob                 ; then the held record, tail-called
.gt_out
    rts
.gt_tick
    jmp cs_loop                     ; no pending record: palette and return
.pu_done
    jsr rd1                         ; count16 + chk32 -> log header
    sta LOGCNT
    jsr rd1
    sta LOGCNT+1
    jsr rd1
    sta LOGCHK
    jsr rd1
    sta LOGCHK+1
    jsr rd1
    sta LOGCHK+2
    jsr rd1
    sta LOGCHK+3
    lda #&FF
    sta DONEFLAG
.hspin
    jmp hspin

.rd1                                ; next byte from R1 (blocking)
    bit HTUBE_S1
    bpl rd1
    lda HTUBE_D1
    rts

IF WIDE
.hcrtctab
    EQUB 1,88, 2,102, 6,29, 7,33
ENDIF

INCLUDE "tick.inc.asm"              ; frame_tick / vsync / colorscript
INCLUDE "render.inc.asm"            ; render_blob, span fill, tables
INCLUDE "colorscript.asm"
.host_end

SAVE "HOST", &E00, host_end
PUTFILE "spans4.bin", "SPANS4", 0
PUTFILE "spans5.bin", "SPANS5", 0
PUTFILE "circles.bin", "CIRCS", 0
PUTTEXT "boot.txt", "!BOOT", 0

PRINT "HSYM render_blob", ~render_blob
PRINT "HSYM pump", ~pump
PRINT "HSYM hspin", ~hspin
