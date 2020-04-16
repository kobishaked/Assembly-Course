TITLE Q1
; Maor Harash id: 305189409
; This program recive as input 2 arrays in diffrenet size 
; and create new array and return it's sum and it's elements

INCLUDE Irvine32.inc

INCLUDE ex2_q1_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex2-Q1",10,13,0
space BYTE " ",0

.code
main PROC
	mov edx, OFFSET myName
	call writeString
	
	mov sum,0
	mov  esi,0				;this register will be the index of both arrays
	mov ecx, lengthOf Vec1
	
addVec:
	movsx eax,Vec1[esi*2]	;use sign extension cause Vec1 is type WORD
	add eax,Vec2[esi*4]
	add sum,eax 			;calculate the sum
	mov SumVec[esi*4],eax	;create SumVec elements  
	inc esi
	loop addVec
	
	mov edx, OFFSET msg1
	call writeString
	mov eax,sum				;print sum
	call writeInt
	call CRLF

	mov edx, OFFSET msg2
	call writeString
	
	mov ecx, lengthOf SumVec 
	mov edx,offset SumVec
	call Print_Dword_Arr	;print array

	exit
main ENDP

; Print_Dword_Arr: prints signed array of dwords
; Getting arguments in registers:
; EDX - holds the address of the array (first element)
; ECX - holds the number of elements
Print_Dword_Arr PROC
	push eax
	push ecx
	push edx
L1:
	mov eax, [edx]
	call WriteInt
	mov al, ' '
	call writeChar
	add edx, 4
	loop L1
	call CRLF
	pop edx
	pop ecx
	pop eax
	ret
Print_Dword_Arr ENDP
END main	