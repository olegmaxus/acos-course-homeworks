#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{
	char* fin = argv[1];
	char* fout = argv[2];
	
	int _fout = open(fout, O_WRONLY|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR);
	int _fin = open(fin, O_RDONLY, S_IRUSR|S_IWUSR);
	
	for(int i = 0; i < 3; i++)
	{
		argv++;
	}
	
	int wstatus;
	pid_t pid = fork();
	
	if (pid == -1)
	{
		perror("Something went wrong");
		exit(EXIT_FAILURE);
	}
	else if (pid == 0) 
	{
		close(STDIN_FILENO);
		close(STDOUT_FILENO);
		
		dup2(_fin, STDIN_FILENO);
		dup2(_fout, STDOUT_FILENO);
		
		int status = execvp(argv[0], argv);
		if (status < 0)
		{
			perror("Unable to execute the bash command");
			exit(EXIT_FAILURE);
		}
	}
	else do
	{

		if ((pid = waitpid(pid, &wstatus, WNOHANG)) == -1)
		{
			perror("Error while waiting for child to terminate");
			exit(EXIT_FAILURE);
		}
		else 
		{
			if (WIFEXITED(wstatus))
			{
				close(_fout);
				close(_fin);
		
				printf("Requested process exited with status: %d.\n", (int)WEXITSTATUS(wstatus));
 			}
		}
	} while (pid == 0);

	exit(EXIT_SUCCESS);
}

