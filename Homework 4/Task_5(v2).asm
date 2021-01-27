#
# Task 5 implementation, using branching instructions:
#

	.data
pleaser_x:
	.string "Please, input an integer x: "
pleaser_y:
	.string "Please, input an integer y: "
caller_min:
	.string " is the smallest integer among x and y"
caller_max:
	.string " is the largest integer  among x and y"
	
	.text
main:

	li a7, 4
	la a0, pleaser_x
	ecall
	li a7, 5
	ecall
	mv t0, a0
	
	li a7, 4
	la a0, pleaser_y
	ecall
	li a7, 5
	ecall
	mv t1, a0
	
	blt t1, t0, case_1
	blt t0, t1, case_2
	
case_1:
	mv a0, t1
	li a7, 1
	ecall
	la a0, caller_min
	li a7, 4
	ecall
	
	li a0, '\n'
	li a7, 11
	ecall
	
	mv a0, t0
	li a7, 1
	ecall
	la a0, caller_max
	li a7, 4
	ecall
	
	b end
case_2:
	mv a0, t0
	li a7, 1
	ecall
	la a0, caller_min
	li a7, 4
	ecall
	
	li a0, '\n'
	li a7, 11
	ecall
	
	mv a0, t1
	li a7, 1
	ecall
	la a0, caller_max
	li a7, 4
	ecall
	
	b end
end:
	#exit;
