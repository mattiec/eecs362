SRC = unsignedsum.asm
NAME = unsignedsum
GEN =  instr_$(NAME).hex data_$(NAME).hex
DLXASM = /vol/eecs362/scripts/dlxasm
VERILOG = /vol/eecs362/iverilog/bin/iverilog

ALU_FILES = $(wildcard ALU/*.v)
TARGETS_AUTO= $(patsubst %.v,%.o,$(TESTFILES))


.PHONY: default clean

all: toplevel

control: control.v tests/control_test.v;
	${VERILOG} control.v tests/control_test.v -o control

toplevel: toplevel.v control regFile.v instrFetch_single.v; 
	${VERILOG} toplevel.v control.v 16bitTo32bitExtender.v memory.v instrFetch_single.v tests/single_cycle_tb.v -o processor

clean: ;
	rm -f *o processor
	rm -f *o control

files: instr_$(NAME).hex data_$(NAME).hex ;

$(GEN): $(SRC) $(DLXASM) ;
	$(DLXASM) -C instr_$(NAME).hex -D data_$(NAME).hex $(SRC)

