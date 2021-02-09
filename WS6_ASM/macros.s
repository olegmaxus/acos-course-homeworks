#
# Library of macros for workshop 5 and for latter ones, if needed.
#
	.macro int_input(%val)
	li a7, 5
	ecall
	mv %val, a0
	.end_macro	

	.macro print_str(%str)
	.data
str:
	.asciz %str
	.text
	li a7, 4
	la a0, str
	ecall
	.end_macro

	.macro print_val_int(%immed)
	li a7, 1
	li a0, %immed
	ecall
	.end_macro
	
	.macro print_var_int(%var)
	li a7, 1
	mv a0, %var
	ecall
	.end_macro
	
	.macro print_char(%char)
	li a7, 11
	li a0, %char
	ecall
	.end_macro
	
	.macro newline
	print_char('\n')
	.end_macro
	
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