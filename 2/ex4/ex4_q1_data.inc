DAY_TIME  = 0
FUNC_PTR  = DAY_TIME + 4
COUNT     = FUNC_PTR + 4
_NEXT     = COUNT + 1

STRUCT_SIZE = _NEXT + 4


.data
Head DWORD item1

item1    DWORD 453B8h   ;
         DWORD PRINT_1   ; func_ptr
		 BYTE  2         ; count
		 DWORD item2     ; _NEXT

item2    DWORD 727B9h   ; 
         DWORD PRINT_2   ; func_ptr
		 BYTE  5         ; count
		 DWORD item3      ; _NEXT

item3    DWORD 0F7EFAh   ; day_time Saturday (7), 23:59:58 PM
         DWORD PRINT_1   ; func_ptr
		 BYTE  4         ; count
		 DWORD item4      ; _NEXT
		 
item4    DWORD 0D7EFAh   ; day_time Friday (6), 23:59:58 PM
         DWORD PRINT_2   ; func_ptr
		 BYTE  6         ; count
		 DWORD item5      ; _NEXT

item5    DWORD 02BEFAh   ; day_time Sunday (1), 11:59:58 AM
         DWORD PRINT_1   ; func_ptr
		 BYTE  6         ; count
		 DWORD NULL      ; _NEXT

;============================================
SUNDAY    BYTE "SUNDAY", 0
MONDAY    BYTE "MONDAY", 0
TUESDAY   BYTE "TUESDAY", 0
WEDNESDAY BYTE "WEDNESDAY", 0
THURSDAY  BYTE "THURSDAY", 0
FRIDAY    BYTE "FRIDAY", 0
SATURDAY  BYTE "SATURDAY", 0

SUN    BYTE "SUN", 0
MON    BYTE "MON", 0
TUE    BYTE "TUE", 0
WED    BYTE "WED", 0
THU    BYTE "THU", 0
FRI    BYTE "FRI", 0
SAT    BYTE "SAT", 0

DAYS_SHORT DWORD 0, SUN, MON, TUE, WED, THU, FRI, SAT
DAYS_LONG  DWORD 0, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, 
                 THURSDAY, FRIDAY, SATURDAY

.code
; ===========================================
; print_colon
; ===========================================
print_colon PROC 
  push eax
  mov al, ':'
  call writeChar
  pop eax
  ret
print_colon ENDP

; ===========================================
; print_single_space
; ===========================================
print_single_space PROC 
  push eax
  mov al, ' '
  call writeChar
  pop eax
  ret
print_single_space ENDP

; ===========================================
; print_CR
; prints ONLY CR (and does not print LF)
; While in development mode, print also the LF
; So you are able to observe what's happening. 
; Comment out the printing of LF in production,
; or before submitting your exercise
; ===========================================
print_CR PROC 
  push eax
  mov al, 13  ; CR character
  call writeChar

  ; comment-out or un-comment-out the next two lines
  mov al, 10  ; LF character
;  call writeChar
  pop eax
  ret
print_CR ENDP

; ===========================================
; print_small_num: prints the small num in AL
; ===========================================
print_small_num PROC 

  movzx eax, al
  cmp al, 10
  jge skip11
  push eax
  mov al, '0'
  call writeChar
  pop eax
skip11:
  call writeDec
  ret
print_small_num ENDP

; ===========================================
; mySleep
; ===========================================
mySleep PROC
	pushad
	push 1000
	call sleep
	popad
	ret
mySleep ENDP
