//
// Created by olegm on 02.04.2021.
//

#ifndef FUNCTIONS_H
#define FUNCTIONS_H
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

// Definitions:
void swap(int* x, int* y);
void array_inverse(int* array, int size);
int** transpose(int** _transpose, int _rowlen, int _collen);
void delete_matrix(int** matrix, int _rowlen);


// Implementations:
void swap(int* x, int* y)
{
    *x = *x + *y;
    *y = *x - *y;
    *x = *x - *y;
}

void array_inverse(int* array, int size)
{
    for(int i = 0; i < size/2; ++i)
    {
        swap(&array[i], &array[size-i-1]);
    }
}

int** transpose(int** _transpose, int _rowlen, int _collen)
{
    int** _transposed = (int**)malloc(_collen * sizeof(int*));

    for(int j = 0; j < _collen; ++j)
    {
        _transposed[j] = (int*)malloc(_rowlen * sizeof(int));
    }

    for(int i = 0; i < _rowlen; ++i)
    {
        for(int j = 0; j < _collen; ++j)
            _transposed[j][i] = _transpose[i][j];
    }
    return _transposed;
}

void delete_matrix(int** matrix, int _rowlen)
{
    if (matrix == NULL || _rowlen == 0)
    {
        printf("\nERROR: Invalid function call: nothing to delete.\n");
        exit(1);
    }
    for (int i = 0; i < _rowlen; ++i)
    {
        free(matrix[i]);
    }
    free(matrix);
}

#endif //FUNCTIONS_H
