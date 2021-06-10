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
        char* cmd = argv[1];
        char* fout = argv[2];
		int _fout = open(fout, O_WRONLY|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR);

		close(STDOUT_FILENO);
		dup2(_fout, STDOUT_FILENO);
		
        int status = execlp(cmd, cmd, NULL);

        if (status < 0) { perror("Unable to execute the bash command."); return 1;}

        exit(EXIT_SUCCESS);
}
