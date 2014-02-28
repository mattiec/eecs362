`include "../ALU/mux.v"
`include "../ALU/alu.v"
`include "../ALU/adder.v"
`include "../ALU/basic.v"
`include "../ALU/set.v"
`include "../ALU/shift.v"
`include "../ALU/mult.v"
`include "../ALU/fa.v"
`include "./regFile2.v"

module toplevel(clk, rst);

	input clk, rst;
	
	wire [0:31] busA, busB, busWr; 				//register file signals
	wire [0:4] RS, RT, WrAddr, RD, regWrAddr;			//regster file signals
	wire RegDst, RegWr, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, Zero;
	wire [0:3] ALUCtr;
	wire ALUSrc, ExtOp, MemWr, Mem2Reg, RegFp_write, RegFp_read; //Control Signals
	wire [0:31] bIN, ALUOut; //ALU signal

	wire [0:23] jump_instruction;
	wire [0:15] branch_instruction;
	
	input [0:31] instruction; //make back to wire
	wire [0:15] immed;
	wire [0:31] ExtOut;

	wire [0:31] PCoutput;	
	wire [0:31] MemOut, RegOut;

	wire [0:4] reg31;

	wire tmp;

	assign reg31 = 5'b11111;
	assign tmp = 0;
	
		instrFetch instructionfetch(Branch, Branch_NotEqual, busA[0:29], Jump, Jump_Reg, Jump_Link, Zero, branch_instruction, jump_instruction, clk, ~rst,instruction, PCoutput);

		control controlUnit (instruction, RegDst, RegWr, RegFp_write, RegFp_read, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, branch_instruction, jump_instruction);
			
		mux2to1_5bits regDstMUX(RT, RD,RegDst,regWrAddr);
		mux2to1_5bits regDSTJALMux(regWrAddr,reg31, Jump_Link, WrAddr);
		regFile2 rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, RegWr, busWr, RS, RT, busA, busB);
	
		extender signExtender(immed,ExtOp, ExtOut); 
		mux2to1 AluInMUX(busB, ExtOut, ALUSrc, bIN);
		alu main_alu(busA, bIN, ALUCtr, ALUOut, Zero);
		
		dmem datamem(ALUOut, MemOut, busB, MemWr, 3, clk); //dsize = 3; write/read word size chunks from data memory
	
		mux2to1 JALMux(ALUOut, PCoutput, Jump_Link, RegOut);	
		mux2to1 MemToRegMUX(RegOut, MemOut, Mem2Reg, busWr);
		
		assign RS = instruction[6:10];
        assign RT = instruction[11:15];

        assign RD = instruction[16:20];
        assign immed = instruction[16:31];

endmodule
