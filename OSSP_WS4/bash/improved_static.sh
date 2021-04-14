#!/bin/sh
gcc -Wall -DLINKTIME -c fred.c john.c
ar crv libfoo.a fred.o john.o
gcc -c program_for_static.c
gcc -o program_static_improved program_for_static.o fred.o john.o -lm
gcc -o program_static_improved program_for_static.o -L. -lfoo
./program_static_improved
