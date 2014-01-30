
VERILOG = /vol/eecs362/iverilog/bin/iverilog

all: adder mult

adder: adder.v  mux2to1.v fa.v tests/adder_test.v;
	${VERILOG} adder.v mux2to1.v fa.v tests/adder_test.v -o adder

mult: mult.v fa.v tests/mult_test.v;
	${VERILOG} mult.v fa.v tests/mult_test.v -o mult

PHONY: clean
clean:
	rm -rf *o adder
	rm -rf *o mult
