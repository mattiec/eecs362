`include "./ALU/mux.v"
`include "./ALU/alu.v"
`include "./ALU/adder.v"
`include "./ALU/basic.v"
`include "./ALU/set.v"
`include "./ALU/shift.v"
`include "./ALU/mult.v"
`include "./ALU/fa.v"
`include "./regFile.v"

module toplevel(clk, rst);

	input clk, rst;
	
	wire [0:31] busA, busB, busWr; 				//register file signals
	wire [0:4] RS, RT, WrAddr, RD;			//regster file signals
	wire RegDst, RegWr, Branch, Branch_NotEqual, Jump, Zero;
	wire [0:3] ALUCtr;
	wire ALUSrc, ExtOp, MemWr, Mem2Reg, RegFp_write, RegFp_read; //Control Signals
	wire [0:31] bIN, ALUOut; //ALU signal

	wire [0:25] jump_instruction;
	wire [0:15] branch_instruction;
	
	input [0:31] instruction; //make back to wire
	wire [0:15] immed;
	wire [0:31] ExtOut;
	
	wire [0:31] MemOut;

	wire tmp;

	assign tmp = 0;
	
		instrFetch instructionfetch(Branch, Branch_NotEqual, Jump, Zero, branch_instruction, jump_instruction, clk, ~rst,instruction);

		control controlUnit (instruction, RegDst, RegWr, RegFp_write, RegFp_read, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, branch_instruction, jump_instruction);
			
		mux2to1_5bits regDstMUX(RT, RD,RegDst,WrAddr);
		regFile rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, RegWr, busWr, RS, RT, busA, busB);
	
		extender signExtender(immed,ExtOp, ExtOut); 
		mux2to1 AluInMUX(busB, ExtOut, ALUSrc, bIN);
		alu main_alu(busA, bIN, ALUCtr, ALUOut, Zero);
		
		dmem datamem(ALUOut, MemOut, busB, MemWr, 3, clk); //dsize = 3; write/read word size chunks from data memory
		
		mux2to1 MemToRegMUX(ALUOut, MemOut, Mem2Reg, busWr);
		
		assign RS = instruction[6:10];
                assign RT = instruction[11:15];

                assign RD = instruction[16:20];
                assign immed = instruction[16:31];

endmodule
