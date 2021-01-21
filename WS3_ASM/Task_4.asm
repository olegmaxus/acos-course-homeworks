#
# calculating stuff
#
	.data
please:
	.string "Please, input an integer x: "
please1:
	.string "Please, input an integer y: "
fst:
	.string "\nResults: (assuming integers)\n1.x + 5 - y : "
snd:
	.string "\n2.(x - y) << 3 : "
trd:
	.string "\n3.(x + y) >> 2 : "
frt:
	.string "\n4.(x + 5) + (x - 7) : "
fft:
	.string "\n5.x >> 3 + y << 3 : "
	
	.text
main:
	
	li a7, 4
	la a0, please
	ecall
	# x.input()
	li a7, 5
	ecall
	add t0, zero, a0
	
	li a7, 4
	la a0, please1
	ecall
	# y.input()
	li a7, 5
	ecall
	add t1, zero, a0
	
	# 1st
	li a7, 4
	la a0, fst
	ecall
	addi t2, t0, 5
	sub a0, t2, t1
	#add a0, zero, t2
	li a7, 1
	ecall
	
	# 2nd
	li a7, 4
	la a0, snd
	ecall
	sub t2, t0, t1
	slli a0, t2, 3
	li a7, 1
	ecall
	
	# 3d
	li a7, 4
	la a0, trd
	ecall
	add t2, t0, t1
	srli a0, t2, 2
	li a7, 1
	ecall
	
	# 4th
	li a7, 4
	la a0, frt
	ecall
	addi t2, t0, 5
	addi t3, t0, -7
	add a0, t2, t3
	li a7, 1
	ecall
	
	# 5th
	li a7, 4
	la a0, fft
	ecall
	srli t2, t0, 3
	slli t3, t1, 3
	add a0, t2, t3
	li a7, 1
	ecall
	 
	
	
	
