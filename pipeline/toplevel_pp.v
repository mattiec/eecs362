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
	wire cout1, cout2, cout3;
	wire [0:31] four, two;

	wire [0:31] PCout, PCin, PCin1;	
	wire [0:31] PCplus4, EXplusShift, instruction, Branch_PC;
	wire PCSrc, PCSrc1, PCSrc2;


	wire [0:63] IDout, IDin;
	wire [0:4] WrAddr, RS, RT, Rd;
	wire [0:31] busWr, RData1, RData2;
	wire [0:15] immed;
	wire [0:31] ExtOut, Decoder_PC;
	wire ALUSrc, ExtOp, MemWr, Mem2Reg, RegFp_write, RegFp_read;
	wire RegDst, RegWr, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, Zero;
	wire [0:3] ALUCtr, Exec_ALUctr;
	wire [0:23] jump_instruction;
	wire [0:31] jumpInstructionExtended, jumpimmediate;
	wire [0:15] branch_instruction;
	wire compareEq;
	

	wire [0:192] EXin, EXout;
	wire [0:31] Exec_immed;
	wire [0:31] busA, busB, ALUinB, ALUout;
	wire [0:4] RT2, RD2; 
	wire [0:31] Exec_PC;
	wire [0:4] reg31;
	wire Exec_ALUSrc, Exec_RegDst;
		

	wire [0:105] MEMin, MEMout;


	wire [0:70] WBin, WBout;
	wire RegWr2; 


	assign four = 32'b100;
	assign two = 32'b10;
	assign EXplusShift = 32'b0;
	assign reg31 = 5'b11111;

	
	//Instruction Fetch
	PipeReg32 PC(PCout,PCin,clk,~rst);

	imem instrMem(PCout,instruction);
	fa_32bit Add4(PCout, four, 0, PCplus4, cout1);
	mux2to1 pcBranchEqMUX(PCplus4,Branch_PC, PCSrc, PCin); //PCin1

	
	assign IDin[0:31] = instruction;
	assign IDin[32:63] = PCplus4;


	//Instruction Decoder
	PipeReg64 ID(IDout, IDin, clk, ~rst);
	
	control controlUnit (instruction, RegDst, RegWr, RegFp_write, RegFp_read, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, branch_instruction, jump_instruction);
		
	assign RS = IDout[6:10];
	assign RT = IDout[11:15];
	assign RD = IDout[16:20];
	assign immed = IDout[16:31];
	assign Decoder_PC = IDout[32:63];

	regFile2 rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, RegWr2, busWr, RS, RT, RData1, RData2);
	extender signExtender(immed,ExtOp, ExtOut); 
	//shift shiftLeft2 (ExtOut, two, 00, signExtended);
	fa_32bit AddShifted(Decoder_PC, ExtOut, 0, Branch_PC, cout2); //changed signExtended to ExtOut

	seq1bit branchCompare(RData1, RData2, compareEq);
	assign PCSrc1 = Branch & compareEq; //AND branch and the zero flag
	assign PCSrc2 = Branch_NotEqual & ~compareEq;
	assign PCSrc = PCSrc1 | PCSrc2;
	
	assign EXin[0] = Mem2Reg;
	assign EXin[1] = RegWr;
	assign EXin[2] = Branch;
	assign EXin[3] = MemWr;
	assign EXin[4:7] = ALUCtr;
	assign EXin[8] = ALUSrc;
	assign EXin[9] = RegDst;
	assign EXin[10:41] = Decoder_PC;
	assign EXin[42:73] = RData1;
	assign EXin[74:105] = RData2;
	assign EXin[106:137] = immed;
	assign EXin[138:142] = RT;
	assign EXin[143:147] = RD;
	assign EXin[148] = Jump;
	assign EXin[149] = Branch_NotEqual;
	assign EXin[150] = Jump_Reg;
	assign EXin[151] = Jump_Link;
	assign EXin[152:167] = branch_instruction;
	assign EXin[168:192] = jump_instruction;
	
	
	//Execute
	PipeReg193 EX(EXout, EXin, clk, ~rst);

	assign Exec_immed = EXout[106:137];
	assign busA = EXout[42:73];
	assign busB = EXout[74:105];
	assign RT2 = EXout[138:142];
	assign RD2 = EXout[142:147];
	assign Exec_PC = EXout[10:41];
	assign Exec_ALUctr = EXout[4:7];
	assign Exec_ALUSrc = EXout[8];
	assign Exec_RegDst = EXout[9];

	mux2to1 aluMUX(busB, Exec_immed, Exec_ALUSrc, ALUinB);
	alu main_alu(busA, ALUinB, Exec_ALUctr, ALUout, Zero);
 
	mux2to1_5bits regDstMUX(RT2, RD2, Exec_RegDst, WrAddr);

	assign MEMin[0:3] = EXout[0:3];
	assign MEMin[36] = Zero;
	assign MEMin[37:68] = ALUout;
	assign MEMin[69:100] = busB;
	assign MEMin[101:105] = WrAddr;

	
	//Memory
	PipeReg106 MEM(MEMout, MEMin, clk, ~rst);

	//assign Branch_PC = MEMout[4:35];
	//assign PCSrc = MEMout[2] & MEMout[36]; //AND branch and the zero flag

	dmem datamem(MEMout[37:68], WBin[2:33], MEMout[69:100], MEMout[3], 3, clk); //dsize = 3 (word)

	assign WBin[0:1] = MEMout[0:1];
	assign WBin[34:65] = MEMout[69:100];
	assign WBin[66:70] = MEMout[101:105];

	
	//Write Back
	PipeReg71 WB(WBout, WBin, clk, ~rst);
	assign RegWr2 = WBout[1];

endmodule
