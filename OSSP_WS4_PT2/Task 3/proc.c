#include <math.h>
#include <stdio.h>

int func(int);

int var = 33;

int main(int argc, char *argv[]) {
   int val = func(42);
   printf("sqrt(%d)=%lf\r\n", val, sqrt(val));
   return 0;
}
