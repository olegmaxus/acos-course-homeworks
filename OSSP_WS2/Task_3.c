#include "Functions.h"
//***************************************************************************************//
//                                                                                       //
//                            Created by olegm on 02.04.2021.                            //
//                                                                                       //
// • Write a program in C, which does the following:                                     //
// • inputs two integer values N and M;                                                  //
// • allocates a matrix of size N * M and fills it with values from standard input;      //
// • transposes the matrix;                                                              //
// • prints the resulting matrix;                                                        //
// • deallocate the matrices.                                                            //
// • Note: the matrices must be allocated with malloc and deallocated with free          //
//***************************************************************************************//


int main()
{
    int N,M;
    int** matrix = NULL;
    int** matrixT = NULL;
    printf("\nPlease, specify the number of rows of a matrix (M):");
    scanf("%d", &M);
    printf("Please, specify the number of columns of an a matrix (N):");
    scanf("%d", &N);

    if (M <= 0 || N <= 0)
    {
        printf("ERROR: Invalid array size.\n"); //a[i][j] i = rows, j = columns
        exit(1);
    }

    matrix = (int**)malloc(M * sizeof(int*));

    for(int i = 0; i < M; ++i)
    {
        matrix[i] = (int*)malloc(N * sizeof(int));
    }

    printf("Please, enter your %d by %d matrix row by row.\nAlso, please separate the values by space:\n", M, N);

    for(int i = 0; i < M; ++i)
    {
        for(int j = 0; j < N; ++j)
        {
            scanf("%d", &matrix[i][j]);
        }
    }

    matrixT = transpose(matrix, M, N);

    printf("\nOriginal matrix is:\n");
    for (int i = 0; i < M; ++i)
    {
        for(int j = 0; j < N; ++j)
        {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }

    printf("\nTransposed matrix is:\n");
    for (int i = 0; i < N; ++i)
    {
        for(int j = 0; j < M; ++j)
        {
            printf("%d ", matrixT[i][j]);
        }
        printf("\n");
    }

    delete_matrix(matrix, M);
    delete_matrix(matrixT, N);

    return 0;
}
