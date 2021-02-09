# implement divide function, which returns a pair (Quatient, Remnant)
# function divide_unsigned(N, D)
#     Q := 0; R := N
#     while R ≥ D do
#         Q := Q + 1
#         R := R − D
#     end
#     return (Q, R)
# end

	.text
	.include "macros.s"
	.eqv N t0
	.eqv D t1
	.eqv Q t2
	.eqv R t3
main:
	addi sp, sp, -24
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw s0, 8(sp)
	sw s1, 12(sp)
	
	int_input(N)
	int_input(D)
	
	beqz D, error_exit
	

	mv a0, N
	mv a1, D
	
	# necessary space in stack being allocated for latter usage (done preventively)
	
	li s0, 0
	mv s1, a0
	
	jal ra, divide_unsigned_while
	
	mv Q, a0
	mv R, a1
	

	print_str("(")
	print_var_int(Q)
	print_str(", ")
	print_var_int(R)
	print_str(")")
	newline
	
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw s0, 8(sp)
	lw s1, 12(sp)
	addi sp, sp, 24

	li a7, 10
	ecall


error_exit:
	# emergency readressing 
	print_str("\nERROR: division by zero has occured!\nThe program terminated with an emergency exit.\n")
	j _exit


divide_unsigned_while:
	blt s1, a1, end_while
	addi s0, s0, 1
	sub s1, s1, a1
	j divide_unsigned_while


end_while:
	mv a0, s0
	mv a1, s1
	jr ra

_exit:
	# return;
	li a7, 10
	ecall
	
	
	
	