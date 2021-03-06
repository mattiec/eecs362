module mult_test;
      reg signed[31:0] A;
      reg signed[31:0] B;
      wire signed [31:0] PROD;
     
      mult32bit multiplier(A,B,PROD);

    initial begin
          $monitor("A=%d B=%d PROD=%d", A, B, PROD);
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
		  #1 A = 32'hFFFF; B = -7;
          #1 A = -97; B = 0;
		  #1 A = -97; B = -1202;
    end
endmodule // testbench
 
