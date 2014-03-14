//  Testbench for the very top... the whole dang thing

module pp_tb;
reg clock;
reg reset;
reg [8*80-1:0] filename;
//wire [0:31] PC;

toplevel top(clock,reset);

//assign PC = {top.instructionfetch.PCout,2'b00};

always begin
   #1 clock = ~clock;
end

integer i;
integer iter;
initial begin
  // Clear DMEM
   for (i = 0; i < top.datamem.SIZE; i = i+1)
      top.datamem.mem[i] = 8'h0;

  //Load IMEM from file
   if (!$value$plusargs("instrfile=%s", filename)) begin
      filename = "instr_fib.hex";
   end
   $readmemh(filename, top.instrMem.mem);
  // Load DMEM from file
  if (!$value$plusargs("datafile=%s", filename)) begin 
      filename = "data_fib.hex";
  end
  $readmemh(filename, top.datamem.mem);

//$monitor("Rst = %b Clk = %b; Instruct = %h PC = %h imm=%h target=%h PCplus4 =%h Branch_PC =%h PCSrc =%b rs =%d rt =%d rd = %d \nJump = %b Branch = %b compareEq= %b PCSrc1 = %b PCSrc2 = %b PCSrc = %b RData1 = %h RData2 = %h\n", top.rst, top.clk, top.instruction, top.PCout, top.immed, top.PCin, top.PCplus4, top.Branch_PC, top.PCSrc, top.RS, top.RT, top.RD, top.Jump, top.Branch, top.compareEq, top.PCSrc1, top.PCSrc2, top.PCSrc, top.RData1, top.RData2); 
//$monitor("iFetch: Clk=%b instruction = %h PCout = %h PCin = %h PCplus4 = %h Branch_PC = %h PCSrc = %h/n",top.clk, top.Instruction, top.PCout, top.PCin, top.PCplus4, top.Branch_PC, top.PCSrc);
//$monitor("Decoder: instruction = %h RegDst = %b RegWr = %b RegFp_write = %b ALUCtr = %b ExtOp = %b ALUSrc = %b MemWr = %b Mem2Reg = %b Branch = %b Branch_NotEqual = %b Jump = %b\n", top.instruction, top.RegDst, top.RegWr, top.RegFp_write, top.ALUCtr, top.ExtOp, top.ALUSrc, top.MemWr, top.Mem2Reg, top.Branch, top.Branch_NotEqual, top.Jump);
//$monitor("Exec: Clock = %b; Instruction = %h PC = %h target=%h rs=%d rt=%d rd = %d imm=%h Exec_immed = %h \nbusB = %h Exec_ALUSrc = %b ALUinB = %h busA = %h ALUout = %h WrAddr =%h", top.clk, top.instruction, top.PCout, top.PCin, top.RS, top.RT, top.RD, top.immed, top.Exec_immed, top.busB, top.Exec_ALUSrc, top.ALUinB, top.busA, top.ALUout, top.WrAddr);
//$monitor("Mem: Addr = %h RData = %h WrData = %h WrEn = %b", top.Mem_Addr, top.Mem_RData, top.Mem_WrData, top.Mem_MemWr);
$monitor("Clock = %b; Instruction = %h PC = %h imm=%h target=%h rs=%d rt=%d rd = %d busA = %h busB = %h WrAddr = %h WB_RegWr = %h busWr = %h\nregister[1] = %h register[2] = %h register[3] = %h register[4] = %h RD2 = %h RD3 = %h RD4 = %h", top.clk, top.instruction, top.PCout, top.immed, top.PCin, top.RS, top.RT, top.RD, top.RData1, top.RData2, top.WrAddr, top.WB_RegWr, top.busWr, top.rFile.ireg01.out, top.rFile.ireg02.out, top.rFile.ireg03.out, top.rFile.ireg04.out, top.RD2, top.RD3, top.RD4); 




      iter=0;

   #0 clock=0; reset=0;
   #2 reset=1;
   #2 reset=0;

   #60 $finish; //changed from 5000 to 60
end
reg [0:31] instr;

always @(top.instruction) begin
  //This checks for a trap 0x300 (signifying the end of the file)
   if (top.instruction == 32'h44000300) begin	
   
	$display("Data memory: \n");

	for (i = 32'h2000; i < 32'h2100; i = i+4) begin
		assign instr = {top.datamem.mem[i], top.datamem.mem[i+1], top.datamem.mem[i+2], top.datamem.mem[i+3]};
		$display("address: %h\tdata: %h", i, instr);
	end
	
	$finish;
	
	end
end

endmodule
