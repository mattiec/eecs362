
VERILOG = /vol/eecs362/iverilog/bin/iverilog

all: alu

adder: adder.v  mux.v fa.v tests/adder_test.v;
	${VERILOG} adder.v mux.v fa.v tests/adder_test.v -o adder

mult: mult.v fa.v tests/mult_test.v;
	${VERILOG} mult.v fa.v tests/mult_test.v -o mult

shift: shift.v tests/shift_test.v;
	${VERILOG} shift.v tests/shift_test.v -o shift
	
basic: basic.v tests/basic_test.v;
	${VERILOG} basic.v tests/basic_test.v -o basic

alu: alu.v tests/alu_test.v adder mult shift basic;
	${VERILOG} alu.v adder.v mux.v mult.v fa.v shift.v basic.v tests/alu_test.v -o alu

.PHONY: clean
clean:
	rm -rf *o adder
	rm -rf *o mult
	rm -rf *o shift
	rm -rf *o basic
	rm -rf *o alu
