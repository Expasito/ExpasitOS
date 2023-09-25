

;
; print prints out a null-terminating string to the console
; bx should have the location of the string to print
;
print:
	pusha ;move all registers to the stack

	mov ah, 0xe ; we want to print to the screen

	print_loop:
		mov al, [bx]     ; load bx to al so we can print
		inc bx           ; move 1 char over
		
		cmp al, 0        ; check for the null terminator
		je print_exit    ; jump to exit if we did find the null terminator

		int 0x10         ; print the character
		jmp print_loop   ; jump back to next int

	print_exit:
		popa             ; put the registers back to the values from the stack
		ret              ; and go back to the old code


; returns the number of digits in cx
; destroys ax, cx, and bx
; divisor must be in bl
getDigits:
	mov ah,20
	mov al, bl
	mov cl, 0  ; reset the counter

	getDigitsLoop:

		; lets print something out for logging
		
		mov dx, ax ; store ax in dx
		
		; print a space
		mov ah, 0xe
		mov al, ' '
		int 0x10

		; print the value of cl
		mov al, cl
		add al, '0'
		int 0x10
		
		; restore the values
		mov ax, dx
			

		cmp al, 0  ; check for ah being equal to 0
		je getDigitsExit  ; exit if 0

		; mov al to ax
		mov ah, 0
		; al is already there
		

		mov bl, 10 ; we want to divide by 10 each time
		div bl     ; now divide
		
		;add ah, -1  ; subtract to move over 1
		
		inc cl     ; add 1 to the counter

		jmp getDigitsLoop
		

	getDigitsExit:
		ret
