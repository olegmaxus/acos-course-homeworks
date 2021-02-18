#
# Input three cardinals — A, B and n. 
# Output double float F that has exact n decimal places of A/B. 
# You need to write a subroutine than accepts double f=A/B in fa0 and integer n in a0 and returns rounded double F in fa0.
#


	.text
	.include "macros.s"
	.eqv AA t0
	.eqv BB t1
	.eqv startVAL t2
	.eqv power t3
	.eqv n a0
	.eqv frac fa0
	.eqv frac_pw ft0
	.eqv pow ft1
	.eqv fpow ft2
	
main:
	int_input(AA)
	int_input(BB)
	int_input(n)
	li startVAL, 10
	li power, 1
	fcvt.d.w fpow, power
	
	fcvt.d.w frac, AA
	fcvt.d.w frac_pw, BB
	fdiv.d frac, frac, frac_pw
	fcvt.d.w frac_pw, startVAL

	call exponent_truncation

	newline
	print_var_double(frac)
	
	j _end

exponent_truncation:
	beqz n, exponent_returner
	addi n, n, -1
	fmul.d fpow, fpow, frac_pw
	
	j exponent_truncation
	
exponent_returner:
	
	fmul.d frac, frac, fpow
	fcvt.w.d startVAL, frac
	fcvt.d.w frac, startVAL
	
	fdiv.d frac, frac, fpow

	ret

_end:
	null.exit()
	
