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

	
	// accessing the created message queue //
	
	mqd_t _mqd;
	struct mq_attr _attrs;
	char* exits = "QUIT";
	unsigned int prior;
	
	if ((_mqd = mq_open(argv[1], O_RDONLY)) == -1)
	{
		procerr("Error, whence accessing the message queue");
	}
	
	printf("%s opened successfully\n", argv[1]);
	
	mq_getattr(_mqd, &_attrs);
	
	char* messbuf = (char*)malloc(_attrs.mq_msgsize);
	
	while(1)
	{
		bzero(messbuf, _attrs.mq_msgsize);
		ssize_t desc = mq_receive(_mqd, messbuf, _attrs.mq_msgsize, &prior);
		
		if (!strcmp(messbuf, exits)){printf("QUIT message was received.\n"); break;}
		
		if(desc == -1)
		{
			procerr("Error receiving a message");
		}
		printf("| Priority: %u\t\tMessage: %s\t\tIn Bytes: %ld\t|\n", prior, messbuf, (long) desc);
	}
	
	if (mq_unlink(argv[1]) == -1)
	{
		procerr("Failed to unlink the queue");
	}
	printf("%s unlinked successfully\n", argv[1]);
}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}
