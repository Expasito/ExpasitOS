[org 0x07c00]


mov ah, 0x0e


mov bx, MSG_START_UP
call print

mov ah, 0x0e
mov al, 13 ; newline
int 0x10

mov ah, 0x0e
mov al, 10
int 0x10


mov bl, 90
call getDigits

mov ah, 0xe
mov al, ' '
int 0x10
int 0x10
int 0x10

mov al, cl
add al, '0'
int 0x10


mov ah, 0xe
mov al, 13
int 0x10

mov ah, 0xe
mov al, 10
int 0x10

mov ah, 0xe
mov al, 13
int 0x10
mov al, 10
int 0x10

mov bx, MSG_EXIT
call print


mov ah, 0xe
mov al, 'A'
int 0x10
;mov al, 13
;int 0x10

;jmp $

; now test division
;mov ax, 14
;mov bl, 7
;div bl

jmp $

; do all of our imports for the program
%include "utils/io.asm"	


; Add a few messages here
MSG_START_UP db "Starting the program now", 13, 10, 0
MSG_EXIT db "Exiting the program now",13,10,0
times 510-($-$$) db 0

dw 0xaa55
