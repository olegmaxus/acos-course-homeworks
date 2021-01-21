#
# program for inputting int x and printing it as dec, unsigned, hex, binary
#
	.data
intro:
	.string "Please, input some integer: "
new_line:
	.string "\n"
dec:
	.string " - decimal"
usgn:
	.string " - unsigned"
hex:
	.string " - hexadecimal"
bin:
	.string " - binary"
	
	.text
main:
	#intro
	li a7, 4
	la a0, intro
	ecall
	li a7, 5
	ecall
	add t0, zero, a0
	
	#printing decimal
	add a0, zero, t0
	li a7, 1
	ecall
	
	li a7, 4
	la a0, dec
	ecall
	
	li a7, 4
	la a0, new_line
	ecall
	
	#printing unsigned
	add a0, zero, t0
	li a7, 36
	ecall
	
	li a7, 4
	la a0, usgn
	ecall
	
	li a7, 4
	la a0, new_line
	ecall
	
	#printing hex
	add a0, zero, t0
	li a7, 34
	ecall
	
	li a7, 4
	la a0, hex
	ecall
	
	li a7, 4
	la a0, new_line
	ecall
	
	#printing binary
	add a0, zero, t0
	li a7, 35
	ecall
	
	li a7, 4
	la a0, bin
	ecall
	

