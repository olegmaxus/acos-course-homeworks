#include <stdio.h>

int f(int x, int y) 
{
    return (2 * x + y);
}

int g(int a, int b, int c, int d) 
{
    return f(a, c) - f(b, d);
}

int main() 
{
    int a,b,c,d;
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);
    scanf("%d", &d);
    int z = g(a,b,c,d);
    printf("%d",z);
    printf("\n");
}
