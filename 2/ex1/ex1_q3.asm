TITLE ex1_q3 
; Maor Harash id: 305189409
; This program  prints to the screen the pal series from the end to start

INCLUDE Irvine32.inc

N = 15;
.data
myName BYTE "Maor Harash id: 305189409 Ex1-Q3",10,13,0
arrPal DWORD 0,1,N-2 DUP (?) ;the array we store the pal series

.code
main PROC
	mov edx, OFFSET myName 
	call writeString

	mov edi, OFFSET arrPal
	mov ecx,N ; initialize counter
	sub ecx,2 ; beacuse outside of the loop the first two numbers initialize
	
	;initialize the two numbers to registers
	mov esi,1
	mov ebx,0
	
	add edi, 8 ;starting position of the array
	
	;ebx - fisrt , esi- second ,  [edi]- next
	;initialize the array in pal series
	loop1:
	add [edi],esi
	add [edi],esi
	add [edi],ebx	
	;switch the values of the first and second nubmers
	mov ebx,esi
	mov esi,[edi]
	add edi, 4
	loop loop1
	
	sub edi, 4 ; beacuse the last add that happen in line 36 point to outside of the array
	mov ecx,N ; initialize counter
	
	;print the array from the end
	loop2:
	mov eax,[edi]
	call writeDec	
	call CRLF
	sub edi, 4
	loop loop2

	call CRLF
	exit
main ENDP
END main	