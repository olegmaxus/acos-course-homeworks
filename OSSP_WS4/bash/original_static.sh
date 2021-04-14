#!/bin/sh
gcc -c fred.c john.c
ar crv libfoo.a fred.o john.o
gcc -c program_for_static.c
gcc -o program_static program_for_static.o fred.o john.o -lm
gcc -o program_static program_for_static.o -L. -lfoo -lm
./program_static
