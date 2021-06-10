#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define aleng(arr) (sizeof(arr) / sizeof(char*))

static void signal_handler(int signal);
static void exit_handler(int signal);
static QUIT_STATE = 0;
int main(int argc, char* argv[])
{
	// KILL FULFILLMENT //
	
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
	
	char* _signal;
	_signal = strtok(SIGSTR, " ");
	for(int i = 0; _signal != NULL; i++)
	{
		SIGNALS[i] = _signal;
		_signal = strtok(NULL, " ");
	}
	
	pclose(fp);
	
	// SIGNAL HANDLER PROCESSMENT //
	
	for(int i = 2; i < argc; i++)
	{
		int state = 0;
		int j = 0;
		
		for(j = 0; j < aleng(SIGNALS); j++)
		{
			state = strcmp(SIGNALS[j], argv[i]);
			if(!state){break;}
		}
		if(j != 2)
		{
			signal(++j, signal_handler);
		}
		else
		{
			signal(++j, exit_handler);
		}
	}
	
	// CHILD FORKER CONTROLS //
	
	int status = atoi(argv[1]);
	pid_t pid;
	if((pid = fork()) == 0)
	{
		while(1);
	} 
	else
	{
		printf("Forking a child: %d\n", pid);
		wait(&status);
		printf("And finally…\n");

		if (WIFSIGNALED(status))
		{
			psignal(WTERMSIG(status), "Terminated:");
		}
		printf("Exit status: %d\n", status);
	}
	
	printf("Starting the counter, delay: %d seconds.\n", (int) atoi(argv[1]));
    for (int i = 0;; i++) 
    {
		sleep(atoi(argv[1]));
		printf("%d: %d\n", (int) getpid(), i);
	}
    return 0;
}


static void signal_handler(int signal)
{
	printf("[Caught: %s]\n", (char*) strsignal(signal));	
}

static void exit_handler(int signal)
{
	printf("[Caught: %s]\n", (char*) strsignal(signal));
  ++QUIT_STATE;
  if(QUIT_STATE == 3)
  {
    exit(EXIT_SUCCESS);
  }
}
