TITLE EX3_Q1
;Kobi Shaked 203207873

INCLUDE Irvine32.inc
INCLUDE ex3_q1_data.inc

.data
	header BYTE "Kobi Shaked id: 203207873 Ex1-Q3",10,13,0
	arrSize = TYPE Arr_1
	sumArr_1 SDWORD ?

.code
main PROC
	mov edx, OFFSET header			;print student details
	call writeString

	mov edx, OFFSET msg1
	call writeString

	push LENGTHOF Arr_1				;arguments of arr1 to the function
	push OFFSET Arr_1
	call SumArray
	call writeInt					;at this point eax hold the return value from the function
	mov SumArr_1, eax
	call CRLF

	mov edx, OFFSET msg2
	call writeString

	push LENGTHOF Arr_2				;arguments of arr2 to the function	
	push OFFSET Arr_2
	call SumArray
	call writeInt					;at this point eax hold the return value from the function
	call CRLF

	cmp eax, SumArr_1				;at this point eax hold the return value from the second call of the function
									;and we making comparison between the 2 sums
	jng  Sum1Greater				;jump in a case that sum of arr1 greater than sum of arr2 
	mov edx, OFFSET arr2_bigger		;correct msg for this case
	call writeString
	call CRLF
	jmp done

Sum1Greater:
	mov edx, OFFSET arr1_bigger		;correct msg for this case
	call writeString
	call CRLF

done:
	call exitProcess
main ENDP

SumArray PROC						;This function calculate the sum of array
									;receive: 1. Address of the array in esi 2.Number of Elements in ecx
									;return:  Sum of the array in EAX 
	push ebp
	mov ebp, esp

	mov ecx, [ebp + 12]				;second argument, the length of the array
	mov esi, [ebp + 8]				;first argument, offset of the array
	mov eax, 0
L1:

	movsx ebx, WORD PTR [esi]		;get the value of the element
	add eax, ebx					;eax hold the sum
	add esi, arrSize				;move the index to the next element
	loop L1
	mov esp, ebp
	pop ebp
	ret 8							;we got 2 arguments of DWORD size so need to get back 8 bytes in the stack

SumArray ENDP
END main