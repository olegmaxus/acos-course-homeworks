#
# Inputs two integers and prints their sum. 
# checks whether overflow has occured during the additions
# prints 1 if occured, 0 otherwise
#
	.data
please_x:
	.string "Please, input integer x: "
please_y:
	.string "Please, input integer y: "
print:
	.string "\nOverflow occurs if 'overflow = 1',\ni.e. if 'overflow = 0' there's no overflow:\nLet's see then whether it has occured:\n"
overflow:
	.string "overflow = "
	
    .text
main: 
	#input example for reaching overflow is x = 2147483647, y = 1.
	
    # x.input() {max x = 2^31 - 1}
    li a7, 4
    la a0, please_x
    ecall
    li a7, 5
    ecall
    add t0, zero, a0

    # y.input() {max y = 2^31 - 1}
    li a7, 4
    la a0, please_y
    ecall
    li a7, 5
    ecall
    add t1, zero, a0
    
    # intro
	li a7, 4
	la a0, print
	ecall
	
    # z: t2 = t0 + t1
    add t2, t0, t1

	# an overflow occurs if x + y < x && x + y < y
	# for x32 architecture of the assembley compiler on ubuntu linux VM
	# that happens if for some given pair (x,y) and operation R="+" : R(x,y) >= 2^31
	# let's then check the condition: if (x+y<x && x+y<y) then: overflow; else: no overflow
	
	slt t3, t2, t0
	slt t4, t2, t1
	
	li a7, 4
	la a0, overflow
	ecall
	
	and a0, t3, t4
	li a7, 1
	ecall
