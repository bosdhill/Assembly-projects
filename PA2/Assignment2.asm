;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TITLE   Assignment 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Bobby Dhillon
; date: 10/22/16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Comment !
Write a complete program that:
	1. Prompts the user to enter 10 numbers.
	2. saves those numbers in a 32 bit integer array.
	3. Calculates the sum of the numbers and displays it.
	4. Calculates the mean of the array and displays it.
	5. Prints the array with the same order it was entered.
	6. Rotates the members in the array forward one position for
	   9 times. so the last rotation will display the array in
	   reversed order. Print the array after each rotation.
	   check the sample run.


	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  Don't use any shift or rotate instructions which we have
	  not covered yet. You need to use loop and indexed addressing.
	  All you work should be on the original array. Don't make
	  a copy of the array at any time.
	  Add comments to make your program easy to read.
!


INCLUDE Irvine32.inc

.data

; prompt strings
str1 BYTE "Enter a number: ",0
str2 BYTE "The sum is: ",0
str3 BYTE "The mean is: ",0
str4 BYTE " ",0
str5 BYTE "/",0
str6 BYTE "The original array is: ",0
str7 BYTE "After a rotation: ",0

; array
intArr DWORD 10 DUP(?)

; constants
ARRLEN = LENGTHOF intArr
ARRSIZE = SIZEOF intArr
ELT = TYPE intArr

.code

main proc
; collect numbers
mov ecx, ARRLEN
mov edi, 0
mov edx, OFFSET str1
L1:
	call writeString
	call readDec
	mov intArr[edi], eax
	add edi, ELT
	Loop L1

; array rotation
mov ecx, ARRLEN - 1
mov esi, ARRSIZE - ELT

LLL:
mov ebx, intArr[esi]
xchg ebx, intArr[esi - ELT]
mov intArr[esi], ebx
sub esi, ELT
Loop LLL

call writeString
mov ecx, ARRLEN
mov edi, 0
LL:
	mov eax, intArr[edi]
	call writeDec
	add edi, ELT
	Loop LL

	exit
main endp
end main
