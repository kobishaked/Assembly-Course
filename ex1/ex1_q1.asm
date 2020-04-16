TITLE ex1_q1 
; Maor Harash id: 305189409
; This program recive as input two numbers: N - unsigned number, M - signed number
; and prints to the screen the calculation N * M , without using the MUL opration

INCLUDE Irvine32.inc
INCLUDE ex1_q1_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex1-Q1",10,13,0
newLine BYTE 10,13,0
multiSign BYTE " * ",0
equalSign BYTE " = ",0

.code
main PROC

	mov edx,OFFSET myName
	call writeString
	
	mov edx,OFFSET MSG
	call writeString
	
	;print the first part of the equation
	movsx eax,M
	call writeInt
	
	mov edx,OFFSET multiSign
	call writeString
	
	movzx eax,N 
	call writeInt
	
	mov edx,OFFSET equalSign
	call writeString

	;defining registers
	movsx ebx,M
	mov eax,0
	mov ecx,0
	mov cl,N ; initialize counter

	; calculation N * M
	again:	add eax,ebx 	
	loop again
	
	;print the second part of the equation
	mov RESULT,eax
	call writeInt	

	mov edx, OFFSET newLine 
	call writeString
	exit
main ENDP
END main		