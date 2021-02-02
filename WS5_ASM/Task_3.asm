# 
# Write a program that inputs two positive integer values N and D, 
# finds their quatient (Q = N // D) and remainder (R = N % D) using the algorithm below[], print the result.
# 

	.include "macros.s"
	
	.eqv N t0
	.eqv D t1
	.eqv Q t2
	.eqv R t3
	
	.macro int_input_pair(%N,%D)
	print_str("Please, input integers N and D:\nN is: ")
	li a7, 5
	ecall
	mv %N, a0
	print_str("D is: ")
	li a7, 5
	ecall
	mv %D, a0
	.end_macro
	
	.text	

main:
	int_input_pair(N,D)
	beqz D, error_exit
	li Q, 0
	mv R, N
	
while:
	# branch if R < D:
	blt R, D, end_while
	addi Q, Q, 1
	sub R, R, D
	j while
	
end_while:
	# return
	print_str("(Quatient, Remainder) pair for N and D is: (Q, R) = (")
	print_var_int(Q)
	print_str(", ")
	print_var_int(R)
	print_str(")")
	newline
	j exit
	
error_exit:
	print_str("\nERROR: division by zero has occured!\nThe program terminated with an emergency exit.\n")
	j exit
exit:
	#return;