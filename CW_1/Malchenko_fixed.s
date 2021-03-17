# Malchenko Var 17

# Write a RISC-V assembly program that inputs integer value x and calculates the value of the f(x) function,
# according to the specified equations. 
# f(x) must be implemented as a function and must comply with RISC-V calling conventions.

# The implemented function must use callee-saved registers (s0, s1, etc.) to store intermediate results of calculations. 
# These registers must be saved to the stack and restored when the function returns.

# Note: the ^ symbol means “power”.
#  f(x) = 4^x + 8 if x < 1 #sorry
#  f(x) = 3*x^7 + 6*x^4 + 3*x^3 - 3*x if x >= 1
#  f(x) = 7*x + 1 if x == 3
#  f(x) = -9 if x > 6


	.text
	.include "macros.s"
	.eqv isw t1
	.eqv res t2

main:
	print_str("Please, input an integer x: ")
	int_input(t0)
	
	mv a0, t0

	jal ra, funct
	
	mv t1, zero
	blt t0, zero, float_ret
 
	mv res, a0
	
	print_str("\nf(x) = ")
	print_var_int(res)
	
	j _exit

float_ret:
	print_str("\nf(x) = ")
	print_var_float(fa0)
	mv a0, zero
	mv s0, zero
	j _exit

funct:

	li isw, 1
	blt a0, isw, funct_1
	li isw, 3
	beq a0, isw, funct_3
	li isw, 6
	bgt a0, isw, funct_4
	li isw, 1
	bge a0, isw, funct_2
	j retr

funct_1:
	addi sp, sp, -20
	sw s0, 0(sp)
	fsw fs1, 4(sp)
	fsw fs2, 8(sp)
	sw s2, 12(sp)

	beqz a0, funct_1_0
	mv s0, a0
	li s2, -1
	mul s0, s0, s2
	li s2, 4
	fcvt.s.w fa0, s2
	fmv.s fs1, fa0
	fmv.s fs2, fs1
funct_1_exp:
	fdiv.s fs1, fs1, fs2
	beqz s0, funct_1_end
	addi s0, s0, -1
	j funct_1_exp

funct_1_0:
	addi a0, a0, 9
	
	lw s0, 0(sp)
	flw fs1, 4(sp)
	flw f2, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 20

	j retr

funct_1_end:
	fmv.s fa0, fs1
	li s0, 8
	fcvt.s.w fs2, s0
	fadd.s fa0, fa0, fs2

	lw s0, 0(sp)
	flw fs1, 4(sp)
	flw f2, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 20
	j retr


funct_2: #  f(x) = 3*x^7 + 6*x^4 + 3*x^3 - 3*x if x >= 1
	addi sp, sp, -24
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)
	sw s4, 16(sp)
	sw s5, 20(sp)

	mv s0, a0
	li s3, 6
	mv s1, a0
	li s4, 3
	mv s2, a0
	li s5, 2


	#ineffective, but ok:
funct_2_loop_1:
	beqz s3, funct_2_loop_2
	mul s0, s0, a0
	addi, s3, s3, -1
	j funct_2_loop_1

funct_2_loop_2:
	beqz s4, funct_2_loop_3
	mul s1, s1, a0
	addi, s4, s4, -1
	j funct_2_loop_2

funct_2_loop_3:
	beqz s5, f2_loop_ext
	mul s2, s2, a0
	addi, s5, s5, -1
	j funct_2_loop_3

f2_loop_ext:
	li s5, 3
	mul s0, s0, s5
	li s5, 6
	mul s1, s1, s5
	li s5, 3
	mul s2, s2, s5
	mv s4, a0
	li s5, -3
	mul s4, s4, s5

	add a0, s0, s1
	add a0, a0, s2
	add a0, a0, s4
	

	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	lw s4, 16(sp)
	lw s5, 20(sp)
	addi sp, sp, 24
	
	j retr
funct_3:
	addi sp, sp, -8
	sw s0, 0(sp)
	li s0, 7
	mul a0, a0, s0
	addi a0, a0, 1
	lw s0, 0(sp)
	addi sp, sp, 8
	j retr
	
funct_4:
	li a0, -9
	j retr

retr:
	ret

_exit:
	null.exit()
