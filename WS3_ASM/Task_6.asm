#
# all *,/,%
# almost all these operations can be done without multiplication, 
# division and remainder instructions, just by bit-shifts and bit addition (but that may be hard to implement).
# That is what I'm exactly going to implement (if possible).
# Output format: binary
#

	.data
please:
	.string "Please, input integer x: "
resulting:
	.string "\nResults:"
valm_2:
	.string "\nx * 2 : "
valm_3:
	.string "\nx * 3 : "
valm_4:
	.string "\nx * 4 : "
valm_5:
	.string "\nx * 5 : "
valm_8:
	.string "\nx * 8 : "
valm_31:
	.string "\nx * 31: "
vald_2:
	.string "\nx / 2 : "
vald_3:
	.string "\nx / 3 : "
vald_5:
	.string "\nx / 5 : "
vald_8:
	.string "\nx / 8 : "
vald_31:
	.string "\nx / 31: "
valr_2:
	.string "\nx % 2 : "
valr_3:
	.string "\nx % 3 : "
valr_5:
	.string "\nx % 5 : "
valr_8:
	.string "\nx % 8 : "
valr_31:
	.string "\nx % 31: "
	
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
	la a0, resulting
	ecall
	
	## multiplication ##
	
	li a7, 4
	la a0, valm_2
	ecall #decomposed: x * 2 = x * 010_2 = x * (2^1) = x << 1;
	slli a0, t0, 1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valm_3
	ecall #decomposed: x * 3 = x * 011_2 = x * (2^1 + 2^0) = x << 1 + x << 0;
	slli t1, t0, 1
	slli t2, t0, 0
	add a0, t1, t2
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valm_4
	ecall #decomposed: x * 4 = x * 100_2 = x * (2^2) = x << 2;
	slli a0, t0, 2
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valm_5
	ecall #decomposed: x * 5 = x * 101_2 = x * (2^2 + 2^0) = x << 2 + x << 0;
	slli t1, t0, 2
	slli t2, t0, 0
	add a0, t1, t2
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valm_8
	ecall #decomposed: x * 8 = x * 1000_2 = x * (2^3) = x << 3;
	slli a0, t0, 3
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valm_31
	ecall #decomposed: x * 31 = x * 11111_2 = x * (2^4 + 2^3 + 2^2 + 2^1 +2^0) = x << 4 + x << 3 + x << 2 + x << 1 + x << 0;
	slli t1, t0, 4
	slli t2, t0, 3
	slli t3, t0, 2
	slli t4, t0, 1
	add t5, t1, t2
	add t6, t3, t4
	add t1, t5, t6
	add a0, t1, t0
	li a7, 35
	ecall
	
	## division ##
	
	li a7, 4
	la a0, vald_2
	ecall #decomposed: x / 2 = x / 010_2 = x / (2^1) = x >> 1;
	srli a0, t0, 1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, vald_3
	ecall 
	#division by non-power-of-two int is hard to implemet and too long, but we may try: 1.5 * (x/3) = x/2, 
	#yet we didn't consider floats, so i'd just use normal division;
	li t1, 3
	div a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, vald_5
	ecall
	li t1, 5
	div a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, vald_8
	ecall #decomposed: x / 8 = x >> 3;
	srli a0, t0, 3
	li a7, 35
	ecall
	
	li a7, 4
	la a0, vald_31
	ecall
	li t1, 31
	div a0, t0, t1
	li a7, 35
	ecall
	
	## modulo ##
	
	li a7, 4
	la a0, valr_2
	ecall #for such denominator y, that y = 2^n, x % y = x & (y - 1);
	li t1, 1
	and a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valr_3
	ecall 
	li t1, 3
	rem a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valr_5
	ecall
	li t1, 5
	rem a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valr_8
	ecall
	li t1, 7
	and a0, t0, t1
	li a7, 35
	ecall
	
	li a7, 4
	la a0, valr_31
	ecall
	li t1, 31
	rem a0, t0, t1
	li a7, 35
	ecall
	
	
	
	
