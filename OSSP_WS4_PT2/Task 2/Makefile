BUILDNAME=hello.c
EXEC=hello
BUILDTRASH=*.o *.s *.i *~ $(EXEC)
.PHONY: all
all: hello
	
hello: hello.o
	gcc $< -o $@
hello.o: hello.s
	gcc $< -c
hello.s: hello.i
	gcc $< -S
hello.i: $(BUILDNAME)
	gcc $< -E -o $@
	
clear:
	rm -f $(BUILDTRASH)
