#
# Write a program that utilizes memory sparsely, so that its footprint is 100% misses 2-way associative cache.
# However, it fits (almost) into a 4-way associative cache with 16 blocks.
#


## for 2-way set associative cache with 8 blocks MR = 100% ##
## for 4-way set associative cache with 16 blocks MR = 25% ## (Misses occur in the beginning, since the memory is empty) close to linear


	.text
	.include "macros.s"

	.eqv  MEM_START 0x10010000
	.eqv  MEM_SIZE  256
	.eqv  GAP       5   # shifting n.e. pow 2

	.eqv MEM_PTR s0
	.eqv MEM_END s1
	.eqv GAPVAR  s2
	.eqv BYTEGAP s3
	.eqv counter t0
	.eqv dump    t2

	.text

main:
	li    MEM_PTR, MEM_START         # start address
	addi  MEM_END, MEM_PTR, MEM_SIZE # end address
	li    GAPVAR, GAP                # gap in words
	slli  BYTEGAP, GAPVAR, 2         # gap in bytes

	mv    counter, zero

loop_gap:
	slli  t1, counter, 2
	add   t1, MEM_PTR, t1

loop:
	lw    dump, 0(t1)
 
	add   t1, t1, BYTEGAP
	blt   t1, MEM_END, loop

	addi  counter, counter, 1
	blt   counter, GAPVAR, loop_gap

_exit:
	null.exit()

