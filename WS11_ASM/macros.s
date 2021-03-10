#
# Library of macros for workshop 5 and for latter ones, if needed.
#
	.macro int_input(%var)
	li a7, 5
	ecall
	mv %var, a0
	.end_macro	
	
	.macro print_var_str(%str)
	mv a0, %str
	li a7, 4
	ecall
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
	
# printing immediate in bin format:

	.macro print_bin_val(%immed)
	.data
bin:
	.word %immed
	.text
	li a7, 35
	lw a0, bin
	ecall
	.end_macro

# input float value:

.macro float_input(%var)
   	li a7, 6
  	ecall
   	fmv.s %var, fa0
   	.end_macro

# input double value:

	.macro double_input(%var)
   	li a7, 7
  	ecall
   	fmv.d %var, fa0
   	.end_macro

# store double value:
	
	.macro store_double(%var)
	addi sp, sp, -8
	fsd %var, 0(sp)
	.end_macro

# unstore double value:

	.macro unstore_double(%var)
	addi sp, sp, 8
	.end_macro
	
# print float value in binary:

   	.macro print_bin_float (%var)
   	fmv.x.s a0, %var
   	li a7, 35 
   	ecall
   	.end_macro

# print float value:

	.macro print_var_float (%var)
   	fmv.s fa0, %var
   	li a7, 2 
   	ecall
   	.end_macro

# print double value in binary:

	.macro print_bin_double(%var)
	store_double(%var)
	lw a0, 4(sp)
   	li a7, 35 
   	ecall
   	
   	lw a0, 0(sp)
   	li a7, 35 
   	ecall
	unstore_double(%var)
   	.end_macro

# print double value:

	.macro print_var_double(%var)
	fmv.d fa0, %var
	li a7, 3
	ecall
   	.end_macro

# exit:

	.macro null.exit()
	li a7, 10
	ecall
	.end_macro
