; ============================================================================
; BSS Segment
; TODO: Figure out vlink so can hack off BSS segment from binary!!
; ============================================================================

.include "roseconfig.asm"

.bss

r_StateLists:
    .skip	(MAX_FRAMES+MAX_WAIT)*4

r_StateSpace:
    .skip	(MAX_TURTLES+1)*STATE_SIZE
r_StateSpaceEnd:

r_Sinus:
    .skip	(DEGREES)*4

r_CircleBuffer:
	.skip	(MAX_CIRCLES)*(CIRCLEDATA+1)*4
r_circleBufEnd:

r_CircleBufPtrs:
	.skip	(Screen_Height)*4

gen_code_pointers:
	.skip	4*8*MAXSPAN

gen_code_start:
