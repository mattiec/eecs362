module decoder2to4(Wr, En, a0,a1,a2,a3);

	input [0:1] Wr;
	input En;
	
	output a0, a1, a2, a3;
	
	assign a0 = (!Wr[0] & !Wr[1]) & En;
	assign a1 = (!Wr[0] &  Wr[1]) & En;
	assign a2 =  (Wr[0] & !Wr[1]) & En;
	assign a3 =  (Wr[0] &  Wr[1]) & En;

endmodule



module decoder3to8(Wr, En, a0,a1,a2,a3,a4,a5,a6,a7);
	
	input [0:2] Wr;
	input En;
	
	output a0,a1,a2,a3,a4,a5,a6,a7;
	
	assign a0 = (!Wr[0] & !Wr[1]) & (!Wr[2] & En);
	assign a1 = (!Wr[0] & !Wr[1]) & (Wr[2] & En);
	assign a2 = (!Wr[0] &  Wr[1]) & (!Wr[2] & En);
	assign a3 = (!Wr[0] &  Wr[1]) & (Wr[2] & En);
	assign a4 = (Wr[0] & !Wr[1]) & (!Wr[2] & En);
	assign a5 = (Wr[0] & !Wr[1]) & (Wr[2] & En);
	assign a6 = (Wr[0] &  Wr[1]) & (!Wr[2] & En);
	assign a7 = (Wr[0] &  Wr[1]) & (Wr[2] & En);
	
endmodule



module decoder5to32(Wr,En,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31);
	
	input [0:4] Wr;
	input En;
	
	output a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31;
	
	/*wire d3, d2, d1, d0;
	
	decoder2to4 d24(Wr[0:1], En, d0, d1, d2, d3);
	
	decoder3to8 d38_1(Wr[2:4], d0, a0,a1,a2,a3,a4,a5,a6,a7);
	decoder3to8 d38_2(Wr[2:4], d1, a8,a9,a10,a11,a12,a13,a14,a15);
	decoder3to8 d38_3(Wr[2:4], d2, a16,a17,a18,a19,a20,a21,a22,a23);
	decoder3to8 d38_4(Wr[2:4], d3, a24,a25,a26,a27,a28,a29,a30,a31);*/
	
	assign a0 = (!Wr[0] & !Wr[1]) & (!Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a1 = (!Wr[0] & !Wr[1]) & (!Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a2 = (!Wr[0] & !Wr[1]) & (!Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a3 = (!Wr[0] & !Wr[1]) & (!Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a4 = (!Wr[0] & !Wr[1]) & (Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a5 = (!Wr[0] & !Wr[1]) & (Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a6 = (!Wr[0] & !Wr[1]) & (Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a7 = (!Wr[0] & !Wr[1]) & (Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a8 = (!Wr[0] & Wr[1]) & (!Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a9 = (!Wr[0] & Wr[1]) & (!Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a10 = (!Wr[0] & Wr[1]) & (!Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a11 = (!Wr[0] & Wr[1]) & (!Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a12 = (!Wr[0] & Wr[1]) & (Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a13 = (!Wr[0] & Wr[1]) & (Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a14 = (!Wr[0] & Wr[1]) & (Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a15 = (!Wr[0] & Wr[1]) & (Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a16 = (Wr[0] & !Wr[1]) & (!Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a17 = (Wr[0] & !Wr[1]) & (!Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a18 = (Wr[0] & !Wr[1]) & (!Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a19 = (Wr[0] & !Wr[1]) & (!Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a20 = (Wr[0] & !Wr[1]) & (Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a21 = (Wr[0] & !Wr[1]) & (Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a22 = (Wr[0] & !Wr[1]) & (Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a23 = (Wr[0] & !Wr[1]) & (Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a24 = (Wr[0] & Wr[1]) & (!Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a25 = (Wr[0] & Wr[1]) & (!Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a26 = (Wr[0] & Wr[1]) & (!Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a27 = (Wr[0] & Wr[1]) & (!Wr[2] & Wr[3]) & (Wr[4] & En);
	assign a28 = (Wr[0] & Wr[1]) & (Wr[2] & !Wr[3]) & (!Wr[4] & En);
	assign a29 = (Wr[0] & Wr[1]) & (Wr[2] & !Wr[3]) & (Wr[4] & En);
	assign a30 = (Wr[0] & Wr[1]) & (Wr[2] & Wr[3]) & (!Wr[4] & En);
	assign a31 = (Wr[0] & Wr[1]) & (Wr[2] & Wr[3]) & (Wr[4] & En);
	
endmodule