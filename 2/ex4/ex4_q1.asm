TITLE ex4_q1
; Maor Harash id: 305189409
; This program print a list that it's elemnt conatin time and conut, 
; the prigram will print each elemnt's time count times  

INCLUDE Irvine32.inc
INCLUDE ex4_q1_data.inc

.data
myName BYTE "Maor Harash id: 305189409 Ex4-Q1",10,13,0
AM BYTE "AM",0
PM BYTE "PM",0

; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MaskSECOND DWORD 3Fh     ;0000 0000 0000 0011 1111  ;mask for the prints
MaskMINUTE DWORD 0FC0h   ;0000 0000 1111 1100 0000
MaskHOUR   DWORD 1F000h  ;0001 1111 0000 0000 0000
MaskDAY    DWORD 0E0000h ;1110 0000 0000 0000 0000

MaskSECOND_REV DWORD 0FFFC0h   ;1111 1111 1111 1100 0000	;masks for the incSecond
MaskMINUTE_REV DWORD 0FF000h   ;1111 1111 0000 0000 0000
MaskHOUR_REV   DWORD 0E0000h   ;1110 0000 0000 0000 0000
MaskDAY_REV    DWORD 0h   	   ;0000 0000 0000 0000 0000

SECONDPOS = 6  ;end positon of amount of bits
MINUTEPOS =12
HOURPOS =17
DAYPOS = 20

MAX=20				;length of each bits pack
SECONDLENGTH = 6
MINUTELENGTH = 6
HOURLENGTH = 5 
DAYLENGTH  = 3
; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.code
main PROC
	mov edx, OFFSET myName
	call writeString

	push Head
	call for_On_the_List
	
	exit
main ENDP

; ===========================================
; for_On_the_List: run on the list 
; Params:   list head
; ===========================================
for_On_the_List PROC
	ListHead=8 
	push ebp
	mov ebp,esp
	push esi

	mov esi,[ListHead+ebp]
    cmp esi,0
    je EmptyList 
	NextElement:
	push esi
	call handle_one_element
	
	mov esi, _NEXT[esi] ;Next element
    cmp esi,0           ;End of list?
    je Done             ;Yes, get out.
	jmp NextElement
	
	Done:
	EmptyList:
	pop esi
	mov esp,ebp
	pop ebp
	ret 4
for_On_the_List ENDP

; ===========================================
; handle_one_element: print the day time count times 
; Params: 1.  Element hold a elemnet form the list
; ===========================================
handle_one_element PROC uses esi ebx ecx edx
	Element=8 + 4*4
	NUM2=-4
	push ebp
	mov ebp,esp
	sub esp,4
	
	mov esi,[ebp+Element]	
	mov ebx ,[esi +DAY_TIME]
	mov ecx,0
	mov cl , [esi +COUNT]
	mov edx , [esi +FUNC_PTR]
	
	again:
	call edx
	call mySleep
	
	mov [ebp+NUM2],ebx
	lea eax,[ebp+NUM2]
	push eax
	call incSecond
	mov ebx,[ebp+NUM2]
	call print_CR
	loop again
	call CRLF
	
	mov esp,ebp
	pop ebp
	ret 4
handle_one_element ENDP


; ===========================================
; PRINT_1: print in the first format 
; Params: EBX - hold the date and time
; ===========================================
PRINT_1 PROC
		
	;--> Day calculation
	push ebx
	push MaskDAY
	mov eax,DAYPOS
	sub eax,DAYLENGTH
	push eax
	call getValue
	pop ebx		
	call printDay1
	;<-- Day calculation
	
	;--> HOUR calculation
	push ebx
	push MaskHOUR
	mov eax,HOURPOS
	sub eax,HOURLENGTH
	push eax
	call getValue
	call printHour1
	pop ebx		
	;<-- HOUR calculation

	push eax ; hold the hour for the am pm calculation
	
	;--> MINUTE calculation
	push ebx
	push MaskMINUTE
	mov eax,MINUTEPOS
	sub eax,MINUTELENGTH
	push eax
	call getValue
	call printMinute
	pop ebx
	;<-- MINUTE calculation
	
	;--> SECOND calculation
	push ebx
	push MaskSECOND
	mov eax,SECONDPOS
	sub eax,SECONDLENGTH
	push eax
	call getValue
	call printSecond
	pop ebx
	;<-- SECOND calculation

	;-->AM : PM
	pop eax 
	call printAMPM
	;<--AM : PM
	
	ret 
PRINT_1 ENDP

; ===========================================
; getValue: return the wanted part number from the DOWRD veriable
; Params: 1. mask
;		  2. how many shift left
;		  3. EBX - HOLD THE NUMBER	
; Return Value : hold in EAX - represent the wanted number	 
; ===========================================
getValue PROC
	SHIFT = 8
	MASKED = SHIFT+4
	push ebp
	mov ebp,esp
	
	and ebx,[ebp+MASKED]
	push ecx
	mov ecx,[ebp+SHIFT]
	shr ebx,cl
	pop ecx
	mov eax,ebx	

	mov esp,ebp
	pop ebp
	ret 8
getValue ENDP

; ===========================================
; printDay1: print the spesific day
; Params: 1. eax - hold the number of day in the array of days
; ===========================================
printDay1 PROC
	push edx
	mov edx, [DAYS_SHORT+ 4*eax ]
	call writeString
	call print_single_space
	pop edx
	ret 
printDay1 ENDP

; ===========================================
; printHour1: print the hour
; Params: 1. eax - hold the hour number 
; ===========================================
printHour1 PROC
	MAXHOUR=12
	push eax
	
	cmp eax,0
	jne continue ; in am the hour 00 is 12
	mov eax,MAXHOUR
	jmp print
	
	continue:
	cmp eax,MAXHOUR
	ja OptionB ; the hour is more then 12
	jmp print
	
	OptionB:
	sub eax,MAXHOUR
	
	print:
	call printHour2	
	
	pop eax
	ret 
printHour1 ENDP

; ===========================================
; printMinute: print the minute
; Params:  eax - hold the number 
; ===========================================
printMinute PROC

	call print_small_num
	call print_colon
	ret 
printMinute ENDP

; ===========================================
; printSecond: print the second
; Params:  eax - hold the number 
; ===========================================
printSecond PROC

	call print_small_num
	call print_single_space
	ret 
printSecond ENDP


; ===========================================
; printAMPM: print am or pm acording to the hour 
; Params: 1. eax - hold the number of hour
; ===========================================
printAMPM PROC
	MAXHOUR=12
	push edx
	cmp eax,0
	jne continue ; in am the hour 00 is 12
	mov edx,offset AM
	jmp print
	
	continue:
	cmp eax,MAXHOUR
	jae OptionB ; the hour is more then 12
	mov edx,offset AM
	jmp print
	
	OptionB:
	mov edx,offset PM
	
	print:
	call writeString	
	pop edx
	ret
printAMPM ENDP


; ===========================================
; PRINT_2: print in the first format 
; Params: EBX - hold the date and time
; ===========================================
PRINT_2 PROC
	
	;--> Day calculation
	push ebx
	push MaskDAY
	mov eax,DAYPOS
	sub eax,DAYLENGTH
	push eax
	call getValue
	pop ebx		
	call printDay2
	;<-- Day calculation
	
	;--> HOUR calculation
	push ebx
	push MaskHOUR
	mov eax,HOURPOS
	sub eax,HOURLENGTH
	push eax
	call getValue
	call printHour2
	pop ebx		
	;<-- HOUR calculation
	
	;--> MINUTE calculation
	push ebx
	push MaskMINUTE
	mov eax,MINUTEPOS
	sub eax,MINUTELENGTH
	push eax
	call getValue
	call printMinute
	pop ebx
	;<-- MINUTE calculation
	
	;--> SECOND calculation
	push ebx
	push MaskSECOND
	mov eax,SECONDPOS
	sub eax,SECONDLENGTH
	push eax
	call getValue
	call printSecond
	pop ebx
	;<-- SECOND calculation
	ret
PRINT_2 ENDP

; ===========================================
; printDay2: print the spesific day
; Params: 1. eax - hold the number of day in the array of days
; ===========================================
printDay2 PROC
	push edx
	mov edx, [DAYS_LONG+ 4*eax ]
	call writeString
	call print_single_space
	pop edx
	ret 
printDay2 ENDP

; ===========================================
; printHour2: print the hour
; Params: 1. eax - hold the hour number 
; ===========================================
printHour2 PROC
	push eax
	call print_small_num	
	call print_colon
	pop eax
	ret 
printHour2 ENDP


; ===========================================
; incSecond: will add a second to the date
; Params: 1.offset to the date  
; USE : EAX 
; ===========================================
incSecond PROC
	MAXSECOND_Or_MINUTE=59
	MAXHOUR = 23
	MAXDAY = 7
	
	NUM =8
	push ebp
	mov ebp,esp
	push ebx
	push edx
	
	mov edx,[ebp +NUM]
	
	;<-- SECOND calculation
	mov ebx,[edx]
	push MaskSECOND
	mov eax,SECONDPOS
	sub eax,SECONDLENGTH
	push eax
	call getValue
	inc eax
	cmp eax,MAXSECOND_Or_MINUTE
	jbe DoneSECOND
	;--> SECOND calculation
	
	;add 1 to minute
	
	;<-- MINUTE calculation
	mov ebx,[edx]
	push MaskMINUTE
	mov eax,MINUTEPOS
	sub eax,MINUTELENGTH
	push eax
	call getValue
	inc eax
	cmp eax,MAXSECOND_Or_MINUTE
	jbe DoneMINUTE
	;--> MINUTE calculation
	
	;add 1 to hour
	
	;<-- HOUR calculation
	mov ebx,[edx]
	push MaskHOUR
	mov eax,HOURPOS
	sub eax,HOURLENGTH
	push eax
	call getValue
	inc eax
	cmp eax,MAXHOUR
	jbe DoneHOUR
	;--> HOUR calculation
	
	;add 1 to day
	
	;<-- DAY calculation
	mov ebx,[edx]
	push MaskDAY
	mov eax,DAYPOS
	sub eax,DAYLENGTH
	push eax
	call getValue
	inc eax
	cmp eax,MAXDAY
	jbe DoneDAY
	;--> DAY calculation
	
	mov eax,1 ; if we got here meaning we at the last day of the week
	jmp DoneDAY
		
	doneSECOND:
	mov ebx,[edx] 
	and ebx,MaskSECOND_REV
	add ebx,eax
	mov [edx],ebx
	jmp endFunc
	
	DoneMINUTE:
	mov ebx,[edx]
	and ebx,MaskMINUTE_REV ;cause the SECOND turn zero
	shl eax,SECONDPOS ; the pos of end second is the start of minute
	add ebx,eax
	mov [edx],ebx
	jmp endFunc
	
	DoneHOUR:
	mov ebx,[edx]
	and ebx,MaskHOUR_REV ;cause the MINUTE and SECOND turn zero
	shl eax,MINUTEPOS ; the pos of end minute is the start of hour
	add ebx,eax
	mov [edx],ebx
	jmp endFunc
	
	DoneDAY:
	mov ebx,[edx]
	and ebx,MaskDAY_REV ;cause the hour,MINUTE,SECOND turn zero
	shl eax,HOURPOS ; the pos of end hour is the start of day
	add ebx,eax
	mov [edx],ebx
	
	endFunc:
	pop edx
	pop ebx
	mov esp,ebp
	pop ebp
	ret 4
incSecond ENDP

END main