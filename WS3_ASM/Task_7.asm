#
# setting 3-rd bit of x, resetting its 6-th bit of x (assuming smallest from the right, enumerating smallest bit as 1st (not 0th))
#
	.data 
please_intro:
	.string "Please, input an integer x: "
result:
	.string "\nResult: "
init:
	.string "Initial:"

	.text
main:
	li a7, 4
	la a0, please_intro
	ecall
	#x.input()
	li a7, 5
	ecall
	add t0, zero, a0
	
	li a7, 4
	la a0, init
	ecall
	add a0, zero, t0
	li a7, 35
	ecall
	
	li a7, 4
	la a0, result
	ecall
	
	li t1, 1
	slli t1, t1, 2
	or t0, t0, t1
	
	li t1, 1
	slli t1, t1, 5
	not t1, t1
	and a0, t0, t1
	li a7, 35
	ecall
