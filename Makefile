SRC = quicksort.asm
GEN = $(SRC).exe instr.hex data.hex
DLXASM = /vol/eecs362/scripts/dlxasm
VERILOG = /vol/eecs362/iverilog/bin/iverilog

.PHONY: default clean

all: toplevel

toplevel: toplevel.v control.v; 
	${VERILOG} toplevel.v control.v tests/single_cycle_tb.v -o processor

files: instr.hex data.hex ;

clean: ;
	rm -f $(GEN)
	rm -f *o processor

$(GEN): $(SRC) $(DLXASM) ;
	$(DLXASM) -C instr.hex -D data.hex $(SRC)


