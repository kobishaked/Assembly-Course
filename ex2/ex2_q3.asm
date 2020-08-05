TITLE EX2_Q3
;Kobi Shaked 203207873
INCLUDE Irvine32.inc

.data
header BYTE "Kobi Shaked id: 203207873 Ex2-Q3",10,13,0
insertMsg BYTE "Enter a string:",10,13,0
afterProccesingMsg BYTE "After processing the string is: ",10,13,0
input BYTE 80 DUP (?),0	
upperCaseString BYTE 80 DUP (?),0

.code
main PROC
mov edx, OFFSET header					   ;print student details
call writeString
mov edx, OFFSET insertMsg				   ;print insert msg
call writeString
mov edx, OFFSET input
mov ecx, SIZEOF input
call readString
mov esi, 0									;input string index
mov ebx, 0									;upper case string index
again:
	cmp input[esi], 0						;stop condition
	jz finish				
	mov al, input[esi]		
	cmp input[esi], 'A'						
	jb skip									;check if the char is bellow the 'A' char
	cmp input[esi], 'Z'
	ja skip									;check if the char is above the 'Z' char
	mov upperCaseString[ebx], al			;if the char is A-Z then add it to the upperCaseString
	inc ebx									;inc the upper case string index
	jmp done

skip:										;if the char is not A-Z 
	cmp input[esi], 'a'						
	jb done									;check if the char is bellow the 'a' char, if so dont do nothing (jump to done)
	cmp input[esi], 'z' 
	ja done									;check if the char is above the 'a' char, if so dont do nothing (jump to done)
	mov upperCaseString[ebx], al			;if the char is a-z change it to upper case and add it to the upperCaseString
	sub upperCaseString[ebx], 32
	inc ebx

done:
	inc esi									;inc the input string index
	jmp again

finish:
	mov edx, OFFSET afterProccesingMsg      ;print student details
	call writeString
	mov edx, OFFSET upperCaseString         ;print upper case string
	call writeString

	exit
main ENDP
END main











