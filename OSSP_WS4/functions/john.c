#include <stdio.h>
#include <math.h>

void john(int arg)
{
	float computed = sqrt(exp(log(pow(arg, 4))));
	printf("john: you passed x = %d.\njohn: x^2 = sqrt(exp(log(x^4))) = %.0f.\n", arg, computed);
}
