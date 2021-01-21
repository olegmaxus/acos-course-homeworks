#
# swap x and y using xor
#

	.data
please_x:
	.string "Please, input integer x: "
please_y:
	.string "Please, input integer y: "
x_old:
	.string "\nSwapping x and y:\n...\ninitial x value is: "
y_old:
	.string "\ninitial y value is: "
x_new:
	.string "\n...\nnew value of x is : "
y_new:
	.string "\nnew value of y is : "
complete:
	.string "\n...\nswap is complete!\n"
	
	.text
main:
	#as we know the following order of operation swaps x and y:
	#x = x xor y; y = x xor y; x = x xor y;
	
	li a7, 4
	la a0, please_x
	ecall
	#x.input()
	li a7, 5
	ecall
	add t0, zero, a0
	
	li a7, 4
	la a0, please_y
	ecall
	#y.input()
	li a7, 5
	ecall
	add t1, zero, a0
	
	li a7, 4
	la a0, x_old
	ecall
	li a7, 1
	add a0, zero, t0
	ecall
	
	li a7, 4
	la a0, y_old
	ecall
	li a7, 1
	add a0, zero, t1
	ecall
	
	xor t0, t0, t1
	xor t1, t0, t1
	xor t0, t0, t1
	
	li a7, 4
	la a0, x_new
	ecall
	li a7, 1
	add a0, zero, t0
	ecall
	
	li a7, 4
	la a0, y_new
	ecall
	li a7, 1
	add a0, zero, t1
	ecall
	
	li a7, 4
	la a0, complete
	ecall
