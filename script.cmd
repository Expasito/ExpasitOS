@echo off
nasm boot_sect.asm -f bin -o boot_sect.bin
gcc -ffreestanding -c basic.c -o basic.o
ld -r -Ttext 0x1000 -e main -s -o basic.out basic.o
objcopy -O binary -j .text basic.out basic.bin
type boot_sect.bin basic.bin > os-image
bochs -q