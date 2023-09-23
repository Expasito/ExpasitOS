



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
dd gdt_start               ; this is the start address



; few constants to help
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
