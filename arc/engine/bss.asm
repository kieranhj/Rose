; ============================================================================
; BSS Segment
; TODO: Figure out vlink so can hack off BSS segment from binary!!
; ============================================================================

.include "roseconfig.h.asm"

.bss

.global r_StateLists
.global r_StateSpace
.global r_StateSpaceEnd
.global r_Sinus
.global reciprocal_table
.global r_CircleBuffer
.global r_circleBufEnd
.global r_CircleBufPtrs
.global gen_code_pointers
.global gen_code_start

r_StateLists:
    .skip	(MAX_FRAMES+MAX_WAIT)*4

r_StateSpace:
    .skip	(MAX_TURTLES+1)*STATE_SIZE
r_StateSpaceEnd:

r_Sinus:
    .skip	(DEGREES)*4

reciprocal_table:
.if MakeReciprocalTable
	.skip	(1<<16)*4
.else
.long 0
.set divisor, 1
.rept 65535
    .long (1<<24)/divisor
    .set divisor, divisor+1
.endr
.endif

r_CircleBuffer:
	.skip	(MAX_CIRCLES)*(CIRCLEDATA+1)*4
r_circleBufEnd:

r_CircleBufPtrs:
	.skip	(Screen_Height)*4

gen_code_pointers:
	.skip	4*8*MAXSPAN

gen_code_start:

; ============================================================================
