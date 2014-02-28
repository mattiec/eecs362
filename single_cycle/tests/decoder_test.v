module decoder_test;
    reg [0:4] Wr;
	reg En;
	
    wire a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31;
     
    decoder5to32 decode532(Wr, En, a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31);

    initial begin
		$monitor("Wr=%d a0=%b a1=%b a2=%b a3=%b a4=%b a5=%b a6=%b a7=%b", Wr,a0,a1,a2,a3,a4,a5,a6,a7);
          
		#0 Wr = 5'b00000; En = 1'b0;
		#1 Wr = 5'b00000; En = 1'b0; 
		#1 Wr = 5'b00000; En = 1'b1;	  
        #1 Wr = 5'b00001; En = 1'b1; 
        #1 Wr = 5'b00010; En = 1'b1; 
        #1 Wr = 5'b00011; En = 1'b1; 
        #1 Wr = 5'b00100; En = 1'b1; 
        #1 Wr = 5'b00101; En = 1'b1; 
        #1 Wr = 5'b00110; En = 1'b1; 
		#1 Wr = 5'b00111; En = 1'b1; 
		  
    end
endmodule // testbench

/*
module decoder_test;
    reg [0:2] Wr;
	reg En;
	
    output a0,a1,a2,a3,a4,a5,a6,a7;
     
    decoder3to8 decode532(Wr, En, a0,a1,a2,a3,a4,a5,a6,a7);

    initial begin
	
		$monitor("Wr=%d En=%b a0=%b a1=%b a2=%b a3=%b a4=%b a5=%b a6=%b a7=%b", Wr, En, a0, a1, a2, a3,a4,a5,a6,a7);
          
		#0 Wr = 5'b000; En = 1'b0;
		#1 Wr = 5'b000; En = 1'b1; 
		#1 Wr = 5'b001; En = 1'b1;  
        #1 Wr = 5'b010; En = 1'b1; 
        #1 Wr = 5'b011; En = 1'b1; 
        #1 Wr = 5'b100; En = 1'b1; 
        #1 Wr = 5'b101; En = 1'b1; 
        #1 Wr = 5'b110; En = 1'b1; 
        #1 Wr = 5'b111; En = 1'b1; 
		  
    end
endmodule // testbench*/