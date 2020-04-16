TITLE ex2_q2 data	

.data
SrcStr BYTE "HELLO !Good-Bye?? @#$%ZYX", 0
DestStr BYTE Lengthof SrcStr DUP (?)
msg1 BYTE "The String Before:",10,13,0
msg2 BYTE "The String After Filtering:",10,13,0
msg3 BYTE "The String After Sorting:",10,13,0