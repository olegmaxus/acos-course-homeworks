#
# Write a program that inputs two integer values x and y and prints all the values in the range min(x, y)..max(x, y).
#
	
	.include "macros.s"
	
main:
	print_str("Please, input an integer x: ")
	int_input(t0)
	print_str("Please, input an integer y: ")
	int_input(t1)
	
	#t2 = min
	slt t2, t0, t1
	neg t2, t2
	xor t3, t0, t1
	and t2, t2, t3
	xor t2, t1, t2
	mv t3, zero
	#t3 = max
	slt t3, t0, t1
	neg t3, t3
	xor t4, t0, t1
	and t3, t3, t4
	xor t3, t0, t3
	mv t4, zero

	addi t3, t3, 1 #range
for_step:
	beq t2, t3, end_for
	print_var_int(t2)
	newline
	addi t2, t2, 1
	j for_step
end_for:
	#exit;
	
	
