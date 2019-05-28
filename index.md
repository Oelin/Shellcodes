# Index of Shellcodes

This document provides details and brief explanations of each Shellcode featured within this repository; ordered by upload date. 
The various compilation methods for each are given by reference in parenthesis and shown fully in `./compile.md`.

### execve
An archetypal Shellcode which uses the `execve()` system call to open Linux's basic shell `/bin/sh` from within a vulnerable program. (1)

### execve_bind

In many cases, Shellcodes are used to exploit programs on remote hosts rather than a physically accessable machine. As such, this Shellcode pipes the input and output of `/bin/sh` through client TCP connections. In exploit circumstances, Shellcodes of this type can lead to system wide compramise. execve_bind accepts connections on port 1234. (1)

### seed

Commonly, exploits can be greatly limited by small buffers, only 30 bytes or so. Seed aims to provide circumvention by downloading and executing arbitarily large payloads while itself remaining small. (1)
