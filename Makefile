COBC ?= cobc
BIN := bin/stakeholder
SRC := src/stakeholder.cob

.PHONY: all compiler-proof build test clean

all: build

compiler-proof:
	$(COBC) --version | sed -n '1,5p'

build:
	mkdir -p bin
	$(COBC) -x -free -o $(BIN) $(SRC)

test: build
	BIN=$(BIN) tests/test_cli.sh

clean:
	rm -rf bin
