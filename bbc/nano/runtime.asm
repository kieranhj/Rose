; ===========================================================================
; Rose Nano runtime — BBC Model B, MODE 2
; Generated code is spliced in at @@PROCS@@; see bbc/nano/nanoc.py.
;
; Geometry, confirmed on the machine (rose-nano.md §14.1):
;   +1 = next scanline within a character row, +8 = next 2-pixel column.
; The grid itself is chosen in nanoc.py, which hands down GW, GH, XSH, YSH,
; CELLB, COLSTEP and NSIZE; this file is written against those rather than
; against one grid, so 40x32 and 80x64 share every instruction below.
; ===========================================================================

CPU 0                           ; plain 6502 — this is a Model B

OSWRCH  = &FFEE
OSBYTE  = &FFF4

; --- zero page (the Model B's free user block, &70-&8F) ---------------------
P       = &70                   ; working screen pointer
RBASE   = &72                   ; row base
PAT_A   = &74                   ; the two bytes of this tint's dither pair
PAT_B   = &75
COL     = &76
ROW     = &77
C0      = &78
C1      = &79
SPCNT   = &7A
SPIDX   = &7B
PCV     = &7C                   ; JMP (PCV) resumes a turtle
tsave   = &7E
RND     = &7F
FRLO    = &80
FRHI    = &81
TMP     = &82
MX      = &84                   ; move-table pointers, selected per distance
MXH     = &86
MY      = &88
MYH     = &8A
DONE    = &8C                   ; finished flag, read by the harness
SPINCNT = &8D                   ; frames until the next palette rotation
VIDULA  = &FE21

; A video ULA palette write: logical colour L takes physical colour P.
; The ULA stores the physical colour inverted (§4.2).
MACRO PALW L, P
    LDA #(L * 16) OR (P EOR 7) : STA VIDULA
ENDMACRO

; RASTER=1 recolours logical 0 for the duration of the turtle pass, so the
; blue band on screen is a direct picture of how far down the frame the
; scheduler got.  It costs 8 cycles a frame and moves no screen bytes, so a
; raster build still verifies against the reference model.
BLUE    = 4
BLACK   = 0

ORG ORGADDR
GUARD SCREEN

.start
    JSR init
.mainloop
IF NOVSYNC = 0
    LDA #19 : JSR OSBYTE        ; wait for vertical sync
ENDIF
IF RASTER
    PALW 0, BLUE                ; raster debug: turtle pass starts here
ENDIF
    LDX #0
.tloop
    LDA talive,X : BEQ tnext
    LDA twait,X : BEQ trun
    DEC twait,X
    JMP tnext
.trun
    LDA tpcl,X : STA PCV
    LDA tpch,X : STA PCV+1
    JMP (PCV)                   ; into compiled code, X = turtle
.tyield                         ; compiled code returns here
.tnext
    INX
    CPX #MAXT
    BNE tloop
IF RASTER
    PALW 0, BLACK               ; raster debug: turtle pass ends here
ENDIF
    INC FRLO
    BNE nowrap
    INC FRHI
.nowrap
IF SPINRATE > 0
    DEC SPINCNT
    BNE nospin
    LDA #SPINRATE : STA SPINCNT
    JSR palspin
.nospin
ENDIF
IF MAXFRAMES > 0
    LDA FRHI : CMP #HI(MAXFRAMES) : BCC mainloop
    LDA FRLO : CMP #LO(MAXFRAMES) : BCC mainloop
    JMP finished
ENDIF
    JMP mainloop

.finished
    LDA #&FF : STA DONE         ; done flag, for the harness
.spin
    JMP spin

; --- a turtle reaching the end of its proc dies ----------------------------
.tdie
    LDA #0 : STA talive,X
    JMP tnext

; ---------------------------------------------------------------- allocation
; talloc: Y = a free slot, C clear; C set when the pool is full.
.talloc
    LDY #0
.al1
    LDA talive,Y : BEQ alfound
    INY
    CPY #MAXT : BNE al1
    SEC
    RTS
.alfound
    CLC
    RTS

; tclone: copy turtle X into slot Y and make it live.
.tclone
    LDA txl,X   : STA txl,Y
    LDA txh,X   : STA txh,Y
    LDA tyl,X   : STA tyl,Y
    LDA tyh,X   : STA tyh,Y
    LDA tdir,X  : STA tdir,Y
    LDA ttint,X : STA ttint,Y
    LDA tsize,X : STA tsize,Y
    LDA tl0,X   : STA tl0,Y
    LDA tl1,X   : STA tl1,Y
    LDA tl2,X   : STA tl2,Y
    LDA tl3,X   : STA tl3,Y
    LDA #0      : STA twait,Y
    LDA #1      : STA talive,Y
    RTS

; ---------------------------------------------------------------------- rand
.nrand
    LDA RND
    ASL A
    BCC nr1
    EOR #&1D
.nr1
    STA RND
    RTS

; ---------------------------------------------------------------------- move
; Y = distance index.  Direction is a byte; the tables are 128 entries, so the
; index is dir>>1 (§5.1: the error budget is a cell, which licenses this).
.tmove
    LDA dxlo_l,Y : STA MX
    LDA dxlo_h,Y : STA MX+1
    LDA dxhi_l,Y : STA MXH
    LDA dxhi_h,Y : STA MXH+1
    LDA dylo_l,Y : STA MY
    LDA dylo_h,Y : STA MY+1
    LDA dyhi_l,Y : STA MYH
    LDA dyhi_h,Y : STA MYH+1
    LDA tdir,X
    LSR A
    TAY
    LDA txl,X : CLC : ADC (MX),Y  : STA txl,X
    LDA txh,X :       ADC (MXH),Y : STA txh,X
    LDA tyl,X : CLC : ADC (MY),Y  : STA tyl,X
    LDA tyh,X :       ADC (MYH),Y : STA tyh,X
    ; x is 0..159; wrap it toroidally.  y needs no wrap: 32 rows x 8 = 256.
    LDA txh,X
    CMP #160
    BCC mvok
    CMP #208                    ; midway — above this it underflowed
    BCS mvadd
    SEC : SBC #160
    JMP mvst
.mvadd
    CLC : ADC #160
.mvst
    STA txh,X
.mvok
    RTS

; ---------------------------------------------------------------------- draw
.tdraw
    LDA ttint,X : AND #7 : TAY      ; the palette is 8 entries; mask like the model
    LDA pata,Y : STA PAT_A
    LDA patb,Y : STA PAT_B
    LDA txh,X                       ; 160px -> GW columns
    FOR n, 1, XSH
    LSR A
    NEXT
    STA COL
    LDA tyh,X                       ; 256 scanlines -> GH rows
    FOR n, 1, YSH
    LSR A
    NEXT
    STA ROW
    LDA tsize,X : AND #NSIZE-1 : TAY    ; §13.3
    LDA spancnt,Y : STA SPCNT
    LDA spanofs,Y : STA SPIDX
.dsrow
    LDY SPIDX
    LDA spandy,Y
    CLC : ADC ROW
    AND #GH-1                   ; the canvas is a torus in y
    TAY
    LDA rowlo,Y : STA RBASE
    LDA rowhi,Y : STA RBASE+1
    LDY SPIDX
    LDA spandx,Y : STA TMP
    LDA COL : SEC : SBC TMP
    BPL dsc0
    LDA #0
.dsc0
    STA C0
    LDA COL : CLC : ADC TMP
    CMP #GW
    BCC dsc1
    LDA #GW-1
.dsc1
    STA C1
    LDY C0
    LDA RBASE   : CLC : ADC colo,Y : STA P
    LDA RBASE+1 :       ADC cohi,Y : STA P+1
.dscell
    ; One grid cell: CELLB contiguous bytes, the dither alternating by
    ; scanline.  Byte index parity IS scanline parity whatever the cell height
    ; -- a half-height cell starts at scanline 0 or 4, both even -- so the
    ; pattern stays locked to screen position for free (§13.4).
    LDY #0
    FOR n, 0, CELLB-1
    IF (n AND 1) = 0
    LDA PAT_A
    ELSE
    LDA PAT_B
    ENDIF
    STA (P),Y
    IF n < CELLB-1
    INY
    ENDIF
    NEXT
    ; Cells step by COLSTEP, which is NOT CELLB once a cell is half-height.
    LDA P : CLC : ADC #COLSTEP : STA P
    BCC dsnc
    INC P+1
.dsnc
    INC C0
    LDA C0
    CMP C1
    BCC dscell
    BEQ dscell
    INC SPIDX
    DEC SPCNT
    BEQ dsdone
    JMP dsrow                   ; the cell loop is too long for a branch
.dsdone
    RTS

; ---------------------------------------------------------------------- init
.init
    LDA #22 : JSR OSWRCH : LDA #2 : JSR OSWRCH      ; MODE 2
    LDA #23 : JSR OSWRCH : LDA #1 : JSR OSWRCH      ; cursor off
    LDX #8
.cur1
    LDA #0 : JSR OSWRCH
    DEX : BNE cur1
    JSR setpal
    JSR clearbg
    LDX #MAXT-1
    LDA #0
.iz
    STA talive,X
    DEX
    BPL iz
    ; turtle 0 starts at the first proc
    LDX #0
    LDA #1   : STA talive
    LDA #0   : STA twait  : STA txl : STA tyl : STA tdir
    STA tl0  : STA tl1    : STA tl2 : STA tl3
    LDA #80  : STA txh
    LDA #128 : STA tyh
    LDA #1   : STA ttint
    LDA #0   : STA tsize
    LDA #LO(@@ENTRY@@) : STA tpcl
    LDA #HI(@@ENTRY@@) : STA tpch
    LDA #SPINRATE : STA SPINCNT
    LDA #0 : STA DONE
    LDA #1 : STA RND
    LDA #0 : STA FRLO : STA FRHI
    RTS

; ------------------------------------------------------------------- palette
; The dither patterns hold LOGICAL colour numbers; rotating the logical->
; physical map recolours everything already on screen, including trails whose
; turtles are long dead (§4.2).  Eight writes to the video ULA, once a frame.
.setpal
    LDY #7
.sp1
    LDA palcur,Y
    EOR #7                      ; the ULA stores the physical colour inverted
    STA TMP
    TYA
    ASL A : ASL A : ASL A : ASL A
    ORA TMP
    STA VIDULA
    DEY
    BPL sp1
    RTS

; Rotate palcur[SPINLO..SPINHI] by one and reprogram.
.palspin
    LDA palcur+SPINLO
    STA TMP
    LDY #SPINLO
.ps1
    LDA palcur+1,Y
    STA palcur,Y
    INY
    CPY #SPINHI
    BNE ps1
    LDA TMP
    STA palcur+SPINHI
    JMP setpal

.palcur
    EQUB 0,1,2,3,4,5,6,7

; Fill the screen with the background tint's pattern, so a background-coloured
; blob is invisible exactly as it is in the reference renderer (§13.4).
.clearbg
    LDA #LO(SCREEN) : STA P
    LDA #HI(SCREEN) : STA P+1
    LDX #80
.cb1
    LDY #0
.cb2
    LDA #BACKA : STA (P),Y : INY
    LDA #BACKB : STA (P),Y : INY
    BNE cb2
    INC P+1
    DEX
    BNE cb1
    RTS

; ------------------------------------------------------------ compiled procs
; @@PROCS@@

; ------------------------------------------------------------------- tables
; @@TABLES@@

; ---- grid column -> byte offset, col*COLSTEP.
.colo
    FOR n, 0, GW-1
    EQUB LO(n*COLSTEP)
    NEXT
.cohi
    FOR n, 0, GW-1
    EQUB HI(n*COLSTEP)
    NEXT

; ------------------------------------------------------------------- arrays
; @@ARRAYS@@

.progend

PRINT "SYM start", ~start
PRINT "SYM talive", ~talive
PRINT "SYM tables", ~rowlo
PRINT "SYM progend", ~progend
PRINT "SIZE", progend - start
PRINT "FREE", &3000 - progend

SAVE "NANO", start, progend, start
