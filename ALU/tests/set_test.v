module mux_test;
    reg [31:0] a, b;
	
    wire [31:0] SEQ, SNE, SGE, SLE, SGT, SLT;
	
     
    seq seq1(a,b,SEQ);
	sne sne1(a,b,SNE);
	sge sge1(a,b,SGE);
	sle sle1(a,b,SLE);
	sgt sgt1(a,b,SGT);
	slt slt1(a,b,SLT);

    initial begin
	
         $monitor("a=%d b=%d SEQ=%b SNE=%b SGE=%b SLE=%b SGT=%b SLT=%b", a, b, SEQ, SNE, SGE, SLE, SGT, SLT);
         #0 a = 32'h1; b = 32'h1; 
		 #1 a = 32'h0; b = 32'h1; 
		 #1 a = 32'h1; b = 32'h0; 
		 #1 a = 32'hFFFFFFFF; b = 32'hFFFFFFFE; 
		 #1 a = 32'hFFFFFFFE; b = 32'hFFFFFFFF; 
		 #1 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; 
    end
endmodule // testbench
