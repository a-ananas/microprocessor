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

.PHONY: all clean help

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

## Build the entire project
project:
	@printf "\n\n\n########## BUILDING ASSEMBLER ##########\n\n\n"
	@$(MAKE) compiler -C assembler
	@printf "\n\n\n########## BUILDING SIMULATOR ##########\n\n\n"
	@$(MAKE) simulator -C netlist_simulator
	@printf "\n\n\n########## BUILDING NETLIST ##########\n\n\n"
	@$(MAKE) tofile -C proc_netlist
	@printf "\n\n\n########## DONE BUILDING EVERYTHING ##########\n\n\n"

## Clean the entire project
clean:
	@printf "\n\n\n########## CLEANING ASSEMBLER ##########\n\n\n"
	@$(MAKE) clean -C assembler
	@printf "\n\n\n########## CLEANING SIMULATOR ##########\n\n\n"
	@$(MAKE) clean -C netlist_simulator
	@printf "\n\n\n########## CLEANING NETLIST ##########\n\n\n"
	@$(MAKE) clean -C proc_netlist
	@printf "\n\n\n########## DONE CLEANING EVERYTHING ##########\n\n\n"