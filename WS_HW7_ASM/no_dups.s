#
# Input an integer value N and then N double values. Outputs all the doubles, skipping duplicated ones.
#

	.data
print: .word 0

	.text
	.include "macros.s"

	.eqv N t0
	.eqv N_store t1

	.eqv ii t2
	.eqv jj t3

	.eqv space_move t4
	.eqv temp_ptr t5
	.eqv darr_ptr t6

	.eqv flag s0
	.eqv print_ptr s1

	.eqv double fa0
	.eqv tdoub_1 ft0
	.eqv tdoub_2 ft1

main:
	int_input(N)
	mv N_store, N
	li space_move, 8
	la print_ptr, print

while_input:
	beqz N, N_move

	double_input(double)
	
	addi sp, sp, -8
	fsd double, 0(sp)
	addi N, N, -1
	
	j while_input

N_move: mv N, N_store

store_word: # to print the very first unique element inputter <=> order is not reverse
	beqz N, interim

	fld double, 0(sp)
	addi sp, sp, 8
	addi print_ptr, print_ptr, -8
	fsd double, 0(print_ptr)

	addi N, N, -1
	j store_word
interim:
	mv N, N_store
	mv darr_ptr, print_ptr #initial array pointer, updating
	mv ii, zero

external_for:
	beq ii, N_store, _end

	fld tdoub_1, 0(darr_ptr)
	add darr_ptr, darr_ptr, space_move
	
	mv temp_ptr, print_ptr # renewable at iteration array pointer
	mv jj, zero

embedded_loop:
	beq jj, ii, end_inner

	fld tdoub_2, 0(temp_ptr)
	add temp_ptr, temp_ptr, space_move
	
	feq.d flag, tdoub_1, tdoub_2
	bnez flag, end_inner
	
	addi jj, jj, 1
	j embedded_loop

end_inner:
	#code
	bne ii, jj, proceed_no_print
	newline
	print_var_double(tdoub_1)

proceed_no_print:
	addi ii, ii, 1
	j external_for

_end:
	mul N, N, space_move
	add sp, sp, N
	null.exit()

	




