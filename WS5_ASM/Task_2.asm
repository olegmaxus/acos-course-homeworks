#
# Write a program that fills an array of 32 integers from values from the standard input.
# It reads values in a loop and finishes reading when all 32 values are read or when value 0 is read.
#
	.include "macros.s"
	
	.macro print_hex(%var)
	li a7, 34
	mv a0, %var
	ecall
	.end_macro
	
	.eqv COUNT t5
	.eqv CONST t1
	.eqv x t0
	
	.data
	.space 128
	
	.text
main:
	li COUNT, 0
	li CONST, 32
	print_str("Please, sequntially input the integers to be stored:\n")
	j while_case
	
while_case:
	int_input(x)
	beqz x, _exit
	#sw x, 0(sp)
	addi sp, sp, -4
	sw x, 0(sp)
	addi COUNT, COUNT, 1
	beq COUNT, CONST, _exit
	
	j while_case
	
_exit:
	print_str("The current sp-address is: ")
	print_hex(sp)
	newline
	print_str("Check this address in the 'Data Segment' of 'Execute' pannel to see if all ints were stored correctly.\n")
	print_str("Note that if zero was inputted as a terminating symbol, the above address would point to that very zero.\n")
	 newline            #|
	 lw t3 0(sp)        #| this code will give you the last content of the array, i.e. arr[max_arr]
	 print_var_int(t3)  #| for example for sequence 1 2 3 4 5 6 7 0, it gives 7. (as zero is an indicator number)
	#                    #| for the sequence 1,2,3,4,5,6,7,8,...,32 it gives 32.
