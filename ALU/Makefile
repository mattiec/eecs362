

all: adder

adder: adder.v tests/adder_test.v
	iverilog adder.v tests/adder_test.v -o adder

.PHONY: clean
clean:
	rm -rf *o adder

