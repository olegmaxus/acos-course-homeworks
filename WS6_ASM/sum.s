#
# Write program sum.s that first inputs integer value n, after that inputs n integer elements and stores them in the stack, 
# then calls function sum adding all the elements, and, finally, prints the sum.
#

	.text
	.include "macros.s"
	.eqv n t0
	.eqv CONST t1
	.eqv COUNT t2
	.eqv summ t3

	#.data
	#.space 1028 # 256 integers to be inputted at max, starting from zero in stack $ questionable?
	# removed since max input size is not specified

	.text
main:
	int_input(n)
	li COUNT, 0
	mv CONST, n

	j while_case

while_case:
	int_input(n)
	addi sp, sp, -4
	sw n, 0(sp)
	addi COUNT, COUNT, 1
	beq COUNT, CONST, sum
	
	j while_case

sum:
	li COUNT, 0
	jal ra, sum_f
	mv summ, a0
	
	print_var_int(summ)
	
_exit:
	li a7, 10
	ecall

sum_f:
	lw a0, 0(sp)
	add a1, a1, a0
	addi sp, sp, 4
	addi COUNT, COUNT, 1
	
	beq COUNT, CONST, sum_ret
	
	j sum_f

sum_ret:
	mv a0, a1
	mv a1, zero

	ret


	
