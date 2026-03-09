;****************************************************************************************************************************
;Program name: "Circles". The purpose of this program is to calculate the area of a circle based on user input radius.
;Copyright (C) 2026 Tristan chen *
; *
;This file is part of the software program "Circles". *
;"Circles" is free software: you can redistribute it and/or modify it under the terms of the GNU General
;Public *
;License version 3 as published by the Free Software Foundation. *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
;implied *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;for more details. *
;A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here: *
;<https://www.gnu.org/licenses/>. The copyright holder may be contacted here: tchen2006@csu.fullerton.edu *
;*************************************************************************************************************************/

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Tristan Chen
;  Author email: tchen2006@csu.fullerton.edu
;
;Program information
;  Program name: Arrays
;  Programming languages: main module and output array in C++, input_array, isfloat, manager, maximum, and reverse modules in x86 assembly language with Intel syntax, shell scripts written in BASH
;  Date of last update: 2026-Mar-8
;  Date comments upgraded: 2026-Mar-8
;  Date open source license added: 2026-Mar-8
;  Files in this program: input_array.asm, isfloat.asm, manager.asm, maximum.asm, reverse.asm, output_array.cpp main.cpp, r.sh
;  Status: Finished.
;  Future upgrade possible: None that are currently envisioned.
;

;
;Purpose of this file: The purpose of this module, maximum.asm is to find the maximum valye present in the array
;
;This file
;  File name: maximum.asm
;  Language: X86 with Intel syntax.
;  Max page width: 80 columns
;  Compile: nasm -f elf64 -l maximum.lis -o maxmmum.o maximum.asm
;  Link: gcc -no-pie -o circles main.cpp circle.o isfloat.o


;Begin code


extern isfloat;

global maximum;

;declarations
segment .bss 
    max resq 1 ; reserve space for the maximum value
    i resq 1 ; reserve space for the loop index
    size resq 1 ; reserve space for the size of the array
    array resq 100 ; reserve space for the array of 100 double-precision floating

segment .text

;setting up the stack frame and saving the registers
push rbp
push rbx
push r12
push r13
push r14
push r15

;get the size of the array from the stack
mov r12, [rsp + 48] ; size of the array is passed 
mov [size], r12 ; store the size in the variable

;initialize the maximum value to the first element of the array
mov r13, [rsp + 40] ; pointer to the array
mov rax, [r13] ; load the first element of the array into rax
mov [max], rax ; store the first element as the initial maximum value

;loop
mov r14, 1 ;initialize loop index to 1
.loop_start:
    cmp r14, [size] ; compare loop index with the size of the array
    jge .loop_end ; if loop index is greater than or equal to size, exit
    mov rax, [r13 + r14*8] ;put the current element of the array into rax

    ;using isfloat to check if the currene element is a valid fp number
    mov rdi, rax
    call isfloat
    cmp rax, 0 
    je .not_float ;not a valid float

    ;if valid, compare
    cmp rax, [max]
    jle .loop_continue ; if less than or equal
    mov [max], rax ; update maximum value if not

    .not_float:
    inc r14 ; increment loop index
    jmp .loop_start 
     
.loop_end:
;move the maximum value to rax for return
mov rax, [max]

pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret