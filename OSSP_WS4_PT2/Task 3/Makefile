BUILDNAME_SRC=proc.c
BUILDNAME_LIB=lib.c

.PHONY: all
all: lib.o libfoo.so program

program: libfoo.so
	gcc -Wall  -o $@ $(BUILDNAME_SRC) -lfoo -lm -L.
	export LD_LIBRARY_PATH=.
lib.o: $(BUILDNAME_LIB)
	gcc -c -Wall -fPIC -lm $<
libfoo.so: lib.o
	gcc -Wall -shared -o  $@ $<

clear:
	rm -f *.o *.so *~ program
