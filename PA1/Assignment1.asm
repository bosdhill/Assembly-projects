;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Assignment 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Bobby Dhillon
; date: 10/14/2016
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


INCLUDE Irvine32.inc

.data
; variables
a DWORD ?
b DWORD ?
cc DWORD ?
result DWORD ?
; strings
str1 BYTE "Enter the value of a:",0
str2 BYTE "Enter the value of b:",0
str3 BYTE "Enter the value of c:",0
str4 BYTE "Result is:",0
str5 BYTE "Press any key to continue...",0

.code
main proc

mov edx, OFFSET str1
call writeString
call Crlf

call readDec
mov a, eax

mov edx, OFFSET str2
call writeString
call Crlf

call readDec
mov b, eax

mov edx, OFFSET str3
call writeString
call Crlf

call readDec
mov cc, eax

; result = (a + (b*c))/(2*b)
mov eax, 2
mul b
mov ebx, eax
mov eax, b
mul cc
add eax, a
mov edx, 0
div ebx
mov result, eax

mov edx, OFFSET str4
call writeString
call Crlf

mov eax, result
call writeDec
call Crlf

mov edx, OFFSET str5
call writeString
call Crlf

	exit
main endp
end main
