#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

/********************************* TASK DESCRIPTION *********************************/
//Read documentation on the read and write system calls.                            //
//Note descriptors standard numbers for stdin, stdout, and stderr.                  //
//Write a program that reads chars (note the &c notation)                           //
//from stdin, increments them by 1, and writes them to stdout.                      //
//Do not forget to include all the headers mentioned in the manual.                 //
//To close stdin from the terminal, use the ^D key combination                      //
//It is not passed to program, but interpreted by operating system as end of output //
/************************************************************************************/

int main() 
{
    char buffer[2]; //avoiding \0 separate addon for new lines. (try beffer[1] if you want to know, what I mean)
    ssize_t ERROR_IN, MSG_LEN = sizeof("Hello! Please, enter the chars one by one.\nExample:\nIn[0] : 1\nOut[0]: 2\nIn[0] :...\n\n");
    write(1, "Hello! Please, enter the chars one by one.\nExample:\nIn[0] : 1\nOut[0]: 2\nIn[0] :...\n\n", MSG_LEN);
    while((ERROR_IN = read(0, &buffer, sizeof(buffer))) != 0)
    {
        buffer[0]++;
        write(1, buffer, ERROR_IN);
    }
	if (ERROR_IN == -1)
	{
		perror("\nCaution: failed to read from <stdin>!\nCorruption will terminate the program.\n");
		exit(EXIT_FAILURE);
	}
	if (ERROR_IN > 1)
	{
		perror("\nCaution: an error has occured while reading:\nERRMSG: \"Too many input parameters.\"");
		exit(EXIT_FAILURE);	
	}

    
    return 0;
}
