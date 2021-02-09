# translate the following C code to S:
# int f(int x, int y) {
#     return 2 * x + y;
# }
#
# int g(int x, int y) {
#     return 3 * y - x);
# }
#
# int main() {
#     int x = read_int();
#     int y = read_int();
#     int z = f(x, y) + x + g(x, y) - y;
#     print_int(z);
# }
	.text
	.include "macros.s"
	.eqv x t0
	.eqv y t1
	.eqv res_f t2
	.eqv res_g t3
	.eqv z t4
	
main:
	int_input(x)
	int_input(y)
	
	mv a0, x
	mv a1, y

	addi sp, sp, -4
	sw a0, 0(sp)

	jal ra, f
	mv res_f, a0

	lw a0, 0(sp)
	addi sp, sp, 4
	jal ra, g
	mv res_g, a0

	add z, res_f, x
	add z, z, res_g
	sub z, z, y
	
	print_var_int(z)
	newline
		
	mv a1, zero # sorry, i didn't properly preserve the memory, so that i've had to free it by hand there
	mv a0, zero


_exit:
	li a7, 10
	ecall

f:
	addi sp, sp, -4
	sw s4, 0(sp)

	slli s4, a0, 1
	add s4, s4, a1
	mv a0, s4

	lw s4, 0(sp)
	addi sp, sp, 4
	
	ret
g:
	addi sp, sp, -8
	sw x, 4(sp)
	sw s4, 0(sp)

	li x, 3
	mul s4, a1, x
	sub s4, s4, a0
	mv a0, s4

	lw s4, 0(sp)
	lw x, 4(sp)
	addi sp, sp, 12
	
	ret
	
