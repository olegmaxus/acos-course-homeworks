#
# signed and unsigned comparison of x and y
#

	.data
pleaser_x:
	.string "Please, input integer x: "
pleaser_y:
	.string "Please, input integer y: "
ne_new:
	.string "\nIf x is less then y: output is 1, else: output is 0"
isless:
	.string "\nsigned comparison:  x < y : "
isless_u:
	.string "\nunsigned comparison:x < y : "

	.text
main:
	li a7, 4
	la a0, pleaser_x
	ecall
	#x.input()
	li a7, 5
	ecall
	add t0, zero, a0
	
	li a7, 4
	la a0, pleaser_y
	ecall
	#y.input()
	li a7, 5
	ecall
	add t1, zero, a0
	
	li a7, 4
	la a0, ne_new
	ecall
	
	slt t2, t0, t1
	sltu t3, t0, t1
	
	li a7, 4
	la a0, isless
	ecall
	li a7, 1
	add a0, zero, t2
	ecall
	li a7, 4
	la a0, isless_u
	ecall
	li a7, 1
	add a0, zero, t3
	ecall
	
