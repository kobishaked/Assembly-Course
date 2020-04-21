TITLE EX1_Q3
;Kobi Shaked 203207873

INCLUDE Irvine32.inc

N=10

.data
    header BYTE "Kobi Shaked id: 203207873 Ex1-Q3",10,13,0
    firstOutput BYTE "Fib(" ,0
    secondOutput BYTE ") = " ,0
    firstNumInSeries DWORD 0                ;first number in the series
    secondNumInSeries DWORD 1               ;second number in the series

.code
     myMain PROC
        mov edx, OFFSET header              ;print student details
        call writeString

        mov edx, OFFSET firstOutput         ;print the first 2 lines 
        call writeString
        mov eax, firstNumInSeries
        call writeDec
        mov edx, OFFSET secondOutput 
        call writeString
        call writeDec
        call Crlf
        mov edx, OFFSET firstOutput 
        call writeString
        mov eax, secondNumInSeries
        call writeDec
        mov edx, OFFSET secondOutput 
        call writeString
        call writeDec
        call Crlf

        mov ecx, N                         ;initialize the count of the loop
        sub ecx, 1
        xor eax,eax
        
        mov ebx, firstNumInSeries          ;ebx - first number
        mov esi, secondNumInSeries         ;esi - second number. 
        again:
           mov edx, OFFSET firstOutput 
           call writeString
           mov eax, N                      ;calculate the index
           inc eax
           sub eax, ecx
           call writeDec                   ;print the index
           mov edx, OFFSET secondOutput 
           call writeString
    
           mov eax, ebx                    ;eax - next number
           add eax, esi                    ;calculate the next number
           call writeDec
           xchg ebx,esi                    ;switch first and second numbers
           xchg esi,eax                    ;switch second and third numbers
           xor eax,eax                     ;reset the eax (next number) register for the next iteration
           call Crlf
        loop again
         
	    exit
    myMain ENDP
    END myMain