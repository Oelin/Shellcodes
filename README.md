# Shellcodes

Shellcode, strictly speaking describes any code injected into a program's memory and executed with the aim of opening a "shell". However the term also more broadly describes any code injected and executed at run-time. This repository contains some useful Shellcodes for security audits.

To run a Shellcode outside the context of an exploit, one can use an assembler such as NASM. For instance, to assemble and run
`execve_bind.asm` you may type the following into a shell.

```bash

# Assemble and link.

nasm -f elf32 -o execve_bind.o execve_bind.asm
ld -m elf_i386 execve_bind.o -o execve_bind

# Run the Shellcode/

./execve_bind
```
Note that, as assembly language is architecture specific, particular Shellcodes will only work on one or several specific operating systems.
