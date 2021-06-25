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
	mqd_t mqd;
	
	struct mq_attr attrs;
	attrs.mq_maxmsg = 10;
	attrs.mq_msgsize = 2048; 
	
	if ((mqd = mq_open(argv[1], O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR, &attrs)) == -1)
	{
		perror("Failed to initialize the message queue");
		if ((mqd = mq_open(argv[1], O_RDWR, S_IRUSR | S_IWUSR)) == -1)
		{
			procerr("Failed to open already existing queue");
		}
	}
	
	
	mq_getattr(mqd, &attrs);
	
	unsigned int prior = 1;
	
	char* console_msg = argv[2];
	
	mq_send(mqd, console_msg, strlen(console_msg), prior);
	
	printf("The message was sent successfully\n");
	exit(EXIT_SUCCESS);
}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}
