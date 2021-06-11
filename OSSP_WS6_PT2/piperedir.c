#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

static void procerr(const char* error);

int main(int argc, char* argv[])
{
	const char* cmdex_1 = argv[1];
	const char* cmdex_2 = argv[2];
	int pipefd[2];
	pid_t pid;
	int wstatus;
	
	for(int i = 0; i < 2; i++)
	{
		argv++;
	}

	
	if (pipe(pipefd) == -1)
	{
		procerr("Error while pipe creation");
	}

	// FIRST EXEC //
	
	if ((pid = fork()) == -1)
	{
		procerr("Something went wrong");
	}
	else if (pid == 0)
	{
		if (close(pipefd[0]) == -1)
		{
			procerr("Error while closing pipe");
		}
		
		close(STDOUT_FILENO);
		dup2(pipefd[1], STDOUT_FILENO);
		
		if (pipefd[1] != STDOUT_FILENO) // duplication of fout check
		{
			if (dup2(pipefd[1], STDOUT_FILENO) == -1)
			{
				procerr("Error while redirecting STDOUT");
			}
			if (close(pipefd[1]) == -1)
			{
				procerr("Error while closing pipe");
			}
		}
		
		execlp(cmdex_1, cmdex_1, NULL);
		procerr("Unable to execute first command");
	}
	else
	{
		asm("nop");
	}
	
	// SECOND EXEC //
	
	if ((pid = fork()) == -1)
	{
		procerr("Something went wrong");
	}
	else if (pid == 0)
	{
		if (close(pipefd[1]) == -1)
		{
			procerr("Error while closing pipe");
		}
		
		close(STDIN_FILENO);
		dup2(pipefd[0], STDIN_FILENO);
		
		if (pipefd[0] != STDIN_FILENO) // duplication of fout check
		{
			if (dup2(pipefd[0], STDIN_FILENO) == -1)
			{
				procerr("Error while redirecting STDIN");
			}
			if (close(pipefd[0]) == -1)
			{
				procerr("Error while closing pipe");
			}
		}
		
		execvp(argv[0], argv);
		procerr("Unable to execute second command");
	}
	else
	{
		asm("nop");
	}


	if (close(pipefd[0]) == -1)
	{
		procerr("Error while closing pipe");
	}
	if (close(pipefd[1]) == -1)
	{
		procerr("Error while closing pipe");
	}	
	if (wait(NULL) == -1)
	{
		procerr("Waiting failed");
	}
	if (wait(NULL) == -1)
	{
		procerr("Waiting failed");
	}
	
	exit(EXIT_SUCCESS);
}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}
