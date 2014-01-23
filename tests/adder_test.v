module adder_test;
      reg [31:0] A;
      reg [31:0] B;
      reg CIN;
      wire [31:0] SUM;
      wire COUT;

      fa_32 adder(A,B,CIN,SUM,COUT);

    initial begin
          $monitor("A=%b B=%b CIN=%b SUM=%b COUT=%b", A, B, CIN, SUM, COUT);
          #0 A = 32'h0000; B = 32'h0000; CIN = 1'b0;
          #1 A = 32'h0000; B = 32'h0000; CIN = 1'b1;
          #1 A = 32'h0001; B = 32'h0000; CIN = 1'b0;
          #1 A = 32'b0; B = 32'b1; CIN = 1'b1;
          #1 A = 32'b1; B = 32'b0; CIN = 1'b0;
          #1 A = 32'b1; B = 32'b0; CIN = 1'b1;
          #1 A = 32'b1; B = 32'b1; CIN = 1'b0;
          #1 A = 32'b1; B = 32'b1; CIN = 1'b1;
    end
endmodule // testbench
