section .text:
    global _start

_start:
    jmp short path

main:
    pop ebx

    xor ecx, ecx
    xor edx, edx

    mov al, 11
    int 128

path:
    call main
    db "/bin/sh"
