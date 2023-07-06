;
; This will eventually become a utils file or just a printing file, but for now
;     it will just hold several functions
;


print:
	pusha   ; move all registers to the stack

	; we have the address in bx so now we can print

	mov ah, 0xe ; we want a visual interupt

	print_loop:
	mov al, [bx] ; load bx into al
	inc bx       ; add 1 to move a char over
	cmp al, 0    ; check null terminator
	je print_exit      ; if al is equal to 0(ascii for \0), we will jump to the exit section

	int 0x10     ; print char

	jmp print_loop     ; loop back up for next character


	print_exit:
		popa     ; return stack to old form
		ret      ; jump back to old instruction address

; this will convert a number to a string and print it
; bx will hold the number value
print_num:
	pusha ; move all reigsters to the stack

	mov ah, 0xe ; we want a visual interupt

	; to get the number, divide by the largest base 10
	; and then the result is the moduls of it and the base 10 value

	; first we need to find the largest base 10 number
	;start at 1 and mult by 10 until the number is larger

	; since we have 4 registers, we will put the counter on the stack

	push 0 ; this is the counter
	; bx is the value we modify
	; cx is the divisor
	mov cx, 1

	print_num_loop_1:

		mov dx, 0    ; clear dividend
		mov ax, bx   ; bx is the dividend
		; cx is already the divisor
		div cx
		pop dx ; put the counter into dx
		inc dx ; increment by 1
		push dx ; back on stack
		cmp ax, 0
		je print_num_exit_1  ; if the quotient is 0, we have the maximum
		mov ax, 10
		mul cx
		mov cx, ax
		jmp print_num_loop_1 ; jump back up to check again



	print_num_exit_1:
		mov ah, 0xe
		mov al, '0'
		pop dx ; put the counter into dx
		dec dx  ; counter is 1 too many
		add al, dl ; increment by the count
		int 0x10

		push dx ; put the counter back on stack

		; print a space

		mov ah, 0xe
		mov al, ' '
		int 0x10

		; we need to divide the cx by 10 to get into a usable range
		mov dx, 0  ; clear dividend
		mov ax, cx
		mov cx, 10
		div cx
		mov cx, ax ; cx is now 1/10th the value

		



	; okay, now we have the number of digits in cx
	; we need to extract the digits and print them out

	; bx still holds the value
	; cx holds the starting value

	print_num_loop2:



		mov dx, 0  ; clear the dividend
		mov ax, bx  ; move bx to the top
		; cx is already here
		div cx
		; we have ax as the number and dx as the remainer
		push dx ; we need to move this on the stack temporarly
		mov dx, ax ; mov ax to dx for printing
		mov ah, 0xe
		mov al, '0' 
		add al, dl  ; add dl + '0'
		int 0x10

		mov ax, dx  ; make ax itself again before fixing dx
		pop dx ; put dx back into dx off the stack
		mov bx, dx  ; make bx the remainder

		pop dx ; load the counter back to dx

		cmp dx, 0
		je print_num_exit2  ; if the number is equal to 0, leave
		dec dx
		push dx; put back on stack

		; lastly, divide cx by 10
		mov dx, 0
		mov ax, cx
		mov cx, 10
		div cx
		mov cx, ax ; make cx itself/10
		jmp print_num_loop2
		


	print_num_exit2:
		

	popa 
	ret


load_sector:
	pusha
	mov ah, 0x02
	mov dl,0
	mov ch,3
	mov dh,1

	mov cl, 4
	mov al, 5

	mov bx, 0xa000
	mov es,bx
	mov bx, 0x1234

	int 0x13

	jc disk_error

	jmp load_sector_exit

	

	disk_error:
	mov bx, err
	call print

	load_sector_exit:
		popa
		ret

err: db "Failed to load disk",13,10,0