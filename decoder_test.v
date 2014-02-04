module decoder_test;
    reg [4:0] Wr;
	reg En;
	
    wire a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31;
     
    decoder5to32 decode532(Wr, En, a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31);

    initial begin
          $monitor("Wr=%d En=%b a0=%b a1=%b a2=%b a3=%b a4=%b a5=%b a6=%b a7=%b a8=%b a9=%b a10=%b a11=%b a12=%b a13=%b a14=%b a15=%b a16=%b a17=%b a18=%b a19=%b a20=%b a21=%b a22=%b a23=%b a24=%b a25=%b a26=%b a27=%b a28=%b a29=%b a30=%b a31=%b", Wr, En, a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31);
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
          #1 Wr = 5'b01000; En = 1'b1; 
          #1 Wr = 5'b01001; En = 1'b1; 
          #1 Wr = 5'b01010; En = 1'b1; 
          #1 Wr = 5'b01011; En = 1'b1; 
          #1 Wr = 5'b01100; En = 1'b1; 
          #1 Wr = 5'b01101; En = 1'b1; 
          #1 Wr = 5'b01110; En = 1'b1; 
          #1 Wr = 5'b01111; En = 1'b1; 
          #1 Wr = 5'b10000; En = 1'b1; 
          #1 Wr = 5'b10001; En = 1'b1; 
          #1 Wr = 5'b10010; En = 1'b1; 
          #1 Wr = 5'b10011; En = 1'b1; 
          #1 Wr = 5'b10100; En = 1'b1; 
          #1 Wr = 5'b10101; En = 1'b1; 
          #1 Wr = 5'b10110; En = 1'b1; 
          #1 Wr = 5'b10111; En = 1'b1; 
          #1 Wr = 5'b11000; En = 1'b1; 
          #1 Wr = 5'b11001; En = 1'b1; 
          #1 Wr = 5'b11010; En = 1'b1; 
          #1 Wr = 5'b11011; En = 1'b1; 
          #1 Wr = 5'b11100; En = 1'b1; 
          #1 Wr = 5'b11101; En = 1'b1; 
          #1 Wr = 5'b11110; En = 1'b1; 
          #1 Wr = 5'b11111; En = 1'b1;
		  
    end
endmodule // testbench