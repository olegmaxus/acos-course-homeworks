	.file	"Task_1_ByMachine.c"
	.option nopic
	.text
	.align	1
	.globl	f
	.type	f, @function
f:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	slliw	a5,a5,1
	sext.w	a5,a5
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	f, .-f
	.align	1
	.globl	g
	.type	g, @function
g:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	mv	a5,a4
	slliw	a5,a5,1
	addw	a5,a5,a4
	sext.w	a4,a5
	lw	a5,-20(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	g, .-g
	.section	.rodata
	.align	3
.LC0:
	.string	"%d"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	addi	a5,s0,-40
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	__isoc99_scanf
	addi	a5,s0,-44
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	__isoc99_scanf
	lw	a5,-40(s0)
	lw	a4,-44(s0)
	mv	a1,a4
	mv	a0,a5
	call	f
	mv	a5,a0
	mv	a4,a5
	lw	a5,-40(s0)
	addw	a5,a4,a5
	sext.w	s1,a5
	lw	a5,-40(s0)
	lw	a4,-44(s0)
	mv	a1,a4
	mv	a0,a5
	call	g
	mv	a5,a0
	addw	a5,s1,a5
	sext.w	a4,a5
	lw	a5,-44(s0)
	subw	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	li	a0,10
	call	putchar
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 10.2.0"
	.section	.note.GNU-stack,"",@progbits
