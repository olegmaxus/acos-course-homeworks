#
# Write your own macros print_hex and print_bin for printing values in hexadecimal and binary formats respectively.
# What if you want to print immediate values? What kind of macro do you need in this case?
# 

	.include "macros.s"
	
# printing variable in hex format:

	.macro print_hex(%var)
	li a7, 34
	mv a0, %var
	ecall
	.end_macro
	
# printing variable in binary format:

	.macro print_bin(%var)
	li a7, 35
	mv a0, %var
	ecall
	.end_macro
	
# printing immediate in hex format:

	.macro print_hex_val(%immed)
	.data
hex:
	.word %immed
	.text
	li a7, 34
	lw a0, hex
	ecall
	.end_macro
	
# printing immediate in hex format

	.macro print_bin_val(%immed)
	.data
bin:
	.word %immed
	.text
	li a7, 35
	lw a0, bin
	ecall
	.end_macro

# check:
	.eqv x t0
	.text
main:
	li t0, 16
	print_str("Hello! This is a test for printing hex and binary representation of an integer 'x' = 16 and an immediate of the same value .\n")
	print_str("You don't have to input anything, just look: \n")
	print_str("Let's see whether calling print_hex(x) and print_bin(x)\n")
	print_str("provide us with same results, as print_hex_val(16), print_bin_val(16).\n\n")
	print_str("Results:\nprint_hex(x): ")
	print_hex(x)
	newline
	print_str("print_bin(x): ")
	print_bin(x)
	newline
	newline
	print_str("print_hex_val(16): ")
	print_hex_val(16)
	newline
	print_str("print_bin_val(16): ")
	print_bin_val(16)
	newline
	print_str("\nIf results are same for both variable and immediate cases, then I've done all macros correctly :)")