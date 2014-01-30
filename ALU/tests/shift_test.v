module shift_test;
      reg [31:0] A;
      reg [31:0] B;
      reg [1:0] CTRL;
      output [31:0] OUT;

      shift shift1(A,B,CTRL,OUT);

    initial begin
          $monitor("A=%b B=%b CTRL=%b OUT=%b", A, B, CTRL, OUT);
          #0 A = 32'hF000; B = 32'h0003; CTRL = 2'b00;
          #1 A = 32'hF000; B = 32'h0003; CTRL = 2'b10;
          #1 A = 32'hF000; B = 32'h0003; CTRL = 2'b01;
          #1 A = 32'hF000; B = 32'h0008; CTRL = 2'b10;
          #1 A = 32'hFFF000; B = 32'h000A; CTRL = 2'b01;
          #1 A = 32'hFFF000; B = 32'h000A; CTRL = 2'b10;
          #1 A = 32'hFFFFFFFF; B = 32'hFFFF; CTRL = 2'b00;
          #1 A = 32'hFFFFFFFF; B = 32'hFFFF; CTRL = 2'b10;
    end
endmodule // testbench
