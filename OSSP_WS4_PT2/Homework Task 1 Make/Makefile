DYNAMIC=program_for_dynamic.c
STATIC=program_for_static.c
LIB=lib.h
BILL=bill.c
FRED=fred.c
JOHN=john.c
SAM=sam.c

.PHONY: all
all: libfoo.so dynamic_run libfoo.a static_run

dynamic_run: libfoo.so
	gcc -Wall -o $@ $(DYNAMIC) -lfoo -lm -L.
	export LD_LIBRARY_PATH=.
libfoo.so: sam.o bill.o
	gcc -Wall -shared -o $@ $^
dyn.o: $(SAM) $(BILL)
	gcc -Wall -DLOADTIME -c -fPIC $^ -lm
static_run: fred.o john.o program_for_static.o libfoo.a
	gcc -o $@ $^ -lm -L. -lfoo
libfoo.a: fred.o john.o
	ar crv $@ $^
program_for_static.o: $(STATIC)
	gcc -c $<
static.o: $(FRED) $(JOHN)
	gcc -Wall -DLINKTIME -c $^

clear:
	rm -f *.o *.so *.save *.a dynamic_run static_run *~ *.out
	
