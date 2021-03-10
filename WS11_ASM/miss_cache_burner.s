#
# Write a program that: 
# burns out default fully associative cache with 100% misses;
# does this in cycle (if previously not);
# fills only 256 bytes of memory without a gap.
#


## 16 blocks, cache size is 256 bytes, assuming that each block contains 4 words || 100 % of misses##

	.text
	.include "macros.s"

 	.eqv  MEM_BEGIN 0x10010000
	.eqv  MEM_SIZE 256

	.eqv  MEM_PTR s0
	.eqv  MEM_END s1
	.eqv  dump t0

main:
	li    MEM_PTR, MEM_BEGIN
	addi  MEM_END, MEM_PTR, MEM_SIZE

loop:
	lw    dump, 0(MEM_PTR)
	addi  MEM_PTR, MEM_PTR, 16
	blt   MEM_PTR, MEM_END, loop

_exit:
	null.exit()