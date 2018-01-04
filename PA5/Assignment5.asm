;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TITLE   Assignment 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Bobby Dhillon
; date: 11/17/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.data
; strings
promptStr BYTE "This program will compute the "
		      BYTE "product of any 32 bit unsigned integers",0
prompt1 BYTE "First number:",0
prompt2 BYTE "Second number:",0
productPrompt BYTE "Their product:",0

; symbolic constants
var_unit EQU DWORD PTR [ebp - 4]
sum_local EQU DWORD PTR [ebp - 8]
var1_param EQU [ebp + 8]
var2_param EQU [ebp + 12]
returnVal EQU [ebp + 16]

.code
main proc

; initial prompt and menuLoop call
mov edx, OFFSET promptStr
call writeString
call crlf
call menuLoop

	exit
main endp


;===============Function Definitions===============

;==================================================
;===============multiply procedure=================
;==================================================
; The multiply procedure gets parameters through
; stack and multiplies them by aid of an arithmetic
; sequence. It returns the product through the
; stack.
; Receives: var1_param = multiplicand
;			var2_param = multiplier
; Returns: sum_total = product
;==================================================
multiply PROC

push ebp	; pushes ebp temporarily onto stack
mov ebp, esp ; ebp points to same pos as esp
sub esp, 8 ; makes room for 2 local var
mov ebx, var2_param ; ebx starts with var2_param

; intializing sum with 0
mov sum_local, 0

; algorithm that first finds the largest 2^n in var2,
; then subtracts 2^n from var2, and shifts var1 left by n
; and adds that value to a running total.
; then repeats the process with the new value for var2,
; essentially multiplying var1 by var2
startWhileOut:

	mov cl, 0 ; counter for exponent
	mov edx, 2 ; base
	mov var_unit, 0 ; adds to base

	; part of the loop that finds largest 2^n
	; inside given ebx using the arithmetic
	; seq : A_1 = 2, A_n+1 = A_n + A_n
	startWhileIn:

		add edx, var_unit ; adds powers of 2
		cmp edx, ebx
		ja endWhileIn	  ; if 2^n > ebx, exit loop
		inc cl			  ; otherwise, inc counter
		mov var_unit, edx ; n+1 for 2^n+1, next term in seq
		jmp startWhileIn

	endWhileIn:
		; for case when multiplier = 0
		cmp ebx, 0
		jz endWhileOut

		sub edx, var_unit ; to generate largest 2^n that's <= var2
		sub ebx, edx	  ; diff between ebx and largest 2^n in ebx

		cmp cl, 0
		jnz continue	; if counter != 0, continue
		mov eax, var1_param ; moves var1_param into eax
		add sum_local, eax	; otherwise, add var1 to sum and exit
		jmp endWhileOut

		continue:
		mov eax, var1_param	; mov var1_param val into eax
		shl eax, cl	; shift left var1 by n, which is counter
		add sum_local, eax ; add it to running total

		cmp ebx, 0
		jz endWhileOut	; if diff of ebx and 2^n is zero, exit loop
		jmp startWhileOut ; otherwise, continue

endWhileOut:

; move return var to eax
mov eax, sum_local

; release local var
mov esp, ebp

; move return var into stack
mov returnVal, eax
pop ebp

ret 8
multiply ENDP

;==================================================
;================menuLoop procedure================
;==================================================
; The menuLoop procedure loops the prompt
; statements and gathers the parameters for the
; multiply procedure to use. It ends once the user
; enters zeros for both the multiplier and the
; multiplicand.
; Receives: nothing
; Returns: nothing
;==================================================
menuLoop PROC

startWhile:

	; prompt to collect var2
	mov edx, OFFSET prompt1
	call writeString
	call readDec
	push eax ; var2

	; prompt to collect var1
	mov edx, OFFSET prompt2
	call writeString
	call readDec

	pop ebx ; var2
	cmp ebx, 0
	jnz pushVal ; if var2 != 0, continue
	cmp eax, 0
	jz endWhile ; if var1 == 0, endWhile

	pushVal:

	sub esp, 4 ; to make room for return val from multiply
	push ebx ; var2 parameter
	push eax ; var1 parameter

	call multiply

	pop eax ; returns product from multiply thru stack

	; prompt to display product
	mov edx, OFFSET productPrompt
	call writeString
	call writeDec
	call crlf

	jmp startWhile

endWhile:
ret
menuLoop ENDP


end main

;==================================================
;===================sample run=====================
;==================================================
comment $==========================================
This program will compute the product of any 32 bit unsigned integers
First number:12
Second number:10
Their product:120
First number:0
Second number:1
Their product:0
First number:1
Second number:0
Their product:0
First number:1290
Second number:90
Their product:116100
First number:9
Second number:8
Their product:72
First number:4
Second number:4
Their product:16
First number:2
Second number:123
Their product:246
First number:0
Second number:0
Press any key to continue . . .
$===================================================
