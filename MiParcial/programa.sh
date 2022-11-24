#!/bin/bash
nasm -f elf32 bubble_sort.asm
gcc -m32 bubble_sort.o main.c -o main