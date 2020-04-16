TITLE Q1
; Maor Harash id: 305189409
; This program recive an array , and return an array with the index of an element in the fibonacci series 

INCLUDE Irvine32.inc
INCLUDE ex3_q1_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex3-Q1",10,13,0
headLine BYTE "Results of Fib Arrays:",10,13,0
fibRowPart1 BYTE "fib(",0
fibRowPart2 BYTE ")=",0

.code
main PROC
	mov edx, OFFSET myName
	call writeString
	
	mov esi,0
	mov eax,0
	
	again:
	movzx eax, Nums[esi*1]
	push eax 
	call fib_rec ; calculate the fibonacci number
	mov FIB[esi*4],eax	
	cmp esi,LengthOf Nums - 1
	je endLoop ; check if the it's the end of the string
	inc esi
	jmp again
	
	endLoop:
	mov edx, OFFSET headLine
	call writeString

	push offset FIB
	push offset Nums
	push LengthOf Nums
	call print_fib_results ;print the arrays

	exit
main ENDP


; fib_rec: calculate the value of a element Num in the fibonacci series
; Getting arguments in Stack:
; Num  - holds the fibonacci index we want to return
; FIB_1,FIB_2  - holds a local elements of the fibonacci array 
fib_rec PROC
	Num = 12
	FIB_1 = -4
	FIB_2 = FIB_1 -4	
	push ebx
	push ebp
	mov ebp,esp
	
	; the base of the Recursion
	cmp DWORD PTR[ebp + Num],1 ;if num <=1
	jg option2
	mov eax,[ebp+Num] 		   ;return num
	jmp endfunc
	
	option2:	;else
	sub esp,8
	mov ebx,[ebp+Num]
	
	dec ebx
	push ebx
	call fib_rec
	mov [ebp+FIB_1],eax ;FIB_1 = fib_rec (num -1)
	
	dec ebx
	push ebx
	call fib_rec
	mov [ebp+FIB_2],eax ;FIB_2 = fib_rec (num -2)
	
	mov eax,[ebp+FIB_1]
	add eax,[ebp+FIB_2] ;return FIB_1+FIB_2

	endfunc:
	mov esp,ebp
	pop ebp
	pop ebx
	ret 4
fib_rec ENDP


; print_fib_results: print the elemntes in both arrays
; Getting arguments in Stack:
; ArraySize - holds the size of the arrays  
; ArrayNums, ArrayFib  - holds the index in ArrayNums and their fibonacci value in ArrayFib
print_fib_results PROC
	ArraySize=8
	ArrayNums = ArraySize+4
	ArrayFib = ArrayNums+4
	
	push ebp
	mov ebp,esp
		
	mov ecx,[ebp+ArraySize]
	
	again:
	push [ebp+ArrayNums]	;send the offset to the print function row
	push [ebp+ArrayFib]
	
	call print_fib_entry
	
	add BYTE PTR [ebp+ArrayNums],1
	add DWORD PTR [ebp+ArrayFib],4
	loop again
	
	mov esp,ebp
	pop ebp
	ret 12
print_fib_results ENDP


; print_fib_entry: print a row 
; Getting arguments in Stack:
; ArrayNums, ArrayFib  - holds the index in ArrayNums and their fibonacci value in ArrayFib
print_fib_entry PROC
	ArrayFib  = 8
	ArrayNums = ArrayFib + 4
	push ebp
	mov ebp,esp
	
	mov ebx,0
	mov eax,0
	
	mov edx, OFFSET fibRowPart1
	call writeString
	
	mov ebx,[ebp+ArrayNums] 
	mov al,[ebx]		;get access to actual value
	call WriteDec
	
	mov edx, OFFSET fibRowPart2
	call writeString

	mov ebx,[ebp+ArrayFib]
	mov eax,[ebx] 		;get access to actual value
	
	call WriteDec
	call CRLF 
	
	mov esp,ebp
	pop ebp
	ret 8
print_fib_entry ENDP


END main