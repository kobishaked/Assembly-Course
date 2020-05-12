.data
Bvec    BYTE   0FFh, 0FEH, 10, 3	; 255, 254, 10, 3
Wvec    SWORD  -5, -54, 100, 3000
Dvec    SDWORD -500, 200, 300, 3000000
SumVec  SDWORD lengthOf Bvec DUP (?)

.code

; Print_Dword_Arr: prints signed array of dwords
; Getting arguments in registers:
;   EDI - holds the address of the array (first element)
;   ECX - holds the number of elements
Print_Dword_Arr PROC
	push eax
	push ecx
	push edi
L1:
    mov eax, [edi]
	call WriteInt
	mov al, ' '
	call writeChar
	add edi, 4
	loop L1
	
	call CRLF
	pop edi
	pop ecx
	pop eax
	ret
Print_Dword_Arr ENDP