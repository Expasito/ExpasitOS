;
; This will eventually become a utils file or just a printing file, but for now
;     it will just hold several functions
;


print:
	pusha   ; move all registers to the stack

	; we have the address in bx so now we can print

	mov ah, 0xe ; we want a visual interup

	loop:
	mov al, [bx] ; load bx into al
	inc bx       ; add 1 to move a char over
	cmp al, 0    ; check null terminator
	je exit      ; if al is equal to 0(ascii for \0), we will jump to the exit section

	int 0x10     ; print char

	jmp loop     ; loop back up for next character


	exit:
		popa     ; return stack to old form
		ret      ; jump back to old instruction address



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
