module regFile_test;
    reg [4:0] WrAddr;
	reg [4:0] Read1;
	reg [4:0] Read2;
	reg [31:0] WData;
	
	
	wire [31:0] RData1;
	wire [31:0] RData2;
	
	reg ftpt_write = 1;
	reg ftpt_read = 1;
	
	reg WrEn;
	reg rst;
	reg clk;
	
	
	regFile2 test(rst, clk, ftpt_write, ftpt_read, WrAddr, WrEn, WData, Read1, Read2, RData1, RData2);
	
	//register test(RData1, WData, WrEn, rst, clk);
	
	initial begin
		rst = 1;
		clk = 0;
		@(negedge clk);
		rst = 0;
	end
	
	always #10 clk = ~clk;
	
	initial begin
		$monitor("rst=%b clk=%b ftpt_write=%b WrEn=%b WrAddr=%d WrData=%h RAddr1=%d RData1=%h RAddr2=%d RData2=%h", rst, clk, ftpt_write, WrEn, WrAddr, WData, Read1, RData1, Read2, RData2);
		//$monitor("WrEn=%b WrAddr=%d WrData=%h RAddr1=%d RData1=%h RAddr2=%d RData2=%h O00=%h D00=%b D01=%b ",WrEn, WrAddr, WData, Read1, RData1, Read2, RData2, test.O00, test.D00, test.D01);
		//$monitor("rst=%b clk=%b WrEn=%b WrData=%h RData1=%h", rst, clk, WrEn, WData, RData1);
		Read1 = 0;
		Read2 = 0;
		WrEn = 0;
		WrAddr = 0;
		WData = 0;
		@(negedge rst);
		@(posedge clk);
		
		//writing data into register file
		WrEn = 1;
		WrAddr = 5'd0;
		WData = 32'h2ae42;
		@(posedge clk);
		WrAddr = 5'd1;
		WData = 32'h32137;
		@(posedge clk);
		WrAddr = 5'd2;
		WData = 32'h8b004e;
		@(posedge clk);
		WrAddr = 5'd3;
		WData = 32'hfde546;
		
		//stop writing data into register file
		@(posedge clk);
		WrEn = 0;
		WData = 32'h0;
		@(posedge clk);
		
		//reading data from register file
		Read1 = 5'd0;
		Read2 = 5'd1;
		@(posedge clk);
		Read1 = 5'd2;
		Read2 = 5'd3;
		
		$finish;
	end
endmodule // testbench
