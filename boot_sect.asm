
; resource: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
; on top pg 27

[org 0x7c00] ; going to write our code at 0x7c00 in memory
bits 16      ; using 16 bits for size of register



section .text

; few things to do first
mov bp, 0x8000  ; we need to give the stack some space so it does not delete bios related stuff
mov sp, bp      ; and put sp at bp since we have nothing on our stack
                ; Doing this will prevent crashes later if we overwrite the interupts table, ec

; here is a quick stack test for fun
; This will print 'TEST ' to the screen
push ' '
push 'T'
push 'S'
push 'E'
push 'T'

; we will loop 5 times
mov bx, 0   ; bx will be our counter
mov ah, 0xe ; we will print to screen
printing:
    cmp bx, 5  ; see if bx is equal to 5
    je stop
    inc bx     ; increment bx by one
    pop ax
    mov ah, 0xe ; we will print to screen, also reset because of pop
    int 0x10
    jmp printing ; jump back to top of loop
  

stop:
    ; just continue with program



mov  bx, msg   ; load msg to bx which is the location for a print string function
call print     ; call the print function
mov  bx, msg2  ; same here, load msg2 to bx for printing
call print

call load_sector   ; still working on this part

; testing divide

mov dx, 0
mov ax, 100
mov cx, 5
div cx

mov bx, 12345  ; fails at this number for a reason
call print_num




jmp $

; include our other file we wrote
%include "utils/prints.asm"


; this holds our data for strings to print
; includes the text, a newline, cartrige return and null terminator
msg: db "Testing our print function",10,13,0

msg2: db "Looks good!",10,13,0

; pad the rest of the file with zeros and the magic number

times 510-($-$$) db 0

dw 0xaa55