TITLE ex1_q2 
; Maor Harash id: 305189409
; This program  prints to the screen the pal series

INCLUDE Irvine32.inc
INCLUDE ex1_q2_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex1-Q2",10,13,0
firstNumInPalSeries DWORD 0 ; first number in the series
secondNumInPalSeries DWORD 1 ; second number in the series
sumOfPalSeries DWORD 0 ; will hold the sum of the series


.code
main PROC
	mov edx, OFFSET myName 
	call writeString
	
	;print the first two numbers
	mov eax,firstNumInPalSeries
	call writeDec
	mov edx, OFFSET separator 
	call writeString
	mov eax,secondNumInPalSeries
	call writeDec
	
	mov ecx,N ; initialize counter
	sub ecx,2 ; beacuse we print outside of the loop the first two numbers
	
	mov esi,secondNumInPalSeries
	mov ebx,firstNumInPalSeries
	add sumOfPalSeries,eax
	xor eax,eax	
	;ebx - fisrt , esi- second ,  eax- next
	again:
	add eax,esi
	add eax,esi
	add eax,ebx
	
	add sumOfPalSeries,eax
	mov edx, OFFSET separator 
	call writeString
	call writeDec

	;switch the values of the first and second nubmers
	xchg ebx,esi
	xchg esi,eax
	xor eax,eax	
	loop again
	
	call CRLF
	mov edx, OFFSET msg 
	call writeString
	; print the sum
	mov eax,sumOfPalSeries
	call writeDec
	
	call CRLF
	exit
main ENDP
END main	