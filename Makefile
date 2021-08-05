all: lib build decode_1 decode_2

build:
	gcc -L. -Wl,-rpath=. -lcyphernew -lcypher -m32 decode.o -o decode
lib:
	gcc -m32 -fno-pic -c cypher.c -o cypher.o
	gcc --share -L. -Wl,-rpath=. -m32 cypher.o -o libcyphernew.so -lcypher
decode_1:
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt1.dat out1
decode_2:
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt2.dat out2
clean:
	rm -f decode cypher.o libcyphernew.so out1 out2
tarball:
	tar -czf imf2021-eu.tar.gz Makefile decode.o cypher.c README libcypher.so crypt1.dat crypt2.dat
