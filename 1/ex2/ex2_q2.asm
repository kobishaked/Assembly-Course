TITLE ex2_q2
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex2_q2_data.inc

.data
header BYTE "kobi shaked id: 203207873 EX2-Q2" ,10,13,0
firstChar BYTE ?
secondChar BYTE ?
thirdChar BYTE ?
space BYTE " " ,0


.code
 myMain PROC
 mov edx, OFFSET header		;print student details
 call writeString

 mov edx, OFFSET Str_before ;print the before decleration
 call writeString
 mov edx, OFFSET Seuss		;print the before string
 call writeString

 mov edx, OFFSET ask_1st	;get & print the first char input
 call writeString
 call readChar
 mov firstChar, al
 call writeChar
 call CRLF

 mov edx, OFFSET ask_2nd	;get & print the second char input
 call writeString
 call readChar
 mov secondChar, al
 call writeChar
 call CRLF

 mov edx, OFFSET ask_3rd	;get & print the third char input
 call writeString
 call readChar
 mov thirdChar, al
 call writeChar
 call CRLF


 xor esi, esi				;the indexer
 begin:
	xor Seuss[esi], 0		;check if the string finished
	jz continue
	movzx eax, Seuss[esi]	;get the current char of the string 
	cmp al, firstChar		;check if the char is the firstChar
	jz switch				;if yes, jump to switch them
	cmp al, secondChar		;check if the char is the secondChar
	jz switch				;if yes, jump to switch them
	inc esi					;increase the index
	jmp begin				;if both of the chars not the current char start over

 switch:
	movzx eax, thirdChar	;insert the third char to eax
	mov Seuss[esi], al		;change the current char with the third char
	inc esi					;increase the index
	jmp begin				;start over

 continue:
	mov edx, OFFSET Str_after	;print the after string declaration
	call writeString
	mov edx, OFFSET Seuss		;print the after string
	call writeString
 
	exit
myMain ENDP
END myMain



