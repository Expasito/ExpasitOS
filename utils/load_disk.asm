

load_disk:

	pusha          ; put all registers on the stack

	mov ah, 0x02   ; bios read sector interupt

	mov dl, 0      ; read the first drive
	mov ch, 0      ; read cylinder 0
	mov dh, 0      ; select the 0th side of the disk
	mov cl, 2      ; select the 2nd sector of the disk, which is after the boot sector

	mov al, 5      ; we want to read 5 sectors(5*512)

	mov bx, 0xa000 ; set es to 0xa000
	mov es, bx     ; now move over

	mov bx, 0x1234 ; this is the end memory location to read to

	int 0x13       ; now load from 0xa000 to 0x1234

	jc disk_error  ; jump here if we get a carry flag error set
	cmp al, 5      ; we expected to load 5 sectors so check that to
	jne disk_error

	jmp disk_worked ; jump to worked if nothing failed


	; if we have an error, jump here
	disk_error:
		mov ah, 0xe ; we want a visual interupt
		mov al, 'F' ; printing F
		int 0x10
		mov al, 'a' ; printing a
		int 0x10
		mov al, 'i' ; printing i
		int 0x10
		mov al, 'l' ; printing l
		int 0x10

		popa        ; return values to normal
		ret

	; if not, then here
	disk_worked:
		mov ah, 0xe ; we want a visual interupt
		mov al, 'W' ; printing W
		int 0x10
		mov al, 'o' ; printing o
		int 0x10
		mov al, 'r' ; printing r
		int 0x10
		mov al, 'k' ; printing k
		int 0x10
		mov al, 'e' ; printing e
		int 0x10
		mov al, 'd' ; printing d
		int 0x10

		popa        ; return values to normal
		ret

