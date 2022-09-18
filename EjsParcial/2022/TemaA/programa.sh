#!/bin/bash
nasm -f elf32 ejecut.asm
nasm -f elf32 syscalls32.asm
gcc -m32 -nostartfiles  ejecut.o syscalls32.o raices.c -o raices -lm
