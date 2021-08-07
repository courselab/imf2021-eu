all: lib build decode_1 decode_2

build: decode.o libcyphernew.so libcypher.so
	gcc -m32 decode.o -L. -Wl,-rpath=. -no-pie -lcyphernew -lcypher -o decode

lib: cypher_bypass.c
	gcc -m32 -fno-pic -c cypher_bypass.c -o cypher_bypass.o
	gcc --share -m32 cypher_bypass.o abi_fix.o -L. -Wl,-rpath=. -lcypher -o libcyphernew.so

abi_fix.o: abi_fix.S
	as --32 $^ -o $@

decode_1: decode crypt1.dat libcyphernew.so libcypher.so
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt1.dat out1

decode_2: decode crypt2.dat libcyphernew.so libcypher.so
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt2.dat out2

.PHONY: clean tarball
clean:
	rm -f decode cypher_bypass.o libcyphernew.so out1 out2

tarball: Makefile decode.o cypher_bypass.c README libcypher.so crypt1.dat crypt2.dat
	tar -czf imf2021-eu.tar.gz Makefile decode.o cypher_bypass.c README libcypher.so crypt1.dat crypt2.dat
