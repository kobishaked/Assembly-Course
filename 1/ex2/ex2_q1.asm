TITLE ex2_q1
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex2_q1_data.inc

.data
header BYTE "kobi shaked id: 203207873 EX2-Q1" ,10,13,0
space BYTE " " ,0

.code
 myMain PROC
 mov edx, OFFSET header ; print student details
 call writeString
 mov edx, OFFSET msg1 ; print sum msg details
 call writeString
 
 xor ebx, ebx ;restore ebx
 mov ecx, lengthof Bvec ;counter of 4 elemnts
 again:
	
	movzx eax, [Bvec + ebx] 
	add [SumVec + ebx*4], eax ;add the byte array
	movsx eax, [Wvec + ebx*2]
	add [SumVec + ebx*4], eax ;add the word array
	mov eax, [Dvec + ebx*4]
	add [SumVec + ebx*4], eax ;add the dword array
	inc ebx ;add 1 to the index array
 loop again

 mov edi, OFFSET SumVec ; ;initialize the edi register for the print func
 mov ecx, lengthof Bvec ;initialize the ecx register for the print func
 call Print_Dword_Arr ; call the print func

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



