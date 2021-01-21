#
# performing logical and arithmetical bit shifts
#
	.data
please:
	.string "Please, input integer x: "
arleft:
	.string "\nResults: (assuming integers, printing binaries)\n1.x Arithm.<< 3 <=> Log.<< 3 : "
arright:
	.string "\n2.x Arithm.>> 3 : "
logright:
	.string "\n3.x Log.>> 3 : "
	
	.text
main:
	li a7, 4
	la a0, please
	ecall
	#x.input()
	li a7, 5
	ecall
	add t0, zero, a0
	
	li a7, 4
	la a0, arleft
	ecall
	slli a0, t0, 3
	li a7, 35
	ecall
	
	li a7, 4
	la a0, arright
	ecall
	srai a0, t0, 3
	li a7, 35
	ecall
	
	li a7, 4
	la a0, logright
	ecall
	srli a0, t0, 3
	li a7, 35
	ecall
	## in general both srli and srai provide same outputs, as compilator is x32 00..() {32}##
	
	
