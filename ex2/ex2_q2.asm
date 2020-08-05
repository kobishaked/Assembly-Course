TITLE EX2_Q2
;Kobi Shaked 203207873

INCLUDE Irvine32.inc
INCLUDE ex2_q2_data.inc

.data
header BYTE "Kobi Shaked id: 203207873 Ex2-Q2",10,13,0

.code
 myMain PROC
 mov edx, OFFSET header             ; print student details
 call writeString

 xor ebx, ebx                       ;restore ebx
 mov ecx, lengthof Bvec             ;counter of 4 elemnts
 again:
	
	movzx eax, [Bvec + ebx] 
	add [SumVec + ebx*4], eax       ;add the byte array
	movsx eax, [Wvec + ebx*2]
	add [SumVec + ebx*4], eax       ;add the word array
	mov eax, [Dvec + ebx*4]
	add [SumVec + ebx*4], eax       ;add the dword array
	inc ebx                         ;add 1 to the index array
 loop again

 mov edi, OFFSET SumVec             ;initialize the edi register for the print func
 mov ecx, lengthof Bvec             ;initialize the ecx register for the print func
 call Print_Dword_Arr               ;call the print func

	exit
myMain ENDP
END myMain

