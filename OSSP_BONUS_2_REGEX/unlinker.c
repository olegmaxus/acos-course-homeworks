#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <mqueue.h>

static void procerr(const char* error);

int main(int argc, char* argv[])
{	
	if (mq_unlink(argv[1]) == -1)
	{
		procerr("Failed to unlink the queue");
	}
	printf("%s unlinked successfully\n", argv[1]);
	
	exit(EXIT_SUCCESS);
}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}

