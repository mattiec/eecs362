module regFile_test;
    reg [4:0] WrAddr;
	reg [4:0] Read1;
	reg [4:0] Read2;
	reg [31:0] WData;
	
	
	wire [31:0] RData1;
	wire [31:0] RData2;
	
	reg ftpt = 0;
	
	reg WrEn;
	reg rst;
	reg clk;
	
	//regFile test(rst, clk, WrAddr, WrEn, WData, Read1, Read2, RData1, RData2);

	regFile test(rst, clk, ftpt, WrAddr, WrEn, WData, Read1, Read2, RData1, RData2);
	//regFile test(rst, clk, WrAddr, WrEn, Read1, Read2, WData, RData1, RData2);
	
	
	
	initial begin
		rst = 1;
		clk = 0;
		@(negedge clk);
		rst = 0;
	end
	
	always #10 clk = ~clk;
	
	initial begin
		$monitor("rst=%b clk=%b WrEn=%b WrAddr=%d WrData=%h RAddr1=%d RData1=%h RAddr2=%d RData2=%h", rst, clk, WrEn, WrAddr, WData, Read1, RData1, Read2, RData2);
		
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
		WData = 323'hfde546;
		
		//stop writing data into register file
		@(posedge clk);
		WrEn = 0;
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
