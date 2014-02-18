module mux2to1(a,b,sel,out);
	parameter width = 32;
	input [0:width-1] a,b;
	input sel;

	output [0:width-1] out;

	assign out[0] = (a[0] & !sel) | (b[0] & sel);
	assign out[1] = (a[1] & !sel) | (b[1] & sel);
	assign out[2] = (a[2] & !sel) | (b[2] & sel);
	assign out[3] = (a[3] & !sel) | (b[3] & sel);
	assign out[4] = (a[4] & !sel) | (b[4] & sel);
	assign out[5] = (a[5] & !sel) | (b[5] & sel);
	assign out[6] = (a[6] & !sel) | (b[6] & sel);
	assign out[7] = (a[7] & !sel) | (b[7] & sel);
	assign out[8] = (a[8] & !sel) | (b[8] & sel);
	assign out[9] = (a[9] & !sel) | (b[9] & sel);
	assign out[10] = (a[10] & !sel) | (b[10] & sel);
	assign out[11] = (a[11] & !sel) | (b[11] & sel);
	assign out[12] = (a[12] & !sel) | (b[12] & sel);
	assign out[13] = (a[13] & !sel) | (b[13] & sel);
	assign out[14] = (a[14] & !sel) | (b[14] & sel);
	assign out[15] = (a[15] & !sel) | (b[15] & sel);
	assign out[16] = (a[16] & !sel) | (b[16] & sel);
	assign out[17] = (a[17] & !sel) | (b[17] & sel);
	assign out[18] = (a[18] & !sel) | (b[18] & sel);
	assign out[19] = (a[19] & !sel) | (b[19] & sel);
	assign out[20] = (a[20] & !sel) | (b[20] & sel);
	assign out[21] = (a[21] & !sel) | (b[21] & sel);
	assign out[22] = (a[22] & !sel) | (b[22] & sel);
	assign out[23] = (a[23] & !sel) | (b[23] & sel);
	assign out[24] = (a[24] & !sel) | (b[24] & sel);
	assign out[25] = (a[25] & !sel) | (b[25] & sel);
	assign out[26] = (a[26] & !sel) | (b[26] & sel);
	assign out[27] = (a[27] & !sel) | (b[27] & sel);
	assign out[28] = (a[28] & !sel) | (b[28] & sel);
	assign out[29] = (a[29] & !sel) | (b[29] & sel);
	assign out[30] = (a[30] & !sel) | (b[30] & sel);
	assign out[31] = (a[31] & !sel) | (b[31] & sel);
	
endmodule

module mux2to1_5bits(a,b,sel,out); 
parameter width = 5;
        input [0:width-1] a,b;
        input sel;

        output [0:width-1] out;

        assign out[0] = (a[0] & !sel) | (b[0] & sel);
        assign out[1] = (a[1] & !sel) | (b[1] & sel);
        assign out[2] = (a[2] & !sel) | (b[2] & sel);
        assign out[3] = (a[3] & !sel) | (b[3] & sel);
        assign out[4] = (a[4] & !sel) | (b[4] & sel);
endmodule

module mux4to1(a,b,c,d,sel,out);
	parameter width = 32;
	input [width-1:0] a,b,c,d;
	input [1:0] sel;
	
	wire [width-1:0] i0, i1;

	output [width-1:0] out;

	mux2to1 iomux (a, b, sel[0], i0);
	mux2to1 i1mux (c, d, sel[0], i1);
	
	mux2to1 outmux(i0, i1, sel[1], out);

endmodule

module mux8to1(a,b,c,d,e,f,g,h,sel,out);
	parameter width = 32;
	input [width-1:0] a,b,c,d,e,f,g,h;
	input [2:0] sel;

	wire [width-1:0] i0, i1, i2, i3;
	
	output [width-1:0] out;

	mux2to1 i0mux (a, b, sel[0], i0);
	mux2to1 i1mux (c, d, sel[0], i1);
	mux2to1 i2mux (e, f, sel[0], i2);
	mux2to1 i3mux (g, h, sel[0], i3);
	
	mux4to1 outmux (i0, i1, i2, i3, sel[2:1], out);
	
endmodule


module mux16to1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,sel,out);
	parameter width = 32;
	input [width-1:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
	input [3:0] sel;

	wire [width-1:0] i0, i1;

	output [width-1:0] out;

	mux8to1 iomux (a0,a1,a2,a3,a4,a5,a6,a7, sel[2:0], i0);
	mux8to1 i1mux (a8,a9,a10,a11,a12,a13,a14,a15, sel[2:0], i1);

	mux2to1 outmux(i0, i1, sel[3], out);

endmodule

module mux32to1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,sel,out);
	parameter width = 32;
	input [width-1:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
	input [width-1:0] a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31;
	input [4:0] sel;

	wire [width-1:0] i0, i1, i2, i3;
	wire [2:0] nsel;
	
	output [width-1:0] out;

	mux8to1 i0mux (a0,a1,a2,a3,a4,a5,a6,a7, sel[2:0], i0);
	mux8to1 i1mux (a8,a9,a10,a11,a12,a13,a14,a15, sel[2:0], i1);
	mux8to1 i2mux (a16,a17,a18,a19,a20,a21,a22,a23, sel[2:0], i2);
	mux8to1 i3mux (a24,a25,a26,a27,a28,a29,a30,a31, sel[2:0], i3);
	
	assign nsel[2] = 0;
	assign nsel[1:0] = sel[4:3];
	mux8to1 outmux (i0, i1, i2, i3, 0, 0, 0, 0, nsel, out);
	
endmodule
