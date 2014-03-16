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



$monitor("PC: Clock = %b; Instruction = %h PC = %h target = %h PCplus4 = %h Branch_PC = %h PCSrc = %h\nDC: WrAddr = %h WB_RegWr = %h busWr = %h RS = %h RData1 = %h RT = %h RData2 = %h immed = %h\nEX: Exec_ALUctr = %h ALUout = %h Zero = %h busA = %h busB = %h RT2 = %h RD2 = %h Exec_RegDst = %h\nMEM: Mem_Addr = %h Mem_RData = %h Mem_WrData = %h Mem_MemWr = %h\nWB: WB_RData = %h WB_Addr = %h WB_Mem2Reg = %h busWr = %h\n", top.clk, top.instruction, top.PCout, top.PCin, top.PCplus4, top.Branch_PC, top.PCSrc, top.WrAddr, top.WB_RegWr, top.busWr, top.RS, top.RData1, top.RT, top.RData2, top.immed, top.Exec_ALUctr, top.ALUout, top.Zero, top.busA, top.busB, top.RT2, top.RD2, top.Exec_RegDst, top.Mem_Addr, top.Mem_RData, top.Mem_WrData, top.Mem_MemWr, top.WB_RData, top.WB_Addr, top.WB_Mem2Reg, top.busWr); 




      iter=0;

   #0 clock=0; reset=0;
   #2 reset=1;
   #2 reset=0;

   #20 $finish; //changed from 5000 to 20
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
