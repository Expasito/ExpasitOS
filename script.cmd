@echo off
nasm boot_sect.asm -f bin -o boot_sect.bin
gcc -ffreestanding -c basic.c -o basic.o
ld -o basic.bin -Ttext 0x1000 basic.o --oformat binary

bochs -q