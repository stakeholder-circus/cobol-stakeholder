COBC ?= cobc
BIN := bin/stakeholder
SRC := src/stakeholder.cob

.PHONY: all compiler-proof analyze build test
all: build

compiler-proof:
	$(COBC) --version | sed -n '1,5p'

analyze:
	$(COBC) -fsyntax-only -free -Wall -Wextra $(SRC)

build:
	mkdir -p bin
	$(COBC) -x -free -Wall -Wextra -o $(BIN) $(SRC)

test: build
	BIN=$(BIN) tests/test_cli.sh
