;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TITLE   Assignment 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Bobby Dhillon
; date: 11/3/16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.data
; prompt strings
welcomeStr BYTE "Welcome to my program!",0
prompt1 BYTE "Enter first signed integer: ",0
prompt2 BYTE "Enter second signed integer: ",0
sumPrompt BYTE "Their sum is: ",0
diffPrompt BYTE "Their difference is: ",0
pressAnyKey BYTE "Press any key...",0

; loop counter constant
COUNTER = 3

; row and col constant values
ROWSTART = 10
COLSTART = 20

; row and column variables
rowCord BYTE ROWSTART
colCord BYTE COLSTART

.code

main PROC
; sets counter
mov ecx, COUNTER
; menu that iterates 3 times
MenuLoop:
	; starts at top of screen
	mov rowCord, ROWSTART
	; starts with clearing the screen
	call ClrScr
	; moves down 2 values every
	; locate call
	call Locate
	; calls input for 2 signed integers
	call Input
	call Locate
	; pushes val temporarily into stack
	push eax
	; sums the signed integers
	add eax, ebx
	; displays sum of 2 integers
	call DisplaySum
	; pops value of signed integer back into eax
	pop eax
	; subtracts 1st integer from second integer
	sub eax, ebx
	call Locate
	; displays 1st integer minus second
	call DisplayDiff
	call Locate
	; displays wait for key prompt
	call WaitForKey
	Loop MenuLoop
; locate called one more time for press any key
call Locate
exit
main ENDP

;--------------------------------------------
;-----------FUNCTION DEFINITIONS-------------
;--------------------------------------------

;--------------------------------------------
; Input
; Collects input from user, which are two
; signed integers. Also has Locate called
; within it, since there are two prompts.
; Receives: the globally defined strings,
;			prompt1 and prompt2, which
;			should contain strings to
;			display
; Returns: Nothing
;--------------------------------------------
Input PROC
	mov edx, OFFSET prompt1
	; displays prompt and collects 1st integer
	call writeString
	call readInt
	; calls Locate inside it
	call Locate
	; temporarily saves first signed int in stack
	push eax
	mov edx, OFFSET prompt2
	; displays prompt and collects 2nd integer
	call writeString
	call readInt
	; moves second signed integer to ebx
	mov ebx, eax
	; pops first signed integer from stack into eax
	pop eax
	ret
	Input ENDP

;--------------------------------------------
; DisplaySum
; displays sum of eax and ebx, and sumprompt
; Receives: EAX = sum of eax and ebx
;			the address of globally defined
;			string, sumPrompt, which should
;			contain a string to display
; Returns: Nothing
;--------------------------------------------
DisplaySum PROC
	mov edx, OFFSET sumPrompt
	; displays sum
	call writeString
	call writeInt
	ret
	DisplaySum ENDP

;--------------------------------------------
; DisplayDiff
; displays the difference (eax - ebx) located
; in eax, and the difference prompt
; Receives: EAX = difference of eax & ebx
;			the address of the diffPrompt,
;			which should contain a string
; Returns: Nothing
;--------------------------------------------
DisplayDiff PROC
	mov edx, OFFSET diffPrompt
	; displays difference, either neg or pos
	call writeString
	call writeInt
	ret
	DisplayDiff ENDP

;--------------------------------------------
; WaitForKey
; displays wait for key and after user enters
; a character, the loop will go back to
; beginning
; Receives: the globally defined string,
;			pressAnyKey (for output)
;			which should contain a string
; Returns: nothing
;--------------------------------------------
WaitForKey PROC
	; displays press any key prompt
	mov edx, OFFSET pressAnyKey
	call writeString
	call readChar
	ret
	WaitForKey ENDP

;--------------------------------------------
; Locate
; Clears screen and resets cursor position
; and is called between each prompt. After
; it resets the cursor, it increments
; rowCord by 2, so it moves the next
; prompt 2 values below the prior prompt.
; Receives: the global variables rowCord, colCord
;			which should contain values for
;			the cursor
; Returns: nothing
;--------------------------------------------
Locate PROC
	; sets the row and col coordinates
	mov dh, rowCord
	mov dl, colCord
	; increments cursor by 2 so it appears below
	; the previous output
	add rowCord, 2
	; calls Gotoxy so it can relocate cursor
	; using the values in dh and dl
	call Gotoxy
	ret
Locate ENDP

END main
