.PHONY : macosx linux clean

all: 
	@echo Guessing `uname`
	@$(MAKE) `uname`

Darwin macosx:
	clang -Wall -g -O2 -shared -undefined dynamic_lookup -o lvmjit.so lvm_jit.c -Ilua/

Linux linux:
	cd lua/ && make MYCFLAGS="-fPIC" lua
	gcc -Wall -g -O2 -fPIC -shared -o lvmjit.so lvm_jit.c -Ilua/ -Llua/ -llua

lvmjit:
	cd dynasm && luajit dynasm.lua -o ../lvm_x64.h ../lvm_x64.dasc

test:
	../lua/lua-5.4.0/src/lua test.lua

clean:
	rm *.so
	cd lua/ && make clean
