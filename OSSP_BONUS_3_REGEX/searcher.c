#include <stdint.h>
#include <regex.h>
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

#define ARRLENG(arr) (sizeof((arr)) / sizeof((arr)[0]))

static void procerr(const char* error);
static void register_matches(char* text, char* regex);
char* process_file(char* fname);

int main(int argc, char* argv[])
{
	char* file = process_file(argv[2]);
	
	mqd_t _mqd;
	struct mq_attr _attrs;
	unsigned int prior;
	
	if ((_mqd = mq_open(argv[1], O_RDONLY)) == -1)
	{
		procerr("Error, whence accessing the message queue");
	}
	
	printf("%s opened successfully\n", argv[1]);
	
	mq_getattr(_mqd, &_attrs);
	
	char* messbuf = (char*)malloc(_attrs.mq_msgsize);
	
	long int counter = 0;
	while(1)
	{
		if (counter == _attrs.mq_curmsgs){printf("\nThere are no more messages in the queue\n"); break;}
		bzero(messbuf, _attrs.mq_msgsize);
		ssize_t desc = mq_receive(_mqd, messbuf, _attrs.mq_msgsize, &prior);
		
		if(desc == -1)
		{
			procerr("Error receiving a message");
		}
		//printf("| Priority: %u\t\tMessage: %s\t\tIn Bytes: %ld\t|\n", prior, messbuf, (long) desc);
		register_matches(file, messbuf);
		counter++;
	}
	
	exit(EXIT_SUCCESS);
}

static void procerr(const char* error)
{
	perror(error);
	exit(EXIT_FAILURE);
}

static void register_matches(char* text, char* regex)
{
	char* txtcp = text;
	regex_t     regext;
	regmatch_t  pmatch[1];
	regoff_t    offt, len;

	if (regcomp(&regext, regex, REG_NEWLINE))
	{
		procerr("Failed to compile a regular expression");
	}
	
	printf("\nIn the given file, regular exression \"%s\" matches the following substrings:\n", regex);

	for (int i = 0; ; i++) 
	{
		if (regexec(&regext, txtcp, ARRLENG(pmatch), pmatch, 0))
		{
			break;
		}
		
		offt = pmatch[0].rm_so + ( txtcp - text);
		len = pmatch[0].rm_eo - pmatch[0].rm_so;
		printf("%d. \"%.*s\" (%jd characters)\n", i, len, txtcp + pmatch[0].rm_so, (intmax_t) len);

		txtcp += pmatch[0].rm_eo;
	}
}

char* process_file(char* fname)
{
	FILE* file_ptr;
	if ((file_ptr = fopen(fname, "r")) == NULL)
	{
		procerr("Can't open file");
	}
	
	fseek(file_ptr, 0, SEEK_END);
	ssize_t flen;
	if ((flen = ftell(file_ptr)) == -1)
	{
		procerr("Error with position determination");
	}
	
	rewind(file_ptr);
	char* text_buffer = (char* )malloc((flen + 1) * sizeof(*NULL));
	
	fread(text_buffer, flen, 1, file_ptr);
	text_buffer[flen] = '\0';
	
	fclose(file_ptr);
	
	return text_buffer;	
}


