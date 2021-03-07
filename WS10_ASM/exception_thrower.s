#
# Image how the try-catch construct is implemented in high-level languages. 
# Then write a program that implements a simple function with an exception handler. 
# The function takes an argument that specifies what exception it will raise:
# (0 - no exception, 1 - some exception from list obove, 2 - some other exception from the list, etc.). 
# The function must return exception cause or 0 if no exception has occurred. 
# The program prints the exception cause. ~ try-catch construction
#

# skeleton:
# funct(int k){
# 	try{...} catch(random exception){arise; } ret 0; process;}
#

	.include "exception_handler.s"

	.eqv k s0
	.eqv mainfold a0
	.eqv case s1
	.eqv test_val_1 t5
	.eqv test_val_2 t6

	.data #test data
	.space 2 #startcal
	.align 0
	 data: .word 0xDEADBEEF
	
	.text

function:
	addi sp, sp, -20
	sw   case, 0(sp)
	sw   test_val_1, 4(sp)
	sw   test_val_2, 8(sp)
	
	
	la           ERR, _ERRETURN
	csrrw zero,  utvec, ERR  # set utvec (5) to the handlers address
	csrrsi zero, ustatus, 1 # set interrupt enable bit in ustatus (0)
	
	li   case, 0
	beq  mainfold, case, ret_case

	addi case, case, 1
	beq  mainfold, case, exception_0

	addi case, case, 1
	beq  mainfold, case, exception_1

	addi case, case, 1
	beq  mainfold, case, exception_2

	addi case, case, 1
	beq  mainfold, case, exception_3

	addi case, case, 1
	beq  mainfold, case, exception_4

	addi case, case, 1
	beq  mainfold, case, exception_5

	addi case, case, 1
	beq  mainfold, case, exception_6

	addi case, case, 1
	beq  mainfold, case, exception_7

	addi case, case, 1
	beq  mainfold, case, exception_8
	
	j    incorrect_input

exception_0:
	la   test_val_1, spoiled_address
	addi test_val_1, test_val_1, 2 #spoiled link
	jr   test_val_1
	
	# program terminates due to a bug in RARS, since uepc is addressing to the data section, rather than to the next instruction
	# it causes the program to print the error message in an infinite cycle, so that the only way around this issue was just to
	# terminate the program artificially
	# that is why no return is there, as it is not needed.

exception_1:
	la test_val_1, invalid_access
	jr test_val_1
	
	# same issue as for ucause == 0; no return due to bug in uepc address corruption

exception_2:
	li    test_val_1, 8
	csrrs zero, cycle, test_val_1
	j func_ret

exception_3:
	print_str("\nSuch exception is not known, thus is created artificially:\n")
	print_str("ERROR: UNKNOWN INTERNAL ERROR.\n")
	j func_ret

exception_4:
	la test_val_1, data
	lw test_val_2, 0(test_val_1)
	j func_ret

exception_5:
	lw zero, 0(zero)
	j func_ret

exception_6:
	la test_val_1, data
	li test_val_2, 0xDEADBEEF #incorrect writing into dynamic memory # ~ same issue, just with storing word 
	sw test_val_2, 0(test_val_1) #works with 2
	j func_ret

exception_7:
	la t5, main
	li t6, 0xDEADBEEF
	sw t6, 0(t5)
	j func_ret

exception_8:
	li a7, 100
	ecall
	j func_ret	

incorrect_input:
	print_str("\nYour input was out of range.\nProgram terminated with no exception: ")
	j no_except

ret_case:
	print_str("\nNo exception has occured. Exit with: ")
	j no_except

no_except:
	lw   case, 0(sp)
	lw   test_val_1, 4(sp)
	lw   test_val_2, 8(sp)
	addi sp, sp, 20

	li mainfold, 0
	ret

func_ret:
	lw   case, 0(sp)
	lw   test_val_1, 4(sp)
	lw   test_val_2, 8(sp)
	addi sp, sp, 20

	li mainfold, -1
	ret

main:
	print_str("\nHello, this is a exception-catcher test program!\n")
	print_str("\nYou may input any integer, from the list:\n______________________________\n                              |")
	print_str("\n0 : No exception called.      |\n1 : Exception with ucause = 0.|")
	print_str("\n2 : Exception with ucause = 1.|\n3 : Exception with ucause = 2.|\n4 : \"unknown exception\"       |")
	print_str("\n5 : Exception with ucause = 4.|\n6 : Exception with ucause = 5.|\n7 : Exception with ucause = 6.|")
	print_str("\n8 : Exception with ucause = 7.|\n9 : Exception with ucause = 8.|\n______________________________|")
	print_str("\nPlease, input some integer in range [0:9]: ")

	int_input(k)

	mv  mainfold, k
	
	jal ra, function
	mv  k, mainfold
	
	beq k, zero, printex

	print_str("\n_____________________________________________\n                                             \\ ")
	print_str("\nTEST PRINT: to see, whether catch worked.    ")
	print_str(" |\nThis message won't occur, if:                 |\nUcause == 0 or 1, or if no exception occured. |\n")
	print_str("_____________________________________________/")
	j _exit

printex:
	print_var_int(k)
	newline
	j _exit

_exit:
	null.exit()

