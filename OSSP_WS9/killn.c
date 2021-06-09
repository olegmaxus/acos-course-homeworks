#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define aleng(arr) (sizeof(arr) / sizeof(char*))

static int check_presence(char* which, char* array[]);

int main(int argc, char* argv[])
{
	FILE* fp;
	char PATH[1024];
	char SIGSTR[1024];
	char* SIGNALS[31]; // in total 31 arguments in kill -l  //
	
	// CREATING AN ARRAY OF kill -l PRODUCEMENTS //
	
	fp = popen("/bin/kill -l ","r");
	
	if (fp == NULL)
	{
		printf("Sorry, it seems like the \"kill\" directory is absent in /bin/.\n" );
		exit(EXIT_FAILURE);
	}
	
	while(fgets(PATH, sizeof(PATH), fp) != NULL)
	{
		strcat(SIGSTR, PATH);
		SIGSTR[strlen(SIGSTR) - 1] = ' ';
	}

	memmove(SIGSTR, strstr(SIGSTR, "HUP"), strlen(SIGSTR));
	
	char* signal;
	signal = strtok(SIGSTR, " ");
	for(int i = 0; signal != NULL; i++)
	{
		SIGNALS[i] = signal;
		signal = strtok(NULL, " ");
	}
	
	pclose(fp);
	
	// EXECUTING THE COMMAND INPUT //
	
	int PID = atoi(argv[1]);
	signal = argv[2];
		
	if(check_presence(signal, SIGNALS) != 0)
	{
		if(kill(PID, (int) check_presence(signal, SIGNALS)) == -1)
		{
			perror("Unable to execute \"kill\""); 
			exit(EXIT_FAILURE);
		}
		else
		{
			printf("The process %d has been killed. (%s)\n", (int) PID, signal);
		}
	}
	else
	{
		printf("%s: %s\n", signal, "No such signal.");
		return 1;
	}
	
	return 0;
}


static int check_presence(char* which, char* array[])
{
    for(int i = 0; i < aleng(array); i++) 
    {
        if(!strcmp(array[i], which)) 
        {
            return i++; 
        }
    }
    return 0; 
}




