module mux_test;
    reg [31:0] a0, a1, a2, a3, a4, a5, a6, a7;
    reg [31:0] a8,a9,a10,a11,a12,a13,a14,a15;

	
	reg [3:0] SEL;
	
    wire [31:0] OUT;
     
      mux16to1 mux(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,SEL,OUT);

    initial begin
          $monitor("SEL=%d OUT=%d", SEL, OUT);
          #0 a0 = 32'h0; a1 = 32'h1; a2 = 32'h2; a3 = 32'h3; a4 = 32'h4; a5 = 32'h5; a6 = 32'h6; a7 = 32'h7; a8 = 32'h8; a9 = 32'h9;
		  a10 = 32'ha; a11 = 32'hb; a12 = 32'hc; a13 = 32'hd; a14 = 32'he; a15 = 32'hf; SEL = 32'h0; 
		  #1 a0 = 32'h0; a1 = 32'h1; a2 = 32'h2; a3 = 32'h3; a4 = 32'h4; a5 = 32'h5; a6 = 32'h6; a7 = 32'h7; a8 = 32'h8; a9 = 32'h9;
		  a10 = 32'ha; a11 = 32'hb; a12 = 32'hc; a13 = 32'hd; a14 = 32'he; a15 = 32'hf; SEL = 32'h2; 
		  #1 a0 = 32'h0; a1 = 32'h1; a2 = 32'h2; a3 = 32'h3; a4 = 32'h4; a5 = 32'h5; a6 = 32'h6; a7 = 32'h7; a8 = 32'h8; a9 = 32'h9;
		  a10 = 32'ha; a11 = 32'hb; a12 = 32'hc; a13 = 32'hd; a14 = 32'he; a15 = 32'hf; SEL = 32'h9; 
		  #1 a0 = 32'h0; a1 = 32'h1; a2 = 32'h2; a3 = 32'h3; a4 = 32'h4; a5 = 32'h5; a6 = 32'h6; a7 = 32'h7; a8 = 32'h8; a9 = 32'h9;
		  a10 = 32'ha; a11 = 32'hb; a12 = 32'hc; a13 = 32'hd; a14 = 32'he; a15 = 32'hf; SEL = 32'hf; 
    end
endmodule // testbench
