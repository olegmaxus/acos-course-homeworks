#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 65536 // 2^16

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
static long fibonacci[MAX];

static void* fibonacci_thread(void* iterations);

// MAIN //

int main(int argc, char* argv[])
{
	printf("Assuming ./fib 1 : 1\n\n");
	int iterations = atoi(argv[1]);
    pthread_t trd_fib;
    int td_descript;
    
    // FIBONACCI //
    
    td_descript = pthread_create(&trd_fib, NULL, fibonacci_thread, (void*)&iterations);
    if(td_descript != 0){perror("pthread_create()"); return -1;}
    
	td_descript = pthread_join(trd_fib, NULL);
    if(td_descript != 0){perror("pthread_join()"); return -1;}

	int _count = 0;
	int i = 0;
    for(; i < iterations; ++i)
    {
        printf("%ld ", (long) fibonacci[i]);
		_count++;
		if(!(_count % 10) && _count != 0){printf("(%d)\n", (int) (i + 1)); _count = 0;}
    }
    if(_count != 0)
    	printf("(%d)\n", (int) (i));
    else
    	printf("\n");
    exit(EXIT_SUCCESS);
}

// THREAD //

static void* fibonacci_thread(void* iterations)
{
	int size = *((int *) iterations);
	
	long current;
    long base_0 = 1;
    long base_1 = 1;
    
	int td_descript;
   
    int i = 0;
    for(int i = 0; size > 0; i++)
    {
    	--size;
    	base_0 = base_1;
    	base_1 = current;
    	current = base_0 + base_1;
    	
    	td_descript = pthread_mutex_lock(&mutex);
    	if(td_descript != 0){perror("pthread_mutex_lock()"); exit(EXIT_FAILURE);}
    	
    	fibonacci[i] = current;
    	
    	td_descript = pthread_mutex_unlock(&mutex);
    	if(td_descript != 0){perror("pthread_mutex_unlock()"); exit(EXIT_FAILURE);}
    }
    return NULL;
}



