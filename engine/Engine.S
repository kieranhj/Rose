;              T         T               T

	include	Rose:Circles.S


; Saved state:
; Next
; State
; Stack...

; Engine registers:
; D0 = Top of stack
; A0 = Sinus
; A3 = Stack
; A4 = Proc/const
; A5 = State

BC_PROC	=	$07
MIN_INPUT	=	$08
MAX_INPUT	=	$5F
SINGLE_SNIP	=	6
END_OF_SCRIPT	=	$FF
BIG_CONSTANT_BASE =	126


	section	Code,code

RunFrame:
	; A6 = Rose Space
	; D7 = Frame
	move.l	r_Sinus(a6),a0			; a0 = p_Sinus = &r_Sinus
	move.l	r_Constants(a6),a4		; a4 = p_Constants = &r_Constants
.frame:
	move.l	d7,d0					; d0 = r_FrameCounter
	lsl.l	#2,d0					; d0 *= 4
	lea	r_StateLists(a6),a1			; a1 = &r_StateLists
	add.l	d0,a1					; a1 = p_StateList = &r_StateLists[FrameCounter * 4]
	tst.l	(a1)					; if *p_StateList == 0
	beq.b	.done					;   goto done
	move.l	(a1),a3					; a3 = *p_StateList = p_StateStack
	move.l	(a3)+,(a1)				; *pStateList = *p_StateStack++			; set ptr to next turle for this frame.
	move.l	(a3)+,a5				; a5 = p_State = *p_StateStack++		; pop state ptr
	move.l	(a5),a1 ; st_proc		; a1 = *p_State.st_proc					; deref procedure address
	jsr	(a1)						; jsr *p_State.st_proc					; jsr to procedure
	bra.b	.frame					; goto frame
.done:	rts							; return


InitStates:
	; A6 = Rose Space (all RAM required for RoseSpace.S)
	move.l	a6,a1					; a1 = &r_RoseSpace
	add.l	#r_StateSpace,a1		; a1 = pState = &r_StateSpace[0]
	move.w	#MAX_TURTLES-1,d7		; d7 = MAX_TURTLES-1
.state:	lea.l	STATE_SIZE(a1),a2	; a2 = p_NextState = p_State + STATE_SIZE
	move.l	a1,(a2)					; *p_NextState = p_State
	move.l	a2,a1					; p_State = p_NextState
	dbf	d7,.state					; if d7 != -1 then goto state
;	move.l	a2,r_FreeState(a6)

InitMainTurtle:
	move.l	a6,a1					; a1 = &r_RoseSpace
	add.l	#r_Instructions,a1		; a1 = &r_Instructions
;	move.l	r_FreeState(a6),a2
	move.l	(a2),r_FreeState(a6)	; r_FreeState = *pState = p_PrevState
	move.l	a1,(a2)					; *p_State = &r_Instructions
									; *p_State.st_proc = &r_Instructions
	if	USERANDOM
	move.l	#$BABEFEED,st_rand(a2)	; *p_State.st_rand = $BABEFEED
	endc
	move.l	a2,d2					; d2 = p_State = p_StateStack
	move.l	d2,-(a2)				; *(--p_StateStack) = p_State				; push new state ptr onto stack for frame 0
	lea	r_StateLists(a6),a1			; a1 = p_FrameList = &r_StateLists[0]		; 
	move.l	(a1),-(a2)				; *(--p_StateStack) = *p_FrameList			; push previous state ptr for frame 0 onto stack
	move.l	a2,(a1)					; *p_FrameList = p_StateStack				; set head of state list for frame 0 to state stack ptr
	rts

InitEngine:
	; A6 = Rose Space

TranslateBytecode:
	move.l	r_Bytecode(a6),a0			; a0 = p_Bytecode = &r_Bytecode
	lea.l	r_Procedures(a6),a4			; a4 = p_Procedures = &r_Procedures
	move.l	a6,a1						; 
	add.l	#r_Instructions,a1			; a1 = p_Instructions = &r_Instructions

	clr.w	d1							; d1 = 0
.procloop:
	cmp.b	#END_OF_SCRIPT,(a0)			; *p_Bytecode == END_OF_SCRIPT?
	beq.b	InitStates					; 	goto InitStates
	move.l	a1,(a4)+	; Write proc address	; *p_Procedures++ = p_Instructions
.instloop:
	cmp.b	#MIN_INPUT,(a0)				; if *p_Bytecode < 0x08
	blo.b	.noinput					;	goto noInput
	cmp.b	#MAX_INPUT+1,(a0)			; if *p_Bytecode < 0x60
	blo.b	.input						; 	goto Input
.noinput:
	lsr.b	#1,d1						; d1 = d1 >> 1
	bcc.b	.nopush						; if carry == 0 goto nopush
	move.w	#$2700,(a1)+				; *p_Instructions++ = 'move.l d0,-(a3)' = *--p_StateStack
.nopush:	bra.b	.nopop				; goto nopop
.input:
	lsr.b	#1,d1						; d1 = d1 >> 1
	bcs.b	.nopop						; if carry == 1 goto nopop
	move.w	#$201B,(a1)+				; *p_Instructions++ = 'move.l (a3)+,d0' = *p_StateStack++
.nopop:
	clr.w	d0							; d0 = 0
	move.b	(a0)+,d0					; d0 = *p_Bytecode++
	bmi.b	.const						; if d0 >= 0x80 goto const

	moveq.l	#$F,d1						; d1 = $F
	and.b	d0,d1						; d1 = d0 & $F
	lsr.b	#4,d0						; d0 = d0 >> 4
	bne.b	.notsingle					; if d0 != 0 goto notsingle (i.e. bytecode >= 0x10)
	subq.b	#2,d1						; d1 -= 2
	bhs.b	.single						; if d1 >= 0 goto single (i.e. bytecode >= BC_END)
	; Get jump target
	move.l	(a7)+,a2					; a2 = *sp++ (i.e. a2 = bra_ptr)
	addq.b	#2,d1						; d1 += 2
	beq.b	.done						; if d1 == 0 goto done (i.e. bytecode == BC_DONE)
; BC_ELSE
	; Put jump
	move.w	#$6000,d1					; d1 = $6000 'bra'
	move.w	d1,(a1)+					; *p_Instructions++ = 'bra'
	move.l	a1,-(a7)					; *--sp = p_Instructions (i.e. push bra_ptr)
	clr.w	(a1)+						; *p_Instructions++ = 0
.done:	; Put jump offset
	move.w	a1,d2						; d2 = p_Instructions
	sub.w	a2,d2						; d2 -= a2
	move.w	d2,(a2)						; *(a2) = d2 (i.e. *bra_ptr = goto pc)
	bra.b	.instloop					; goto instloop
.single:
	move.b	d1,d0						; d0 = d1
	addq.b	#SINGLE_SNIP,d0				; d0 += 0x06
	bsr.b	PutSnip						; jsr PutSnip
	tst.b	d1							; if d1 == 0 (i.e. if bytecode == BC_END)
	beq.b	.procloop					; 	goto procloop
	cmp.b	#BC_PROC-2,d1				; if d1 != BC_PROC-2 (i.e. if bytecode != BC_PROC)
	bne.b	.instloop					;	goto instloop
; BC_PROC
	move.b	(a0)+,d0					; d0 = *p_Bytecode++
	lsl.w	#2,d0						; d0 *= 4
	add.w	d0,-2(a1)					; *p_Instructions += d0 (i.e. write 'proc_no * 4' into Snip_proc)
	bra.b	.instloop					; goto instloop
.notsingle:
	subq.b	#2,d0						; d0 -= 2
	bhs.b	.notwhen					; if d0 >= 0 goto notwhen (i.e. bytecode >= BC_FORK)
; BC_WHEN
	; Put condition into second highest nibble of branch word
	; 6 = ne, 7 = eq, 12 = ge, 13 = lt, 14 = gt, 15 = le
	ror.w	#8,d1
	or.w	#$6000,d1					; d1 = 'br<cond>'
	move.w	d1,(a1)+					; *pInstructions++ = 'br<cond>'
	move.l	a1,-(a7)					; *--sp = p_Instructions (i.e. push bra_ptr)
	clr.w	(a1)+						; *pInstructions++ = 0
	bra.b	.instloop					; goto instloop
.notwhen:
	bsr.b	PutSnip						; jsr PutSnip

	subq.b	#2,d0						; d0 -= 2
	blo.b	.fork_or_op					; if d0 < 0 goto fork_or_op (i.e. bytecode < BC_WLOCAL)
	lsr.b	#1,d0						; d0 = d0 >> 1
	bcs.b	.longword					; if carry == 1 goto longword (i.e. bytecode == BC_WSTATE || bytecode == BC_RSTATE)
	not.w	d1							; d1 = ~d1 (negate var when bytecode == BC_WLOCAL || bytecode == BC_RLOCAL)
	bra.b	.longword					; goto longword
.const:
	moveq.l	#127,d1						; d1 = 127
	and.b	d0,d1						; d1 &= d0	; mask lowest 7 bits.
	if	USEBIGCONSTANT
	cmp.b	#BIG_CONSTANT_BASE,d1		; if d1 != BIG_CONSTANT_BASE
	bne.b	.small						;   goto small
	move.b	(a0)+,d0					; d0 = *p_Bytecode++
	add.w	d0,d1						; d1 += d0
.small:	endc
	moveq.l	#1,d0						; d1 = 1
	move.w	#$202C,(a1)+				; *pInstructions++ = 'move.l x(a4),d0'
.longword:
	lsl.w	#2,d1						; d1 *= 4
.write:	move.w	d1,(a1)+				; *pInstructions++ = d1 = constant * 4 (presumably the x in the instruction above)
.outifodd:
	move.b	d0,d1						; d1 = d0
	bra.w	.instloop					; goto instloop
.fork_or_op:
	addq.b	#2,d0						; d0 += 2
	bne.b	.op							; if d0 != 0 then goto op
	; Fork
	lsl.b	#2,d1						; d1 *= 4
	move.b	d1,fork_nargs+1-fork_end(a1); *fork_nargs = d1	; self-mod code to write number of args into fork snippet.s
	bra.b	.outifodd					; goto outifodd
.op:
	ror.w	#4,d1						; d1 = d1 >> 4
	or.w	#$0081,d1 					; d1 |= (op.l d1,d0)
	bmi.b	.write						; if d1 < 0 then goto write
	; Shift or rotate
	move.w	#$4841,(a1)+ 				; *pInstructions++ = 'swap.w d1'
	; Bit 2 -> direction, bits 1,0 -> op
	lsr.w	#6,d1						; d1 = d1 >> 6
	lsr.b	#3,d1						; d1 = d1 >> 3
	or.w	#$e2a0,d1 					; d1 |= 'asl.l d1,d0'
	bra.b	.write						; goto write

PutSnip:
	lea	Snipoffs(pc),a2					; a2 = &Snipoffs
	lea	Snips(pc),a3					; a3 = &Snips
	add.w	d0,a2						; a2 += d0 = &Snipoffs[snip_no] = p_Snipoff
	clr.w	d3							; d3 = 0
	move.b	(a2)+,d3					; d3 = *p_Snipoff++ = Snippet_base
	move.b	(a2)+,d2					; d2 = *p_Snipoff++ = Snippet_top
	sub.b	d3,d2						; d2 -= d3 = Snippet_size
	beq.b	.empty						; if d2 == 0 then goto empty
	add.w	d3,a3						; a3 += d3
	add.w	d3,a3						; a3 += d3 = &Snippet = p_Snippet
.copy:	move.w	(a3)+,(a1)+				; *pInstructions++ = *p_Snippet++
	subq.b	#1,d2						; d2--
	bne.b	.copy						; if d2 != 0 goto copt
.empty:	rts								; return


Snips:

Snip_fork:
	;move.l	(a3)+,d0
	; Put nargs in moveq byte
	move.l	r_FreeState(a6),a2			; a2 = r_FreeState = p_NewState
	move.l	(a2),r_FreeState(a6)		; r_FreeState = *p_NewState = p_NextFreeState
	lea	4(a5),a1						; a1 = &p_CurrentState.st_x
	move.l	a2,d2						; d2 = p_NewState
	move.l	d0,(a2)+					; *p_NewState++ = d0 (proc address)
	rept	7+WIRE_CAPACITY				; repeat for 7 fields from st_x to st_time plus wires
	move.l	(a1)+,(a2)+					; 	*p_NewState++ = *p_CurrentState++
	endr
	move.l	d2,a2						; a2 = p_NewState
fork_nargs:
	moveq.l	#0,d1						; d1 = nargs	; self-modified before copying snippet
	sub.w	d1,a2						; p_NewStateStackBottom = p_NewState - nargs*4
	move.l	a2,a1						; p_NewStateStack = p_NewStateStackBottom
	bra.b	.args_in					; goto args_in
.args:	move.l	(a3)+,(a1)+				;	p_NewStateStack++ = p_StateStack++		; pop arg from state stack into new state stack
.args_in:	subq.w	#4,d1				; nargs -= 4
	bge.b	.args						; if nargs >= 0 goto args					; copy nargs into new state stack
	move.l	d2,-(a2)					; *--p_NewStateStackBottom = p_NewState
	clr.l	d0							; d0 = 0
	move.w	st_time(a5),d0				; d0 = *p_State.st_time
	lsl.l	#2,d0						; d0 *= 4 = current_time
	lea	r_StateLists(a6),a1				; a1 = &r_StateLists[0]
	add.l	d0,a1						; a1 += d0 = &r_StateLists[current_time]
	move.l	(a1),-(a2)					; *--p_NewStateStackBottom = r_StateLists[current_time]
	move.l	a2,(a1)						; r_StateLists[current_time] = p_NewStateStackBottom
fork_end:
Snip_op:
	; Put op in high nibble of op word:
	; 8 = or, 9 = sub, 11 = cmp, 12 = and, 13 = add
	;move.l	(a3)+,d0
	move.l	(a3)+,d1					; d1 = *p_StateStack++		; pop second operand
	;op.l	d1,d0
	;move.l	d0,-(a3)

Snip_writelocal:
	; Put index*4 in offset
	;move.l	(a3)+,d0
	dc.w	$2B40	; move.l d0,x(a5)	; *(p_State + x) = d0		; store local var in stack
Snip_writestate:
	; Put index*4 in offset
	;move.l	(a3)+,d0
	dc.w	$2B40	; move.l d0,x(a5)	; *(p_State + x) = d0		; store wire
Snip_readlocal:
	; Put index*4 in offset
	dc.w	$202D	; move.l x(a5),d0	; d0 = *(p_State + x)		; read local
	;move.l	d0,-(a3)
Snip_readstate:
	; Put index*4 in offset
	dc.w	$202D	; move.l x(a5),d0	; d0 = *(p_State + x)		; read wire
	;move.l	d0,-(a3)

Snip_end:
	move.l	r_FreeState(a6),(a5)		; *p_State = r_FreeState	; link to next free state
	move.l	a5,r_FreeState(a6)			; r_FreeState = p_State
	rts
Snip_rand:
	if	USERANDOM
	move.l	st_rand(a5),d0				; d0 = *p_State.st_rand
	move.l	d0,d1						; d1 = d0
	swap.w	d0							; d0 = (d0 << 16) | (d0 >> 16)
	mulu.w	#$9D3D,d1					; d1 *= 0x9d3d
	add.l	d1,d0						; d0 += d1
	move.l	d0,st_rand(a5)				; *p_State.st_rand = d0
	clr.w	d0							; d0 &= 0xffff
	swap.w	d0							; d0 = d0 >> 16
	;move.l	d0,-(a3)
	endc
Snip_draw:
	movem.l	st_x(a5),d0-d3				; d0 = *p_State.st_x; d1 = *p_State.st_y; d2 = *p_State.st_size; d3 = *p_State.st_tint
	swap.w	d0							; d0 = (d0 << 16) | (d0 >> 16)
	swap.w	d1							; d1 = (d1 << 16) | (d1 >> 16)
	swap.w	d2							; d2 = (d2 << 16) | (d2 >> 16)
	swap.w	d3							; d3 = (d3 << 16) | (d3 >> 16)
	move.l	r_PutCircle(a6),a1			; a1 = &r_PutCircle
	jsr	(a1)							; jsr (r_PutCircle)
Snip_tail:
	move.l	(a5),a1 ; st_proc			; a1 = *p_State.st_proc
	jmp	(a1)							; jmp *p_State.st_proc
Snip_plot:
	movem.l	st_x(a5),d0-d3				; d0 = *p_State.st_x; d1 = *p_State.st_y; d2 = *p_State.st_size; d3 = *p_State.st_tint
	swap.w	d0							; d0 = (d0 << 16) | (d0 >> 16)
	swap.w	d1							; d1 = (d1 << 16) | (d1 >> 16)
	swap.w	d2							; d2 = (d2 << 16) | (d2 >> 16)
	swap.w	d3							; d3 = (d3 << 16) | (d3 >> 16)
	not.w	d3							; d3 ~= d3
	move.l	r_PutCircle(a6),a1			; a1 = &r_PutCircle
	jsr	(a1)							; jsr (r_PutCircle)
Snip_proc:
	move.l	r_Procedures+0(a6),d0		; d0 = &r_Procedures[proc_no]		; proc_no written into instruction by self-mod.
Snip_pop:
	;move.l	(a3)+,d0
Snip_div:
	;move.l	(a3)+,d0
	move.l	(a3)+,d1					; d1 = *p_StateStack++
	asr.l	#8,d1						; d1 = d1 >> 8
	divs.w	d1,d0						; d0 = d0 / d1
	ext.l	d0							; sign extend d0!
	asl.l	#8,d0						; d0 = d0 << 8
	;move.l	d0,-(a3)
Snip_wait:
	;move.l	(a3)+,d0
	add.l	d0,st_time(a5)				; *p_State.st_time += wait_frames
	lea.l	.continue(pc),a1			; a1 = &continue
	move.l	a1,(a5) ; st_proc			; *p_State.st_proc = &continue
	move.l	a5,-(a3)					; *(--p_StateStack) = pState		; push state ptr onto local stack.
	clr.l	d0							; 
	move.w	st_time(a5),d0				; d0 = *p_State.st_time
	lsl.l	#2,d0						; d0 *= 4
	lea	r_StateLists(a6),a1				; a1 = p_FrameList = &r_StateLists[0]
	add.l	d0,a1						; a1 += d0 ; p_FrameList = &r_StateLists[*pState.st_time]
	move.l	(a1),-(a3)					; *(--pStateStack) = *p_FrameList	; push previous turtle
	move.l	a3,(a1)						; *p_FrameList = p_StateStack
	rts
.continue:
Snip_sine:
	;move.l	(a3)+,d0
	lsr.w	#2,d0						; d0 /= 4		; [0.16] => [0.14]
	add.w	d0,d0						; d0 += d0		; [0.15] (bottom bit 0)
	move.w	(a0,d0.w),d0				; d0 = sine[d0 & 0xffff] (16384 x 16-bit values see Sinus.S)
	ext.l	d0							; sign extend d0!
	asl.l	#2,d0						; d0 *= 4
	;move.l	d0,-(a3)
Snip_seed:
	if	USERANDOM
	;move.l	(a3)+,d0
	move.l	d0,d1						; d1 = d0
	swap.w	d0							; d0 = (d0 << 16) | (d0 >> 16)
	mulu.w	#$9D3D,d1					; d1 *= 0x9d3d
	add.l	d1,d0						; d0 += d1
	move.l	d0,d1						; d1 = d0
	swap.w	d0							; d0 = (d0 << 16) | (d0 >> 16)
	mulu.w	#$9D3D,d1					; d1 *= 0x9d3d
	add.l	d1,d0						; d0 += d1
	move.l	d0,st_rand(a5)				; *p_State.st_rand = d0
	endc
Snip_neg:
	;move.l	(a3)+,d0
	neg.l	d0							; d0 = ~d0
	;move.l	d0,-(a3)
Snip_move:
	;move.l	(a3)+,d0
	move.l	d0,d2						; d2 = d0
	move.l	st_dir(a5),d0				; d0 = *p_State.st_dir
	asr.l	#8,d0						; d0 = d0 >> 8		; [16.16] => [8.16]
	lsr.w	#2,d0						; d0 = d0 >> 2		; [8.16] => [0.14]
	add.w	d0,d0						; d0 += d0			; [0.15] (bottom bit 0)
	move.w	(a0,d0.w),d1	; Sine		; sine[d0 & 0xffff] (16384 x 16-bit values see Sinus.S)
	move.l	st_dir(a5),d0				; d0 = *p_State.st_dir
	asr.l	#8,d0						; d0 = d0 >> 8		; [16.16] => [8.16]
	add.w	#$4000,d0					; d0 += 0x4000		; quarter of the table
	lsr.w	#2,d0						; d0 = d0 >> 2		; [8.16] => [0.14]
	add.w	d0,d0						; d0 += d0			; [0.15] (bottom bit 0)
	move.w	(a0,d0.w),d0	; Cosine	; sine[d0 & 0xffff] (16384 x 16-bit values see Sinus.S)
	if	USEBIGMOVE
	cmp.l	#32<<16,d2					; if d2 >= (0x200000)
	bge.b	.big						;   goto big
	cmp.l	#-32<<16,d2					; if d2 >= (0xffe0000)
	bgt.b	.small						;   goto small
.big:	asl.l	#2,d2					; d2 = d2 << 2
	swap.w	d2							; d2 = (d2 << 16) | (d2 >> 16)
	muls.w	d2,d0						; d0 *= d2 			; WORD
	muls.w	d2,d1						; d1 *= d2			; WORD
	bra.b	.done						; jmp done
.small:	endc
	asr.l	#6,d2						; d2 = d2 >> 6
	muls.w	d2,d0						; d0 *= d2
	muls.w	d2,d1						; d1 *= d2
	asr.l	#8,d1						; d1 = d1 >> 8
	asr.l	#8,d0						; d0 = d0 >> 8
.done:	add.l	d0,st_x(a5)				; *p_State.st_x = d0
	add.l	d1,st_y(a5)					; *p_State.sy_y = d1
Snip_mul:
	;move.l	(a3)+,d0
	move.l	(a3)+,d1					; d1 = *p_StateStack++
	asr.l	#8,d1						; d1 = d1 >> 8
	asr.l	#8,d0						; d0 = d1 >> 8
	muls.w	d1,d0						; d0 *= d1			; SIGNED
	;move.l	d0,-(a3)

EndOfSnips:


SNIP	macro
	dc.b	(Snip_\1-Snips)/2
	endm

Snipoffs:
	SNIP	fork
	SNIP	op
	SNIP	writelocal
	SNIP	writestate
	SNIP	readlocal
	SNIP	readstate

	SNIP	end
	SNIP	rand
	SNIP	draw
	SNIP	tail
	SNIP	plot
	SNIP	proc
	SNIP	pop
	SNIP	div
	SNIP	wait
	SNIP	sine
	SNIP	seed
	SNIP	neg
	SNIP	move
	SNIP	mul

	dc.b	(EndOfSnips-Snips)/2
	even
