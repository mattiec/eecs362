SRC = unsignedsum.asm
iNAME = unsigned
GEN =  instr_$(NAME).hex data_$(NAME).hex
DLXASM = /vol/eecs362/scripts/dlxasm
VERILOG = /vol/eecs362/iverilog/bin/iverilog

ALU_FILES = $(wildcard ALU/*.v)
TARGETS_AUTO= $(patsubst %.v,%.o,$(TESTFILES))


.PHONY: default clean

all: toplevel

hazard: hazardDetect.v tests/hazardDetect_test.v;
	${VERILOG} hazardDetect.v tests/hazardDetect_test.v -o hazard

control: control.v tests/control_test.v;
	${VERILOG} control.v tests/control_test.v -o control

toplevel: toplevel_pp.v control.v regFile2.v instrFetch_pp.v; 
	${VERILOG} toplevel_pp.v control.v  hazardDetect.v decoder.v 16bitTo32bitExtender.v memory.v pipereg.v tests/pp_tb.v -o pipeline

clean: ;
	rm -f *o pipeline
	rm -f *o control
	rm -f *o hazard

files: instr_$(NAME).hex data_$(NAME).hex ;

$(GEN): $(SRC) $(DLXASM) ;
	$(DLXASM) -C instr_$(NAME).hex -D data_$(NAME).hex $(SRC)

