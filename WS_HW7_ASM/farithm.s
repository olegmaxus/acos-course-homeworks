#
# Write program farithm.s that inputs three DOUBLE values a, b, and c, calculates the result of expression a + b - c, 
# and prints the result.
#

	.text
	.include "macros.s"
	.eqv aa ft0
	.eqv bb ft1
	.eqv cc ft2


main:
	print_str("Please, input double \"a\": ")
	double_input(aa)
	
	print_str("Please, input double \"b\": ")
	double_input(bb)
	
	print_str("Please, input double \"c\": ")
	double_input(cc)
	

	fadd.d aa, aa, bb
	fsub.d aa, aa, cc
	
	newline
	print_str("a + b - c = ")
	print_var_double(aa)

_exit:
	null.exit()
	