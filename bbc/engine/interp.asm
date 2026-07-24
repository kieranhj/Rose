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
; Build: beebasm -i interp.asm -do beeb-<name>-rose.ssd (see bin/build.sh)
; Run:   *LOAD CODE : CALL &2000 — returns to BASIC when all turtles die.
; ============================================================================

CPU 1                       ; 65C12

; WIDE=1 (beebasm -D): 352x232 overscan MODE 1 variant (R1=88, R6=29).
; Full form width displayed; vertical crop 280->232. WIDE=0: 320x256 crop.
; WIDE=2: 320x180 letterbox for the widescreen forms (R6=23, R7=30) — the
; whole form fits the screen, 184 lines displayed, 4 spare rows stay blank.
IF WIDE = 1
XOFF = 0                    ; form x - XOFF = screen x
YOFF = 24
SCRH = 232
SCRW = 352
ROWB = 704                  ; 88 chars * 8 bytes
XCMP = &60                  ; x >= 352 is off-screen (hi byte 1)
XCLAMP = &5F                ; x1 clamps to 351
ELIF WIDE = 2
XOFF = 0
YOFF = 0
SCRH = 180
SCRW = 320
ROWB = 640
XCMP = &40                  ; x >= 320 is off-screen (hi byte 1)
XCLAMP = &3F                ; x1 clamps to 319
ELSE
XOFF = 16
YOFF = 12
SCRH = 256
SCRW = 320
ROWB = 640
XCMP = &40                  ; x >= 320 is off-screen (hi byte 1)
XCLAMP = &3F                ; x1 clamps to 319
ENDIF

; --- Configuration ----------------------------------------------------------
; MAXT, STATE_SIZE (STATESZ) and STATES (STATEBASE) come from -D on the
; beebasm command line — per-demo capacity. Handles are state base ADDRESSES
; (null = hi byte 0), so neither table sizes nor alignment constrain them.
MAXT        = TMAXT         ; max live turtles
                            ; FRAMES (frame cap, matches the roseplots run)
                            ; and WIRES (demo uses wire slots) also from -D
STATE_SIZE  = STATESZ       ; bytes per turtle state block (64 + stack bytes)
MAXRADIUS   = 70            ; circle tables in bank 6 cover 0..70

; --- Memory map -------------------------------------------------------------
BHEADL      = &0900         ; per-bucket FIFO head/tail, 16-bit state addrs
BHEADH      = &0A00         ;   (hi byte 0 = empty)
BTAILL      = &0300
BTAILH      = &0400
SCRATCH     = &0C80         ; MOVE/mul scratch (see below)
STATES      = STATEBASE     ; MAXT x STATE_SIZE state blocks
LOGCNT      = &0B80         ; 16-bit plot count
LOGCHK      = &0B82         ; 32-bit order-independent checksum
IF TUBE
; Stop a full page below the sort stage: the limit check is on the record
; START, so a record beginning at LOGLIMIT-1:F8 may run 9 bytes past it.
LOGLIMIT    = ((STATES - &400 - PBUFN * 8) DIV 256) - 1
ELSE
LOGLIMIT    = &7C           ; plot prefix (from rose_data_end) stops here
ENDIF
; Sideways banks: 4/5 = span fillers, 6 = circle tables, 7 = turtle states.
; Bank 7 stays paged during interpretation; the renderer switches 6 (half-
; widths) and 4/5 (fills) per line and rec_done restores 7.

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
evx         = &74           ; turtle stack top as a state-block index:
                            ; ST_LOCALS + height (64..124). Stored raw
                            ; (un-biased) in the state's ST_HEIGHT byte.
RA          = &75           ; 32-bit accumulator A (top of stack pops here)
RB          = &79           ; 32-bit accumulator B
opsave      = &7D           ; current opcode
frame       = &7F           ; 16-bit current frame
ptr         = &83           ; 16-bit scratch pointer
sgn         = &85           ; scratch: sign flag
zres        = &86           ; scratch: zero-test result
lptr        = &87           ; 16-bit log write pointer
cnt         = &89           ; loop counter (fork args)
APTR        = &89           ; append arg: handle to enqueue (aliases cnt —
CHV         = &89           ;   free by append time) and the span-chain
                            ;   vector CHV (never rendering while appending)
scr         = &8D           ; screen write pointer (renderer)
T4PTR       = &8B           ; -> next t4mask RLE entry (erase-class verdicts)

; --- Multiply zero page (&50-&5D) ---------------------------------------------
; Quarter-square multiply pointers. The four tables are page-aligned and 512
; bytes long, so a pointer into table T for operand byte a is simply
; (lo = a, hi = >T): the hi bytes are set once at init and never change.
MS1L        = &50           ; -> sq1_lo + a   (f(a+y),  f(n) = n^2/4)
MS1H        = &52           ; -> sq1_hi + a
MS2L        = &54           ; -> sq2_lo + a   (f(a-255+y), i.e. f(a-b) at y=~b)
MS2H        = &56           ; -> sq2_hi + a
MNBL        = &58           ; ~M2 (255 - multiplier lo byte)
MNBH        = &59           ; ~M2+1
MT1         = &5A           ; mid partial product al*bh
MT2         = &5C           ; mid partial product ah*bl

; --- Renderer fast-path zero page (&60-&6F) ----------------------------------
; The machine is OS-free once running (all IRQ sources masked, OS abandoned),
; so the renderer claims a block outside the official user slice.
OFFP        = &60           ; -> bank 6 OFF[phase][hw]: span left offset
D8LP        = &62           ; -> bank 6 D8 lo[phase][hw]: 8*((phase-hw)>>2)
D8HP        = &64           ; -> bank 6 D8 hi (signed 16-bit extension)
BASE        = &66           ; screen addr of centre byte column, walking down
BAS2        = &68           ; same for the mirror line, walking up
SC2         = &6A           ; resolved span address for the mirror line
TM          = &6C           ; lines until BASE crosses a character row
TM2         = &6D           ; lines until BAS2 crosses a character row

; Turtle list heads/counters (word each; cold paths, so absolute is fine)
FREEH       = SCRATCH+80    ; free-list head
DEFH        = SCRATCH+82    ; deferred list head (wait >= 256 frames)
DEFT        = SCRATCH+84    ; deferred list tail
TCNT        = SCRATCH+86    ; live turtle count (16-bit: up to 288 turtles)

; Intrusive list link inside each state block. When the demo uses no wires
; (WIRES=0) it lives in wire slot 0's bytes (32/33). Wire-using demos keep
; it in the top two bytes of the state instead — the build must then pass a
; STATESZ with at least two spare bytes above the deepest stack
; (64 + 4*max_stack + 2, rounded up).
IF WIRES
TL_LO       = STATE_SIZE - 2
ELSE
TL_LO       = 32
ENDIF
TL_HI       = TL_LO + 1

; --- Scratch block (abs) -----------------------------------------------------
IDX14       = SCRATCH+0     ; 14-bit sine index
TSIN        = SCRATCH+2     ; sinlook result (s16)
SAV         = SCRATCH+4     ; sin(dir) (s16)
CAV         = SCRATCH+6     ; cos(dir) (s16)
VAL16       = SCRATCH+8     ; move distance operand (s16)
M1          = SCRATCH+14    ; multiplier (destroyed)
M2          = SCRATCH+16    ; multiplicand (preserved)
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
RFILL       = &6E           ; 4-pixel fill byte for the tint (zp: every span
                            ; filler edge write touches it)
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
TMPB        = &6F           ; masked-write temp (zp, hot in span edges)
CSPTR       = SCRATCH+68    ; colorscript event pointer (2 bytes)
CSVAL       = SCRATCH+70    ; current event value byte
CCX         = SCRATCH+73    ; fast path: cx >> 2 (byte column of centre)
QTAG        = SCRATCH+77    ; record queue: tag byte in flight
QW          = SCRATCH+78    ; record queue: write index (16-bit)
PBW         = SCRATCH+88    ; frame stage: write pointer (word)
NREC        = SCRATCH+90    ; frame stage: records staged this frame
PPASS       = SCRATCH+91    ; frame stage: flush pass (0/1)
KLO         = SCRATCH+92    ; frame stage: bucket key lo
KHI         = SCRATCH+93    ; frame stage: bucket key hi / chain temp
P1F         = SCRATCH+94    ; frame stage: any record filed for pass 1
T4BYTE      = SCRATCH+97    ; t4mask: verdict shift register (MSB next)
T4NB        = SCRATCH+98    ; t4mask: bits left in the register

; --- Frame stage: stable (y - r) render order --------------------------------
; The visualizer stable-sorts each frame's plots by (t, y-r) before drawing
; (renderer.cpp), as did the Archimedes engine via per-line circle buffers.
; Records are staged here during the frame and flushed to the byte sink in
; bucket order at the frame boundary. 8-byte entries: next(2), then the
; 6-byte wire record (tag, x lo/hi, y lo/hi, r). Key = y - r + 140, two
; 256-bucket passes cover keys 0..511 (visible blobs land in -140..279).
IF TUBE
SORTBASE    = STATES - (&400 + PBUFN * 8) ; parasite: below the state blocks
ELSE
SORTBASE    = &9900         ; single CPU: SWRAM bank 6, above circle tables
                            ; (hw data ends &97B1 at maxr 70; asserted in
                            ; rose2bbc.py make_circle_bank)
ENDIF
PBUF        = SORTBASE      ; PBUFN entries x 8 bytes (-D, default 250;
PBMAX       = PBUFN         ; overflow degrades to a mid-frame flush)
BKHL        = SORTBASE + PBUFN * 8
BKHH        = BKHL + &100
BKTL        = BKHL + &200
BKTH        = BKHL + &300

; --- Record queue: the Tube seam ---------------------------------------------
; The interpreter (future parasite) pushes wire records here; q_drain (the
; future host) consumes them and renders. Wire format (docs/tube.md §3):
;   draw:   tag (bits 0-3 tint, bit 4 square), x lo, x hi, y lo, y hi, r
;   &80+n:  end of frame, advancing n frames
;   &FF:    done — followed by count16 + chk32 for the log header
QBASE       = &0500         ; queue buffer (&0500-&08FF: free once OS-free)
QHIGH       = &03C0         ; drain past this index (queue is 1K to &0900)

OSWRCH      = &FFEE         ; init only — the runtime is OS-free
OSWORD      = &FFF1
OSCLI       = &FFF7
SYSVIA_IFR  = &FE4D         ; bit 1 = CA1 = vsync, bit 6 = T1 = frame tick
SYSVIA_T1CL = &FE44         ; T1 counter lo (read: current beam phase)
SYSVIA_T1CH = &FE45         ; T1 counter hi (write: load + start)
SYSVIA_T1LL = &FE46         ; T1 latch lo
SYSVIA_T1LH = &FE47         ; T1 latch hi (write: latch only, no restart)
SYSVIA_ACR  = &FE4B         ; bit 6 = T1 continuous
ULACOL      = &FE21         ; Video ULA palette register
ACCCON      = &FE34         ; Master: bit 2 (X) maps &3000-&7FFF to LYNNE
SCREEN      = &3000
DONEFLAG    = &0B86         ; set to &FF when the run completes

; Tube ULA registers (status bit 7 = data available, bit 6 = not full)
HTUBE_S1    = &FEE0         ; host side
HTUBE_D1    = &FEE1
HTUBE_S2    = &FEE2
HTUBE_D2    = &FEE3
HTUBE_S3    = &FEE4
HTUBE_D3    = &FEE5
HTUBE_S4    = &FEE6
HTUBE_D4    = &FEE7
PTUBE_S1    = &FEF8         ; parasite side
PTUBE_D1    = &FEF9
PTUBE_S3    = &FEFC
PTUBE_D3    = &FEFD
PTUBE_S4    = &FEFE
PTUBE_D4    = &FEFF

ORG &E00

IF TUBE = 0
INCLUDE "chain.inc.asm"
ENDIF

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
IF TUBE
    ; ------------------------------------------------------------------
    ; Parasite boot (OS still up; OSWRCH/OSCLI/OSWORD round-trip to the
    ; host). The MODE sequence above already ran on the host via the Tube.
    ; Toob/SarahW recipe: load the host program, point the host's WRCHV
    ; at it, fire one dummy OSWRCH so the host enters it and never comes
    ; back, then handshake over R4 and go bare-metal on both sides.
    ; ------------------------------------------------------------------
    ldx #<loadstr                   ; *LOAD HOST FFFF0E00 (host memory)
    ldy #>loadstr
    jsr OSCLI
    lda #<host_entry                ; poke host WRCHV (&020E) via OSWORD 6
    sta owblk+4
    lda #&0E
    sta owblk
    jsr oswpoke
    lda #>host_entry
    sta owblk+4
    lda #&0F
    sta owblk
    jsr oswpoke
    lda #0                          ; dummy char: host enters host_entry
    jsr OSWRCH
    sei                             ; parasite is ours now
    ldx #&FF
    txs
    ; The host says hello FIRST: it is entered by the trigger char, so once
    ; its &A5 arrives the Tube ULA interrupts are off and raw R4 writes are
    ; safe. Writing R4 before that raises a host-side Tube IRQ while the OS
    ; still owns the machine — the MOS eats it as a system-control byte.
.pdrain1                            ; drain stale bytes from our read ports
    bit PTUBE_S1
    bpl pdrain3
    lda PTUBE_D1
    bra pdrain1
.pdrain3
    bit PTUBE_S3
    bpl phello
    lda PTUBE_D3
    bra pdrain3
.phello
    bit PTUBE_S4                    ; wait for the host's &A5 hello
    bpl phello
    lda PTUBE_D4
    cmp #&A5
    bne phello
.pack
    bit PTUBE_S4                    ; R4 write free?
    bvc pack
    lda #&A5                        ; ack: we are bare-metal too
    sta PTUBE_D4
ELSE
    stz DONEFLAG
IF WIDE
    ldx #0                          ; 6845 tweaks (see crtctab per variant)
.crtcloop
    lda crtctab,x
    sta &FE00
    lda crtctab+1,x
    sta &FE01
    inx
    inx
    cpx #CRTCN
    bne crtcloop
ENDIF
    sei                             ; OS not needed from here on
    lda #&7F                        ; and no VIA IRQ sources either: no handler
    sta &FE4E                       ; can ever run, so the &F4 ROMSEL shadow is
    sta &FE6E                       ; dead weight — banks switch with a bare
                                    ; STA &FE30 from here on
    lda #7                          ; turtle states live in bank 7
    sta &FE30
ENDIF
    ; buckets all empty (hi byte 0 = null)
    lda #0
    tax
.initb
    sta BHEADL,x
    sta BHEADH,x
    sta BTAILL,x
    sta BTAILH,x
    inx
    bne initb
    ; frame-stage bucket heads start clear once; flush_sorted's emit scan
    ; keeps them clear (tails are allowed to go stale)
IF TUBE = 0
    lda #6
    sta &FE30
ENDIF
.initk
    stz BKHH,x
    inx
    bne initk
IF TUBE = 0
    lda #7
    sta &FE30
ENDIF
    ; free list: chain all states through their link bytes, last -> null
    lda #<STATES
    sta FREEH
    sta ptr
    lda #>STATES
    sta FREEH+1
    sta ptr+1
    lda #<(MAXT-1)
    sta M1
    lda #>(MAXT-1)
    sta M1+1
.initn
    clc                             ; RA = ptr + STATE_SIZE = next state
    lda ptr
    adc #<STATE_SIZE
    sta RA
    lda ptr+1
    adc #>STATE_SIZE
    sta RA+1
    ldy #TL_LO
    lda RA
    sta (ptr),y
    iny
    lda RA+1
    sta (ptr),y
    lda RA
    sta ptr
    lda RA+1
    sta ptr+1
    lda M1
    bne initn1
    dec M1+1
.initn1
    dec M1
    lda M1
    ora M1+1
    bne initn
    ldy #TL_LO                      ; last state: null link
    lda #0
    sta (ptr),y
    iny
    sta (ptr),y
    stz TCNT
    stz TCNT+1
    stz frame
    stz frame+1
    ; log
    stz LOGCNT
    stz LOGCNT+1
    stz LOGCHK
    stz LOGCHK+1
    stz LOGCHK+2
    stz LOGCHK+3
    lda #<rose_data_end
    sta lptr
    lda #>rose_data_end
    sta lptr+1
    ; quarter-square multiply pointer hi bytes (tables are page-aligned;
    ; the lo bytes are the operand byte, written per multiply)
    lda #>sq1_lo
    sta MS1L+1
    lda #>sq1_hi
    sta MS1H+1
    lda #>sq2_lo
    sta MS2L+1
    lda #>sq2_hi
    sta MS2H+1
IF TUBE
    ; Generate the sq1 pair into free low parasite RAM instead of shipping
    ; 1KB in the image: f(n) = n^2/4 for n 0..511, incrementally via
    ; f(n) = f(n-1) + (n >> 1). (sq2 stays in the image.)
    stz ptr
    stz scr
    lda #>sq1_lo
    sta ptr+1
    lda #>sq1_hi
    sta scr+1
    stz RA                          ; acc = f(n), 16-bit
    stz RA+1
    stz RB                          ; step delta (n+1) >> 1, fits a byte
.sqgen
    lda RA
    sta (ptr)
    lda RA+1
    sta (scr)
    lda ptr                         ; after an odd n the step delta grows
    lsr a
    bcc sqgen_add
    inc RB
.sqgen_add
    clc
    lda RA
    adc RB
    sta RA
    bcc sqgen_next
    inc RA+1
.sqgen_next
    inc scr
    bne sqgen_i2
    inc scr+1
.sqgen_i2
    inc ptr
    bne sqgen
    inc ptr+1
    lda ptr+1
    cmp #>sq1_hi                    ; lo table walked past &6FF -> done
    bne sqgen
ENDIF
IF TUBE = 0
    stz QW
    stz QW+1
ENDIF
    lda #<t4mask                    ; erase-class drop mask bitstream
    sta T4PTR
    lda #>t4mask
    sta T4PTR+1
    stz T4NB
    lda #<PBUF                      ; frame stage empty
    sta PBW
    lda #>PBUF
    sta PBW+1
    stz NREC
    stz DEFH+1                      ; deferred list empty (hi 0 = null)
    stz DEFT+1

    ; ---- create turtle 0 running proc 0 (main) ----
    jsr alloc                       ; ptr = state base (the handle)
    ldy #0
    lda #0
.zeroloop
    sta (ptr),y
    iny
    cpy #STATE_SIZE
    bne zeroloop
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
    sta TCNT
    lda ptr                         ; turtle 0 -> bucket 0
    sta APTR
    lda ptr+1
    sta APTR+1
    ldx #0
    jsr append
IF TUBE = 0
    lda #<rose_colorscript
    sta CSPTR
    lda #>rose_colorscript
    sta CSPTR+1
    jsr timer_init                  ; phase-lock T1 to the raster
    jsr frame_tick                  ; frame 0: tick + initial palette
ENDIF
    ; fall through to scheduler

; ============================================================================
; Scheduler: FIFO bucket per (frame & 255)
; ============================================================================
.sched
    ldx frame                       ; bucket = frame low byte
    lda BHEADH,x
    bne run_turtle
    lda DEFH+1                      ; re-attach deferred (future-lap) turtles
    beq bucket_done
    sta BHEADH,x
    lda DEFH
    sta BHEADL,x
    lda DEFT
    sta BTAILL,x
    lda DEFT+1
    sta BTAILH,x
    lda #0
    sta DEFH+1
    sta DEFT+1
.bucket_done
    ; next frame
    lda TCNT
    ora TCNT+1
    beq exit
    inc frame
    bne nowrap
    inc frame+1
.nowrap
    lda frame+1                     ; frame == FRAMES -> exit
    cmp #>FRAMES
    bne do_tick
    lda frame
    cmp #<FRAMES
    bne do_tick
    bra exit
.do_tick
    jsr flush_sorted                ; emit this frame's records in (y-r) order
    lda #&81                        ; END FRAME, advance 1
    jsr q_push_a
IF TUBE = 0
    jsr q_drain
    jsr frame_tick
ENDIF
    jmp sched
.exit
    jmp exit_body                   ; cold: lives past the dispatcher

.run_turtle
    sta st+1                        ; head handle = state address
    lda BHEADL,x
    sta st
    ldy #TL_LO                      ; pop: head = head.next
    lda (st),y
    sta BHEADL,x
    iny
    lda (st),y
    sta BHEADH,x
    bne headok
    sta BTAILH,x                    ; bucket now empty
.headok
    ldy #ST_TIME+2                  ; turtle due this frame?
    lda (st),y
    cmp frame
    bne frame_defer
    iny
    lda (st),y
    cmp frame+1
    beq frame_ok
.frame_defer                        ; due on a later lap of this bucket
    ldy #TL_LO                      ; our link = null
    lda #0
    sta (st),y
    iny
    sta (st),y
    lda DEFH+1
    bne defer_tail
    lda st                          ; deferred list empty
    sta DEFH
    sta DEFT
    lda st+1
    sta DEFH+1
    sta DEFT+1
    jmp sched
.defer_tail
    lda DEFT                        ; old tail -> us
    sta RA
    lda DEFT+1
    sta RA+1
    ldy #TL_LO
    lda st
    sta (RA),y
    sta DEFT
    iny
    lda st+1
    sta (RA),y
    sta DEFT+1
    jmp sched
.frame_ok
    lda (st)                        ; ip = state pc
    sta ip
    ldy #1
    lda (st),y
    sta ip+1
    ldy #ST_HEIGHT                  ; restore stack height; evx runs biased
    lda (st),y                      ; by ST_LOCALS so push/pop index directly
    clc
    adc #ST_LOCALS
    sta evx
    ; fall through to dispatcher

; ============================================================================
; Dispatcher
; ============================================================================
.next_op                            ; direct dispatch: constants (bit 7)
    lda (ip)                        ; short-circuit; the rest go through an
    inc ip                          ; interleaved word table via the 65C02
    bne next_go                     ; jmp (abs,x)
    inc ip+1
.next_go
    sta opsave
    cmp #&80                        ; (inc ip trashed N — test A, not flags)
    bcs next_const
    asl a
    tax
    jmp (dtab,x)
.next_const
    jmp op_const

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
.push_RA                            ; turtle stack lives in the state block;
    ldy evx                         ; evx is pre-biased by ST_LOCALS, so it
    lda RA                          ; indexes (st),y directly and the four
    sta (st),y                      ; inys advance it for free
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
    sty evx
    rts

.pop_RA
    lda evx
    sec
    sbc #4
    sta evx
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
.op_const
    lda opsave                      ; &80 + index
    and #&7F
    cmp #126                        ; big-constant escape
    bcs const_big
    tax
    lda cst_lo,x                    ; precomputed rose_constants + i*4
    sta ptr
    lda cst_hi,x
    sta ptr+1
.const_load
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
    ldy evx                         ; push_RA inlined
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
    sty evx
    jmp next_op
.const_big                          ; index = 126 + next byte
    stz ptr+1
    jsr fetch
    clc
    adc #126
    bcc const_cb
    inc ptr+1
.const_cb
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
    bra const_load

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
    ldy evx                         ; push_RA inlined
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
    sty evx
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

.op_op                              ; binary op, fused in place: a (top) OP
    lda evx                         ; b (below); the result overwrites b's
    sec                             ; slot, one net pop
    sbc #4
    sta evx
    tay
    lda (st),y                      ; a (the old top) -> RA
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
    lda evx
    sec
    sbc #4
    tay                             ; Y -> b, which becomes the result
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
    and #3                          ; nibbles 2/6 (ROXR/ROXL): absent
    cmp #2                          ; upstream too, still unimplemented
    beq op_op_bad
    jmp op_shift
.op_op_bad
    jmp err_unimpl
.do_add
    clc
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
    jmp next_op
.do_sub                             ; a - b
    sec
    lda RA
    sbc (st),y
    sta (st),y
    iny
    lda RA+1
    sbc (st),y
    sta (st),y
    iny
    lda RA+2
    sbc (st),y
    sta (st),y
    iny
    lda RA+3
    sbc (st),y
    sta (st),y
    jmp next_op
.do_and
    lda (st),y
    and RA
    sta (st),y
    iny
    lda (st),y
    and RA+1
    sta (st),y
    iny
    lda (st),y
    and RA+2
    sta (st),y
    iny
    lda (st),y
    and RA+3
    sta (st),y
    jmp next_op
.do_or
    lda (st),y
    ora RA
    sta (st),y
    iny
    lda (st),y
    ora RA+1
    sta (st),y
    iny
    lda (st),y
    ora RA+2
    sta (st),y
    iny
    lda (st),y
    ora RA+3
    sta (st),y
    jmp next_op

; Shifts and rotates (OP nibbles 0/1/3/4/5/7), semantics exactly as the
; visualizer's interpret.h: count = (right >> 16) & 63 (& 31 for rotates);
; ASL/LSL << count (0 when count >= 32), LSR logical >> (0 when >= 32),
; ASR arithmetic >> (-1 when >= 32, regardless of sign), ROR/ROL 32-bit
; circular. Value = RA (the old top = left operand); result overwrites the
; below slot at Y like every other op_op path. Rare ops: looped, cold.
.op_shift
    iny
    iny
    lda (st),y                      ; (right >> 16) low byte
    dey
    dey
    and #63
    sta zres                        ; count
    lda opsave
    and #15
    cmp #3
    beq sh_ror
    cmp #7
    beq sh_rol
    ldx zres
    beq sh_store                    ; count 0: value unchanged
    cpx #32
    bcs sh_sat
    cmp #0                          ; OP_ASR
    beq sh_asr
    cmp #1                          ; OP_LSR
    beq sh_lsr
.sh_asl                             ; OP_ASL / OP_LSL (identical on 32 bits)
    asl RA
    rol RA+1
    rol RA+2
    rol RA+3
    dex
    bne sh_asl
    bra sh_store
.sh_lsr
    lsr RA+3
    ror RA+2
    ror RA+1
    ror RA
    dex
    bne sh_lsr
    bra sh_store
.sh_asr
    lda RA+3
    cmp #&80                        ; carry = sign bit
    ror RA+3
    ror RA+2
    ror RA+1
    ror RA
    dex
    bne sh_asr
    bra sh_store
.sh_sat                             ; count >= 32 saturates
    cmp #0
    beq sh_neg1                     ; ASR -> -1 (interpret.h hardcodes it)
    stz RA
    stz RA+1
    stz RA+2
    stz RA+3
    bra sh_store
.sh_neg1
    lda #&FF
    sta RA
    sta RA+1
    sta RA+2
    sta RA+3
    bra sh_store
.sh_ror
    lda zres
    and #31
    beq sh_store
    tax
.sh_rorl
    lda RA
    lsr a                           ; carry = bit 0
    ror RA+3
    ror RA+2
    ror RA+1
    ror RA
    dex
    bne sh_rorl
    bra sh_store
.sh_rol
    lda zres
    and #31
    beq sh_store
    tax
.sh_roll
    lda RA+3
    asl a                           ; carry = bit 31
    rol RA
    rol RA+1
    rol RA+2
    rol RA+3
    dex
    bne sh_roll
.sh_store
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

.op_when                            ; pop value, branch by negated condition.
    lda evx                         ; fused pop: only sign + zero are needed,
    sec                             ; and ip only advances when not taken
    sbc #4
    sta evx
    tay
    lda (st),y
    iny
    ora (st),y
    iny
    ora (st),y
    sta zres
    iny
    lda (st),y                      ; byte 3: sign, and completes the OR
    tax
    ora zres
    sta zres                        ; 0 if zero
    txa
    and #&80
    sta sgn                         ; &80 if negative
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
    bra w_no
.w_eq
    lda zres
    beq take_branch
    bra w_no
.w_ge
    lda sgn
    beq take_branch
    bra w_no
.w_lt
    lda sgn
    bne take_branch
    bra w_no
.w_gt
    lda sgn
    bne w_no
    lda zres
    bne take_branch
.w_no
    clc                             ; not taken: skip the 2 target bytes
    lda ip
    adc #2
    sta ip
    bcc w_nx
    inc ip+1
.w_nx
    jmp next_op
.w_le
    lda sgn
    bne take_branch
    lda zres
    beq take_branch
    bra w_no
.take_branch
    lda (ip)                        ; ip still points at the target bytes
    tax
    ldy #1
    lda (ip),y
    sta ip+1
    stx ip
    jmp next_op

.op_else                            ; unconditional jump
    jsr fetch
    sta ptr
    jsr fetch
    sta ip+1
    lda ptr
    sta ip
    jmp next_op

.op_proc                            ; push proc address (1-byte index into
    jsr fetch                       ; proctab — 3 bytes/op saved over inline
    tax                             ; addresses; ~1KB on the big demos)
    lda proctab_lo,x
    sta RA
    lda proctab_hi,x
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
    ; per-record hash: h = rol32(h,1) ^ byte over the 10 bytes, fully
    ; unrolled. h starts at 0, so the first step is just h = REC[0].
    ; RB (free during DRAW) holds h in zero page.
    lda REC
    sta RB
    stz RB+1
    stz RB+2
    stz RB+3
FOR k, 1, 9
    asl RB
    rol RB+1
    rol RB+2
    rol RB+3
    lda RB
    adc #0                          ; carry (old bit 31) into bit 0
    eor REC+k
    sta RB
NEXT
    clc                             ; checksum += hash (order-independent)
    lda LOGCHK
    adc RB
    sta LOGCHK
    lda LOGCHK+1
    adc RB+1
    sta LOGCHK+1
    lda LOGCHK+2
    adc RB+2
    sta LOGCHK+2
    lda LOGCHK+3
    adc RB+3
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
    jsr sort_add                    ; stage the wire record for this frame
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
    lda evx                         ; un-bias for the stored height
    sec
    sbc #ST_LOCALS
    sta (st),y
    ldy #ST_TIME+2                  ; bucket = frame low byte
    lda (st),y
    tax
    lda st
    sta APTR
    lda st+1
    sta APTR+1
    jsr append
    jmp sched
.wait_done
    jmp next_op

.op_end
    jsr free_cur
    jmp sched

.op_fork                            ; stack: [args..., proc] (proc on top)
    jsr pop_RA                      ; proc address
    jsr alloc                       ; ptr = child state (the handle)
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
    tax
    lda ptr
    sta APTR
    lda ptr+1
    sta APTR+1
    jsr append
    inc TCNT
    bne fork_done
    inc TCNT+1
.fork_done
    jmp next_op

; ============================================================================
; MOVE — exact replica of interpret.h caseAMoveStatement
; ============================================================================
.op_move
    jsr pop_RA                      ; m stays in RA (sinlook only uses ptr)

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
    clc                             ; s = m + &00200000 (M1 is scratch here)
    lda RA+2
    adc #&20
    sta M1
    lda RA+3
    adc #0
    bne move_hd                     ; s byte3 != 0 -> high distance
    lda M1
    cmp #&40
    bcs move_hd                     ; s >= &400000 -> high distance
    ora RA+1
    ora RA                          ; s == 0 (m == -32.0 exactly) -> hd
    beq move_hd
    ; high precision: val16 = (m >> 6) & &FFFF, product >> 8
    lda #1
    sta HPFLAG
    lda RA                          ; (bytes 2:1:0 << 2), take top two
    sta PR
    lda RA+1
    sta PR+1
    lda RA+2
    sta PR+2
    bra move_val
.move_hd
    ; high distance: val16 = (m >> 14) & &FFFF, product used as-is
    stz HPFLAG
    lda RA+1
    sta PR
    lda RA+2
    sta PR+1
    lda RA+3
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
; smul16: PR = M1 * M2, signed 16x16 -> 32. Preserves M1/M2.
; ============================================================================
.smul16
    jsr umul16
    ; sign corrections
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

; umul16: PR = M1 * M2 unsigned, quarter-square tables (~215 cycles vs ~770
; for the old shift-add loop). a*b = f(a+b) - f(a-b) with f(n) = n^2/4:
; sq1[i] = f(i), sq2[i] = f(i-255), so with a pointer at table+a,
; (sq1+a),b = f(a+b) and (sq2+a),~b = f(a-b). Preserves M1/M2.
.umul16
    lda M1                          ; point the four tables at al
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
    ldy M2                          ; P0 = al*bl -> PR 0:1
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
    ldy M2+1                        ; P1 = al*bh -> MT1
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
    lda M1+1                        ; repoint at ah
    sta MS1L
    sta MS1H
    sta MS2L
    sta MS2H
    ldy M2                          ; P2 = ah*bl -> MT2
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
    ldy M2+1                        ; P3 = ah*bh -> PR 2:3
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
    clc                             ; PR += (MT1 + MT2) << 8
    lda MT1
    adc MT2
    sta MT1
    lda MT1+1
    adc MT2+1
    sta MT1+1
    lda #0
    adc #0
    sta MT2                         ; bit 16 of the mid sum
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
.alloc                              ; -> ptr = state base (the handle)
    lda FREEH+1
    bne alloc_ok
    jmp err_nofree
.alloc_ok
    sta ptr+1
    lda FREEH
    sta ptr
    ldy #TL_LO                      ; freeh = freeh.next
    lda (ptr),y
    sta FREEH
    iny
    lda (ptr),y
    sta FREEH+1
    rts

.free_cur                           ; free the current turtle (st)
    ldy #TL_LO
    lda FREEH
    sta (st),y
    iny
    lda FREEH+1
    sta (st),y
    lda st
    sta FREEH
    lda st+1
    sta FREEH+1
    lda TCNT
    bne free_dec
    dec TCNT+1
.free_dec
    dec TCNT
    rts

.append                             ; APTR = handle, X = bucket
    ldy #TL_LO                      ; new tail's link = null
    lda #0
    sta (APTR),y
    iny
    sta (APTR),y
    lda BTAILH,x
    beq app_empty
    sta RA+1                        ; old tail -> new
    lda BTAILL,x
    sta RA
    ldy #TL_LO
    lda APTR
    sta (RA),y
    sta BTAILL,x
    iny
    lda APTR+1
    sta (RA),y
    sta BTAILH,x
    rts
.app_empty
    lda APTR
    sta BHEADL,x
    sta BTAILL,x
    lda APTR+1
    sta BHEADH,x
    sta BTAILH,x
    rts

.exit_body
    jsr flush_sorted                ; last frame's records first
    lda #&FF                        ; DONE record: &FF + count16 + chk32.
    jsr q_push_a                    ; the drain sets DONEFLAG when it sees it
    lda LOGCNT
    jsr q_push_a
    lda LOGCNT+1
    jsr q_push_a
    lda LOGCHK
    jsr q_push_a
    lda LOGCHK+1
    jsr q_push_a
    lda LOGCHK+2
    jsr q_push_a
    lda LOGCHK+3
    jsr q_push_a
IF TUBE = 0
    jsr q_drain
ENDIF
.spin
    jmp spin

.t4_consume                         ; next erase-class verdict bit, MSB
    ldy T4NB                        ; first: A = 0 drop / 1 keep (Z set)
    bne t4c_have
    lda (T4PTR)                     ; refill the shift register
    sta T4BYTE
    inc T4PTR
    bne t4c_p
    inc T4PTR+1
.t4c_p
    ldy #8
.t4c_have
    dey
    sty T4NB
    asl T4BYTE
    lda #0
    adc #0
    rts

.vdutab
    EQUB 23,1,0,0,0,0,0,0,0,0
IF WIDE = 1
.crtctab
    EQUB 1,88, 2,102, 6,29, 7,33
CRTCN = 8
ELIF WIDE = 2
.crtctab                            ; letterbox: 184 lines shown, centred
    EQUB 6,23, 7,30
CRTCN = 4
ENDIF


IF TUBE
.loadstr
    EQUS "LOAD HOST FFFF0E00", 13
.owblk                              ; OSWORD 6 block: host addr (32-bit) + byte
    EQUB &0E, &02, &FF, &FF, 0
.oswpoke                            ; write owblk+4 to host memory at owblk addr
    lda #6
    ldx #<owblk
    ldy #>owblk
    jmp OSWORD
ENDIF

IF TUBE
; ============================================================================
; Record push, Tube edition: bytes go straight into R1 (parasite -> host has
; a 24-byte FIFO). Backpressure is the flow control — a full FIFO blocks us
; until the host catches up.
; ============================================================================
.q_push_a                           ; append the byte in A (preserves X/Y)
    bit PTUBE_S1                    ; V = not-full
    bvc q_push_a
    sta PTUBE_D1
    rts

ELSE
; ============================================================================
; Record queue, producer side (future parasite). RA is free here: the hash
; is finished by push time and the interpreter is paused during a drain.
; ============================================================================
.q_setra                            ; RA = QBASE + QW
    clc
    lda #<QBASE
    adc QW
    sta RA
    lda #>QBASE
    adc QW+1
    sta RA+1
    rts

.q_push_a                           ; append the byte in A
    pha
    jsr q_setra
    pla
    sta (RA)
    inc QW
    bne qpa_done
    inc QW+1
.qpa_done
    rts

ENDIF

; ============================================================================
; Frame stage: sort_add stores REC as an 8-byte entry (next + wire record);
; flush_sorted emits all staged records through q_push_a in stable (y - r)
; bucket order. Single-CPU build pages SWRAM bank 6 around stage access.
; ============================================================================
.sa_drop
    rts
.sort_add
    lda REC+7                       ; negative radius never renders: drop
    bmi sa_drop
    bne sa_clamp                    ; clamp radius to MAXRADIUS in REC
    lda REC+6                       ; (already hashed/logged, so REC is
    cmp #MAXRADIUS+1                ; scratch now)
    bcc sa_cull
.sa_clamp
    lda #MAXRADIUS
    sta REC+6
    stz REC+7
    ; Erase-class records (tint & 7 == 4: layer-1 transparent, flattened to
    ; erase-everything) consume one verdict bit from the t4mask stream —
    ; BEFORE the offscreen cull so ordinals match rose2bbc's enumeration.
    ; c >= 0: tint & 7 == 4; c < 0 (square, c = ~tint): c & 7 == 3.
    lda REC+8
    and #7
    ldx REC+9
    bmi sa_t4s
    cmp #4
    bne sa_cull
    bra sa_t4go
.sa_t4s
    cmp #3
    bne sa_cull
.sa_t4go
    jsr t4_consume
    beq sa_drop                     ; drop: erased an empty layer 1 upstream
.sa_cull
    ; whole-blob cull: fully offscreen records (16-47% in the Painters
    ; demos) never reach the stage, the wire, or the host
    clc                             ; y + r < YOFF -> off the top
    lda REC+4
    adc REC+6
    tax
    lda REC+5
    adc #0
    tay
    txa
    sec
    sbc #YOFF
    tya
    sbc #0
    bmi sa_drop
    sec                             ; y - r >= YOFF+SCRH -> off the bottom
    lda REC+4
    sbc REC+6
    tax
    lda REC+5
    sbc #0
    tay
    txa
    sec
    sbc #<(YOFF+SCRH)
    tya
    sbc #>(YOFF+SCRH)
    bpl sa_drop
    clc                             ; x + r < XOFF -> off the left
    lda REC+2
    adc REC+6
    tax
    lda REC+3
    adc #0
    tay
    txa
    sec
    sbc #XOFF
    tya
    sbc #0
    bmi sa_drop2
    sec                             ; x - r >= XOFF+SCRW -> off the right
    lda REC+2
    sbc REC+6
    tax
    lda REC+3
    sbc #0
    tay
    txa
    sec
    sbc #<(XOFF+SCRW)
    tya
    sbc #>(XOFF+SCRW)
    bmi sa_keep
.sa_drop2
    rts
.sa_keep
IF TUBE = 0
    lda #6                          ; stage lives in bank 6
    sta &FE30
ENDIF
    lda NREC                        ; stage full? flush mid-frame (never in
    cmp #PBMAX                      ; practice: max measured 146/frame)
    bcc sa_room
    jsr flush_sorted
IF TUBE = 0
    lda #6
    sta &FE30
ENDIF
.sa_room
    lda PBW
    sta RA
    lda PBW+1
    sta RA+1
    ldy #7
    lda REC+6                       ; r (clamped above)
    sta (RA),y
    ldy #6                          ; entry+3..6 = x lo, x hi, y lo, y hi
.sa_xy
    lda REC-1,y
    sta (RA),y
    dey
    cpy #2
    bne sa_xy
    lda REC+9                       ; tag from c: negative c = square
    bpl sa_circ
    lda REC+8
    eor #&FF
    and #15
    ora #16                         ; square flag
    bra sa_tag
.sa_circ
    lda REC+8
    and #15
.sa_tag
    ldy #2
    sta (RA),y
    clc                             ; PBW += 8
    lda PBW
    adc #8
    sta PBW
    bcc sa_cnt
    inc PBW+1
.sa_cnt
    inc NREC
IF TUBE = 0
    lda #7                          ; interpreter bank back
    sta &FE30
ENDIF
.sa_rts
    rts

.flush_sorted                       ; emit staged records in (y-r) order
    lda NREC
    bne so_go
    rts
.so_go
    lda ip                          ; ip doubles as the chain pointer here;
    pha                             ; only live on a mid-frame overflow flush
    lda ip+1
    pha
IF TUBE = 0
    lda #6
    sta &FE30
ENDIF
    stz PPASS
    stz P1F                         ; set if any record needs pass 1
.so_pass                            ; (bucket heads are already clear: init
                                    ; clears them once, the emit scan clears
                                    ; as it consumes)
    lda #<PBUF                      ; walk the stage, filing this pass keys
    sta RB
    lda #>PBUF
    sta RB+1
.so_walk
    lda RB
    cmp PBW
    bne so_ent
    lda RB+1
    cmp PBW+1
    bne so_ent
    jmp so_render
.so_ent
    ldy #7                          ; key = y - r + 140
    lda (RB),y
    sta KLO
    sec
    lda #140
    sbc KLO
    sta KLO
    clc
    ldy #5
    lda (RB),y
    adc KLO
    sta KLO
    iny
    lda (RB),y
    adc #0
    beq so_class                    ; 0..255: bucket KLO, pass 0
    bmi so_neg                      ; far above the screen: bucket 0, pass 0
    cmp #1
    beq so_p1                       ; 256..511: bucket KLO, pass 1
    lda #&FF                        ; >= 512 (invisible): bucket 255, pass 1
    sta KLO
.so_p1
    lda #1
    sta P1F
    bra so_class
.so_neg
    stz KLO
    lda #0
.so_class
    cmp PPASS
    bne so_next                     ; not this pass
    ldx KLO
    ldy #1                          ; entry.next = null
    lda #0
    sta (RB),y
    lda BKHH,x                      ; head decides new-vs-append (tails may
    beq so_bnew                     ; be stale — heads are the cleared truth)
    lda BKTH,x
    sta KHI                         ; old tail -> this entry
    lda BKTL,x
    sta ip
    lda KHI
    sta ip+1
    lda RB
    sta (ip)
    sta BKTL,x
    ldy #1
    lda RB+1
    sta (ip),y
    sta BKTH,x
    bra so_next
.so_bnew
    lda RB
    sta BKHL,x
    sta BKTL,x
    lda RB+1
    sta BKHH,x
    sta BKTH,x
.so_next
    clc
    lda RB
    adc #8
    sta RB
    bcc so_wj
    inc RB+1
.so_wj
    jmp so_walk
.so_render
    ldx #0
.so_bloop
    lda BKHH,x
    beq so_bnext
    stz BKHH,x                      ; consume: heads stay clean for next frame
    sta ip+1
    lda BKHL,x
    sta ip
.so_chain
    ldy #2                          ; push the 6 wire bytes (q_push_a
.so_pb
    lda (ip),y                      ; preserves X and Y)
    jsr q_push_a
    iny
    cpy #8
    bne so_pb
IF TUBE = 0
    lda QW                          ; queue nearly full? drain (in order)
    cmp #<QHIGH
    lda QW+1
    sbc #>QHIGH
    bcc so_nodrain
    phx                             ; q_drain clobbers X, RA/RB and the banks
    lda RB
    pha
    lda RB+1
    pha
    jsr q_drain
    pla
    sta RB+1
    pla
    sta RB
    plx
    lda #6
    sta &FE30
.so_nodrain
ENDIF
    ldy #1                          ; follow the chain
    lda (ip),y
    sta KHI
    lda (ip)
    sta ip
    lda KHI
    sta ip+1
    bne so_chain
.so_bnext
    inx
    bne so_bloop
    inc PPASS                       ; two passes: keys 0-255, then 256-511
    lda PPASS
    cmp #2
    beq so_done
    lda P1F                         ; nothing filed for pass 1? done
    beq so_done
    jmp so_pass
.so_done
    lda #<PBUF                      ; stage empty again
    sta PBW
    lda #>PBUF
    sta PBW+1
    stz NREC
IF TUBE = 0
    lda #7                          ; interpreter bank back
    sta &FE30
ENDIF
    pla
    sta ip+1
    pla
    sta ip
    rts
IF TUBE = 0
INCLUDE "tick.inc.asm"
ENDIF


; ============================================================================
; Errors (BRK returns to BASIC with visible message; on the parasite the
; OS is gone, so errors just spin — the harness detects the stall)
; ============================================================================
IF TUBE
.err_unimpl
.err_nofree
.err_frame
    jmp err_unimpl
ELSE
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
ENDIF

; ============================================================================
; Tables
; ============================================================================

; ============================================================================
; Record queue, consumer side — the future HOST render loop. Pages LYNNE in
; once for the whole batch, parses wire records into REC and calls the
; renderer, then restores the state bank for the interpreter.
; RA = read pointer, RB = end pointer (both free during a drain).
; ============================================================================
IF TUBE = 0
.q_drain
    lda QW
    ora QW+1
    bne qd_go
    rts                             ; empty
.qd_go
    lda ACCCON                      ; page in the shadow screen
    ora #4
    sta ACCCON
    lda #<QBASE
    sta RA
    clc
    adc QW
    sta RB
    lda #>QBASE
    sta RA+1
    adc QW+1
    sta RB+1
.qd_loop
    lda RA
    cmp RB
    bne qd_more
    lda RA+1
    cmp RB+1
    beq qd_done
.qd_more
    lda (RA)                        ; tag byte
    sta QTAG
    inc RA
    bne qd_tag
    inc RA+1
.qd_tag
    lda QTAG
    bmi qd_ctrl
    ldy #3                          ; draw record: x, y into REC+2..5
.qd_xy
    lda (RA),y
    sta REC+2,y
    dey
    bpl qd_xy
    ldy #4
    lda (RA),y                      ; radius (pre-clamped)
    sta REC+6
    stz REC+7
    clc                             ; advance past the 5 payload bytes
    lda RA
    adc #5
    sta RA
    bcc qd_c
    inc RA+1
.qd_c
    lda QTAG                        ; rebuild c for render_blob
    and #16
    beq qd_circ
    lda QTAG
    and #15
    eor #&FF
    sta REC+8
    lda #&FF
    sta REC+9
    bra qd_draw
.qd_circ
    lda QTAG
    and #15
    sta REC+8
    stz REC+9
.qd_draw
    jsr render_blob
    bra qd_loop
.qd_ctrl
    cmp #&FF
    beq qd_fin
    jmp qd_loop                     ; END FRAME: pacing stays in the main loop
.qd_fin
    ldy #5                          ; DONE: count16 + chk32 -> log header
.qd_fcopy
    lda (RA),y
    sta LOGCNT,y
    dey
    bpl qd_fcopy
    clc
    lda RA
    adc #6
    sta RA
    bcc qd_ff
    inc RA+1
.qd_ff
    lda #&FF                        ; run complete
    sta DONEFLAG
    jmp qd_loop
.qd_done
    stz QW
    stz QW+1
    lda ACCCON
    and #&FB
    sta ACCCON
    lda #7                          ; state bank back for the interpreter
    sta &FE30
    rts
ENDIF
IF TUBE = 0
INCLUDE "render.inc.asm"
ENDIF

ALIGN &100
.sine_quarter
INCBIN "sine_quarter.bin"

; Quarter-square multiply tables: f(n) = n^2/4. sq1[i] = f(i) for i 0..511;
; sq2[i] = f(i-255) so that, with a pointer offset by operand byte a,
; index ~b (= 255-b) yields f(a-b). floor works exactly: (a+b)^2 and
; (a-b)^2 are congruent mod 4. Interpreter-only, so above &3000 is fine.
IF TUBE
sq1_lo = &0500              ; generated at init (see sqgen) — the parasite
sq1_hi = &0700              ; image is the scarce resource
ELSE
ALIGN &100
.sq1_lo
FOR i, 0, 511
    EQUB <((i*i) DIV 4)
NEXT
.sq1_hi
FOR i, 0, 511
    EQUB >((i*i) DIV 4)
NEXT
ENDIF
ALIGN &100
.sq2_lo
FOR i, 0, 511
    EQUB <(((i-255)*(i-255)) DIV 4)
NEXT
.sq2_hi
FOR i, 0, 511
    EQUB >(((i-255)*(i-255)) DIV 4)
NEXT

; Dispatch tables (interpreter runs with main RAM paged, so above &3000 is fine)
.dtab                               ; opcodes 0-127 (consts short-circuit in
    EQUW err_unimpl, op_else, op_end, op_rand
    EQUW op_draw, op_tail, op_plot, op_proc
    EQUW op_pop, op_div, op_wait, op_sine
    EQUW op_seed, op_neg, op_move, op_mul
FOR n, 0, 15
    EQUW op_when
NEXT
FOR n, 0, 15
    EQUW op_fork
NEXT
FOR n, 0, 15
    EQUW op_op
NEXT
FOR n, 0, 15
    EQUW op_wlocal
NEXT
FOR n, 0, 15
    EQUW op_wstate
NEXT
FOR n, 0, 15
    EQUW op_rlocal
NEXT
FOR n, 0, 15
    EQUW op_rstate
NEXT

.rose_data_start
; Small-constant address tables: rose_constants + i*4 for the 126 inline
; indices (big-constant escapes fall back to the shift path).
.cst_lo
FOR i, 0, 125
    EQUB <(rose_constants + i*4)
NEXT
.cst_hi
FOR i, 0, 125
    EQUB >(rose_constants + i*4)
NEXT

INCLUDE "rose_data.asm"
IF TUBE = 0
INCLUDE "colorscript.asm"           ; single-CPU: colorscript lives with CODE
ENDIF
.rose_data_end                      ; plot prefix log grows from here

IF TUBE
PRINT "SYM rose_data_end", ~rose_data_end, "SORTBASE", ~SORTBASE
ASSERT rose_data_end <= SORTBASE    ; code+data must fit below the frame stage
SAVE "PARA", &E00, rose_data_end, entry
ELSE
PUTFILE "spans4.bin", "SPANS4", 0
PUTFILE "spans5.bin", "SPANS5", 0
PUTFILE "circles.bin", "CIRCS", 0
PUTTEXT "boot.txt", "!BOOT", 0
SAVE "CODE", &E00, rose_data_end, entry
ENDIF

; Region boundary symbols for bbc/tools/profile.mjs (parsed from beebasm.log).
PRINT "SYM entry", ~entry
PRINT "SYM sched", ~sched
PRINT "SYM emit_rec", ~emit_rec
PRINT "SYM rec_done", ~rec_done
PRINT "SYM build_rec", ~build_rec
PRINT "SYM op_wait", ~op_wait
PRINT "SYM err_unimpl", ~err_unimpl
IF TUBE = 0
PRINT "SYM frame_tick", ~frame_tick
PRINT "SYM vsync_wait", ~vsync_wait
PRINT "SYM cs_loop", ~cs_loop
PRINT "SYM timer_init", ~timer_init
PRINT "SYM q_drain", ~q_drain
PRINT "SYM render_blob", ~render_blob
PRINT "SYM ctab", ~ctab
ENDIF
; Fine-grained boundaries for bbc/tools/opprofile.mjs (per-handler cycles).
PRINT "SYM do_tick", ~do_tick
PRINT "SYM run_turtle", ~run_turtle
PRINT "SYM next_op", ~next_op
PRINT "SYM fetch", ~fetch
PRINT "SYM push_RA", ~push_RA
PRINT "SYM pop_RA", ~pop_RA
PRINT "SYM pop_RB", ~pop_RB
PRINT "SYM op_const", ~op_const
PRINT "SYM op_rstate", ~op_rstate
PRINT "SYM op_wstate", ~op_wstate
PRINT "SYM op_rlocal", ~op_rlocal
PRINT "SYM op_wlocal", ~op_wlocal
PRINT "SYM op_op", ~op_op
PRINT "SYM op_neg", ~op_neg
PRINT "SYM op_pop", ~op_pop
PRINT "SYM op_when", ~op_when
PRINT "SYM op_else", ~op_else
PRINT "SYM op_proc", ~op_proc
PRINT "SYM op_tail", ~op_tail
PRINT "SYM op_plot", ~op_plot
PRINT "SYM op_draw", ~op_draw
PRINT "SYM op_end", ~op_end
PRINT "SYM op_fork", ~op_fork
PRINT "SYM op_move", ~op_move
PRINT "SYM sinlook", ~sinlook
PRINT "SYM smul16", ~smul16
PRINT "SYM umul16", ~umul16
PRINT "SYM op_mul", ~op_mul
PRINT "SYM op_div", ~op_div
PRINT "SYM op_rand", ~op_rand
PRINT "SYM op_seed", ~op_seed
PRINT "SYM op_sine", ~op_sine
PRINT "SYM alloc", ~alloc
PRINT "SYM append", ~append
PRINT "SYM free_cur", ~free_cur
PRINT "SYM wait_sched", ~wait_sched
PRINT "SYM sort_add", ~sort_add
PRINT "SYM flush_sorted", ~flush_sorted
PRINT "SYM q_push_a", ~q_push_a
