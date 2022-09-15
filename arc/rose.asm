; ============================================================================
; Rose Arc Port.
; ============================================================================

.equ _DEBUG, 1
.equ _ENABLE_MUSIC, 0

.equ Screen_Banks, 1
.equ Screen_Mode, 9
.equ Screen_Width, 320
.equ Screen_Height, 256
.equ Mode_Height, 256
.equ Screen_PixelsPerByte, 2
.equ Screen_Stride, Screen_Width/Screen_PixelsPerByte
.equ Screen_Bytes, Screen_Stride*Screen_Height
.equ Mode_Bytes, Screen_Stride*Mode_Height

.include "lib/swis.h.asm"

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
	SWI OS_WriteI + 22		; Set MODE
	SWI OS_WriteI + Screen_Mode

	; Set screen size for number of buffers
	MOV r0, #DynArea_Screen
	SWI OS_ReadDynamicArea
	MOV r0, #DynArea_Screen
	MOV r2, #Mode_Bytes * Screen_Banks
	SUBS r1, r2, r1
	SWI OS_ChangeDynamicArea
	MOV r0, #DynArea_Screen
	SWI OS_ReadDynamicArea
	CMP r1, #Mode_Bytes * Screen_Banks
	ADRCC r0, error_noscreenmem
	SWICC OS_GenerateError

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

	; LOAD STUFF HERE!

.if _ENABLE_MUSIC
	; Load module
	adrl r0, module_filename
	mov r1, #0
	swi QTM_Load

	mov r0, #48
	swi QTM_SetSampleSpeed
.endif

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
    bl MakeSinus
    bl InitStates

	; Enable Vsync event
	mov r0, #OSByte_EventEnable
	mov r1, #Event_VSync
	SWI OS_Byte

main_loop:

	.if _DEBUG
	bl debug_info
	.endif

	; Exit if Escape is pressed
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_Escape
	MOV r2, #0xff
	SWI OS_Byte
	
	CMP r1, #0xff
	CMPEQ r2, #0xff
	BEQ exit
	
	; Wait for vsync.
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

	; Process color script.
	bl RunColorScript

    ; Do the rose thing!
    bl RunFrame

    ; Next frame.
    ldr r2, r_FrameCounter
    add r2, r2, #1
    str r2, r_FrameCounter
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

.endif

; ============================================================================
; Additional code modules
; ============================================================================

.include "engine.asm"

r_Instructions:
;.include "circle.asm"			; WORKS! \o/
;.include "ball.asm"			; INVISIBLE! :\
;.include "tree.asm"			; WORKS! \o/
;.include "chiperia.asm"		; SOME MATHS ERRORS STILL?
;.include "teaser.asm"			; WORKS ALTHOUGH WOBBLY LINES NOT QUITE CORRECT?
;.include "everyway.asm"		; WON'T EVEN COMPILE!
.include "jesuis.asm"			; WORKS ALTHOUGH FINAL CREDITS SCENE MISSING?
;.include "frustration.asm"		; WORKS ALTHOUGH WOBBLY LINES NOT QUITE CORRECT?
;.include "euphoria.asm"		; FREEZES AT TRANSITION WITH CIRCLES & SQUARES (SQUARES DON'T ROTATE PROPERLY EITHER)

; ============================================================================
; Data Segment
; ============================================================================

.if _ENABLE_MUSIC
module_filename:
	.byte "<Demo$Dir>.Music",0
	.align 4
.endif
