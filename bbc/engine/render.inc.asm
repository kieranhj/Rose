
; ============================================================================
; MODE 1 renderer. Runs with the shadow screen paged in (ACCCON X set), so
; everything it touches — code, tables, REC, scratch — must live below &3000.
; Coordinates: form 352x280 cropped to 320x256 (offset -16,-12).
; ============================================================================

; Bank 6 fast-path tables (rose2bbc.py make_circle_bank): per-phase rows of
; 64 entries indexed by half-width. OFF = span left offset (phase-hw)&3;
; D8 = signed 16-bit 8*((phase-hw)>>2), the byte-column shift from the
; centre column to the span's first byte.
OFFTAB = &8100
D8LTAB = &8200
D8HTAB = &8300
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
    lda #6                          ; circle tables live in bank 6
    sta &FE30
    ldx RRAD                        ; half-width row for this radius
    lda &8000,x
    sta ptr
    lda &8080,x
    sta ptr+1
    sec                             ; cx = x - XOFF
    lda REC+2
    sbc #XOFF
    sta RCX
    lda REC+3
    sbc #0
    sta RCX+1
    sec                             ; cy = y - YOFF
    lda REC+4
    sbc #YOFF
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
    ; ---- fast path eligibility: blob fully on screen and r <= 62 ----
    lda RRAD
    cmp #63
    bcs rb_lj                       ; big radius: generic per-line path
    lda RY+1                        ; top on screen? (cy-r >= 0)
    bne rb_lj
    clc                             ; bottom: cy+r < SCRH
    lda RCY
    adc RRAD
    tax
    lda RCY+1
    adc #0
    bne rb_lj
IF WIDE
    cpx #SCRH
    bcs rb_lj
ENDIF
    sec                             ; left: cx-r >= 0
    lda RCX
    sbc RRAD
    lda RCX+1
    sbc #0
    bmi rb_lj
    clc                             ; right: cx+r <= 319
    lda RCX
    adc RRAD
    tax
    lda RCX+1
    adc #0
    beq rb_fast_setup               ; < 256: fine
    cmp #1
    bne rb_lj
    cpx #XCMP
    bcc rb_fast_setup
.rb_lj
    jmp rb_line                     ; slow path is out of branch range
.rb_fast_setup
    lda RCX
    and #3
    tax
    lda ph64,x                      ; phase*64: common lo byte for the three
    sta OFFP                        ; per-phase bank 6 lookup rows
    sta D8LP
    sta D8HP
    lda #>OFFTAB
    sta OFFP+1
    lda #>D8LTAB
    sta D8LP+1
    lda #>D8HTAB
    sta D8HP+1
    lda RCX                         ; CCX = centre byte column (0-87)
    lsr a
    lsr a
    sta CCX
    lda RCX+1
    beq rb_fs1
    lda CCX
    ora #64
    sta CCX
.rb_fs1
    ldx RY                          ; BASE = row[y0] + col8[CCX] (top line)
    ldy CCX
    clc
    lda row_lo,x
    adc col8_lo,y
    sta BASE
    lda row_hi,x
    adc col8_hi,y
    sta BASE+1
    txa                             ; TM: crossing after the line with y&7 = 7
    and #7
    eor #7
    inc a
    sta TM
    lda SQF
    beq rbf_circle
    jmp rbf_square
.rbf_circle
    clc                             ; y1 = cy + r (bottom line, on-screen)
    lda RCY
    adc RRAD
    tax
    ldy CCX
    clc
    lda row_lo,x
    adc col8_lo,y
    sta BAS2
    lda row_hi,x
    adc col8_hi,y
    sta BAS2+1
    txa                             ; TM2: crossing after the line with y&7 = 0
    and #7
    inc a
    sta TM2
    lda RRAD                        ; mirror pairs; r = 0 -> centre line only
    sta RCNT
    bne rbf_pj
    jmp rbf_mid
.rbf_pj
    jmp rbf_pair
.rb_line
    lda SQF
    bne rb_hwsq
    lda #6                          ; half-width read needs bank 6
    sta &FE30
    lda (ptr)
    bra rb_hw
.rb_hwsq
    lda RRAD
.rb_hw
    sta RHW
    lda RY+1                        ; line on screen?
    bne rb_next
IF WIDE
    lda RY
    cmp #SCRH
    bcs rb_next
ENDIF
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
    cmp #XCMP
    bcs rb_next                     ; x0 off right
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
    cmp #XCMP
    bcc rb_x1ok
.rb_x1clamp
    lda #XCLAMP
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

; ---- fast path: blob fully on screen, r <= 62 — no clipping.
; Circles walk mirror line pairs from both edges toward the centre: rows dy
; and -dy share half-width, so span length, left offset, filler vector and
; the D8 column shift are computed once and painted twice (fillers load
; RFILL and set Y themselves and never touch scr). Screen addresses are
; tracked incrementally (BASE down / BAS2 up); the per-line phase arithmetic
; is folded into the bank 6 OFF/D8 tables indexed by half-width. ----
.rbf_pair
    lda #6                          ; hw + fast tables live in bank 6
    sta &FE30
    lda (ptr)                       ; hw for this line pair
    tay
    lda (D8LP),y                    ; top span addr = BASE + D8[hw]
    clc
    adc BASE
    sta scr
    lda (D8HP),y
    adc BASE+1
    sta scr+1
    lda (D8LP),y                    ; mirror span addr = BAS2 + D8[hw]
    clc
    adc BAS2
    sta SC2
    lda (D8HP),y
    adc BAS2+1
    sta SC2+1
    lda (OFFP),y                    ; left offset -> filler bank + table
    tax
    tya                             ; vector index = L-1 = 2*hw
    asl a
    tay
    lda obank,x
    sta &FE30
    lda othi,x
    sta rbf_v1+2
    sta rbf_v2+2
.rbf_v1
    lda &8000,y                     ; page byte patched from othi
    sta CHV
.rbf_v2
    lda &8080,y
    sta CHV+1
    jsr chain_call                  ; top line
    lda SC2                         ; bottom line: same filler, new scr
    sta scr
    lda SC2+1
    sta scr+1
    jsr chain_call
    inc ptr                         ; next half-width
    bne rbf_p1
    inc ptr+1
.rbf_p1
    dec TM                          ; BASE: one line down
    beq rbf_bd
    inc BASE
    bne rbf_p2
    inc BASE+1
    bra rbf_p2
.rbf_bd
    lda #8
    sta TM
    clc
    lda BASE
    adc #<(ROWB-7)
    sta BASE
    lda BASE+1
    adc #>(ROWB-7)
    sta BASE+1
.rbf_p2
    dec TM2                         ; BAS2: one line up
    beq rbf_bu
    lda BAS2
    bne rbf_p3
    dec BAS2+1
.rbf_p3
    dec BAS2
    bra rbf_p4
.rbf_bu
    lda #8
    sta TM2
    sec
    lda BAS2
    sbc #<(ROWB-7)
    sta BAS2
    lda BAS2+1
    sbc #>(ROWB-7)
    sta BAS2+1
.rbf_p4
    dec RCNT
    beq rbf_mid
    jmp rbf_pair
.rbf_mid                            ; centre line: BASE has walked r lines down
    lda #6
    sta &FE30
    lda (ptr)                       ; hw here = r
    tay
    lda (D8LP),y
    clc
    adc BASE
    sta scr
    lda (D8HP),y
    adc BASE+1
    sta scr+1
    lda (OFFP),y
    tax
    tya
    asl a
    tay
    lda obank,x
    sta &FE30
    lda othi,x
    sta rbf_m1+2
    sta rbf_m2+2
.rbf_m1
    lda &8000,y
    sta CHV
.rbf_m2
    lda &8080,y
    sta CHV+1
    jmp (CHV)                       ; filler rts returns to render_blob's caller

.rbf_square                         ; every line identical: resolve once,
    lda #6                          ; then walk scr itself down the lines
    sta &FE30
    ldy RRAD                        ; hw = r
    lda (D8LP),y
    clc
    adc BASE
    sta scr
    lda (D8HP),y
    adc BASE+1
    sta scr+1
    lda (OFFP),y
    tax
    tya
    asl a
    tay
    lda obank,x
    sta &FE30
    lda othi,x
    sta rbf_s1+2
    sta rbf_s2+2
.rbf_s1
    lda &8000,y
    sta CHV
.rbf_s2
    lda &8080,y
    sta CHV+1
.rbf_sqloop                         ; RCNT = 2r+1 from render_blob entry
    jsr chain_call
    dec RCNT
    beq rbf_sqdone
    dec TM
    beq rbf_sqbd
    inc scr
    bne rbf_sqloop
    inc scr+1
    bra rbf_sqloop
.rbf_sqbd
    lda #8
    sta TM
    clc
    lda scr
    adc #<(ROWB-7)
    sta scr
    lda scr+1
    adc #>(ROWB-7)
    sta scr+1
    bra rbf_sqloop
.rbf_sqdone
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
    ldx C0                          ; scr += C0 * 8 (table)
    clc
    lda scr
    adc col8_lo,x
    sta scr
    lda scr+1
    adc col8_hi,x
    sta scr+1
    sec                             ; L-1 = x1 - x0 (fits a byte, <= 140)
    lda RX1
    sbc RX0
    cmp #125                        ; L >= 126: generic fallback
    bcs fill_generic
    tay                             ; Y = L-1 indexes the SWRAM vectors
    lda RX0
    and #3                          ; left offset selects bank + table
.span_go                            ; entry: A = offset 0-3, Y = L-1, scr set
    cmp #2
    bcs sp_o23
    lsr a
    bcs sp_o1                       ; low bit is in C after LSR, not in A
    lda #4                          ; o=0: bank 4, first table
    sta &FE30
    lda &8000,y
    sta CHV
    lda &8080,y
    sta CHV+1
    jmp (CHV)
.sp_o1
    lda #4                          ; o=1: bank 4, second table
    sta &FE30
    lda &8100,y
    sta CHV
    lda &8180,y
    sta CHV+1
    jmp (CHV)
.sp_o23
    lsr a
    bcs sp_o3
    lda #5                          ; o=2: bank 5, first table
    sta &FE30
    lda &8000,y
    sta CHV
    lda &8080,y
    sta CHV+1
    jmp (CHV)
.sp_o3
    lda #5                          ; o=3: bank 5, second table
    sta &FE30
    lda &8100,y
    sta CHV
    lda &8180,y
    sta CHV+1
    jmp (CHV)

.fill_generic                       ; L > 125 (rare: r > 62 unclipped)
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
    lda C1                          ; C1 = byte count - 1
    sec
    sbc C0
    sta C1
    bne fs_multi
    lda ML                          ; single byte: combined mask
    and MR
    sta ML
    ldy #0
    jmp fs_masked
.fs_multi
    ldy #0                          ; left edge
    jsr fs_masked
.fs_chunk
    lda C1                          ; bytes remaining after current scr
    cmp #32
    bcc fs_tail
    lda RFILL                       ; full 30-store chunk
    jsr chain30
    clc                             ; scr += 240
    lda scr
    adc #240
    sta scr
    bcc fs_ch1
    inc scr+1
.fs_ch1
    lda C1
    sec
    sbc #30
    sta C1
    bra fs_chunk
.fs_tail                            ; 1..31 bytes left: A = n
    sec
    sbc #1                          ; k = n-1 middle stores
    beq fs_last
    asl a                           ; CHV = chain_rts - 4k
    asl a
    sta TMPB
    sec
    lda #<chain_rts
    sbc TMPB
    sta CHV
    lda #>chain_rts
    sbc #0
    sta CHV+1
    lda RFILL
    jsr chain_call
.fs_last
    lda C1                          ; last byte at offset n*8 (<= 248)
    asl a
    asl a
    asl a
    tay
    lda MR
    sta ML
    ; fall through
.fs_masked                          ; new = old ^ ((old ^ fill) & mask)
    lda (scr),y
    sta TMPB
    eor RFILL
    and ML
    eor TMPB
    sta (scr),y
    rts
.chain_call
    jmp (CHV)

; ============================================================================
; Renderer tables (must stay below &3000)
; ============================================================================
.ctab                               ; 4 pixels of colour c (MODE 1)
    EQUB &00, &0F, &F0, &FF
.ph64                               ; phase -> lo byte of the bank 6 table rows
    EQUB 0, 64, 128, 192
.obank                              ; span left offset -> filler SWRAM bank
    EQUB 4, 4, 5, 5
.othi                               ; span left offset -> vector page in bank
    EQUB &80, &81, &80, &81
.maskL                              ; pixels >= x&3 within byte
    EQUB &FF, &77, &33, &11
.maskR                              ; pixels <= x&3 within byte
    EQUB &88, &CC, &EE, &FF
.col8_lo
FOR c, 0, 87
    EQUB <(c*8)
NEXT
.col8_hi
FOR c, 0, 87
    EQUB >(c*8)
NEXT
.row_lo
FOR y, 0, 255
    EQUB <(SCREEN + (y DIV 8)*ROWB + (y MOD 8))
NEXT
.row_hi
FOR y, 0, 255
    EQUB >(SCREEN + (y DIV 8)*ROWB + (y MOD 8))
NEXT
ASSERT P% <= &3000                  ; render path must not cross into shadow
