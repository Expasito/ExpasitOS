
; inputs:
; dh: number of sectors
; dl: which drive(set as the base value at beginning of program)
; bx: the offset to load to
load_disk:

	push dx         ; save for checking the number of sectors to read 


	mov ah, 0x02    ; we want a bios read disk interupts
	mov al, dh      ; set the number of sectors to dh since we will overwrite it
	mov ch, 0       ; cylinder 0
	mov cl, 2       ; second sector(after 1)
	mov dh, 0       ; head 0
	; dl is already set


	int 0x13       ; now load from 0xa000 to 0x1234

	jc disk_error  ; jump here if we get a carry flag error set
	pop dx
	cmp al, dh      ; we expected to load dh sectors
	jne disk_error

	jmp disk_worked ; jump to worked if nothing failed


	; if we have an error, jump here
	disk_error:
		mov bx, LOAD_DISK_MSG_FAILED
		call print

		ret

	; if not, then here
	disk_worked:
		mov bx, LOAD_DISK_MSG_WORKED
		call print

		ret
	ret

LOAD_DISK_MSG_WORKED db "    Disk loaded correctly",10,13,0
LOAD_DISK_MSG_FAILED db "    Disk failed to load", 10,13,0