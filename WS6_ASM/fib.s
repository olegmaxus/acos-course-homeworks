# implement fibonacci recursion: int fib(int n) {
#     if (n < 2)
#         return n;
#     else
#         return fib(n-1) + fib(n-2);
# }



	.text
	.include "macros.s"
	.eqv n a0
	.eqv res t1
	.eqv temp t2
	.eqv resfib_1 s0
	

main:
	int_input(n)
	
	jal ra, fib_main_case_else
	mv res, a0

	print_var_int(res)

_exit:
	li a7, 10
	ecall

fib_main_case_else:

	addi sp, sp, -12
	sw ra, 0(sp)
	sw a0, 4(sp)

	li temp, 2
	blt a0, temp, base

	addi a0, a0, -1
	jal fib_main_case_else

	sw a0, 8(sp)
	lw a0, 4(sp)

	addi a0, a0, -2
	jal fib_main_case_else

	lw resfib_1, 8(sp)
	add a0, a0, resfib_1
	
	j _return

base:
	lw a0 4(sp)

	j _return

_return:
	lw ra, 0(sp)
	addi sp, sp, 12
	ret
