#!/bin/bash
nasm -f elf32 syscalls.asm
gcc -c -m32 main.c
nasm -f elf32 binary_search.asm
gcc -m32 syscalls.o main.o binary_search.o -o binary_search
#recibe primero el numero q quiere buscar y despues el array separado con comas
./binary_search $1 $2