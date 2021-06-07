#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <pthread.h>

#define n 1024
#define THREAD_LIMIT 1024

static double A[n][n];
static double B[n][n];
static double C[n][n];
static float timer = 0.0;
static int which = 0;


float tdiff(struct timeval* start, struct timeval* end);
static void* multiply_thread(void* arguments);

// MAIN //

int main(int argc, const char* argv[]) 
{

	// MATRIX GENERATOR //
	
    for (int i = 0; i < n; i++) 
    {
        for (int j = 0; j < n; j++) 
        {
            A[i][j] = (double)rand() / (double)RAND_MAX;
            B[i][j] = (double)rand() / (double)RAND_MAX;
            C[i][j] = 0;
        }
    }
    
    // THREADING AND TIME NEASURING // 
    
    pthread_t multd[THREAD_LIMIT];
    int i, td_descript;
    
    struct timeval start, end;
    gettimeofday(&start, NULL); 
	
    for(i = 0; i < THREAD_LIMIT; i++)
    {
        td_descript = pthread_create(&multd[i], NULL, multiply_thread, NULL);
		    if(td_descript != 0){perror("pthread_create()"); return -1;}
    }
	
    for(i = 0; i < THREAD_LIMIT; i++)
    {
        td_descript = pthread_join(multd[i], NULL);
        if(td_descript != 0){perror("pthread_join()"); return -1;}
    }
	
    gettimeofday(&end, NULL);
    timer = tdiff(&start, &end);
	
    // PRINTING //
	
    printf("%0.6f\n", timer);
    exit(EXIT_SUCCESS);
}

// TIMER //

float tdiff(struct timeval *start, struct timeval *end) 
{
    return (end->tv_sec - start->tv_sec) +
           1e-6 * (end->tv_usec - start->tv_usec);
}

// THREAD //

static void* multiply_thread(void* redundant)
{
    int mtx_des;
    int thread_which = which++;
	
	// COMPUTING EACH ROW SEPARATELY DEPENDING ON THE COUNTER //
	
    for (int i = thread_which * n / THREAD_LIMIT; i < (thread_which + 1) * n / THREAD_LIMIT; i++)
    {
        for (int j = 0; j < n; j++)
        {
            for (int k = 0; k < n; k++)
            {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    
    return NULL;
}





