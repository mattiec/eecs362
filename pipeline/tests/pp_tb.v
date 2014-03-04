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
      filename = "instr_unsignedsum.hex";
   end
   $readmemh(filename, top.instrMem.mem);
  // Load DMEM from file
  if (!$value$plusargs("datafile=%s", filename)) begin 
      filename = "data_unsignedsum.hex";
  end
  $readmemh(filename, top.datamem.mem);

//   $monitor("Instruction = %h  PC = %h\n\tIFU\n\t\tTarget = %h\n\t\ttakeBranch = %b\n\t\tjType = %b\n\t\treset = %b\n\t\tregJump = %b\n\t\tlinkTarget = %h\n\tDECODER\n\t\trs1 = %d\n\t\trs2 = %d\n\t\trd = %d\n\t\timmediate = %h\n\t\talu_signals = %b\n\t\tmem_size = %b\n\t\tmem_write = %b\n\t\tmem_ext = %b\n\t\treg_write = %b\n\t\tbranch_instr = %b\n\t\tjump_instr = %b\n\t\treg_data = %b\n\t\tI_type = %b\n\t\tbne = %b\n\t\tbeq = %b\n\t\tlink = %b\n\tREGISTERS\n\t\treg_data_in = %h\n\t\twrite_en = %b\n\t\taddr1 = %d\n\t\taddr2 = %d\n\t\twraddr = %d\n\t\tregA = %h\n\t\tregB = %h\n\tALU\n\t\tA = (HEX)%h   (DEC)%d\n\t\tB = (HEX)%h    (DEC)%d\n\t\talu_controls = %b\n\t\tzero = %b\n\t\talu_out = (HEX)%h    (DEC)%d\n\tDATA_MEMORY\n\t\taddr = %h\n\t\twData = %h\n\t\twriteEnable = %b\n\t\tdsize = %b\n\t\tmem_ext = %b\n\t\tdata_mem_out = %h\n\n",top.instruction,top.instructionfetch.PCout,top.instruction,top.Branch,top.jump_instruction,top.rst,top.Jump,top.instruction,top.RS,top.RT,top.RD,top.immed,top.ALUCtr,top.tmp,top.MemWr,top.tmp,top.RegWr,top.branch_instruction,top.jump_instruction,top.busWr,top.tmp,top.Branch_NotEqual,top.Branch,top.tmp,top.busWr,top.RegWr,top.RS,top.RT,top.WrAddr,top.busA,top.busB,top.busA,top.busA,top.bIN,top.bIN,top.ALUCtr,top.Zero,top.ALUOut,top.ALUOut,top.ALUOut,top.busB,top.MemWr,top.tmp,top.tmp,top.MemOut);

$monitor("Reset = %b; Clock = %b; Instruction = %h PC = %h imm=%h ptar1=%h ptar2=%h target=%h rs=%d rt=%d rd = %d \nJump = %b Branch = %b compareEq= %b PCSrc1 = %b PCSrc2 = %b PCSrc = %b RData1 = %h RData2 = %h", top.rst, top.clk, top.instruction, top.PCout, top.immed, top.PCplus4, top.MEM_PCout, top.PCin, top.RS, top.RT, top.RD, top.Jump, top.Branch, top.compareEq, top.PCSrc1, top.PCSrc2, top.PCSrc, top.RData1, top.RData2); 
	
	iter=0;

   #0 clock=0; reset=0;
   #2 reset=1;
   #2 reset=0;

   #5000 $finish;
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
