#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define aleng(arr) (sizeof(arr)/sizeof(int))
#define name(var) #var

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
static int maximum = 0, minimum = 0;
static double average = 0;

typedef struct Array
{
	int* content;
	int size;   
} array_t;

static void* average_thread(void* array);
static void* minimum_thread(void* array);
static void* maximum_thread(void* array);

// MAIN //

int main(int argc, char* argv[])
{
	argc--;
	argv++;

	int statArr[argc];
	pthread_t trd_avg, trd_min, trd_max;
	int td_descript;
	pthread_t t1;
	array_t stats;
	
	
	for(int i = 0; i < argc; ++i)
	{
		statArr[i] = atoi(argv[i]);
	}
	
	stats.content = (int*) &statArr;
	stats.size = aleng(statArr);
	
	// AVERAGE //
    
	td_descript = pthread_create(&trd_avg, NULL, average_thread, (void*)&stats);
	if(td_descript != 0){perror("pthread_create()"); return -1;}
	td_descript = pthread_join(trd_avg, NULL);
	if(td_descript != 0){perror("pthread_join()"); return -1;}

	// MINIMUM //

	td_descript = pthread_create(&trd_min, NULL, minimum_thread, (void*)&stats);
	if(td_descript != 0){perror("pthread_create()"); return -1;}
	td_descript = pthread_join(trd_min, NULL);
	if(td_descript != 0){perror("pthread_join()"); return -1;}
    
	// MAXIMUM //
    
	td_descript = pthread_create(&trd_max, NULL, maximum_thread, (void*)&stats);
	if(td_descript != 0){perror("pthread_create()"); return -1;}
	td_descript = pthread_join(trd_max, NULL);
	if(td_descript != 0){perror("pthread_join()"); return -1;}

	// PARENT PRINTING //
    
	printf("The %s value is %.8lf\n", name(average), (double) average);
	printf("The %s value is %d\n", name(minimum), (int) minimum);
	printf("The %s value is %d\n", name(maximum), (int) maximum);
    
    
	exit(EXIT_SUCCESS);
}

// THREADS //

static void* average_thread(void* array)
{
	array_t* avg_arr = array;
	int* avgArr = avg_arr->content;
	int avgLen = avg_arr->size;
	double sum = 0;
	int avg_mtd;
	
	for(int i = 0; i < avgLen; ++i)
	{
		sum += avgArr[i];
	}

	avg_mtd = pthread_mutex_lock(&mutex);
	if(avg_mtd != 0){perror("mutex_lock()"); exit(EXIT_FAILURE);}
	
	sum /= avgLen;
	average = sum;
	
	avg_mtd = pthread_mutex_unlock(&mutex);
	if(avg_mtd != 0){perror("mutex_unlock()"); exit(EXIT_FAILURE);}
	
	return NULL;
}

static void* minimum_thread(void* array)
{
	array_t* min_arr = array;
	int* minArr = min_arr->content;
	int minLen = min_arr->size;
	int _min = minArr[0];
	int min_mtd;
	

	for(int i = 1; i < minLen; ++i)
	{
		if(minArr[i] < _min){_min = minArr[i];}
	}
	
	min_mtd = pthread_mutex_lock(&mutex);
	if(min_mtd != 0){perror("mutex_lock()"); exit(EXIT_FAILURE);}
	
	minimum = _min;
	
	min_mtd = pthread_mutex_unlock(&mutex);
	if(min_mtd != 0){perror("mutex_unlock()"); exit(EXIT_FAILURE);}
	
	return NULL;
}


static void* maximum_thread(void* array)
{
	array_t* max_arr = array;
	int* maxArr = max_arr->content;
	int maxLen = max_arr->size;
	int _max = maxArr[0];
	int max_mtd;
	

	for(int i = 1; i < maxLen; ++i)
	{
		if(maxArr[i] > _max){_max = maxArr[i];}
	}
	
	max_mtd = pthread_mutex_lock(&mutex);
	if(max_mtd != 0){perror("mutex_lock()"); exit(EXIT_FAILURE);}
	
	maximum = _max;
	
	max_mtd = pthread_mutex_unlock(&mutex);
	if(max_mtd != 0){perror("mutex_unlock()"); exit(EXIT_FAILURE);}
	
	return NULL;
}


