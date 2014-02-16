SRC = quicksort.asm
GEN = $(SRC).exe instr.hex data.hex
DLXASM = /vol/eecs362/scripts/dlxasm
VERILOG = /vol/eecs362/iverilog/bin/iverilog

.PHONY: default clean

all: toplevel

control: control.v tests/control_test.v;
	${VERILOG} control.v tests/control_test.v -o control

toplevel: toplevel.v control; 
	${VERILOG} toplevel.v control.v tests/single_cycle_tb.v -o processor

files: instr.hex data.hex ;

clean: ;
	rm -f $(GEN)
	rm -f *o processor
	rm -f *0 control

$(GEN): $(SRC) $(DLXASM) ;
	$(DLXASM) -C instr.hex -D data.hex $(SRC)


