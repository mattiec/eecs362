
module fa(a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;

	assign sum = (a ^ b) ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);
	
endmodule

module fa_32bit(a, b_in, cin, sum, cout);
	parameter width = 32;
	
	input [0:width-1] a, b_in;
	input cin;
	
	output [0:width-1] sum;
	output cout;

	wire [0:width-1] b, b_tmp;
	
	wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;
	wire cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23;
	wire cout24, cout25, cout26, cout27, cout28, cout29, cout30;
	
	assign b_tmp = ~b_in;
        mux2to1 mux_sub(b_in, b_tmp, cin, b);

	fa add0(a[0], b[0], cin, sum[0], cout0);
	fa add1(a[1], b[1], cout0, sum[1], cout1);
	fa add2(a[2], b[2], cout1, sum[2], cout2);
	fa add3(a[3], b[3], cout2, sum[3], cout3);
	fa add4(a[4], b[4], cout3, sum[4], cout4);
	fa add5(a[5], b[5], cout4, sum[5], cout5);
	fa add6(a[6], b[6], cout5, sum[6], cout6);
	fa add7(a[7], b[7], cout6, sum[7], cout7);
	fa add8(a[8], b[8], cout7, sum[8], cout8);
	fa add9(a[9], b[9], cout8, sum[9], cout9);
	fa add10(a[10], b[10], cout9, sum[10], cout10);
	fa add11(a[11], b[11], cout10, sum[11], cout11);
	fa add12(a[12], b[12], cout11, sum[12], cout12);
	fa add13(a[13], b[13], cout12, sum[13], cout13);
	fa add14(a[14], b[14], cout13, sum[14], cout14);
	fa add15(a[15], b[15], cout14, sum[15], cout15);
	fa add16(a[16], b[16], cout15, sum[16], cout16);
	fa add17(a[17], b[17], cout16, sum[17], cout17);
	fa add18(a[18], b[18], cout17, sum[18], cout18);
	fa add19(a[19], b[19], cout18, sum[19], cout19);
	fa add20(a[20], b[20], cout19, sum[20], cout20);
	fa add21(a[21], b[21], cout20, sum[21], cout21);
	fa add22(a[22], b[22], cout21, sum[22], cout22);
	fa add23(a[23], b[23], cout22, sum[23], cout23);
	fa add24(a[24], b[24], cout23, sum[24], cout24);
	fa add25(a[25], b[25], cout24, sum[25], cout25);
	fa add26(a[26], b[26], cout25, sum[26], cout26);
	fa add27(a[27], b[27], cout26, sum[27], cout27);
	fa add28(a[28], b[28], cout27, sum[28], cout28);
	fa add29(a[29], b[29], cout28, sum[29], cout29);
	fa add30(a[30], b[30], cout29, sum[30], cout30);
	fa add31(a[31], b[31], cout30, sum[31], cout);
	
endmodule

module seq(a, b_in, set);
	parameter width = 32;
	input [0:width-1] a, b_in;
	wire [0:width-1] out;
	wire cout;
	output reg set;

//if cin is 1 in mux_sub, then it is subtractor

	fa_32bit setEqual(a, b_in, 1, out, cout);
	
//the out of the fa 32 bit is the value we care about. disregard the cout.
	
	always @(out)
begin
	if(out == 32'b0)
		assign set = 1'b1;
	else
		assign set = 1'b0;
end

endmodule
