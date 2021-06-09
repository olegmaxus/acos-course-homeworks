#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]) 
{
	printf("Starting the counter, delay: %d seconds.\n", (int) atoi(argv[1]));
    for (int i = 0;; i++) 
    {
        sleep(atoi(argv[1]));
        printf("%d: %d\n", (int) getpid(), i);
    }
    return 0;
}
