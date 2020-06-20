TITLE EX3_Q2
;Kobi Shaked 203207873

INCLUDE Irvine32.inc
.data
	header BYTE "Kobi Shaked id: 203207873 Ex3-Q2",10,13,0
	rqst_char BYTE "Please Enter a character: ", 0
	rqst_size BYTE "Please Enter the triangle size: ", 0
	character WORD ?
	triangle_size WORD ?
	space BYTE " "
	spaces_in_line DWORD ?
	num_of_char_in_line DWORD ?
.code
main PROC
	mov edx, OFFSET header			;print student details
	call writeString

	mov edx, OFFSET rqst_char		;get the char from the user
	call writeString
	call readChar
	call writeChar
	mov character, ax

	call CRLF

	mov edx, OFFSET rqst_size		;get the size of the triangle from the user
	call writeString
	call readDec
	mov triangle_size, ax

	mov ecx, 0
	mov eax, 0
	push triangle_size				;second argument to the functions
	push character					;first argument to the functions
	call print_triangle_2			;this function get it argument from the stack

	call exitProcess

main ENDP

print_triangle_1 PROC					
    mov ebx, 1						;initiaise the number of characters per row
 outer:
        push ecx                    ;saving the outer counter number of spaces in a row)
    spaces:
        mov edx, OFFSET space       ;loop for printing the spaces in the row
	    call writeString 
    loop spaces
    mov ecx, ebx                    ;initialize the counter for the number of chars in the row
    chars:
        call WriteChar				;at this point eax holds the char
    loop chars
    call CRLF
    add ebx, 2						;add 2 in order to increase the number of chars that will print in the next row
	pop ecx							;restore the value of exc        
    loop outer
	ret
print_triangle_1 ENDP


print_triangle_2 PROC
	push ebp
	mov ebp, esp
	mov al, BYTE PTR [ebp + 8]		;get data of byte size from the start of the first argument (the character)
	mov cl, BYTE PTR [ebp + 10]		;get data of byte size from the start of the second argument (the triangle size)
	call print_triangle_1			;this function get it argument from the register
	mov esp, ebp
	pop ebp
	ret 4							;got 2 arguments of WORD size so need to get back 4 bytes in the stack
print_triangle_2 ENDP
END main