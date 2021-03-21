#
# Write a program that creates a copy of the specified file. Input arguments:
# -The name of the source and target files are read from the standard input (use system call 8).
# -The buffer to store data being copied is allocated in the heap (use system call 9). The buffer size is specified in standard input.
# -Buffers for storing source and target names are also allocated in the heap (their size is 256 bytes).
#

#	.data
#src_:
	#.asciz "/home/acos/Desktop/text_dir.txt"
#trg_:
	#.asciz "/home/acos/Desktop/just.txt"
#zero_term:
	#.asciz ""


	.text
	.include "macros.s"

	.eqv src          s0
	.eqv trg          s1
	.eqv buffer       s2

	.eqv src.d        s3
	.eqv trg.d        s4
	.eqv buffer.alloc s5

	.eqv size_read    t0
	.eqv trg.dir.end  t1

	.eqv src_sz       t2
	.eqv trg_sz       t3



	j main

UNABLE_TO_OPEN_FILE:
	print_str("\nAn error has occured! Failed to open source file.\nThe program will be terminated immediately.")
	null.exit()

main:
	print_str("\n\n*****************************************************************\n")
	print_str("* In order to count the length of path, please, use: lencnt.cpp *\n")
	print_str("*****************************************************************")

	print_str("\n\nPlease, input the length of your path for source file (in chars): ")
	int_input(src_sz)

	print_str("CAUTION: don't press \"Enter\", when the path is inserted! (Auto)")
	print_str("\nPlease, input the path to the source file to be copied:         ")
	ssbrk(256)
	mv src, a0

	read_dir(src, src_sz)

	print_str("\nPlease, input the length of your path for target file (in chars): ")
	int_input(trg_sz)

	print_str("CAUTION: don't press \"Enter\", when the path is inserted! (Auto)")
	print_str("\nPlease, input the path to the target file, to copy source to:   ")
	ssbrk(256)
	mv trg, a0

	read_dir(trg, trg_sz)
	

	# Since, if i use the input size for string of 256 by default, \n term : 0x0a is read as part of address, what makes it spoiled.
	#la trg, trg_ # these are the hardcoded paths, I used them, before I came to the idea of asking for length of input to kill \n.
	#la src, src_ 

	print_str("\nPlease, specify the size of buffer for storing data from source file:\n")
	int_input(buffer)
	
	sbrk(buffer)
	mv   buffer.alloc, a0
	


# opening a file to be copied:

open.src.dir:
	open_file.read(src)
	bltz  a0, UNABLE_TO_OPEN_FILE
	mv    src.d, a0 # source file descriptor

open.trg.dir:
	open_file.write(trg)
	mv    trg.d, a0 # target file descriptor

read.src.write.trg.loop:
	read_access(src.d, buffer.alloc, buffer)
	mv    size_read, a0
	
	write_access(trg.d, buffer.alloc, size_read)
	beq   size_read, buffer, read.src.write.trg.loop

terminate:
	print_str("\nDone, file is copied!")
	
close.dir:
	file_close(trg.d) # no need to insert \0, as it is copied with the last line as well.
	file_close(src.d)

_exit:
	null.exit()
	
	
	
