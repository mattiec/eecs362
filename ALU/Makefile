
VERILOG = /vol/eecs362/iverilog/bin/iverilog

all: adder

adder: adder.v  mux2to1.v tests/adder_test.v;
	${VERILOG} adder.v mux2to1.v tests/adder_test.v -o adder

PHONY: clean
clean:
	rm -rf *o adder

