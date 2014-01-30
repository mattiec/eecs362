module mult_test;
      reg [31:0] A;
      reg [31:0] B;
      wire [31:0] ANDRES;
	  wire [31:0] ORRES;
	  wire [31:0] XORRES;
     
      and32 ander(A,B,ANDRES);
	  or32 orer(A,B,ORRES);
	  xor32 xorer(A,B,XORRES);

    initial begin
          $monitor("A=%b B=%b ANDRES=%b ORRES=%b XORRES=%b", A, B, ANDRES, ORRES, XORRES);
          #0 A = 32'h0000; B = 32'h0000;
          #1 A = 32'h0000; B = 32'h0001;
          #1 A = 32'h0001; B = 32'h0001;
          #1 A = 32'h0001; B = 32'h0000;		  
          #1 A = 32'h0001; B = 32'h0111;
          #1 A = 32'h1111; B = 32'h0F11;
          #1 A = 32'h0110; B = 32'h010A;
		  #1 A = 32'hAA1F; B = 32'h0F11;
          #1 A = 32'hABCD; B = 32'h010A;
		  #1 A = 32'hFFFF; B = 32'h0001;
		  #1 A = 32'hFFFF; B = 32'h0000;
          #1 A = 32'hFFFF; B = 32'h010A;
    end
endmodule // testbench
 
