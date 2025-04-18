CC=gcc
CFLAGS=$(shell pkg-config --cflags libpmem2)
LIBS=$(shell pkg-config --libs libpmem2)

main: main.c
	$(CC) -g $(CFLAGS) $^ $(LIBS) -o $@

clean:
	rm -rf *.o main