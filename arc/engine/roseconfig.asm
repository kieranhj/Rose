; ============================================================================
; RoseConfig.asm
; ============================================================================

.ifndef _SCREEN_MODE
.equ Screen_Mode, 9
.else
.equ Screen_Mode, _SCREEN_MODE
.endif

.equ Screen_Width, _FORM_WIDTH
.equ Screen_Height, _FORM_HEIGHT

.if _FORM_HEIGHT < 256					; TODO: Shrink MODE!
.equ Mode_Height, 256
.else
.equ Mode_Height, _FORM_HEIGHT
.endif

; ============================================================================

.ifndef MAX_FRAMES
.equ MAX_FRAMES, 10000	        ; Length of Rose animation
.endif

.ifndef MAX_TURTLES
.equ MAX_TURTLES, 500           ; Max turtles alive at the same time (!)
.endif

.ifndef MAX_STACK
.equ MAX_STACK, 20              ; Max depth of execution stack
.endif

.equ MAX_WAIT, 1000             ; Max wait beyond end of program

.ifndef WIRE_CAPACITY
.equ WIRE_CAPACITY, 8           ; Number of wire slots <== IF THIS CHANGES CHECK ForkState!!
.endif

.equ MAXRADIUS, 70              ;
.equ DEGREES, 16384

; ============================================================================

.equ ST_PROC, 0
.equ ST_X, 1
.equ ST_Y, 2
.equ ST_SIZE, 3
.equ ST_TINT, 4
.equ ST_RAND, 5
.equ ST_DIR, 6
.equ ST_TIME, 7

.equ ST_MAX, 8

; ============================================================================

.equ STATE_SIZE, (ST_MAX+WIRE_CAPACITY+MAX_STACK+2)*4

; ============================================================================

.equ MAX_CIRCLES, 200           ; Max circles drawn in a frame (!)
.if _DUAL_PLAYFIELD
.equ CIRCLEDATA, 6				; centre_x, colour word, ptr to size table, line count
.else
.equ CIRCLEDATA, 5				; centre_x, colour word, ptr to size table, line count
.endif

.equ MAXSPAN, (MAXRADIUS+1)*2

; ============================================================================
