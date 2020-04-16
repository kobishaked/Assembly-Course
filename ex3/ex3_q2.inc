.data
	STR_ARR DWORD num1, num2, num3, num4, num5
	num1 BYTE "812345",0 ; the number 12345 in base 8
	num2 BYTE "612340",0 ; the number 12340 in base 6
	num3 BYTE "2100100",0 ; the binary number 100100
	num4 BYTE "2100300",0 ; BAD - digit 3 when the base is 2
	num5 BYTE '6', 15 DUP ("4"),0 ; BAD - overflow in base 6