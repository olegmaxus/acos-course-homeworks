#
# Write a program that inputs two integer values x and y 
# and prints first the smallest of them and then the largest of them.
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
	la a0, pleaser_x
	li a7, 4
	ecall 
	li a7, 5
	ecall
	mv t0, a0 # x
	
	la a0, pleaser_y
	li a7, 4
	ecall
	li a7, 5
	ecall
	mv t1, a0 # y
	
	# we can use "if branching", and it would be done in Task_5(v2).asm
	# but now let's try to create something more interesting, without 
	# using branch instructions :)
	# 
	# let's use XOR instruction to compare x and y, that is:
	# min: y xor ((x xor y) and neg(x < y)), that is:
	#      if x > y, then neg(x < y) == 0, that is we
	#      have y xor ((x xor y) and 0) = y xor 0 = y <=> min = y
	#      if x < y, then (x < y) == 1, that is why we
	#      also use negation: as we need not simple 1-bit one, but
	#      the sequence of ones, i.e. -1, for bitwise and operation
	#      to work properly (we want (x and [111..1 =-1]), not (x and [000..01 = 1]))
	#      have y xor ((x xor y) and -1) = y xor (x xor y) = x <=> min = x
	# max: quite same: x xor ((x xor y) and neg(x < y))
	#
	# let's begin the implementation!
	
	slt t2, t0, t1 # (x < y)
	neg t2, t2
	xor t3, t0, t1
	and t2, t2, t3
	
	xor a0, t1, t2
	li a7, 1
	ecall
	li a7, 4
	la a0, caller_min
	ecall
	
	li a7, 11
	li a0, '\n'
	ecall
	
	xor a0, t0, t2
	li a7, 1
	ecall
	li a7, 4
	la a0, caller_max
	ecall
	
	