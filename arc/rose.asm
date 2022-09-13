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

    ; CLAIM VECTORS HERE!

    ; LATE INITIALISATION HERE!
    bl MakeSinus
    bl InitStates

main_loop:

	.if _DEBUG
	bl debug_info
	.endif

	; exit if Escape is pressed
	MOV r0, #OSByte_ReadKey
	MOV r1, #IKey_Escape
	MOV r2, #0xff
	SWI OS_Byte
	
	CMP r1, #0xff
	CMPEQ r2, #0xff
	BEQ exit
	
	; wait for vsync
	mov r0, #19
	swi OS_Byte

    ; do the rose thing!
    bl RunFrame

    ; next frame.
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

exit:	
.if _ENABLE_MUSIC
	; disable music
	mov r0, #0
	swi QTM_Stop
.endif

	SWI OS_Exit

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
;.include "tree.asm"			; WORKS? :)
.include "chiperia.asm"		; SOME MATHS ERRORS STILL?
;.include "teaser.asm"			; SOME MATHS ERRORS STILL?
;.include "everyway.asm"		; WON'T EVEN COMPILE!

; ============================================================================
; Data Segment
; ============================================================================

.if _ENABLE_MUSIC
module_filename:
	.byte "<Demo$Dir>.Music",0
	.align 4
.endif
