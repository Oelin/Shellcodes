# Index of Shellcodes

This document provides details and brief explanations of each Shellcode featured within this repository; ordered by upload date.

### execve
An archetypal Shellcode which uses the `execve()` system call to open Linux's basic shell `/bin/sh` from within a vulnerable program.
```bash

nasm -f elf32 execve.s -o execve; ld -m elf_i386 execve.o -o execve; rm execve.o
```

### execve_bind

In many cases, Shellcodes are used to exploit programs on remote hosts rather than a physically accessable machine. As such, this Shellcode pipes the input and output of `/bin/sh` through client TCP connections. In exploit circumstances, Shellcodes of this type can lead to system wide compramise. execve_bind accepts connections on port 1234.
```bash

nasm -f elf32 execve.s -o execve; ld -m elf_i386 execve.o -o execve; rm execve.o
```
