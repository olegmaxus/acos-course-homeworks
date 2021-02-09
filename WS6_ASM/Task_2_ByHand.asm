# translate the following C code into S:
# int f(int x, int y) {
#     return 2 * x + y;
# }
#
# int g(int a, int b, int c, int d) {
#     return f(a, c) - f(b, d);
# }
#
# int main() {
#     int a = read_int();
#     int b = read_int();
#     int c = read_int();
#     int d = read_int();
#     int x = g(a, b, c, d);
#     print_int(x);
# }

	.text
	.include "macros.s"
	.eqv A t0
	.eqv BB t1
	.eqv C t2
	.eqv D t3
	.eqv res_f_1 s1
	.eqv res_f_2 s2
	.eqv res_g s4

main:
	addi sp, sp, -12
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw res_g, 8(sp)
	
	int_input(A)
	int_input(BB)
	int_input(C)
	int_input(D)
	
	mv a0, BB
	mv a1, D

	jal ra, g
	mv res_g, a0

	print_var_int(res_g)

	lw a0, 0(sp)
	lw a1, 4(sp)
	lw res_g, 8(sp)
	addi sp, sp, 12
	

_exit:
	li a7, 10
	ecall

g:
	addi sp, sp, -24
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw res_f_1, 16(sp)
	sw res_f_2, 20(sp)

	mv a0, A
	mv a1, C
	
	sw ra, 8(sp)
	jal ra, f
	mv res_f_1, a0
	
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw ra, 8(sp)
	
	sw ra, 0(sp)
	jal ra, f
	mv res_f_2, a0
	
	lw ra, 0(sp)

	sub a0, res_f_1, res_f_2
	
	lw res_f_1, 16(sp)
	lw res_f_2, 20(sp)
	addi sp, sp, 24
	
	ret

f:
	addi sp, sp, -12
	sw s4, 0(sp)
	
	slli s4, a0, 1
	add s4, s4, a1
	mv a0, s4
	
	lw s4, 0(sp)

	addi sp, sp, 12

	ret
