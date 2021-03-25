#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>


///////////////////////////////////////////// TASK DESCRIPTION ///////////////////////////////
///Modify the previous program to accept command-line arguments (argc/argv).               ///
///Pass via command-line arguments the number of words                                     ///
///Use sscanf to get an integer from argv[1] and the name of output file (argv[2]).        ///
//////////////////////////////////////////////////////////////////////////////////////////////

int fscript(const char *fpath)
{
    return open(fpath, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR);
}

int main(int argc, char * argv[]) //argv[1] = #words, //argv[2] = path.
{
	char write_word[256], path[256]; //max
	int numW;
	if (argc != 3)
	{
		printf("\nERROR: not enough arguments.\nProgram will terminate.\n");
		exit(EXIT_FAILURE);
	}
	else
	{
		sscanf(argv[1], "%d", &numW);
		sscanf(argv[2], "%s", path);
			
	   	int FSCRIPT = fscript(path);
	
	    if(FSCRIPT < 0)
	    {
	        perror("\nERROR while opening trial");
	        exit(EXIT_FAILURE);
	    }
	    for (size_t i = 0; i < numW; i++)
	    {
	        scanf("%s", write_word); //user word input
	        write(FSCRIPT, write_word, strlen(write_word));
	        if (i < numW - 1)
	        {
	            write(FSCRIPT, " ", strlen(" "));
	        }
	        else ///
	        {
	            write(FSCRIPT, "\0", strlen("\0"));
	        }
	
    	}
    	close(FSCRIPT);
	}
	return 0;
}

