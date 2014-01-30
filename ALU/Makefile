
VERILOG = /vol/eecs362/iverilog/bin/iverilog

all: adder  shift

adder: adder.v  mux2to1.v fa.v tests/adder_test.v;
	${VERILOG} adder.v mux2to1.v fa.v tests/adder_test.v -o adder

mult: mult.v fa.v tests/mult_test.v;
	${VERILOG} mult.v fa.v tests/mult_test.v -o mult

shift: shift.v tests/shift_test.v;
	${VERILOG} shift.v tests/shift_test.v -o shift

PHONY: clean
clean:
	rm -rf *o adder
	rm -rf *o mult
	rm -rf *0 shift
