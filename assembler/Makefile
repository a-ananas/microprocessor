BIN_FOLDER := asm_microproc/bin
SYNTAX_FOLDER := $(BIN_FOLDER)/syntax
TARGET := main.exe
EXEC := asm

.PHONY = clean

compiler: clean
	@printf "\n%%%% Building %%%%\n"
	cd asm_microproc ; dune build
	ln -s $(BIN_FOLDER)/$(TARGET) $(EXEC)

clean: 
	@printf "\n%%%% Cleaning %%%%\n"
	cd asm_microproc ; dune clean
	rm -f $(EXEC)
