#include <stdio.h>

int f(int x, int y) 
{
    return (2 * x + y);
}

int g(int x, int y) 
{
    return (3 * y - x);
}

int main() 
{
    int x, y;
    scanf("%d", &x);
    scanf("%d", &y);
    int z = f(x, y) + x + g(x, y) - y;
    printf("%d",z);
    printf("\n");
}
