BUILDNAME_SRC=proc.c
BUILDNAME_LIB=lib.h

.PHONY: all
all: lib.o libfoo.so program

program: (1)
        gcc -Wall -o $@ $(BUILDNAME_SRC) -lfoo -L.
        export (2)=.
lib.o: $(BUILDNAME_LIB)
        gcc -c -Wall (3) (4)
libfoo.so: lib.o
        gcc -Wall (5) -o $@ $<

clear:
        rm -f *.o *.so *~ program
