;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;TITLE   Assignment 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Bobby Dhillon
; date: 11/11/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INCLUDE Irvine32.inc

.data
; prompt strings
enterPrompt BYTE "Enter a number and all the prime "
	    BYTE "numbers from 1 to your number will be displayed",0
primePrompt BYTE "Primes found: ",0

; variables
limit DWORD ?  ; limit set by user
currVal DWORD 1	; the val between 1 and limit
divisor DWORD 1 ; what currVal is divided by
count DWORD 1	; num of times remainder == 0

.code
main proc

; to gather input from user
mov edx, OFFSET enterPrompt
call writeString
call readDec

; seeds limit with val from user
mov limit, eax

; calls printFunc
call printFunc

	exit
main endp

;--------------------------------------------
;-----------FUNCTION DEFINITIONS-------------
;--------------------------------------------

;--------------------------------------------
; printFunc
; Prints the prime numbers as determined by
; the isPrime function. Uses the globally
; defined variables currVal and limit, as
; well as the string primePrompt.
; Receives: primePrompt = string
;			currVal = val between 1 and limit
;			limit = number entered by user
; Returns: nothing
;--------------------------------------------
printFunc PROC

; to display how many primes found
mov edx, OFFSET primePrompt
call writeString
call Crlf

; loop prints the current value between 1 and limit
; depending on if isPrime returns a 0 or 1
startWhile1:
	; move currVal to ebx
	mov ebx, currVal
	; compares currVal to limit
	cmp ebx, limit
	; if currVal > limit, end loop
	JA endWhile1
	; compares currVal to 1
	cmp ebx, 1
	; if currVal = 1, dont print because it is not prime
	JE dontPrint
	call isPrime
	; compare val returned by isPrime to 1
	cmp ebx, 1
	;  if ebx is not equal to 1 (which is 0)
	; dont print
	JNE	dontPrint
	; otherwise, print it
	mov eax, currVal
	call writeDec
	mov al, ' '
	call writeChar
dontPrint:
	; increment currVal
	inc currVal
	; restart at beginning of loop
	jmp startWhile1
endWhile1:
call Crlf
ret
printFunc ENDP

;--------------------------------------------
; isPrime
; Determines whether or not a number is prime
; by dividing it by all the integers less
; than it. If this calculation yields a
; remainder of zero more than twice,
; it is considered to be composite and a value
; of 0 is returned. If its remainder count is
; 2, then it is considered prime and a 1 is
; returned.
; Receives: divisor = 1 (during initial call)
;			currVal = val between 1 and limit
;			count = 0 (during initial call)
; Returns: EBX = either a 1 or 0
;--------------------------------------------
isPrime PROC

	; restarts divisor and count
	mov divisor, 1
	mov count, 0

	; while loop that determines how many
	; remainders of zero there are
	startWhile2:
		mov ebx, divisor
		; compares divisor to currVal
		cmp ebx, currVal
		; if divisor > currVal, exit loop
		JA endWhile2
		; clear edx for remainder
		mov edx, 0
		mov eax, currVal
		; divide currVal by divisor
		div divisor
		; compare remainder to 0
		cmp edx, 0
		; if remainder != 0, then inc divisor
		JNE incDiv
		; otherwise increment count and divisor
		inc count
	incDiv:
		inc divisor
	; start at beginning
	jmp startWhile2
	endWhile2:

	; once it exits, its here
	; if statement, to determine whether ebx = 0 or 1
		mov ebx, count
		cmp ebx, 2
		; if it is greater than 2, then return false
		JA return0
		; if not, then ebx = 1
		mov ebx, 1
		jmp endElse
	return0:
		mov ebx, 0
	endElse:
ret
isPrime endp

end main
