#include <stdio.h>

extern int var;

int func(int arg) {
   printf("### %d/%d ###\n", arg, var);
   return arg*2+1;
}
