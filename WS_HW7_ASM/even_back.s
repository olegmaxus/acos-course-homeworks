#
# Input an integer value N and then N float values. 
# Output line by line only even ones, in reversed order. 
# To decide whether a float number is even, it must be coverted (rounded) to an integer value.
#
	
	.text
	.include "macros.s"
	.eqv N t0
	.eqv res t1
	.eqv N1 t2
	.eqv float fa0
	.eqv temp fa1
	.eqv EVEN t3
	
main:						# fcvt.w.s res, fa0 # <=> round
	int_input(N)
	li EVEN, 2
	li N1, 0

while:
	beqz N, print
	addi, N, N, -1

	float_input(float)

	fmv.s temp, float
	fcvt.w.s res, temp
	
	rem res, res, EVEN
	beqz res, store_case
	
	j while

store_case:
	addi sp, sp, -4
	fsw float, 0(sp)
	addi, N1, N1, 1
	
	j while

print:
	beqz N1, _exit
	addi N1, N1, -1

	flw float, 0(sp)
	addi sp, sp, 4
	
	newline
	print_var_float(float)
	
	j print

_exit:
	null.exit()



