CROSS_COMPILE ?=
cc = $(CROSS_COMPILE)gcc
default: all

all: writer

writer: writer.o
	$(cc) writer.o -o writer

writer.o: writer.c
	$(cc) -c writer.c

clean:
	rm -rf writer *.o
