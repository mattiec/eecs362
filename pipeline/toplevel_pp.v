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
	wire [0:31] four, two, zero0;

	wire [0:31] PCout, PCin, PCin1;	
	wire [0:31] PCplus4, EXplusShift, instruction, Branch_PC;
	wire PCSrc, PCSrc1, PCSrc2;


	wire [0:31] ID_instruction;
	wire [0:63] IDout, IDin;
	wire [0:4] RS, RT, RD;
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
	wire id_squash;
	

	wire [0:197] EXin, EXout;
	reg [0:1] ForwardA, ForwardB;
	wire [0:31] ForwardAout,ForwardBout;
	wire [0:11] MuxAout, MuxBout;
	wire [0:4] EX_WrAddr;	
	wire [0:31] Exec_immed;
	wire [0:31] busA, busB, ALUinB, ALUout;
	wire [0:4] RT2, RD2, RS2; 
	wire [0:31] Exec_PC;
	wire [0:4] reg31;
	wire Exec_ALUSrc, Exec_RegDst;
		

	wire [0:4] RD3;
	wire [0:110] MEMin, MEMout;
	wire [0:31] Mem_Addr, Mem_WrData, Mem_RData;
	wire Mem_MemWr;


	wire [0:4] RD4;
	wire EX_regWrite;
	wire [0:75] WBin, WBout;
	wire WB_RegWr, WB_Mem2Reg;
	wire [0:31] WB_RData, WB_Addr; 
	wire [0:4] WB_WrAddr, WrAddr; 


	assign four = 32'b100;
	assign two = 32'b10;
	assign zero0 = 32'b0;
	assign EXplusShift = 32'b0;
	assign reg31 = 5'b11111;



	
	//Instruction Fetch
	PipeReg32 PC(PCout,PCin,clk,~rst);

	imem instrMem(PCout,instruction);
	fa_32bit Add4(PCout, four, 0, PCplus4, cout1);
	mux2to1 pcBranchEqMUX(PCplus4,Branch_PC, PCSrc, PCin);

	assign IDin[0:31] = instruction;
	assign IDin[32:63] = PCplus4;




	//Instruction Decoder
	PipeReg64 ID(IDout, IDin, clk, ~rst);

	assign ID_instruction = IDout[0:31];
	assign RS = ID_instruction[6:10];
	assign RT = ID_instruction[11:15];
	assign RD = ID_instruction[16:20];
	assign immed = ID_instruction[16:31];	
	assign Decoder_PC = IDout[32:63];
	
	control controlUnit (ID_instruction, RegDst, RegWr, RegFp_write, RegFp_read, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, Jump_Reg, Jump_Link, branch_instruction, jump_instruction);
	regFile2 rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, WB_RegWr, busWr, RS, RT, RData1, RData2);
	extender signExtender(immed,ExtOp, ExtOut); 
	fa_32bit AddShifted(Decoder_PC, ExtOut, 0, Branch_PC, cout2); 

	hazardDetect hazardDetection(RD2, RS, RT, ID_instruction[26:31], id_squash);

	seq1bit branchCompare(RData1, RData2, compareEq);
	assign PCSrc1 = Branch & compareEq;
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
	assign EXin[193:197] = RS;




	//Execute
	PipeReg198 EX(EXout, EXin, clk, ~rst);

	assign Exec_immed = EXout[106:137];
	assign busA = EXout[42:73];
	assign busB = EXout[74:105];
	assign RT2 = EXout[138:142];
	assign RD2 = EXout[142:147];
	assign RS2 = EXout[193:197];
	assign Exec_PC = EXout[10:41];
	assign Exec_ALUctr = EXout[4:7];
	assign Exec_ALUSrc = EXout[8];
	assign Exec_RegDst = EXout[9];
	

	//data forwarding
	always @(negedge clk) begin

		assign ForwardA = 00;
		assign ForwardB = 00;

		//MEM/WB hazard
		if (WB_RegWr == 1'b1 & RD4 != 1'b0 & RD3 != RS2 & RD4 == RS2) begin
                        assign ForwardA = 2'b01;
                end
                if (WB_RegWr == 1'b1 & RD4 != 1'b0 & RD3 != RT2 & RD4 == RT2) begin
                        assign ForwardB = 2'b01;
                end


		//EX/MEM Hazard
		if (EX_regWrite == 1'b1 & RD3 != 1'b0 & RD3 == RS2) begin
			assign ForwardA = 2'b10;
		end
		if (EX_regWrite == 1'b1 & RD3 != 1'b0 & RD3 == RT2) begin
			assign ForwardB = 2'b10;
		end
	end

	mux4to1 SelectorA(busA,busWr,Mem_Addr,zero0,ForwardA,ForwardAout);
	mux4to1 SelectorB(busB,busWr,Mem_Addr,zero0,ForwardB,ForwardBout);
	mux2to1 aluMUX(ForwardBout, Exec_immed, Exec_ALUSrc,ALUinB);
	alu main_alu(ForwardAout, ALUinB, Exec_ALUctr,ALUout,Zero);
	//ORIGINAL 2TO1MUX and main_alu
	//mux2to1 aluMUX(busB, Exec_immed, Exec_ALUSrc, ALUinB);
	//alu main_alu(busA, ALUinB, Exec_ALUctr, ALUout, Zero);
	mux2to1_5bits regDstMUX(RT2, RD2, Exec_RegDst, EX_WrAddr);

	assign MEMin[0:3] = EXout[0:3];
	assign MEMin[36] = Zero;
	assign MEMin[37:68] = ALUout;
	assign MEMin[69:100] = ForwardBout; 
	assign MEMin[101:105] = EX_WrAddr;
	assign MEMin[106:110] = RD2;




	//Memory
	PipeReg111 MEM(MEMout, MEMin, clk, ~rst);

	assign Mem_Addr = MEMout[37:68];
	assign Mem_WrData = MEMout[69:100];
	assign Mem_MemWr = MEMout[3];
	assign RD3 = MEMout[106:110];
	assign EX_regWrite = MEMout[1];

	dmem datamem(Mem_Addr, Mem_RData, Mem_WrData, Mem_MemWr, 3, clk); //dsize = 3 (word)

	assign WBin[0:1] = MEMout[0:1];
	assign WBin[2:33] = Mem_RData;
	assign WBin[34:65] = Mem_Addr;
	assign WBin[66:70] = MEMout[101:105];
	assign WBin[71:75] = RD3;


	//Write Back
	PipeReg76 WB(WBout, WBin, clk, ~rst);
	
	assign RD4 = WBout[71:75];
	assign WB_Mem2Reg = WBout[0];
	assign WB_RData = WBout[2:33];
	assign WB_Addr = WBout[34:65];
	assign WB_WrAddr = WBin[66:70];

	mux2to1 wrBackMUX(WB_Addr, WB_RData, WB_Mem2Reg, busWr);

	assign WB_RegWr = WBout[1];

	PipeReg5 storeWrAddr(WrAddr, WB_WrAddr, clk, ~rst);

endmodule
