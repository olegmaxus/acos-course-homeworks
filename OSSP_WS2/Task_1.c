#include "Functions.h"
//***************************************************************************************//
//                                                                                       //
//                            Created by olegm on 02.04.2021.                            //
//                                                                                       //
// Write a program in C that inputs two integer values x and y, call function swap,      //
// which takes the values as arguments and swaps them, print the values after the swap.  //
//***************************************************************************************//



int main()
{
    int x,y;
    printf("x is:");
    scanf("%d", &x);

    printf("y is:");
    scanf("%d", &y);

    swap(&x,&y);

    printf("...\nnew x:%d", x);
    printf("\nnew y:%d", y);
	printf("\n");
    return 0;
}


