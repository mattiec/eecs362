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
	wire [0:4] WrAddr, RS, RT, RD, Exec_WrAddr;
	wire [0:31] busWr, RData1, RData2;
	wire [0:15] immed;
	wire [0:31] ExtOut, Decoder_PC, ExtOut2;
	wire ALUSrc, ExtOp, MemWr, Mem2Reg, RegFp_write, RegFp_read;
	wire RegDst, RegWr, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, Zero;
	wire [0:3] ALUCtr, Exec_ALUctr;
	wire [0:23] jump_instruction;
	wire [0:31] jumpInstructionExtended, jumpimmediate;
	wire [0:15] branch_instruction;
	wire compareEq;
	

	wire [0:192] EXin, EXout;

	wire [0:1] ForwardA, ForwardB;
	wire [0:11] MuxAout, MuxBout;
	
	wire [0:31] Exec_immed;
	wire [0:31] busA, busB, ALUinB, ALUout;
	wire [0:4] RT2, RD2; 
	wire [0:31] Exec_PC;
	wire [0:4] reg31;
	wire Exec_ALUSrc, Exec_RegDst;
		

	wire [0:105] MEMin, MEMout;
	wire [0:31] Mem_Addr, Mem_WrData, Mem_RData;
	wire Mem_MemWr;


	wire [0:70] WBin, WBout;
	wire WB_RegWr, WB_Mem2Reg;
	wire [0:31] WB_RData, WB_Addr; 


	assign four = 32'b100;
	assign two = 32'b10;
	assign EXplusShift = 32'b0;
	assign reg31 = 5'b11111;

	
	//Instruction Fetch
	PipeReg32 PC(PCout,PCin,clk,~rst);

	imem instrMem(PCout,instruction);
	fa_32bit Add4(PCout, four, 0, PCplus4, cout1);
	mux2to1 pcBranchEqMUX(PCplus4,Branch_PC, PCSrc, PCin); //PCin1


	assign IDin[0:31] = instruction; //
	assign IDin[32:63] = PCplus4;


	//Instruction Decoder
	//IDout[0:31] - Instruction
	//IDout[32:63] - PC plus4
	PipeReg64 ID(IDout, IDin, clk, ~rst);
	
	control controlUnit (instruction, RegDst, RegWr, RegFp_write, RegFp_read, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, branch_instruction, jump_instruction);
	
	assign RS = IDout[6:10];
	assign RT = IDout[11:15];
	assign RD = IDout[16:20];
	assign immed = IDout[16:31];	
	assign Decoder_PC = IDout[32:63];

	regFile2 rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, WB_RegWr, busWr, RS, RT, RData1, RData2);
	extender signExtender(immed,ExtOp, ExtOut); 
	//fa_32bit AddBranchPC4(four, ExtOut, 0, ExtOut2, cout2);
	fa_32bit AddShifted(Decoder_PC, ExtOut, 0, Branch_PC, cout2); 

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
	//EXout[0] - Mem2Reg
	//EXout[1] - RegWr
	//EXout[2] - Branch
	//EXout[3] - MemWr
	//EXout[4:7] - ALUCtr
	//EXout[8] - ALUSrc
	//EXout[9] - RegDst
	//EXout[10:41] - Decoder_PC
	//EXout[42:73] - RData1
	//EXout[74:105] - RData2
	//EXout[106:137] - immed
	//EXout[138:142] - RT
	//EXout[143:147] - RD
	//EXout[148] - Jump
	//EXout[149] - Branch_NotEqual
	//EXout[150] - Jump_Reg
	//EXout[151] - Jump_Link
	//EXout[152:167] - branch_instruction
	//EXout[168:192] - jump_instruction
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
	//MEMout[0] - Mem2Reg
	//MEMout[1] - RegWr
	//MEMout[2] - Branch
	//MEMout[3] - MemWr
	//MEMout[36] - Zero
	//MEMout[37:68] - ALUout
	//MEMout[69:100] busB;
	//MEMout[101:105] - WrAddr
	PipeReg106 MEM(MEMout, MEMin, clk, ~rst);

	assign Mem_Addr = MEMout[37:68];
	assign Mem_WrData = MEMout[69:100];
	assign Mem_MemWr = MEMout[3];

	dmem datamem(Mem_Addr, Mem_RData, Mem_WrData, Mem_MemWr, 3, clk); //dsize = 3 (word)

	assign WBin[0:1] = MEMout[0:1];
	assign WBin[2:33] = Mem_RData;
	assign WBin[34:65] = Mem_Addr;
	assign WBin[66:70] = MEMout[101:105]; //Register WrAddr

	
	//Write Back
	//WBout[0] - Mem2Reg
	//WBout[1] - RegWr
	//WBout[2:33] - Data read from memory
	//WBout[34:65] - Address of data read from memory
	//WBout[66:70] - Register Write Address
	PipeReg71 WB(WBout, WBin, clk, ~rst);
	
	assign WB_Mem2Reg = WBout[0];
	assign WB_RData = WBout[2:33];
	assign WB_Addr = WBout[34:65];

	mux2to1 wrBackMUX(WB_RData, WB_Addr, WB_Mem2Reg, busWr);
	assign WB_RegWr = WBout[1];

endmodule
