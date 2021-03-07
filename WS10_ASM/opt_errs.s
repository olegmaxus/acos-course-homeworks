.include "/home/acos/Desktop/acos_materials/WS_HW7_ASM/macros.s"



#	INSTRUCTION_ADDR_MISALIGNED (ucause = 0)
#    j main	
# end:
#    li a7, 10
#    ecall
# main:
#    la t0, end
#    addi t0, t0, 2 #spoiled link
#    jr t0



#	INSTRUCTION_ACCESS_FAULT (ucause = 1)
#  .data
# data:
#  .word 99
#  .word 100
# .text
#  la t0, data
#  jr t0 # no special t0 to jump to, no further information provided



#	ILLEGAL_INSTRUCTION (ucause = 2)
#  .text
# main:
#  li    t0, 8
#  csrrs zero, cycle, t0 #zero register, can't read => retrial



#	LOAD_ADDRESS_MISALIGNED (ucause = 4)
#  .data
#  .space 2 #startcal
#  .align 0
#data:
#  .word 0xDEADBEEF
#  .text
#main:		# incorrect load word from dynamic memory
#  la t0, data
#  lw t1, 0(t0) #nonexcept with (2) immediate, as aligned bytes are 0, division onto 2 blocks
#  print_hex(t1)



#	LOAD_ACCESS_FAULT (ucause = 5)
# .text
# main:
#  la t0, main
#  lw t1, 0(t0) #not a data-storing segment, nothing to be loaded from the address (nospec mem) pres 4 corruption of linking


#	STORE_ADDRESS_MISALIGNED (ucause = 6)
#  .data
#  .space 2 # startval
#  .align 0
# data:
#  .word 0
#  .text
# main:
#  la t0, data
#  li t1, 0xDEADBEEF #incorrect writing into dynamic memory # ~ same issue, just with storeing word 
#  sw t1, 0(t0) #works with 2
#  sw t1, 4(t0) #works with 6



#	STORE_ACCESS_FAULT (ucause = 7) # cannot write into memory units, which are protected from writing into
#  .text
# main:
#  la t0, main
#  li t1, 0xDEADBEEF
#  sw t1, 0(t0)



#	ENVIRONMENT_CALL (ucause = 8) # wrong ECALL or EBREAK parameter
#  .text
# main:
#  li a7, 100
#  ecall
