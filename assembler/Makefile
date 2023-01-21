BIN_FOLDER := asm_microproc/bin
SYNTAX_FOLDER := $(BIN_FOLDER)/syntax
TESTS_FOLDER := tests
TEST_FILE := double_dabble.x
TEST_OUTPUT := double_dabble.i
TARGET := main.exe
EXEC := asm
PYTHON_SCRIPT := format_output.py

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
	@cat $(TESTS_FOLDER)/$(TEST_FILE)
	@printf "\n------------\n"
	@printf "\nThe produced addreses: \n"
	@python3 $(PYTHON_SCRIPT)
