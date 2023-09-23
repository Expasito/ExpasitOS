
; resource: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
; on top pg 55

[org 0x7c00] ; going to write our code at 0x7c00 in memory



;mov [BOOT_DRIVE], dl  ; store the boot drive in dl

mov bp, 0x9000    ; move our stack to x9000
mov sp, bp         ; and move the stack pointer

mov bx, MSG_START_UP
call print


; now switch over
call switch_to_pm




jmp $



; include our other file we wrote
%include "utils/prints.asm"
;%include "utils/load_disk.asm"
%include "utils/gdt.asm"
%include "utils/switch_to_pm.asm"


[bits 32]
BEGIN_PM:

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

mov edx, VIDEO_MEMORY

mov ebx, WORKED

print_:
mov al, [ebx]
mov ah, WHITE_ON_BLACK

cmp al, 0
je done

mov [edx],ax
add ebx, 1
add edx, 2
jmp print_

done:





jmp $

; few messages
MSG_START_UP db "Starting the program now", 13,10, 0
MSG_LOAD_DISK db "Attempting to load from the disk",13,10,0
MSG_LOAD_WORKED db "Load worked",13,10,0

WORKED db "Into 32 bits",13,10,0

MSG_TEST db "Testing strings",0


BOOT_DRIVE db 0  ; this is the drive to boot at

; pad the rest of the file with zeros and the magic number

times 510-($-$$) db 0

dw 0xaa55
