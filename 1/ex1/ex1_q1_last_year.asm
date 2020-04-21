TITLE ex1_q1
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex1_q1_data_last_year.inc

.data
header BYTE "kobi shaked id: 203207873 EX1-Q1" ,10,13,0
mulSign BYTE " * " ,0
equalSign BYTE " = " ,0

.code
 myMain PROC
 mov edx, OFFSET header
 call writeString
 mov edx, OFFSET MSG
 call writeString

 movsx eax, M
 call writeint
 mov edx, OFFSET mulSign
 call writeString
 movsx eax, N
 call writeint
 mov edx, OFFSET equalSign
 call writeString
 
 
movsx eax, M
; initialize the counter 
movzx ecx, N
dec ecx
; calculate with loop instead of the mul instruction
 summarize:
	add ax, M
	loop summarize
 mov result, eax
 call writeint
 ;call Crlf  // new line 

	exit
myMain ENDP
END myMain




