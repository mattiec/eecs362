module control_test;
      reg [0:31] Instr;
      output REGDST, REGWR, REGFP_WR, REGFP_R, EXTOP, ALUSRC,MEMWR, MEM2REG, BRANCH, JUMP;
      output [0:3] ALUCTR;

      control  ctr_signals(Instr,REGDST, REGWR, REGFP_WR, REGFP_R, ALUCTR, EXTOP, ALUSRC,MEMWR, MEM2REG, BRANCH, JUMP);

    initial begin
          $monitor("instr=%b RegDst=%b RegWr=%b RegFp_Wr=%b Regfp_R=%b ExtOp=%b ALUSrc=%b MemWr=%b Mem2Reg=%b Branch=%b Jump=%b ALUCtr=%b", Instr, REGDST, REGWR, REGFP_WR, REGFP_R, EXTOP, ALUSRC,MEMWR, MEM2REG, BRANCH, JUMP, ALUCTR);    
	#0 Instr = 32'h00000000;
	#1
	//r-type instruction
	 #1 Instr = 32'h00000020;
     	$display("add");
	 #1 Instr = 32'h00000022;
	$display("sub");
	 #1 Instr = 32'h00000024;
     	$display("and");

	 #1 Instr = 32'h00000034;
	$display("movfp2ip");
	 #1 Instr = 32'h00000035;
	$display("movi2fp");

	#1 Instr = 32'h08000000;
	$display("jump");
	#1 Instr = 32'h10000000;
	$display("branch");

	#1 Instr = 32'h20000000;
	$display("addi");
	#1 Instr = 32'h24000000;
	$display("addui");
	#1 Instr = 32'h30000000;
	$display("andi");
	#1 Instr = 32'h38000000;
	$display("xori");

	#1 Instr = 32'h8C000000;
	$display("lw");
	#1 Instr = 32'hA0000000;
	$display("sb"); 

    end
endmodule // testbench
