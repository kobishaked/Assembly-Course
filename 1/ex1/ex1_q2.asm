TITLE ex1_q2 
;name: kobi shaked. id: 203207873

INCLUDE Irvine32.inc
INCLUDE ex1_q2_data.inc

.data
header BYTE "kobi shaked id: 203207873 EX1-Q2" ,10,13,0
firstNumInSeries DWORD 1 ; first two numbers in the series
sumOfSeries DWORD 0 ; hold the sum of the series

.code
 myMain PROC
 mov edx, OFFSET header ;  print students details
 call writeString

 mov eax, firstNumInSeries  ; initialize the 2 first members of the Tri-Bonachi series 
 mov eax,firstNumInSeries ;print first member
 call writeDec
 mov edx, OFFSET separator ;print separator
 call writeString
 call writeDec ;print second member

 mov ecx, N  ; initialize the count of the loop
 sub ecx, 2 ; without the 2 first members

 
 mov ebx,firstNumInSeries 
 mov esi,firstNumInSeries
 mov sumOfSeries, eax ;add the two first members to the sum
 add sumOfSeries, eax
 ;ebx - first number. esi - second number. eax - next
 again:
 ;do the tribonachi formula calculating - t(n - 1) * 2 + t(n - 2)
 mov eax, esi
 add eax, esi
 add eax, ebx
 
 add sumOfSeries,eax ;add the new member to the sum 
 mov edx, OFFSET separator 
 call writeString
 call writeDec

 xchg ebx,esi ; switch first and second members
 xchg esi,eax ; switch second and third members
 xor eax,eax  ; reset the eax (third member) register
 loop again

 call Crlf
 
 mov edx, OFFSET msg ; print sum declaration 
 call writeString
 mov eax,sumOfSeries ; print sum of the series
 call writeDec

	exit
myMain ENDP
END myMain



