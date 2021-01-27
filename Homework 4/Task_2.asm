	.text
	# nothing to be ran
task_2:
	#   Decode the following hexademical values to instructions:
	#   
	#      assuming some #predefined t0, t1, t2, s0, etc.
	#
	#   1. 0x98765437:
	#      0x98765437 = 1001 1000 0111 0110 0101 0100 0011 0111 (base 2)
	#      Opcode is always 7-bits-long : last seven bits always stand for the 'opcode' => 'opcode' is: 0110111_2
	#      Since 'opcode' is 0110111_2 the only instruction, corresponding to such an 'opcode' is LUI, then the
	#      Instruction is of U-type, then next five bits to the left of 'opcode' correspond to 'rd', i.e. 'rd' is 01000_2
	#      That is 'rd' is 's0'. Next 20 to the left of 'rd' bits correspond to 'immediate', which then is 0x98765. 
	#
	#      Hence, the whole instruction would look like that:
	       lui s0, 0x98765
		   
	#   for next decodings explanations won't be as precise and explicit as for the 1st one,
	#   since i have already explained, how to proceed, and will only folow thr very same steps.
		   
	#   2. 0x00744433:
	#      0x00744433 = 0000 0000 0111 0100 0100 0100 0011 0011 (base 2)
	#      Opcode is 0110011_2, then the instruction is of R-type, let's now look at 'funct7' parameter, i.e. for the first 7
	#      Bits of the given vector: 'funct7' = 0000000_2, and now for 'funct3' = 100_2, thus the instruction is: XOR.
	#      'rs2' = 00111_2, i.e. rs2 = x7 = t2, 'rs1' = 01000_2, i.e. rs1 = x8 = s0, 'rd' = 01000_2 = s0.
	#      
	#      Hence, the whole instruction would look like that:
	       xor s0, s0, t2    
	       
	#   3. 0x0080006f:
	#      0x0080006f = 0000 0000 1000 0000 0000 0000 0110 1111 (base 2)
	#      Opcode is 1101111_2, the only instruction corresponding to such 'opcode' is JAL, thus instruction is of UJ-type
	#      'rd' is 00000_2, that is rd = x0 = zero, 'immediate' is 0000 0000 0000 0000 0100 + '...0_2', i.e. immediate is 0x00005 = 0x5
	#
	#      Hence, the whole instruction would look like that:
	       jal zero, 0x5
	       
	#   4. 0xfff37293:
	#      0xfff37293 = 1111 1111 1111 0011 0111 0010 1001 0011 (base 2)
	#      Opcode is 0010011_2, then instruction is eithrt of R or of I-type:
	#      Let's check funct3: 'funct3' = 111_2, hence instruction is of I-type, namely: ANDI, and thus:
	#      Immediate is 111111111111_2 = 0xfff, 'rs1' = 00110_2 = t1, 'rd' = 00101_2 = t0.
	#
	#      Hence, the whole instruction would look like that:
	       andi t0, t1, 0xfff
	       
	#   5. 0x00000463:
	#      0x00000463 = 0000 0000 0000 0000 0000 0100 0110 0011 (base 2)
	#      Opcode is 1100011_2, then instruction is of SB-type
	#      Let's then check funct3 : 'funct3' = 000, hence instruction is BEQ:
	#      'rs1' is 00000_2, 'rs_2' is 00000_2 as well, hence:
	#      Immediate is 0000 0000 0100 + '...0', i.e. 0x8
	#
	#      Hence, the whole instruction would look like that:
	       beq zero, zero, 0x8
	       
	#   6. 0x00032823:
	#      0x00032823 = 0000 0000 0000 0011 0010 1000 0010 0011 (base 2)
	#      Opcode is 0100011_2, hence, instruction, that fits is the S-type instruction
	#      'funct3' is 010_2, thus instruction is SW, 'rs1' = 00110_2 = t1, 'rs2' = 00000_2 = zero
	#      Immediate is 0000 0001 0000 = 0x10
	#
	#      Hence, the whole instruction would look like that:
	       sw t1, 0x10(zero)
	       
	       
	       
