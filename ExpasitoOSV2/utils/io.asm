

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
	mov ah,0
	mov al, bl
	mov cl, 0  ; reset the counter

	getDigitsLoop:
		mov dx, ax ; store ax in dx
		mov ah, 0xe
		mov al, '_'
		int 0x10

		mov ax, dx
			

		cmp ah, 0  ; check for ax being equal to 0
		je getDigitsExit  ; exit if 0

		mov bl, 10 ; we want to divide by 10 each time
		div bl     ; now divide
		
		inc cl     ; add 1 to the counter

		jmp getDigitsLoop
		

	getDigitsExit:
		ret
