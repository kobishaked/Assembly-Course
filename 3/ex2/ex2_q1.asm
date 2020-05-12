TITLE E2_Q1
;Kobi Shaked 203207873
INCLUDE Irvine32.inc

.data
	header BYTE "Kobi Shaked id: 203207873 Ex2-Q1",10,13,0
	rqst_char BYTE "Please Enter a character: ",0
	rqst_size BYTE "Please Enter the triangle size: ",0
    char_input BYTE ?
	N BYTE ?
    space BYTE " "


.code
main PROC
	    mov edx, OFFSET header 
	    call writeString
	    mov edx, OFFSET rqst_char 
	    call writeString
        call ReadChar
        call WriteChar
        call CRLF
        mov char_input, al                  ;save the char into the char_input variable
        mov edx, OFFSET rqst_size 
	    call writeString
        call readDec
        mov N, al                           ;save the size into the N variable
        movzx ecx, N                        ;initialize the counter of the outer loop (depend on the size that inserted)
        mov ebx, 1                          ;initialize the numbers of times the char will printing (1 in the first row)

    outer:
        mov esi, ecx                        ;saving the outer counter

    spaces:
        mov edx, OFFSET space               ;loop for printing the spaces in the row
	    call writeString 
    loop spaces
    mov ecx, ebx                            ;initialize the counter for the number of chars in the row
    chars:
        movzx eax, char_input               ;loop for printing the chars in the row
        call WriteChar
    loop chars
    call CRLF
    add ebx, 2                              ;add 2 in order to increase the number of chars that will print in the next row
    mov ecx, esi                            ;restore the outer counter
    loop outer

	exit
main ENDP
END main


 
