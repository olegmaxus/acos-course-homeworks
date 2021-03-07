#
# Write a program that waits for timer interrupts and counts them. 
# Input data: 'm' is the limit on number of interrupts to process, 
# 't' is the interval between interrupts in milliseconds. 
# The program exits when the number of handler interrupts reaches the limit.
#
	.text
	.include "macros.s"

	.eqv   H_TIME t0
	.eqv   m t1
	.eqv   t t2
	.eqv   milsec t3
	.eqv   TIME_PV s0
	.eqv   TIME_NT s1
	.eqv   TIME_OUT s2
	
	.eqv   TIME_PREV 0xFFFF0018
	.eqv   TIME_NEXT 0xFFFF0020

	j      main

handler:
	addi   m, m, -1

	lw     H_TIME, 0(TIME_PV)
	add    H_TIME, H_TIME, t
	sw     H_TIME, 0(TIME_NT)	
	
	print_str("\nInterrupt occured!\nTime: ")
	lw     TIME_OUT, 0(TIME_PV)
	div    TIME_OUT, TIME_OUT, milsec 
	print_var_int(TIME_OUT)
	print_str(" (sec.)")
	newline
	
	beqz m, _exit
	uret

main:
	print_str("\nPlease, input the limiting number for interrupts (m): ")
	int_input(m)
	print_str("Please, input the interval between interrupts in ms.(t): ")
	int_input(t)

	la     H_TIME, handler

	csrrw  zero, utvec, H_TIME
	csrrsi zero, ustatus, 1
	csrrwi zero, uie, 0x10 # interrupt enable
	
	li     TIME_PV, TIME_PREV
	li     TIME_NT, TIME_NEXT

	lw     H_TIME, 0(TIME_PV)
	add    H_TIME, H_TIME, t
	sw     H_TIME, 0(TIME_NT)

	li     milsec, 1000

interrupt_loop:	
	wfi
	j     interrupt_loop

_exit:
	print_str("\nThe maximum number of interrupts is reached.\nThe program is terminated.\n")
	null.exit()
	
	
