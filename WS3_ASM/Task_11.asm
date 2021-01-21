#
# bit tricks for x:
# turning off the rightmost 1-bit
# turning on the rightmost 0-bit
# turning on the trailing zeroes
#

	.data
k1_asker:
	.string "Please, input an integer x for the 1st trick: "
k2_asker:
	.string "\nPlease, input an integer y for the 2nd trick: "
k3_asker:
	.string "\nPlease, input an integer z for the 3rd trick: "
intro:
	.string "\nNow let's perform some bit tricks:\nInitial x base 2 is: "
intro1:
	.string "\nInitial y base 2 is: "
intro2:
	.string "\nInitial z base 2 is: "
off_rm1:
	.string "\n\nTurning off the rightmost 1-bit of x: "
on_rm0:
	.string "\nTurning on the rightmost 0-bit of y : "
trail:
	.string "\nTurning on the trailing zeroes of z : "

	.text
main:
	#x.input() example x = 88
	li a7, 4
	la a0, k1_asker
	ecall
	li a7, 5
	ecall
	add t0, zero, a0
	
	#y.input() example y = 167
	li a7, 4
	la a0, k2_asker
	ecall
	li a7, 5
	ecall
	add t1, zero, a0
	
	#z.input() example z = 168
	li a7, 4
	la a0, k3_asker
	ecall
	li a7, 5
	ecall
	add t2, zero, a0
	
	#intro
	li a7, 4
	la a0, intro
	ecall
	li a7, 35
	add a0, zero, t0
	ecall
	li a7, 4
	la a0, intro1
	ecall
	li a7, 35
	add a0, zero, t1
	ecall
	li a7, 4
	la a0, intro2
	ecall
	li a7, 35
	add a0, zero, t2
	ecall
	
	#1st trick: x & (x - 1)
	li a7, 4
	la a0, off_rm1
	ecall
	li a7, 35
	addi t3, t0, -1
	and a0, t0, t3
	ecall
	
	#2nd trick: y | (y + 1)
	li a7, 4
	la a0, on_rm0
	ecall
	li a7, 35
	addi t3, t1, 1
	or a0, t1, t3
	ecall
	
	#3d trick: z | (z - 1)
	li a7, 4
	la a0, trail
	ecall
	li a7, 35
	addi t3, t2, -1
	or a0, t2, t3
	ecall
	
	