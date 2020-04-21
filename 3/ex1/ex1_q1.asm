TITLE EX1_Q1
;Kobi Shaked 203207873
INCLUDE Irvine32.inc

.data
	header BYTE "Kobi Shaked id: 203207873 Ex1-Q1",10,13
	getNameInstruction BYTE "Please Enter Your Name: ",0
	greeting BYTE "Hello There "
	nameInput BYTE 10 DUP (?),0

.code
main PROC
	mov edx, OFFSET header 
	call writeString

	mov edx, OFFSET nameInput
	mov ecx, SIZEOF nameInput
	call readString

	mov edx, OFFSET greeting
	call writeString
	call CRLF

	exit
main ENDP
END main








