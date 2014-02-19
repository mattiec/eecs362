module control(instr, RegDst, RegWr, RegFp_Wr, RegFp_R, ALUCtr, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump, branch_instruction, jump_instruction);
        input [0:31] instr;
        output reg RegDst, RegWr, RegFp_Wr,RegFp_R, ExtOp, ALUSrc, MemWr, Mem2Reg, Branch, Branch_NotEqual, Jump;
	output reg [0:25] jump_instruction;
	output reg [0:15] branch_instruction;
	output reg [0:3] ALUCtr;
	
always@(instr) begin

	//will need ot change these two for the pipelined processor 
	assign jump_instruction = instr[6:31];
	assign branch_instruction = instr[15:31];

	assign ALUSrc = instr[0] | instr[1] | instr[2];  //opcdoe 000xxx
	assign MemWr = instr[0] & ~instr[1] & instr[2];   // opcode 101xxx
	assign Mem2Reg = instr[0] & ~instr[1] & ~instr[2]; //opcode 100xxx
	assign RegDst = ~(ALUSrc | instr[3] | instr[4]);   //opcode 00000x
	if ((instr[0:4] == 5'b01001) || instr[0:2] == 3'b101 || (instr[0:2] == 3'b000 && instr[3] == 1)) begin 
		if (instr[0:2] == 3'b101) begin  //store instruction	
			Branch = 0;
			Branch_NotEqual = 0;
			Jump = 0;
		end else if (instr[0]==0 && instr[1]==0 && instr[2]==0 && instr[3]==1) begin  //opcode 0001xx  branch instruction
			if (instr[5] == 0) begin
				Branch = 1;
				Branch_NotEqual = 0;
			end else begin 
				Branch = 0;
				Branch_NotEqual = 1;
			end
			Jump = 0;
		end else begin   // jump instr
			Jump = 1;
			Branch = 0;
			Branch_NotEqual = 0;
		end
		RegWr = 0;
	end else begin
		if (instr != 32'h00000013) begin 
			RegWr = 1;
		end else begin
			RegWr = 0; //nop
		end
		// operation that involves writing back to the registe
		Branch = 0;
		Branch_NotEqual = 0;
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
			6'b101000: ALUCtr = 4'b1000; //seq
			6'b101001: ALUCtr = 4'b1001; //sne
			6'b101010: ALUCtr = 4'b1110; //slt
			6'b101011: ALUCtr = 4'b1100; //sgt
			6'b101100: ALUCtr = 4'b1011; //sle
			6'b101101: ALUCtr = 4'b1010; //sge
			6'b000100: ALUCtr = 4'b0100; //shift left
			6'b000110: ALUCtr = 4'b0111; //shift right logical
			6'b000111: ALUCtr = 4'b0110; //shift right arithmetic 
		endcase
	end else if (instr[0:5] == 6'b000001) begin //r-type floating point instruction
			ALUCtr = 4'b0011; //mult
	end else if (instr[0:1] == 2'b10) begin //load or store
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
			6'b010100: ALUCtr = 4'b0100; //slli
			6'b010110: ALUCtr = 4'b0111; //srli
			6'b010111: ALUCtr = 4'b0110; //srai
			6'b011000: ALUCtr = 4'b1000; //seqi
			6'b011001: ALUCtr = 4'b1001; //snei
			6'b011010: ALUCtr = 4'b1110; //slti
			6'b011011: ALUCtr = 4'b1100; //sgti
			6'b011100: ALUCtr = 4'b1011; //slei
			6'b011101: ALUCtr = 4'b1010; //sgei
			6'b000100: ALUCtr = 4'b1101; //beqz
			6'b000101: ALUCtr = 4'b1101; //bnez
		endcase
	end //end of r-type if statement

	if (instr[0:5] == 6'b001001 || instr[0:5] == 6'b001011 || instr==32'h04000016) begin
		ExtOp = 0;
	end else begin
		ExtOp = 1;
	end

	if (instr[0:5] == 6'b000000 && instr[26:31] == 6'b110100) begin
		RegFp_R = 1;
	end else begin
		RegFp_R = 0;
	end

	if (instr[0:5] == 6'b000000 && instr[26:31] == 6'b110101) begin
		RegFp_Wr <= 1;
	end else begin
		RegFp_Wr <= 0;
	end
 
end//end always
endmodule

