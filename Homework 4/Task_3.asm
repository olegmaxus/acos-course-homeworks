	.text
task_3:
	#_________________________________________________________________________
	# Get familiar with RISC-V pseudoinstructions (mv, li, la, b, j, etc). 
	# What instructions are used to replace them when a program is assembled?:
	# mv t0, t1
	# li t0, 0x12345678
	# li t0, 16
	# b  label
	# j  label
	# la t0, label
	#_________________________________________________________________________
	
	
	# 1. [mv t1, t2] <move instruction>: sets t1 to contents of t2
	# mv t0, t1
	# according to "riscv-spec-v2.2.pdf" the 'mv' instruction can be performed through the base instructions of 'addi' (but we may eplicitly use 'add' as well).
	# basically mv just assigns t0 with data stored by t0, then we may use these two instructions, which have been described above,
	# in order to replace mv:
	# mv t0, t1 <=> addi t0, t1, 0 <=> add t0, zero, t1, that makes mv to be described by R-type basic instructions.
	
	# 2. [li t1, unsgn_immed] <load immediate instruction>: set t1 to 32-bit immediate (unsigned)
	# li t0, 0x12345678
	# according to "riscv-spec-v2.2.pdf" the 'li' instruction can be assempled using the sequences of base instruction of 'addi', 
	# in our case, as we know 'li' just assignes our destination register with some 32-bit immediate, we have to split our 32-bit number into smaller ones,
	# (<=12 bits [signed]), that is, as the hugest positive signed 12-bit is 2047, we have to make at least ceil[0x12345678 / 2047] additions
	# of 12-bit immediates to our initial variable, which we want to assign the immediate to, that is we'd have the following sequence:
	#
	# addi t0, zero, 2047   \                                                              |
	# addi t0, zero, 2047   |                                                              |
	# ...                   |> 149203 times (as (0x12345678 / (2047)_10 )_10 = 149203.66   |
	# ...                   |                                                              | <=> li t0, 0x12345678
	# addi t0, zero, 2047   /                                                              |
	# addi t0, zero, 1355 \\ since (0x12345678 = 305419896_10) - 2047*149203 = 1355        |
	# 
	# 
	# 149204 addition operations in total [thus our assumption of at least ceil(immediate / 2047) operations to perform 'li' pseudoinstruction holds)
	
	# 3. [li t1, sgn_immed] <load immediate instruction>: set t1 to 12-bit immediate (sign-extended)
	# li t0, 16
	# as far as we have this type of li to have 12-bit immediate (sign extended), there is no need to create the sequence of addi operations, as 
	# [addi rd, rs, immed] itself has 12-bit immediate (sign-extended),
	# that means that in order to replace li:
	# li t0, 16 <=> addi t0, zero, 16. That makes li to be described by I-format base instruction of addi.
	
	# 4. [b label] <branch instruction>: branch to statement at label unconditionally
	# b label
	# basically, as far as we have to branch to statement at label's adress unconditionally, we may just use <branch if equal instruction>
	# for two variables, that are always known to be equal under any condition, that is:
	# b label <=> beq zero, zero, label (makes it branch unconditionally at 'label'). That makes b to be described by SB-type base instruction.
	
	# 5. [j label] <jump instruction>: jump to statement at label
	# j label
	# that is basically we can use jal instruction with zero as rd, so that zero is assigned to return address, and we instantly jump to statement at label
	# that means in order to replace j instruction:
	# j label <=> jal zero, label. That is j may be replaced with jal base instruction of UJ-type.
	
	# 6. [la t0, label] <load address instruction>: set t0 to label's address
	# la t0, label
	# According to "riscv-spec-v2.2.pdf", the load address instruction may be replaced with the sequence of auipc instruction with immedialte of label[31:12]
	# then addi instruction with immediate of label[11:0], such that both rd, rs1 are t0:
	# hence, in order to replace la instruction:
	# la t0, label <=> |  auipc t0, label[31:12]   |
	#              <=> |  addi t0, t0, label[11:0] | assuming some given label, address of which is known, and we take the bits of its address.