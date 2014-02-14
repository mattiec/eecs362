module toplevel(clk, rst)

	input clk, rst;
	
	wire [0:31] busA, busB, busWr; 				//register file signals
	wire [0:4] RS, RT, WrAddr, RD;			//regster file signals
	wire RegDst, RegWr, Branch, Jump, ALUCtr, Zero;
	wire ALUSrc, ExtOp, MemWr, Mem2Reg, RegFp_write, RegFp_read; //Control Signals
	wire bIN, ALUOut; //ALU signals
	
	initial begin
		Branch = 0;
		Jump = 0;
		
	end
	
	wire [0:31] instruction;
	wire [0:15] immed;
	wire [0:31] ExtOut;
	
	wire [0:31] MemOut;
	
	always @(negedge clk)begin
	
		instrfetch instructionfetch(Branch, Jump, instruction);
		control controlUnit (instruction, RegDst, RegWr, RegFp_write, RegFp_read, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Jump, ALUCtr);
		
		RS = instruction[6:10];
		RT = instruction[11:15];
		
		RD = instruction[16:20];
		immed = Instruction[16:31];
		
			
		mux2to15bits regDstMUX(RT, RD,RegDst,WrAddr);
		regFile rFile(rst, clk, RegFp_write, RegFp_read, WrAddr, RegWr, busWr, RS, RT, busA, busB);
	
		extender signExtender(immed,ExtOp, ExtOut); 
		mux2to1 AluInMUX(busB, ExtOut, ALUSrc, bIN);
		alu ALU(busA, bIN, ALUCtr, ALUOut, Zero);
		
		dmem(ALUOut, MemOut, busB, MemWr, //?diskSize, clk);
		
		mux2to1 MemToRegMUX(ALUOut, MemOut, Mem2Reg, busWr);
		
	
	end

endmodule
