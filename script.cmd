@echo off
nasm boot_sect.asm -f bin -o boot_sect.bin
bochs -q