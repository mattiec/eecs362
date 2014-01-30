module mult_test;
      reg [7:0] A;
      reg [7:0] B;
      wire [7:0] PROD;
     
      mult8bit multiplier(A,B,PROD);

    initial begin
          $monitor("A=%b B=%b PROD=%b", A, B, PROD);
          #0 A = 8'b00000000; B = 4'b0000;
          #1 A = 8'b00100000; B = 4'b0001;
          #1 A = 8'b11110001; B = 4'b0111;
          #1 A = 8'b11111111; B = 4'b0011;
          #1 A = 8'b01101011; B = 4'b0100;
    end
endmodule // testbench
 
