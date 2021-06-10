#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
		char* cmd = argv[1];
		char* fin = argv[2];
		char* fout = argv[3];
		char* redirect_out = " >> ";
		char* redirect_in = " < ";

		size_t gensz = strlen(cmd) + strlen(fin) + strlen(fout) + strlen(redirect_in) + strlen(redirect_out) + 1;
		char* rcinout = malloc(gensz);

		strcat(strcat(strcat(strcat(memcpy(rcinout, cmd, strlen(cmd)), redirect_in), fin), redirect_out), fout);

		int wstatus;
		pid_t pid = fork();
		if (pid == -1)
		{
			perror("Something went wrong");
			exit(EXIT_FAILURE);
		}
		else if (pid == 0) 
		{
			int status = execl("/usr/bin/sh", "sh", "-c", rcinout, NULL);
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
                        printf("Requested process exited with status: %d.\n", (int)WEXITSTATUS(wstatus));
 				}
			}
		} while (pid == 0);

		exit(EXIT_SUCCESS);
}


