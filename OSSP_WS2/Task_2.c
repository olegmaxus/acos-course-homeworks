#include "Functions.h"
//***************************************************************************************//
//                                                                                       //
//                            Created by olegm on 02.04.2021.                            //
//                                                                                       //
// • Write a program in C, which does the following:                                     //
// • inputs an integer value ‘N’;                                                        //
// • allocates an array of ‘N’ integer elements;                                         //
// • fills the array with integer values from the standard input;                        //
// • reverses the array;                                                                 //
// • prints the resulting array;                                                         //
// • deallocates the array.                                                              //
// • Notes: use malloc and free to allocate and deallocate the array respectively.       //
//***************************************************************************************//



int main()
{
    int N, temp_val;
    int* array = NULL;

    printf("\nPlease, specify the size of an array (N):");
    scanf("%d", &N);
    if (N <= 0)
    {
        printf("ERROR: Invalid array size.\n");
        exit(1);
    }
    array = (int*)malloc(N * sizeof(int));
    printf("Please, enter %d elements, separated by spaces:\n", N);
    for(int i = 0; i < N; ++i)
    {
        scanf("%d", array + i);
    }

    array_inverse(array, N);
    printf("Reversed array is:\n");

    for(int i = 0; i < N; ++i)
    {
        printf("%d ", *(array + i));
    }
    free(array);
    printf("\n");
    return 0;
}
