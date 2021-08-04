all:
	gcc -L. -Wl,-rpath=. -lcypher -lcypherold -m32 decode.o -o decode
lib:
	gcc -m32 -fno-pic -c cypher.c -o cypher.o
	gcc --share -L. -Wl,-rpath=. -m32 cypher.o -o libcypher.so -lcypherold
decode_1:
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt1.dat out1
decode_2:
	LD_LIBRARY_PATH=. ./decode -d -k ABC crypt2.dat out2
clean:
	rm decode cypher.o
