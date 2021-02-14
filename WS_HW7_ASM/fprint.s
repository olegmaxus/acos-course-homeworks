#
# Write program that inputs a single and double floating-point value and prints them in the binary format.
#

	.text
	
	.include "macros.s"



main:
	addi sp, sp, -8

	print_str("Please, input a floating point number of SINGLE precision: ")
	li a7, 6
	ecall
	fmv.x.s a1, fa0
	print_str("Please, input a floating point number of DOUBLE precision: ")
	li a7, 7
	ecall
	fsd fa0, 0(sp)
	print_str("Binary value for single precision float is: ")
	mv a0, a1
	li a7, 35
	ecall
	newline
	print_str("Binary value for double precision float is: ")
	li a7, 35
	lw a0, 4(sp)
	ecall
	lw a0, 0(sp)
	ecall
	newline

	addi sp, sp, 8
	
	li a7, 10
	ecall
