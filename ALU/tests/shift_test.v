module shift_test;
      reg [31:0] A;
      reg [31:0] B;
      reg [1:0] CTRL;
      output [31:0] OUT;

      shift shift1(A,B,CTRL,OUT);

    initial begin
	 $display("shift left 2x, then shift right arithmetic 2x, then shift right logical 2x");
	 $monitor("A=%b B=%b CTRL=%b OUT=%b logical=%b", A,B,CTRL,OUT, shift1.log_or_arith);
         #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=2'b00;
	 #1 A = 32'hFFFFFFFF; B = 32'h00000001; CTRL=2'b00;
	 #1 A = 32'hFFFFFFFF; B = 32'h0000001F; CTRL=2'b10;
         #1 A = 32'h0FFF0000; B = 32'h0000000D; CTRL=2'b10;
         #1 A = 32'hFFFF0000; B = 32'h0000000D; CTRL=2'b11;
	 #1 A = 32'h0FFFFFFF; B = 32'h00000008; CTRL=2'b11;
    end
endmodule // testbench
