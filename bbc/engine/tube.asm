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

; ============================================================================
; Host entry — reached from the Tube host code's OSWRCH dispatch after the
; parasite pokes WRCHV. The OS is abandoned mid-call: reset the stack, mask
; interrupts, silence the Tube ULA, and never look back.
; ============================================================================
.host_entry
    sei
    ldx #&FF
    txs
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
    jsr frame_tick                  ; frame 0: vsync + initial palette
    ; fall through to the pump

; ============================================================================
; Record pump: block on R1, parse wire records, render.
; ============================================================================
.pump
    jsr rd1                         ; tag
    sta QTAG
    bmi pu_ctrl
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
    bra pu_go
.pu_circ
    lda QTAG
    and #15
    sta REC+8
    stz REC+9
.pu_go
    jsr render_blob
    bra pump
.pu_ctrl
    cmp #&FF
    beq pu_done
    and #&7F                        ; END FRAME: advance n frames
    tax
.pu_ef
    inc frame
    bne pu_tick
    inc frame+1
.pu_tick
    phx
    jsr frame_tick                  ; vsync wait + colorscript
    plx
    dex
    bne pu_ef
    bra pump
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
