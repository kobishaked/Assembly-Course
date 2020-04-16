TITLE Q2
; Maor Harash id: 305189409
; this function recive an array with letters and symboles and 
;return an array with only letters and sorting 

INCLUDE Irvine32.inc
INCLUDE ex2_q2_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex2-Q1",10,13,0

.code
main PROC
	mov edx, OFFSET myName
	call writeString
	
	mov edx, OFFSET msg1
	call writeString
	
	mov edx, OFFSET SrcStr
	call writeString
	call CRLF
	
	mov ebx, offset SrcStr
	mov edx, offset DestStr
	call filter_string				;second function - filtring
	
	mov edx, OFFSET msg2
	call writeString
	
	mov edx, OFFSET DestStr
	call writeString
	call CRLF
	
	mov ecx,0
	mov ebx, offset DestStr
	call STRLEN 
	
	dec ecx
	mov ebx, offset DestStr
	call sort_string 				;third function - sorting
	
	mov edx, OFFSET msg3
	call writeString
	
	mov edx, OFFSET DestStr
	call writeString
	call CRLF
	
	exit
main ENDP

; ls_alpha : return if the input is a letter ( UpperCase or LowerCase)
;WHAT WE WANT:  if (al >= 'A' && al<='Z') || (al >='a' && al<='z') ? return 1 : return 0 ;
; Getting arguments in registers:
; AL - holds the input
; EAX - holds 1 if it's letter and 0 otherwise
ls_alpha PROC
	;push eax;	
	;check if : al >= 'A' && al<='Z'
	cmp al,'A' 
	jb LowerCase		; happen al < 'A'
	cmp al,'Z'
	ja LowerCase		; happen al > 'Z'
	jmp Letter			; Found a letter because al >= 'A' && al<='Z'
	
	;check if : al >='a' && al<='z'
LowerCase:	
	cmp al,'a' 			
	jb NotLetter		; happen al < 'a'
	cmp al,'z'
	ja NotLetter		; happen al > 'z'
Letter:
	mov eax,1			; Found a letter 
	jmp endFunc
NotLetter: 
	mov eax,0		
endFunc:						
	;pop ebx;
	ret	
ls_alpha ENDP

; filter_string : create an array that have only UpperCase or LowerCase letters
; Getting arguments in registers:
; EBX - holds the source array
; EDX - holds the destination array
filter_string PROC

LOOP1:
	mov al,[ebx]
	cmp al,0			;check if the string is done 
	jz endFunc
	call ls_alpha		;check for a letter
	cmp eax,0
	jz endLoop
	mov al,[ebx]
	mov [edx],al
	inc edx				;found a letter, add to the arrat des
endLoop:
	inc ebx
	jmp LOOP1
endFunc:		
	ret	
filter_string ENDP


; sort_string : sorting an array
; Getting arguments in registers:
; EBX - holds the source array
; ECX - holds the length of the array
sort_string PROC	
	mov edi,0
loop1:	;for i=0...N-1
	cmp edi,ecx
	jz endFunc
	mov esi,0
	loop2:	;for j=0...N-i-1
		mov eax,ecx
		sub eax,edi
		cmp esi,eax
		jz endLoop2			
		call compare_chars
		cmp eax , 0
		je next			;if equal then no swap
		call SWAP
	next:
		inc esi
		jmp loop2
endLoop2:
	inc edi			
	jmp loop1
endFunc:		
	ret	
sort_string ENDP


; compare_chars : comapre to chars and return 1 if esi is bigger then edi and 0 otherwise
; Getting arguments in registers:
;EBX - holds the source array
; ESI -holds index to first and second char
; EAX - will hold the output
compare_chars PROC
	mov eax,0
	mov al,[ebx+esi]
	mov ah,[ebx+esi+1]
	;check if : al<='Z'	
	cmp al,'Z'			; we check only this condition cause the array have only letters
	ja nxt1
	add al,'a' - 'A'	;change to lowerCaseLetter	
nxt1: 
	cmp ah,'Z'	
	ja nxt2
	add ah,'a' - 'A'
nxt2: 
	cmp al,ah
	ja Above			; al > ah 
	mov eax,0
	jmp endFunc
Above: mov eax,1		; al <=ah
endFunc:	ret
compare_chars ENDP



; SWAP : swap two chars
; Getting arguments in registers:
; EBX - holds the source array
; ESI - first end second char
SWAP PROC	
	mov eax,0
	mov al,[ebx+esi]
	xchg [ebx+esi+1],al
	mov [ebx+esi],al
	ret
SWAP ENDP


; STRLEN : return a length of wanted array
; Getting arguments in registers:
; EBX - holds the source array
; ECX - holds the length of the array
STRLEN PROC
	mov eax,0
LOOP1:
	mov al,[ebx]
	cmp al,0
	jz endFunc
	inc ebx
	inc ecx
	jmp LOOP1
endFunc:
	ret
STRLEN ENDP



END main