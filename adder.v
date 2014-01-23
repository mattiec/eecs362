
module fa(a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;

	assign sum = (a ^ b) ^ cin;
	assign cout = (a&b)^(cin&(a^b));
	
endmodule

module fa_32bit(a, b, cin, sum, cout);
	parameter width = 32;
	
	input [0:width-1] a, b;
	input cin;
	
	output [0:width-1] sum;
	output cout;
	
	wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;
	wire cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23;
	wire cout24, cout25, cout26, cout27, cout28, cout29, cout30;
	
	fa add31(a[31], b[31], cin, sum[31], cout0);
	fa add30(a[30], b[30], cout0, sum[30], cout1);
	fa add29(a[29], b[29], cout1, sum[29], cout2);
	fa add28(a[28], b[28], cout2, sum[28], cout3);
	fa add27(a[27], b[27], cout3, sum[27], cout4);
	fa add26(a[26], b[26], cout4, sum[26], cout5);
	fa add25(a[25], b[25], cout5, sum[25], cout6);
	fa add24(a[24], b[24], cout6, sum[24], cout7);
	fa add23(a[23], b[23], cout7, sum[23], cout8);
	fa add22(a[22], b[22], cout8, sum[22], cout9);
	fa add21(a[21], b[21], cout9, sum[21], cout10);
	fa add20(a[20], b[20], cout10, sum[20], cout11);
	fa add19(a[19], b[19], cout11, sum[19], cout12);
	fa add18(a[18], b[18], cout12, sum[18], cout13);
	fa add17(a[17], b[17], cout13, sum[17], cout14);
	fa add16(a[16], b[16], cout14, sum[16], cout15);
	fa add15(a[15], b[15], cout15, sum[15], cout16);
	fa add14(a[14], b[14], cout16, sum[14], cout17);
	fa add13(a[13], b[13], cout17, sum[13], cout18);
	fa add12(a[12], b[12], cout18, sum[12], cout19);
	fa add11(a[11], b[11], cout19, sum[11], cout20);
	fa add10(a[10], b[10], cout20, sum[10], cout21);
	fa add9(a[9], b[9], cout21, sum[9], cout22);
	fa add8(a[8], b[8], cout22, sum[8], cout23);
	fa add7(a[7], b[7], cout23, sum[7], cout24);
	fa add6(a[6], b[6], cout24, sum[6], cout25);
	fa add5(a[5], b[5], cout25, sum[5], cout26);
	fa add4(a[4], b[4], cout26, sum[4], cout27);
	fa add3(a[3], b[3], cout27, sum[3], cout28);
	fa add2(a[2], b[2], cout28, sum[2], cout29);
	fa add1(a[1], b[1], cout29, sum[1], cout30);
	fa add0(a[0], b[0], cout30, sum[0], cout);
	

endmodule
