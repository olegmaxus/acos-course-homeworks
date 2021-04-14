#include <stdio.h>
#include <math.h>

void sam(char* arg1, int arg2)
{
	int computed = 0;
	for(int i = 0; arg1[i]; ++i)
	{
		computed++;
	}
	printf("sam: you passed a string \"%s\", which has %d chars.\nsam: you passed an integer x = %d.\nsam: if you write string %d times, the total number of chars in it will be %.0f.\n", arg1, computed, arg2, arg2, pow(sqrt(computed * arg2), 2));
}

