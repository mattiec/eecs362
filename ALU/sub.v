
module sub(a, b, cin, dif, cout);
	input a, b, cin;
	output dif, cout;

	assign dif = (a ^ b) ^ cin;
	assign cout = (a&b)^(cin&(a^b));
	
endmodule

module sub_32bit(a, b, cin, dif, cout);
	parameter width = 32;
	
	input [0:width-1] a, b;
	input cin;
	
	output [0:width-1] dif;
	output cout;
	
	wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;
	wire cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23;
	wire cout24, cout25, cout26, cout27, cout28, cout29, cout30;
	
	sub sub31(a[31], b[31], cin, dif[31], cout0);
	sub sub30(a[30], b[30], cout0, dif[30], cout1);
	sub sub29(a[29], b[29], cout1, dif[29], cout2);
	sub sub28(a[28], b[28], cout2, dif[28], cout3);
	sub sub27(a[27], b[27], cout3, dif[27], cout4);
	sub sub26(a[26], b[26], cout4, dif[26], cout5);
	sub sub25(a[25], b[25], cout5, dif[25], cout6);
	sub sub24(a[24], b[24], cout6, dif[24], cout7);
	sub sub23(a[23], b[23], cout7, dif[23], cout8);
	sub sub22(a[22], b[22], cout8, dif[22], cout9);
	sub sub21(a[21], b[21], cout9, dif[21], cout10);
	sub sub20(a[20], b[20], cout10, dif[20], cout11);
	sub sub19(a[19], b[19], cout11, dif[19], cout12);
	sub sub18(a[18], b[18], cout12, dif[18], cout13);
	sub sub17(a[17], b[17], cout13, dif[17], cout14);
	sub sub16(a[16], b[16], cout14, dif[16], cout15);
	sub sub15(a[15], b[15], cout15, dif[15], cout16);
	sub sub14(a[14], b[14], cout16, dif[14], cout17);
	sub sub13(a[13], b[13], cout17, dif[13], cout18);
	sub sub12(a[12], b[12], cout18, dif[12], cout19);
	sub sub11(a[11], b[11], cout19, dif[11], cout20);
	sub sub10(a[10], b[10], cout20, dif[10], cout21);
	sub sub9(a[9], b[9], cout21, dif[9], cout22);
	sub sub8(a[8], b[8], cout22, dif[8], cout23);
	sub sub7(a[7], b[7], cout23, dif[7], cout24);
	sub sub6(a[6], b[6], cout24, dif[6], cout25);
	sub sub5(a[5], b[5], cout25, dif[5], cout26);
	sub sub4(a[4], b[4], cout26, dif[4], cout27);
	sub sub3(a[3], b[3], cout27, dif[3], cout28);
	sub sub2(a[2], b[2], cout28, dif[2], cout29);
	sub sub1(a[1], b[1], cout29, dif[1], cout30);
	sub sub0(a[0], b[0], cout30, dif[0], cout);
	

endmodule
