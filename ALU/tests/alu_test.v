module alu_test;
      reg [0:31] A;
      reg [0:31] B;
      reg [0:3] CTRL;
      output [0:31] OUT;
      output ZERO_SIGNAL;

      alu alu1(A,B,CTRL,OUT, ZERO_SIGNAL);

    initial begin
          $monitor("A=%b B=%b CTRL=%b OUT=%b ZERO_SIGNAL=%b", A, B, CTRL, OUT, ZERO_SIGNAL);
          #0 A = 32'hF054; B = 32'h005F; CTRL = 4'b0000;
	  #1 A = 32'hF000; B = 32'h000F; CTRL = 4'b0000;
          #1 A = 32'hFF40; B = 32'h00FF; CTRL = 4'b0001;
          #1 A = 32'hFF40; B = 32'h03FF; CTRL = 4'b0010;
          #1 A = 32'h0004; B = 32'h0008; CTRL = 4'b0011;
          #1 A = 32'hFFF000; B = 32'h000A; CTRL = 4'b0101;
          #1 A = 32'hFFFFFFFF; B = 32'hFFFF; CTRL = 4'b1101;
          #1 A = 32'hFFFFFFFF; B = 32'hFFFF; CTRL = 4'b0101;

	 #1 $display("shift left, then shift right arithmetic, then shift right logical");
	 #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=4'b0100;
	 #1 A = 32'hFFFF0000; B = 32'h0000000D; CTRL=4'b0110;
	 #1 A = 32'hFFFF0000; B = 32'h0000000D; CTRL=4'b0111;

	 #1 $display("set tests");
	 #1 A = 32'h0000FFFF; B = 32'h0000FFFF; CTRL=4'b1000;
	 #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=4'b1001;
	 #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=4'b1010;
	 #1 A = 32'h000000FF; B = 32'h00FFFFFF; CTRL=4'b1011;
	 #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=4'b1011;
 	 #1 A = 32'h0000FFFF; B = 32'h0000000D; CTRL=4'b1100;
	 #1 A = 32'h0000FFFF; B = 32'h0000FFFF; CTRL=4'b1110;
    end
endmodule // testbench
