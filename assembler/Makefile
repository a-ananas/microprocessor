BIN_FOLDER := asm_microproc/bin
SYNTAX_FOLDER := $(BIN_FOLDER)/syntax
TESTS_FOLDER := tests
TEST_FILE := test.x
TEST_OUTPUT := test.i
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
	./asm $(TESTS_FOLDER)/$(TEST_FILE)
	@printf "\nThe assembly code: \n"
	@printf "\nThe assembly code: \n"
	@cat $(TESTS_FOLDER)/$(TEST_FILE)
	@printf "\n------------\n"
	@printf "\nThe produced addreses: \n"
	@cat $(TESTS_FOLDER)/$(TEST_OUTPUT)
