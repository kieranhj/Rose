; ============================================================================
; Rose Arc Port.
; Original Amiga engine and language code by Blueberry of Loonies.
; Archimedes version by Kieran of Bitshifters.
; Additional code by Progen (Sarah Walker).
; QTM Module Player by Phoenix of Quantum (steve3000).
; ============================================================================

.equ _DEBUG, 1
.equ _ENABLE_MUSIC, 1
.equ _OVERSCAN, 0						; TODO: Move to config.
.equ _DUAL_PLAYFIELD, 1					; TODO: Move to config.

.equ _DEBUG_RASTERS, (_DEBUG && 1)		; removes code
.equ _DEBUG_STOP_ON_FRAME, -1
.equ _DEBUG_DEFAULT_PLAY_PAUSE, 1		; play
.equ _DEBUG_DEFAULT_SHOW_RASTERS, 0
.equ _DEBUG_DEFAULT_SHOW_INFO, 0		; slow

.equ Screen_Banks, 1
.equ Screen_Mode, 9

.if _OVERSCAN
.equ Screen_Width, 352			; +32
.equ Screen_Height, 280			; +24
.equ Mode_Height, 280
.else
.equ Screen_Width, 320
.equ Screen_Height, 180;256
.equ Mode_Height, 256
.endif

.equ Screen_PixelsPerByte, 2
.equ Screen_Stride, Screen_Width/Screen_PixelsPerByte
.equ Screen_Bytes, Screen_Stride*Screen_Height
.equ Mode_Bytes, Screen_Stride*Mode_Height

.include "lib/swis.h.asm"

.macro SET_BORDER rgb
	.if _DEBUG_RASTERS
	mov r4, #\rgb
	ldrb r0, debug_show_rasters
	cmp r0, #0
	blne palette_set_border
	.endif
.endm

.org 0x8000

; ============================================================================
; Stack
; ============================================================================

Start:
    adrl sp, stack_base
	B main

.skip 1024
stack_base:

; ============================================================================
; Main
; ============================================================================

main:
	SWI OS_WriteI + 22		; Set base MODE
	SWI OS_WriteI + Screen_Mode

	SWI OS_WriteI + 23		; Disable cursor
	SWI OS_WriteI + 1
	MOV r0,#0
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC
	SWI OS_WriteC

	; Set RAM size for screen size * number of buffers.
	MOV r0, #DynArea_Screen
	SWI OS_ReadDynamicArea
	MOV r0, #DynArea_Screen
	MOV r2, #Mode_Bytes * Screen_Banks
	mov r3, r2
	SUBS r1, r2, r1
	SWI OS_ChangeDynamicArea
	MOV r0, #DynArea_Screen
	SWI OS_ReadDynamicArea
	CMP r1, r3
	ADRCC r0, error_noscreenmem
	SWICC OS_GenerateError

	; Clear screen (extended).

	bl get_screen_addr			; single buffer so only needed once.
	bl cls

	; Extend screen size.
	bl set_vidc_regs

	; EARLY INITIALISATION HERE!

.if _ENABLE_MUSIC
	; Load module
	; TODO: Embed module in exe.
	adrl r0, module_filename
	mov r1, #0
	swi QTM_Load

	; TODO: Can we afford higher quality audio?
	mov r0, #24
	swi QTM_SetSampleSpeed

	; Set to mono - modern MOD composers prefer this!
	mov r0, #0
	mov r1, #2
	swi QTM_Stereo
.endif

	; Make tables etc.
	bl gen_code
    bl MakeSinus
    bl InitStates

	; Claim the Error vector
	MOV r0, #ErrorV
	ADR r1, error_handler
	MOV r2, #0
	SWI OS_Claim

	; Claim the Event vector
	mov r0, #EventV
	adr r1, event_handler
	mov r2, #0
	swi OS_AddToVector

    ; LATE INITIALISATION HERE!

	; Enable Vsync event
	mov r0, #OSByte_EventEnable
	mov r1, #Event_VSync
	SWI OS_Byte

	.if _ENABLE_MUSIC
	SWI QTM_Start
	.endif

main_loop:

	.if _DEBUG_RASTERS
	mov r4, #0x000000		; black
	bl palette_set_border
	.endif

	.if _DEBUG
	bl debug_controls
	.endif

	; Exit if Escape is pressed
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_Escape
	MOV r2, #0xff
	SWI OS_Byte
	
	CMP r1, #0xff
	CMPEQ r2, #0xff
	BEQ exit

	; Time debug portion.
	SET_BORDER 0x00ffff		; yellow

	.if _DEBUG
	bl debug_info
	.endif

	; Time Rose script execution.
	SET_BORDER 0xff0000		; blue

	; Reset array of circles.
	ldr r0, p_CircleBufEnd
	str r0, r_FreeCircle

    ; Do the rose thing!
    bl RunFrame

	; Wait for vsync.
	SET_BORDER 0x000000		; black

	; Limit to 50Hz max but don't wait if we're running too slow.
	ldr r1, last_vsync
.1:
	ldr r2, vsync_count
	cmp r1, r2
	beq .1
	.if _DEBUG
	sub r1, r2, r1
	str r1, vsync_delta
	.endif
	str r2, last_vsync

	.if _DEBUG
	ldrb r0, debug_play_pause
	cmp r0, #0
	bne .2

	ldrb r0, debug_play_step
	cmp r0, #0
	beq main_loop
	.2:
	.endif

	; Time Rose colour script execution.
	SET_BORDER 0x00ff00		; green

	; Process color script.
	bl RunColorScript

	; Time circle plotting.
	SET_BORDER 0x0000ff		; red

	; Plot circles sorted by Y.
	bl plot_all_circles

    ; Next frame.
    ldr r2, r_FrameCounter
    add r2, r2, #1
    str r2, r_FrameCounter

	.if _DEBUG
	ldr r1, d_StopOnFrame
	cmp r2, r1
	bne .3
	mov r1, #1
	str r1, debug_play_pause
	.3:
	.endif

    ldr r1, r_MaxFrames
    cmp r2, r1
    bge exit

    b main_loop


error_noscreenmem:
	.long 0
	.byte "Cannot allocate screen memory!"
	.align 4
	.long 0

get_screen_addr:
	str lr, [sp, #-4]!
	adrl r0, screen_addr_input
	adrl r1, screen_addr
	swi OS_ReadVduVariables
	ldr pc, [sp], #4
	
screen_addr_input:
	.long VD_ScreenStart, -1

screen_addr:
	.long 0					; ptr to the current VIDC screen bank being written to.

vsync_count:
	.long 0

last_vsync:
	.long 0

.if _DEBUG
vsync_delta:
	.long 0
.endif

exit:	
	; wait for vsync (any pending buffers)
	mov r0, #19
	swi OS_Byte

.if _ENABLE_MUSIC
	; disable music
	mov r0, #0
	swi QTM_Stop
.endif

	; disable vsync event
	mov r0, #OSByte_EventDisable
	mov r1, #Event_VSync
	swi OS_Byte

	; release our event handler
	mov r0, #EventV
	adr r1, event_handler
	mov r2, #0
	swi OS_Release

	; release our error handler
	mov r0, #ErrorV
	adr r1, error_handler
	mov r2, #0
	swi OS_Release

	SWI OS_Exit

; R0=event number
event_handler:
	cmp r0, #Event_VSync
	movnes pc, r14
	STMDB sp!, {r0, lr}

	; update the vsync counter
	LDR r0, vsync_count
	ADD r0, r0, #1
	STR r0, vsync_count
	LDMIA sp!, {r0, pc}

error_handler:
	STMDB sp!, {r0-r2, lr}

.if _ENABLE_MUSIC
	; disable music
	mov r0, #0
	swi QTM_Stop
.endif

	MOV r0, #OSByte_EventDisable
	MOV r1, #Event_VSync
	SWI OS_Byte
	MOV r0, #EventV
	ADR r1, event_handler
	mov r2, #0
	SWI OS_Release
	MOV r0, #ErrorV
	ADR r1, error_handler
	MOV r2, #0
	SWI OS_Release
	LDMIA sp!, {r0-r2, lr}
	MOVS pc, lr

.if _DEBUG
debug_info:
	ldrb r0, debug_show_info
	cmp r0, #0
	moveq pc, lr

	swi OS_WriteI + 30			; Home.

	ldr r0, r_FrameCounter
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertHex4
	adr r0, debug_string
	swi OS_WriteO

	swi OS_WriteI + 32			; Space.

	ldr r0, vsync_delta
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertCardinal4
	adr r0, debug_string
	swi OS_WriteO
	swi OS_WriteI + 32			; Space.

	ldr r0, r_NumTurtles
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertCardinal4
	adr r0, debug_string
	swi OS_WriteO

	swi OS_WriteI + 32			; Space.

	ldr r0, r_MaxTurtles
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertCardinal4
	adr r0, debug_string
	swi OS_WriteO

	swi OS_WriteI + 32			; Space.

	ldr r0, r_NumCircles
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertCardinal4
	adr r0, debug_string
	swi OS_WriteO

	swi OS_WriteI + 32			; Space.

	ldr r0, r_MaxCircles
	adr r1, debug_string
	mov r2, #8
	swi OS_ConvertCardinal4
	adr r0, debug_string
	swi OS_WriteO

	swi OS_WriteI + 32			; Space.
	swi OS_WriteI + 32			; Space.
	swi OS_WriteI + 32			; Space.
	swi OS_WriteI + 32			; Space.

	mov pc, lr

debug_string:
	.skip 16

debug_controls:
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_Space
	MOV r2, #0xff
	SWI OS_Byte
	CMP r1, #0xff
	CMPEQ r2, #0xff
	BNE .1 ; not pressed
	ldrb r0, debug_debounce_space
	cmp r0, #0
	bne .1 ; still pressed

	; Toggle play/pause.
	ldrb r0, debug_play_pause
	eor r0, r0, #1
	strb r0, debug_play_pause
	.1:
	strb r1, debug_debounce_space

	mov r0, #0
	strb r0, debug_play_step

	; Advance frame (with repeat):
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_ArrowRight
	MOV r2, #0xff
	SWI OS_Byte
	CMP r1, #0xff
	CMPEQ r2, #0xff
	streqb r1, debug_play_step

	.2:
	; Advance frame (without repeat):
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_S
	MOV r2, #0xff
	SWI OS_Byte
	CMP r1, #0xff
	CMPEQ r2, #0xff
	bne .3
	ldrb r0, debug_debounce_s
	cmp r0, #0
	bne .3
	strb r1, debug_play_step
	.3:
	strb r1, debug_debounce_s

	; Toggle debug info.
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_D
	MOV r2, #0xff
	SWI OS_Byte
	CMP r1, #0xff
	CMPEQ r2, #0xff
	bne .4
	ldrb r0, debug_debounce_d
	cmp r0, #0
	bne .4
	ldrb r0, debug_show_info
	eor r0, r0, #1
	strb r0, debug_show_info
	.4:
	strb r1, debug_debounce_d


	; Toggle rasters
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_R
	MOV r2, #0xff
	SWI OS_Byte
	CMP r1, #0xff
	CMPEQ r2, #0xff
	bne .5
	ldrb r0, debug_debounce_r
	cmp r0, #0
	bne .5
	ldrb r0, debug_show_rasters
	eor r0, r0, #1
	strb r0, debug_show_rasters
	.5:
	strb r1, debug_debounce_r

	mov pc, lr

debug_debounce_space:
	.byte 0

debug_debounce_s:
	.byte 0

debug_debounce_d:
	.byte 0

debug_debounce_r:
	.byte 0

debug_play_pause:
	.byte _DEBUG_DEFAULT_PLAY_PAUSE

debug_play_step:
	.byte 0

debug_show_info:
	.byte _DEBUG_DEFAULT_SHOW_INFO

debug_show_rasters:
	.byte _DEBUG_DEFAULT_SHOW_RASTERS

d_StopOnFrame:
	.long _DEBUG_STOP_ON_FRAME
.endif

; ============================================================================
; Additional code.
; ============================================================================

set_vidc_regs:
	adr r1, vidc_regs
	ldr r2, vidc_write
.1:
	ldr r0, [r1], #4
	cmp r0, #-1
	moveq pc, lr
	str r0, [r2]
	b .1

cls:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	mov r4, r0
	mov r5, r0
	mov r6, r0
	mov r7, r0
	mov r8, #Screen_Bytes/(4*8)
	ldr r9, screen_addr
.1:
	stmia r9!, {r0-r7}
	subs r8, r8, #1
	bne .1
	mov pc, lr

vidc_write:
	.long VIDC_Write

vidc_regs:
	.long VIDC_HDisplayStart | ((((MODE9_HCentrePixels - Screen_Width/2))-7)/2)<<14
	.long VIDC_HDisplayEnd   | ((((MODE9_HCentrePixels + Screen_Width/2))-7)/2)<<14
	.long VIDC_VDisplayStart | (MODE9_VCentreRasters - Mode_Height/2)<<14
	.long VIDC_VDisplayEnd   | (MODE9_VCentreRasters + Mode_Height/2)<<14
	.long -1

p_CircleBufEnd:
	.long r_circleBufEnd

; ============================================================================
; Additional code modules.
; ============================================================================

.include "engine.asm"
.include "circles.asm"

r_Instructions:
;.include "circle.asm"			; WORKS! \o/
;.include "ball.asm"			; WORKS! \o/
;.include "tree.asm"			; WORKS! \o/
;.include "chiperia.asm"		; WORKS! \o/
;.include "teaser.asm"			; WORKS ALTHOUGH WOBBLY LINES STILL NOT CORRECT!
;.include "everyway.asm"		; WORKS! \o/
;.include "jesuis.asm"			; WORKS ALTHOUGH FINAL CREDITS SCENE MISSING?
;.include "frustration.asm"		; WORKS ALTHOUGH WOBBLY LINES STILL NOT CORRECT!
;.include "euphoria.asm"		; WORKS?
.include "waytoorude.asm"		; WORKS MOSTLY - ONE EFFECT DOESN'T ANIMATE AND CREDITS ARE BUST?
;.include "revision.asm"		; WORKS! - A USEFUL TEST!
;.include "logicos.asm"			; WORKS? - MAX STACK HEIGHT 31!
;.include "technova.asm"		; WORKS! \o/

; ============================================================================
; Data Segment
; ============================================================================

.if _ENABLE_MUSIC
module_filename:
	.byte "<Demo$Dir>.Music",0
	.align 4
.endif

; ============================================================================
; BSS Segment
; TODO: Figure out vlink so can hack off BSS segment from binary!!
; ============================================================================

.p2align 12

r_StateLists:
    .skip	(MAX_FRAMES+MAX_WAIT)*4

.p2align 12

r_StateSpace:
    .skip	(MAX_TURTLES+1)*STATE_SIZE
r_StateSpaceEnd:

.p2align 12

r_Sinus:
    .skip	(DEGREES)*4

r_CircleBuffer:
	.skip	(MAX_CIRCLES)*(CIRCLEDATA+1)*4
r_circleBufEnd:

r_CircleBufPtrs:
	.skip	(Screen_Height)*4

gen_code_pointers:
	.skip	4*8*Screen_Width

gen_code_start:
