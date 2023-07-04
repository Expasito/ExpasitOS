
mov ah, 0x0e

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10


mov ah, 0x08 ; read character at position
mov bh, 0
int 0x10

mov ah, 0x0e ; now print
int 0x10

mov ch, 0
mov cl, 7
mov ah, 1
int 10h


mov ah, 02h
mov bh, 0
mov dh, 2
mov dl, 2
int 0x10



jmp $

times 510-($-$$) db 0

dw 0xaa55