TITLE ex1_q3
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex1_q3_data.inc

.data
header BYTE "kobi shaked id: 203207873 EX1-Q3" ,10,13,0
 counterOf1 BYTE ?      ; for saving the loop1 ecx counter
 counterOf2 BYTE ?      ; for saving the loop2 ecx counter
 numOfMul BYTE 1        ; the number of multiples in a specific place, use in the loop3
 colNum WORD 1          ; index of the col number
 space BYTE " " ,0

.code
 myMain PROC
 mov edx, OFFSET header ; print students details
 call writeString
 mov edx, OFFSET MSG1   ; print MSG1
 call writeString
 call ReadInt           ; insert the input in eax register
 mov bl, al             ;save the input in the ebx register

 movzx ecx, bl          ;initialize the LOOP1 counter with the readInt input
 loop1:
 mov counterOf1, cl     ; saving the LOOP1 counter
 movzx ecx, bl          ; initialize the LOOP2 counter with the readInt input
 loop2:
 mov counterOf2, cl     ; saving the LOOP2 counter
 movzx ecx, numOfMul    ; initialize the LOOP3 counter with the number of nultiplse
 xor eax, eax           ; reset the eax register
 loop3:                 ; loop for summarize the specific place
 add ax, colNum         ; 
 loop loop3
 call writeDec          ; print the number in the specific place
 mov edx, OFFSET space  ; print a space
 call writeString
 add colNum, 1          
 movzx cx, counterOf2   ; restore the counter of loop2
 loop loop2
 call Crlf              ; new line 
 mov colNum, 1          ; reset the colum num
 add numOfMul, 1      

 movzx cx, counterOf1 ; restore the counter of loop1
 loop loop1

	exit
myMain ENDP
END myMain



