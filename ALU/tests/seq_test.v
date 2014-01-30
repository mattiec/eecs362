module seq_test;
      reg [31:0] a;
      reg [31:0] b_in;
      output set;

      seq test(a,b_in,set);

    initial begin
          $monitor("a=%b b_in=%b set=%b", a, b_in, set);
          #0 a = 32'h0000; b_in = 32'h0000;
          #1 a = 32'h0000; b_in = 32'h0001;
          #1 a = 32'h0001; b_in = 32'h0000;
          #1 a = 32'h0001; b_in = 32'h0001;
    end
endmodule // testbench

