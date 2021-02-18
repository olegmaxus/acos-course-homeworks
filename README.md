# ACOS Workshops' solutions
Solutions of the ACOS Workshops' problems by O.Malchenko
## Notes on the 3d WS
//The first and second tasks are skipped as trivial, since they only required to become used to basics of RISC-V assembler

//Tasks have been done in order, presented on the DSBA ACOS course site

//Each task (from 3rd to 11th) are presented in this repository in .asm extension


//In case of any questions, remarks, additions, please contact me via telegram: @olegmaxus
## Notes on the 4th WS
//
## Notes on the 5th WS
//In the second task the array has been implemented using stack (.space directive), elements are stored in memory in reverse order

//In the third task exception for zero division was added

//In the last task case 0^0 gives 1 (python-like explicit definition)

## Notes on the 6th WS
//The first two tasks required me to translate C code into risc-v assembly code

//I have done it two ways: by hand (my own translation), and using risc-v toolchain through linux command line (shell):
```console
acos@acos-vm:~/Desktop/acos_materaials$ riscv64-unknown-linux-gnu-gcc sample_name.c -S
```

## Notes on the 7th WS
//The 'no_dups.s' task was quite hard to implement

//There may be a prettier implementation of fprint2.s, using bit shifts, that is less bit_print loops are used

## Links
[Workshop 3](https://andrewt0301.github.io/hse-acos-course/part1ca/03_CPU/lecture.html)

[Workshop 4](https://andrewt0301.github.io/hse-acos-course/part1ca/04_Instructions/lecture.html)

[Workshop 5](https://andrewt0301.github.io/hse-acos-course/part1ca/05_MacrosBranchesArrays/lecture.html)

[Workshop 6](https://andrewt0301.github.io/hse-acos-course/part1ca/06_CallStack/lecture.html)

[Workshop 7](https://andrewt0301.github.io/hse-acos-course/part1ca/07_FP/lecture.html)

[Workshop 8](https://andrewt0301.github.io/hse-acos-course/part1ca/08_MMIO/lecture.html)

[Workshop 9](https://andrewt0301.github.io/hse-acos-course/part1ca/09_Pipeline/lecture.html)
