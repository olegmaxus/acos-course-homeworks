#
# Write program fprint2.s that separately prints fields (sign, fraction, exponent) of single and double floating-point values. 
# The code of the previous program can be partially reused.
#

	.text

	.include "macros.s"
	.eqv n a1
	.eqv stop a2
	.eqv curr_f_bit t0
	.eqv curr_g_bit t1
	.eqv num_f s0


main:
	print_str("Please, input a floating point number of SINGLE precision: ")
	float_input(fa1)
	print_str("Please, input a floating point number of DOUBLE precision: ")
	double_input(fa0)

	# bit exctraction: (num >> n) & 1, n = bitpos[0:63]
	# case for float:
	newline
	print_str("FLOAT: ")
	print_bin_float(fa1)
	newline

	li n, 31

	fmv.x.s curr_f_bit, fa1
	srl curr_f_bit, curr_f_bit, n
	andi curr_f_bit, curr_f_bit, 1

	print_str("sgn:      exp:             fract:        \n ")
	print_var_int(curr_f_bit)
	print_str("     ")

	li stop, 23

exp_float:
	fmv.x.s curr_f_bit, fa1

	beq n, stop, interim_float
	addi n, n, -1
	srl curr_f_bit, curr_f_bit, n
	andi curr_f_bit, curr_f_bit, 1

	print_var_int(curr_f_bit)

	j exp_float

interim_float:
	print_str("    ")
	li stop, 0	

frac_float:
	fmv.x.s curr_f_bit, fa1

	beq n, stop, interim_main
	addi n, n, -1
	srl curr_f_bit, curr_f_bit, n
	andi curr_f_bit, curr_f_bit, 1

	print_var_int(curr_f_bit)

	j exp_float

interim_main:
	newline
	newline
	print_str("DOUBLE: ")
	print_bin_double(fa0)
	
	store_double(fa0)
	newline

	li n, 63

	lw curr_g_bit, 4(sp)
	srl curr_g_bit, curr_g_bit, n
	andi curr_g_bit, curr_g_bit, 1

	print_str("sgn:       exp:                             fract:                         \n ")
	print_var_int(curr_g_bit)
	print_str("     ")

	li stop, 52

exp_double:
	lw curr_g_bit, 4(sp)

	beq n, stop, interim_double_first
	addi n, n, -1
	srl curr_g_bit, curr_g_bit, n
	andi curr_g_bit, curr_g_bit, 1

	print_var_int(curr_g_bit)

	j exp_double

interim_double_first:
	print_str("    ")
	li stop, 32

frac_double_first:
	lw curr_g_bit, 4(sp)

	addi n, n, -1
	beq n, stop, interim_double_second
	srl curr_g_bit, curr_g_bit, n
	andi curr_g_bit, curr_g_bit, 1

	print_var_int(curr_g_bit)

	j frac_double_first

interim_double_second:
	lw curr_g_bit, 4(sp)
	
	li stop, 31
	srl curr_g_bit, curr_g_bit, n
	andi curr_g_bit, curr_g_bit, 1
	
	print_var_int(curr_g_bit)
	
	li, stop, 0

frac_double_second:
	lw curr_g_bit, 0(sp)

	beq n, stop, _exit
	addi n, n, -1
	srl curr_g_bit, curr_g_bit, n
	andi curr_g_bit, curr_g_bit, 1

	print_var_int(curr_g_bit)

	j frac_double_second
_exit:
	unstore_double(fa0)
	null.exit()

