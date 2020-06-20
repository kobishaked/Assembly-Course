TITLE EX3_Q3
;Kobi Shaked 203207873

INCLUDE Irvine32.inc
INCLUDE ex3_q3_data.inc
.data
	header BYTE "Kobi Shaked id: 203207873 Ex3-Q3",10,13,0
.code
main PROC
	mov edx, OFFSET header				;print student details
	call writeString

	push SSIZE							;third parameter
	push CHAR							;second parameter
	push SSIZE							;first parameter
	call write_triangle_rec

	call exitProcess

main ENDP

write_triangle_rec PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]					;eax = size
	cmp eax, 0
	je done								;size == 0
	mov ecx, [ebp + 16]					;ecx = org_size
	sub ecx, eax						;ecx = org_size - size
	jz prepareSecondLoop
L1:
	mov al, ' '
	call writeChar
	loop L1

prepareSecondLoop:
	mov ecx, [ebp + 8]					;ecx = size
	add ecx, [ebp + 8]					;ecx = size + size
L2:
	mov al, BYTE PTR [ebp + 12]
	call writeChar
	loop L2

	call CRLF
	push SSIZE							;third parameter = org_size
	push CHAR							;second parameter
	mov eax, [ebp + 8]
	dec eax
	push eax							;first parameter = --size
	call write_triangle_rec

done:
	mov esp, ebp
	pop ebp
	ret 12								;TYPE SIZE = TYPE CHAR = TYPE ORG_SIZE = 4 


write_triangle_rec ENDP
END main