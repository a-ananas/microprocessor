PY := python
CAROTTE_DIR := ./carotte
CAROTTE := $(CAROTTE_DIR)/carotte.py
CACHES := __pycache__ $(CAROTTE_DIR)/__pycache__

NET_DIR := net

#for the moment it's just a test
TARGET := test_fulladder.py

OUTPUT ?= $(TARGET).net

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

.PHONY: all clean print tofile help

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

## Print the netlist to the standard output
print: 
	$(PY) $(CAROTTE) $(TARGET)

## Write the netlist to a file (OUTPUT=<filename> to specify the file)
tofile: | netdir
	$(PY) $(CAROTTE) -o $(NET_DIR)/$(OUTPUT) $(TARGET)

netdir:
	@mkdir -p $(NET_DIR)

## Remove net files and python caches
clean:
ifneq ("$(wildcard $(NET_DIR))","")
	@rm -r $(NET_DIR)
endif
ifneq ("$(wildcard $(CACHES))","")
	@rm -r $(CACHES)
endif