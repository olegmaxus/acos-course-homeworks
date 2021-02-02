#
# Write a program that inputs two !unsigned! integer values x and y, calculates x ** y (x raised to the power of y),
# and prints the result. 
# The exponentiation should be implemented as a multiplication in a loop.
# If an overflow occurs, the program must exit the loop and print an error message.
#

	.include "macros.s"
	.eqv x t0
	.eqv y t1
	.eqv init t2
	.eqv oflow t3
	.eqv ind t4
	.eqv oneC t5
	
	# Notes:                                             \
	# to check whether ERROR exit works correctly input: |
	# x = 46340, y = 2                                   |
	# - no error message;                                |> 46340**2 < 2**31, 46341**2 > 2**31
	# then:                                              |
	# x = 46341, y = 2                                   |
	# - exit with an error message;                      /
	
	# Some other notes:
	# my program uses the following rules:
	# 0 ** 0 = 1
	# 0 ** (n != 0) = 0
	# (n != 0) ** 0 = 1
	# 1 ** n = 1
main:
	print_str("Please, input integers x and y:")
	newline
	print_str("x: ")
	int_input(x)
	print_str("y: ")
	int_input(y)
	mv init, x
	li ind, 1
	li oflow, 1
	li oneC, 1
	
	beq oneC, x, exit_0
	beqz x, zero_powerand
	beqz y, exit_0
	
exp_while:
	beq ind, y, exit
	mul x, x, init
	slt oflow, init, x
	beqz oflow, error
	addi ind, ind, 1
	j exp_while
error:
	print_str("\nERROR: multiplication overflow has occured!\nThe program ended with an emergency exit\n")
	j _end
zero_powerand:
	beqz y, exit_0
	print_str("x ** y = 0")
	j _end
exit_0:
	print_str("x ** y = 1")
	j _end
exit:
	print_str("x ** y = ")
	print_var_int(x)
	j _end
_end:
	# exit;
