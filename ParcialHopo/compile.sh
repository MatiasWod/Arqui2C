#!/bin/bash
nasm -f elf32 main.asm
nasm -f elf32 Numeros_primos.asm
gcc -c -m32 function.c
gcc -m32 main.o Numeros_primos.o function.c -o primos
./primos $*