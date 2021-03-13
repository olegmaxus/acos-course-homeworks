#
# Write a function in RISC-V assembly, which accepts as arguments an array of 16-bit values and returns the result 
# of following expression: A[0] - A[1] + A[2] - A[3] + [A4] ... +- A[N-1].
# Use the loop unrolling technique to make calculations faster.
#



#
# I have created an artificial array of 15 elements, if the array should've been custom, the program would've looked different
# Only the array containing AT MOST 15 elements was considered in my program, as it was not explicitly stated, that array should
# have been of custom size.
#

#
## if the task was to implement the array of custom size, we might have constructed the even and odd LENGTH cases for function
## Yet, I have enrolled the loops, and have separated them for odd and even element idicies to gain performance.
#

	.text	
	.include "macros.s"
	.eqv vec_address a0
	.eqv current     t4
	.eqv sizeof      t5
	.eqv sum         t6
	
	.data
vector:
	.half 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

	.text
main:
	la      vec_address, vector
	jal     func

	print_var_int(a0)
	
	j       _exit

func:
	addi    sp, sp, -24
	sw      current,      0(sp)
	sw      sizeof,       4(sp)
	sw      sum,          8(sp)
	sw      vec_address, 12(sp)

	li      current,   0
	li      sizeof,    28
	li      sum,       0

	add     sizeof, sizeof, vec_address

func_odd:

	lh      current, 0(vec_address)
	add     sum, sum, current
	addi    vec_address, vec_address, 4

	lh      current, 0(vec_address)
	add     sum, sum, current
	beq     vec_address, sizeof, func_step
	addi    vec_address, vec_address, 4


	j       func_odd
	
func_step:
	lw      vec_address, 12(sp)
	addi    vec_address, vec_address, 2
	addi    sizeof, sizeof, -2

func_even:

	lh      current, 0(vec_address)
	sub     sum, sum, current
	beq     vec_address, sizeof, return
	addi    vec_address, vec_address, 4


	lh      current, 0(vec_address)
	sub     sum, sum, current
	addi    vec_address, vec_address, 4

	j      func_even

return:
	sw      current,      0(sp)
	sw      sizeof,       4(sp)
	mv     vec_address, sum
	sw      sum,          8(sp)
	addi   sp, sp, 24

	ret

_exit:
	null.exit()
	