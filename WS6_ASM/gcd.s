# implement gc function, using recursive algo
# function gcd(a, b)
#     if b = 0
#         return a
#     else
#         return gcd(b, a mod b)


	.text
	.include "macros.s"
	.eqv m t0
	.eqv n t1
	.eqv res t2
	
main:
	addi sp, sp, -20
	sw a0, 12(sp)
	sw s0, 16(sp)
	
	int_input(m)
	int_input(n)
	
	mv a0, m
	mv a1, n
	
	jal ra, gcd
	mv res, a0
	
	print_var_int(res)

	lw a0, 12(sp)
	lw s0, 16(sp)
	addi sp, sp, 20


_exit:
	li a7, 10
	ecall


gcd:
	bnez a1, else
	#return a0;
	ret


else:
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw s0, 8(sp)

	mv s0, a1
	remu a1, a0, a1
	mv a0, s0

	j gcd

	lw a0, 0(sp)
	lw a1, 4(sp)
	lw s0, 8(sp)

	ret

	


