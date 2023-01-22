# COLORS
BLACK   := $(shell tput -Txterm setaf 0)
RED     := $(shell tput -Txterm setaf 1)
GREEN   := $(shell tput -Txterm setaf 2)
YELLOW  := $(shell tput -Txterm setaf 3)
BLUE    := $(shell tput -Txterm setaf 4)
MAGENTA := $(shell tput -Txterm setaf 5)
CYAN    := $(shell tput -Txterm setaf 6)
WHITE   := $(shell tput -Txterm setaf 7)
RESET   := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20

BIN_FOLDER := asm_microproc/bin
SYNTAX_FOLDER := $(BIN_FOLDER)/syntax
TESTS_FOLDER := tests
TEST_FILE := double_dabble.x
TEST_OUTPUT := double_dabble.i
TARGET := main.exe
EXEC := asm
PYTHON_SCRIPT := format_output.py

.PHONY: all clean compiler

all: help

## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo ''

## Build the compiler after cleaning the old one
compiler: clean
	@printf "%%%% Building %%%%\n"
	cd asm_microproc ; dune build
	ln -s $(BIN_FOLDER)/$(TARGET) $(EXEC)

## Clean the compiler
clean: 
	@printf "%%%% Cleaning %%%%\n"
	cd asm_microproc ; dune clean
	rm -f $(EXEC)

## Check the result of the compiler on a certain file
tests: compiler
	@printf "%%%% Testing %%%%\n"
	./asm $(TESTS_FOLDER)/$(TEST_FILE)
	@printf "\nThe assembly code: \n"
	@cat $(TESTS_FOLDER)/$(TEST_FILE)
	@printf "\n------------\n"
	@printf "\nThe produced addreses: \n"
	@python3 $(PYTHON_SCRIPT)
