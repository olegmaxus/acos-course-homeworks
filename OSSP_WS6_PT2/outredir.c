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
        char* fout = argv[2];
        char* redirect_out = " >> ";

        size_t gensz = strlen(cmd) + strlen(fout) + strlen(redirect_out) + 1;
        char* rcout = malloc(gensz);

        strcat(strcat(memcpy(rcout, cmd, strlen(cmd)), redirect_out), fout);

        int status = execl("/usr/bin/sh", "sh", "-c", rcout, NULL);

        if (status < 0) { perror("Unable to execute the bash command."); return 1;}

        exit(EXIT_SUCCESS);
}




