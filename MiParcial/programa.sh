#!/bin/bash
nasm -f elf32 binary_search.asm
gcc -m32 binary_search.o binary_search.c -o binary_search

