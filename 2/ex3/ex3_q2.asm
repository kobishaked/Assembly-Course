TITLE Q2
; Maor Harash id: 305189409
; This program prints to screen a string and its number in the wanted base

INCLUDE Irvine32.inc
INCLUDE ex3_q2.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex3-Q2",10,13,0
arrow BYTE " ---> ",0
BAD BYTE "BAD",0

.code
main PROC
	mov edx, OFFSET myName
	call writeString
	
	mov ecx, LengthOf STR_ARR
	mov esi,0
	again:
	push STR_ARR[esi]
	call ConvRadix
	add esi,4
	loop again

	exit
main ENDP


; ConvRadix: convert Num to it's actual number acording to base in the first digit
; Getting arguments in Stack:
;  Num - Pointer to string 
ConvRadix PROC
	Num = 8
	push ebp
	mov ebp,esp
	push esi
	push ecx
	
	mov esi,[ebp+Num]
	
	mov eax,0
	mov ebx,0
	mov ecx,0
	mov cl,[esi] ;hold the base
	sub cl,'0'
	inc esi
	
	again:		
	cmp BYTE PTR[esi],0 ;check for end of string
	je goodNumber
	
	mov bl,0
	mov bl,[esi]
	sub bl,'0'
	
	cmp cl,bl	;check if one of the digits is bigger then the base
	jle badNumber
	
	mul ecx
	jc badNumber	;check if an overflow happen
	
	add eax,ebx	
	inc esi
	jmp again
	
	goodNumber: ; print a good number , meaning the convert was successful
	mov edx, [ebp+Num]
	call writeString
	mov edx,OFFSET arrow
	call writeString
	call writeDec
	call CRLF 
	jmp endFunc
	
	badNumber: ; the convertion has failed
	mov edx, [ebp+Num]
	call writeString
	mov edx,OFFSET arrow
	call writeString
	mov edx,OFFSET BAD
	call writeString
	call CRLF 
	
	endFunc:
	
	pop ecx
	pop esi
	mov esp,ebp
	pop ebp
	ret 4
ConvRadix ENDP

END main