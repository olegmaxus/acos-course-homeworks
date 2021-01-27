#
# Write a program that inputs an integer value x and prints -1 if it is negative,
# 0 if it equals 0, and 1 if it is positive.
# Considering implementation without branching
#
	.data
pleaser:
	.string "Please, input an integer x: "
result:
	.string "Result: "
	.text
main:
	
	li a7, 4
	la a0, pleaser
	ecall
	
	li a7, 5
	ecall
	mv t0, a0
	
	li a7, 4
	la a0, result
	ecall
	
	slt t1, t0, zero
	slt t2, zero, t0
	sub a0 t2, t1
	li a7, 1
	ecall
	 
	
