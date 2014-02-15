module instrFetch_test;
      reg [29:0] a;
      reg [29:0] b;
      reg cin;
      output [29:0] addOut;
      output [31:0] imemOut;

      instrfetch test(a,b,cin,addOut,imemOut);

    initial begin
          $monitor("a=%b b=%b cin=%b addOut=%b imemOut=%b", a, b, cin, addOut, imemOut);
          #0 a = 30'h0000; b = 30'h0001; cin = 1'h0;
          #1 a = 30'h00FF; b = 30'h0005; cin = 1'h0;
          #1 a = 30'h0001; b = 30'h0002; cin = 1'h0;
          #1 a = 30'h0001; b = 30'h0010; cin = 1'h1;
    end


endmodule // testbench

