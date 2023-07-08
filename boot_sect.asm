
; resource: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
; on top pg 27

[org 0x7c00] ; going to write our code at 0x7c00 in memory
bits 16      ; using 16 bits for size of register


; GDT starts here
gdt_start:

gdt_null: ; this is the null descriptor
dd 0x0
dd 0x0

gdt_code: ; this is the code segment descriptor

dw 0xffff   ; limit is bits 0-15
dw 0x0      ; base is bits 0-15
db 0x0      ; base is bits 16-23
db 10011010b  ; first flags, type flags
db 11001111b  ; 2nd flags, limit (bits 16-19)
db 0x0      ; base 24-31

gdt_data:

dw 0xffff    ; limit bits 0-15
dw 0x0       ; base bits 0-15
db 0x0       ; base bits 16-23
db 10010010b  ; first flags, type flags
db 11001111b ; 2nd flags, limit bits 16-19
db 0x0      ; base bits 24-31

gdt_end:
; used for finding the size of gdt by subtracting addresses


; this is the descriptor about our gdt
gdt_descriptor:
dw gdt_end - gdt_start -1  ; is the end - start -1
dw gdt_start               ; this is the start address



; few constants to help
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start


section .text

; few things to do first
mov bp, 0x9000  ; we need to give the stack some space so it does not delete bios related stuff
mov sp, bp      ; and put sp at bp since we have nothing on our stack
                ; Doing this will prevent crashes later if we overwrite the interupts table, ec

cli   ; disables interrupts
lgdt [gdt_descriptor]  ; load gdt register with start addresss of the gdt

mov eax, cr0
or al, 1       ; setting the first bit to 1
mov cr0, eax   ; set cr0 back to itself

jmp 08h:PModeMain


PModeMain:
[bits 32]

mov ax, DATA_SEG
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x90000
mov esp,ebp



mov eax, 100 ; test eax




jmp $

; include our other file we wrote
%include "utils/prints.asm"
%include "utils/load_disk.asm"


; this holds our data for strings to print
; includes the text, a newline, cartrige return and null terminator
msg: db "Testing our print function",10,13,0

msg2: db "Looks good!",10,13,0

; pad the rest of the file with zeros and the magic number

times 510-($-$$) db 0

dw 0xaa55