
# Study the theory and examples on the current workshop.

# Implement an exception handler that prints a message that explains the reason of an exception 
# (the list of exceptions with descriptions is above) ~ whatever, Say :)

	.include "macros.s"
	.eqv ERR t0
	.eqv ERR_CS t1
	.eqv ERR_T t2
	.eqv ERR_PTR t3
	.eqv WARNING t4
	.eqv ERR_MSG a2
	.data

preambula: .string "\nCaution! An error has occured at: "
spoiled_address: .string "\nERROR: INSTRUCTION ADDRESS MISALIGNED.\n"
invalid_access: .string "\nERROR: INSTRUCTION ACCESS FAILURE.\n"
illegal_instruction: .string "\nERROR: ILLEGAL INSTRUCTION.\n"
incorrect_load_attempt: .string "\nERROR: LOAD ADDRESS MISALIGNED.\n"
incorrect_load_target: .string "\nERROR: LOAD ACCESS FAILURE.\n"
incorrect_write_attempt: .string "\nERROR: STORE ADDRESS MISALIGNED.\n"
incorrect_write_target: .string "\nERROR: STORE ACCESS FAILURE.\n"
invalid_environment_call: .string "\nERROR: UNSUPPORTED ENVIRONMENT CALL.\n"

error_type: 
	.word spoiled_address, invalid_access, illegal_instruction, incorrect_load_attempt
	.word incorrect_load_target, incorrect_write_attempt, incorrect_write_target
	.word invalid_environment_call

##	.data #test data
##	.space 2 #startcal
##	.align 0
##data: .word 0xDEADBEEF


	.text
	j main

_ERRETURN:
	csrr  ERR, uepc
	csrr  ERR_CS, ucause

	la    ERR_PTR, error_type
	la    WARNING, preambula

	li    ERR_T, 2

	bgt   ERR_T, ERR_CS, ucause_0.1
	beq   ERR_T, ERR_CS, ucause_2

	addi ERR_T, ERR_T, 1
	
	beq   ERR_T, ERR_CS, ucause_3
	blt   ERR_T, ERR_CS, ucause_4.8

ucause_0.1:
	print_var_str(WARNING)
	print_hex(ERR)
	slli  ERR_CS, ERR_CS, 2
	add   ERR_PTR, ERR_PTR, ERR_CS
	lw    ERR_MSG, 0(ERR_PTR)
	print_var_str(ERR_MSG)
	null.exit()
	
	# program is arificially terminated due to a bug in RARS, since uepc is addressing to the data section, 
	# while it has to point to the inconsistent instruction
	# it causes the program to print the error message in an infinite cycle, so that the only way around this issue was just to
	# terminate the program artificially.
	# that is why no return is there, as it is not needed.

	#j ret

ucause_2:
	print_var_str(WARNING)
	print_hex(ERR)
	slli  ERR_CS, ERR_CS, 2
	add   ERR_PTR, ERR_PTR, ERR_CS
	lw    ERR_MSG, 0(ERR_PTR)
	print_var_str(ERR_MSG)

	j ret

ucause_3:
	print_var_str(WARNING)
	print_hex(ERR)
	print_str("\nERROR: UNKNOWN INTERNAL ERROR.\n")

	j ret

ucause_4.8:
	print_var_str(WARNING)
	print_hex(ERR)
	addi  ERR_CS, ERR_CS, -1
	slli  ERR_CS, ERR_CS, 2
	add   ERR_PTR, ERR_PTR, ERR_CS
	lw    ERR_MSG, 0(ERR_PTR)
	print_var_str(ERR_MSG)

	j ret

ret:
	addi  ERR, ERR, 4
	csrrw zero, uepc, ERR  # update exception PC
	uret                   # return to uepc

##main:
##	la ERR, _ERRETURN
##	csrrw zero, utvec, ERR  # set utvec (5) to the handlers address
##	csrrsi zero, ustatus, 1 # set interrupt enable bit in ustatus (0)

	# UCAUSE == 0: # ERROR: INSTRUCTION ADDRESS MISALIGNED.
	#
	#la   t5, spoiled_address
	#addi t5, t5, 2 #spoiled link
	#jr   t5
	
	# UCAUSE == 1: # ERROR: INSTRUCTION ACCESS FAILURE.
	#
	#la t5, invalid_access
	#jr t5

	# UCAUSE == 2: # ERROR: ILLEGAL INSTRUCTION.
	#
	#li    t5, 8
	#csrrs zero, cycle, t5 #zero register, can't read => retrial

	# UCAUSE == 3: # ERROR: UNKNOWN INTERNAL ERROR.
	#
	#???#

	# UCAUSE == 4: # ERROR: LOAD ADDRESS MISALIGNED.
	#
	#la t5, data
	#lw t6, 0(t5) #nonexcept with (2) immediate, as aligned bytes are 0, division onto 2 blocks

	# UCAUSE == 5: # ERROR: LOAD ACCESS FAILURE.
	#
	#lw zero, 0(zero)

	# UCAUSE == 6: # ERROR: STORE ADDRESS MISALIGNED.
	#
	#la t5, data
	#li t6, 0xDEADBEEF #incorrect writing into dynamic memory # ~ same issue, just with storing word 
	#sw t6, 0(t5) #works with 2
	
	# UCAUSE == 7: # ERROR: STORE ACCESS FAILURE.
	#
	#la t5, main
	#li t6, 0xDEADBEEF
	#sw t6, 0(t5)  # cannot write into memory units, which are protected from writing into

	# UCAUSE == 8: # ERROR: UNSUPPORTED ENVIRONMENT CALL.
	#
	#li a7, 100
	#ecall
	
##	print_str("\nhello there :)")
##	null.exit()

