TITLE ex2_q3
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex2_q3_data.inc

.data
header BYTE "kobi shaked id: 203207873 EX2-Q3" ,10,13,0


.code
 myMain PROC
 mov edx, OFFSET header		;print student details
 call writeString

 mov edx, OFFSET Str_before	;print the before array declaration
 call writeString

 mov edi, OFFSET Arr
 mov ecx, lengthof Arr
 call Print_Dword_Arr		;print the before array
 xor esi, esi

 begin:
	mov eax, esi			;store the esi index
 beginWithoutStore:
	mov ebx, Arr[esi*4]		;store the Arr[esi] and the Arr[esi+1] for using the cmp
	mov edx, Arr[esi*4+4]		
	cmp esi, lengthof Arr	;check if the array finished
	jz continue				;if finished jump to continue
	cmp ebx, edx			;compare two follow elements
	ja switch				;if the first bellow the second switch them 
	mov esi, eax			;if not, restore the esi index from eax
	inc esi					;increase the index
	jmp begin

 switch:					
	mov Arr[esi*4], edx		;switch the two elements
	mov Arr[esi*4+4], ebx
	xor esi, 0				;check if the esi is 0, if yes, restore the esi from eax
	jz restore
	dec esi					;if the esi is not 0, decrease the index to check if need more sorting
	jmp beginWithoutStore 	;start over with the decrease index

 restore:
	mov esi, eax			;if arrived to the begin of the array, restore the esi index 
	inc esi					;and increase the index by 1
	jmp begin

 continue:
	mov edx, OFFSET Str_after	;print the after array declaration
	call writeString
	call Print_Dword_Arr		;print the after array
 
	exit
myMain ENDP

; Print_Dword_Arr: prints signed array of dwords
; Getting arguments in registers:
; EDI - holds the address of the array (first element)
; ECX - holds the number of elements
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
END myMain



