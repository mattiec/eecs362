module control(instr, RegDst, RegWr, RegFp_Wr, RegFp_R, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Jump);
        input [0:31] instr;
        output reg RegDst, RegWr, RegFp_Wr,RegFp_R, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Jump;
	output reg [0:3] ALUCtr;
	
always@(instr)
        begin

	assign ALUSrc = instr[0] | instr[1] | instr[2] | instr[3] | instr[4];  //opcdoe 00000x
	assign MemWr = instr[0] & ~instr[1] & instr[2];   // opcode 101xxx
	assign Mem2Reg = instr[0] & ~instr[1] & ~instr[2]; //opcode 100xxx
	assign RegDst = ~ALUSrc;   //opcode 00000x
	if (instr[0:2] == 3'b010 || instr[0:2] == 3'b101 || (instr[0:2] == 3'b000 && (instr[3] == 1 || instr[4] == 1))) begin 
		if (instr[0:2] == 3'b101) begin  //store instruction	
			Branch = 0;
			Jump = 0;
		end else if (instr[0]==0 && instr[1]==0 && instr[2]==0 && instr[3]==1) begin  //opcode 0001xx  branch instruction
			Branch = 1;
			Jump = 0;
		end else begin   // jump instr
			Branch = 1;
			Jump = 1;
		end
		RegWr = 0;
	end else begin
		// operation that involves writing back to the register
		RegWr = 1;
		Branch = 0;
		Jump = 0;
	end 

        if (instr[0:5] == 6'b000000) begin // r-type integer instruction
		case (instr[26:31]) 
			6'b100000: ALUCtr = 4'b0101; 	 
			6'b100001: ALUCtr = 4'b0101;
			6'b100010: ALUCtr = 4'b1101;
			6'b100011: ALUCtr = 4'b1101;
			6'b100100: ALUCtr = 4'b0000;
			6'b100101: ALUCtr = 4'b0001;
			6'b100110: ALUCtr = 4'b0010;
		endcase
	end else if (instr[0:5] == 6'b000001) begin //r-type floating point instruction
			ALUCtr = 4'b0011; //mult
	end else if (instr[0:1] == 3'b10) begin //load
			ALUCtr=4'b0101;
	end else begin  // use opcode to determine ALUSrc signals
		case (instr[0:5]) 
			6'b001000: ALUCtr = 4'b0101; //addi
			6'b001001: ALUCtr = 4'b0101; //addui
			6'b001010: ALUCtr = 4'b1101; //subi
			6'b001011: ALUCtr = 4'b1101; //subui
			6'b001100: ALUCtr = 4'b0000; //andi
			6'b001101: ALUCtr = 4'b0001; //ori		
			6'b001110: ALUCtr = 4'b0010; //xori
		endcase
	end //end of r-type if statement

	if (instr[0:5] == 6'b001001 || instr[0:5] == 6'b001011) begin
		ExtOp = 0;
	end else begin
		ExtOp = 1;
	end

	if (instr[26:31] == 6'b110100) begin
		RegFp_R = 1;
	end else begin
		RegFp_R = 0;
	end

	if (instr[26:31] == 6'b110101) begin
		RegFp_Wr <= 1;
	end else begin
		RegFp_Wr <= 0;
	end
 
end//end always
endmodule

