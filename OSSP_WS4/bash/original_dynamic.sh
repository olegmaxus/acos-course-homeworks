#!/bin/sh
gcc -c -Wall -fPIC bill.c sam.c -lm
gcc -Wall -shared -o libfoo.so bill.o sam.o
gcc -Wall -o program_dynamic program_for_dynamic.c -lfoo -lm -L.
export LD_LIBRARY_PATH=.
./program_dynamic
