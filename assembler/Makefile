BIN_FOLDER := asm_microproc/bin
SYNTAX_FOLDER := $(BIN_FOLDER)/syntax
TARGET := main.exe
EXEC := asm

.PHONY = clean compiler

compiler: clean
	@printf "%%%% Building %%%%\n"
	cd asm_microproc ; dune build
	ln -s $(BIN_FOLDER)/$(TARGET) $(EXEC)

clean: 
	@printf "%%%% Cleaning %%%%\n"
	cd asm_microproc ; dune clean
	rm -f $(EXEC)

tests: compiler
	@printf "%%%% Testing %%%%\n"
	./asm tests/test.x
	@printf "\nThe assembly code: \n"
	@cat tests/test.x
	@printf "\n------------\n"
	@printf "\nThe produced addreses: \n"
	@cat tests/test.i
