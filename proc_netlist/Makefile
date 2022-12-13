PY := python3
CAROTTE_DIR := ./carotte
CAROTTE := $(CAROTTE_DIR)/carotte.py
CACHES := __pycache__ $(CAROTTE_DIR)/__pycache__

#temporary to fix some problems
SIMU_DIR := ../netlist_simulator
SIMU_NET := $(SIMU_DIR)/test
NET_DIR := net

#for the moment it's just a test
TARGET ?= main.py
BASE_NAME := $(basename $(TARGET))
OUTPUT ?= $(BASE_NAME).net

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

## run the netlist simulator on the netlist produced in main.py
netlist: tofile
	@echo $(BASE_NAME)
	@bash test.sh test/net $(BASE_NAME)

## Write the netlist to a file (OUTPUT=<filename> to specify the file)
tofile: | netdir
	$(PY) $(CAROTTE) -o $(NET_DIR)/$(OUTPUT) $(TARGET)
	cp -r $(NET_DIR) $(SIMU_NET)/.

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
