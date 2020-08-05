TITLE EX1_Q2
;Kobi Shaked 203207873

INCLUDE Irvine32.inc
INCLUDE ex1_q2_data.inc

.data
header BYTE "Kobi Shaked id: 203207873 Ex1-Q2",10,13,0
mulSign BYTE " * ", 0
minusSign BYTE " - ", 0
equalSign BYTE " = ", 0
mulRes DWORD ?

.code
 myMain PROC
    mov edx, OFFSET header      ;printing the exercise
    call writeString
    mov edx, OFFSET MSG
    call writeString
    movsx eax, X
    call writeint
    mov edx, OFFSET minusSign
    call writeString
    movsx eax, Y
    call writeint
    mov edx, OFFSET mulSign
    call writeString
    movsx eax, Z
    call writeint
    mov edx, OFFSET equalSign
    call writeString

    movsx eax, Z             
    movzx ecx, Y                ;initialize the counter
    dec ecx
    
    summarize:                  ;calculate with loop instead of the mul instruction
	    add ax, Z
	    loop summarize
    mov mulRes, eax
    movsx eax, X
    sub eax, mulRes
    mov RESULT, eax
    call writeint

	exit
myMain ENDP
END myMain

