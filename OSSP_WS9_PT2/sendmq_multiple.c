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
		procerr("Failed to initialize the message queue");
	}
	
	printf("%s opened successfully\n", argv[1]);
	
	mq_getattr(mqd, &attrs);
	
	unsigned int prior = 1;
	
	printf("Please, enter ten messages.\n---------\n");
	int i = 0;
	while(i < 10)
	{
		char console_msg[2048];
		printf("Message: ");
		scanf("%s", console_msg);
		printf("Priority: ");
		scanf("%u", &prior);
		printf("---------\n");
		mq_send(mqd, console_msg, strlen(console_msg), prior);
		i++;
	}
	
	printf("Messages were successfully sent\n");

}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}
	
