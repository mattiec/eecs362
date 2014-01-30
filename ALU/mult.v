module fa(a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;

	assign sum = (a ^ b) ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);	
endmodule

module mult8bit(a, b, prod);
	parameter width = 8;
	
	input [width-1:0] a, b;
	
	output [width-1:0] prod;

	wire b00, b01, b02, b03, b04, b05, b06, b07;
	wire c00, c01, c02, c03, c04, c05, c06, c07;
	wire s01, s02, s03, s04, s05, s06, s07;
	
	fa add00(0, a[0]&b[0], 0, prod[0], c00);
	fa add01(0, a[1]&b[0], c00, s01, c01);
	fa add02(0, a[2]&b[0], c01, s02, c02);
	fa add03(0, a[3]&b[0], c02, s03, c03);
	fa add04(0, a[4]&b[0], c03, s04, c04);
	fa add05(0, a[5]&b[0], c04, s05, c05);
	fa add06(0, a[6]&b[0], c05, s06, c06);
	fa add07(0, a[7]&b[0], c06, s07, c07);

	wire b10, b11, b12, b13, b14, b15, b16, b17;
	wire c10, c11, c12, c13, c14, c15, c16, c17;
	wire s11, s12, s13, s14, s15, s16, s17;
	
	fa add10(s01, a[0]&b[1], 0, prod[1], c10);
	fa add11(s02, a[1]&b[1], c10, s11, c11);
	fa add12(s03, a[2]&b[1], c11, s12, c12);
	fa add13(s04, a[3]&b[1], c12, s13, c13);
	fa add10(s05, a[4]&b[1], c13, s14, c14);
	fa add11(s06, a[5]&b[1], c14, s15, c15);
	fa add12(s07, a[6]&b[1], c15, s16, c16);
	fa add13(0, a[7]&b[1], c16, s17, c17);


	wire b20, b21, b22, b23, b24, b25, b26, b27;
	wire c20, c21, c22, c23, c24, c25, c26, c27;
	wire s21, s22, s23, s24, s25, s26, s27;
	
	fa add20(s11, a[0]&b[2], 0, prod[2], c20);
	fa add21(s12, a[1]&b[2], c20, s21, c21);
	fa add22(s13, a[2]&b[2], c21, s22, c22);
	fa add23(s14, a[3]&b[2], c22, s23, c23);
	fa add20(s15, a[4]&b[2], c23, s24, c24);
	fa add21(s16, a[5]&b[2], c24, s25, c25);
	fa add22(s17, a[6]&b[2], c25, s26, c26);
	fa add23(0, a[7]&b[2], c26, s27, c27);


	wire b30, b31, b32, b33, b34, b35, b36, b37;
	wire c30, c31, c32, c33, c34, c35, c36, c37;
	wire s31, s32, s33, s34, s35, s36, s37;
	
	fa add30(s21, a[0]&b[3], 0, prod[3], c30);
	fa add31(s22, a[1]&b[3], c30, s31, c31);
	fa add32(s23, a[2]&b[3], c31, s32, c32);
	fa add33(s24, a[3]&b[3], c32, s33, c33);
	fa add30(s25, a[4]&b[3], c33, s34, c34);
	fa add31(s26, a[5]&b[3], c34, s35, c35);
	fa add32(s27, a[6]&b[3], c35, s36, c36);
	fa add33(0, a[7]&b[3], c36, s37, c37);


	wire b40, b41, b42, b43, b44, b45, b46, b47;
	wire c40, c41, c42, c43, c44, c45, c46, c47;
	wire s41, s42, s43, s44, s45, s46, s47;
	
	fa add40(s01, a[0]&b[1], 0, prod[1], c10);
	fa add41(s02, a[1]&b[1], c10, s11, c11);
	fa add42(s03, a[2]&b[1], c11, s12, c12);
	fa add43(s04, a[3]&b[1], c12, s13, c13);
	fa add40(s05, a[4]&b[1], c13, s14, c14);
	fa add41(s06, a[5]&b[1], c14, s15, c15);
	fa add42(s07, a[6]&b[1], c15, s16, c16);
	fa add43(0, a[7]&b[1], c16, s17, c17);


	wire b50, b11, b12, b13, b14, b15, b16, b17;
	wire c50, c11, c12, c13, c14, c15, c16, c17;
	wire s51, s12, s13, s14, s15, s16, s17;
	
	fa add50(s01, a[0]&b[1], 0, prod[1], c10);
	fa add51(s02, a[1]&b[1], c10, s11, c11);
	fa add52(s03, a[2]&b[1], c11, s12, c12);
	fa add53(s04, a[3]&b[1], c12, s13, c13);
	fa add50(s05, a[4]&b[1], c13, s14, c14);
	fa add51(s06, a[5]&b[1], c14, s15, c15);
	fa add52(s07, a[6]&b[1], c15, s16, c16);
	fa add53(0, a[7]&b[1], c16, s17, c17);


	wire b60, b11, b12, b13, b14, b15, b16, b17;
	wire c60, c11, c12, c13, c14, c15, c16, c17;
	wire s61, s12, s13, s14, s15, s16, s17;
	
	fa add60(s01, a[0]&b[1], 0, prod[1], c10);
	fa add61(s02, a[1]&b[1], c10, s11, c11);
	fa add62(s03, a[2]&b[1], c11, s12, c12);
	fa add63(s04, a[3]&b[1], c12, s13, c13);
	fa add60(s05, a[4]&b[1], c13, s14, c14);
	fa add61(s06, a[5]&b[1], c14, s15, c15);
	fa add62(s07, a[6]&b[1], c15, s16, c16);
	fa add63(0, a[7]&b[1], c16, s17, c17);


	wire b70, b11, b12, b13, b14, b15, b16, b17;
	wire c70, c11, c12, c13, c14, c15, c16, c17;
	wire s71, s12, s13, s14, s15, s16, s17;
	
	fa add70(s01, a[0]&b[1], 0, prod[1], c10);
	fa add71(s02, a[1]&b[1], c10, s11, c11);
	fa add72(s03, a[2]&b[1], c11, s12, c12);
	fa add73(s04, a[3]&b[1], c12, s13, c13);
	fa add70(s05, a[4]&b[1], c13, s14, c14);
	fa add71(s06, a[5]&b[1], c14, s15, c15);
	fa add72(s07, a[6]&b[1], c15, s16, c16);
	fa add73(0, a[7]&b[1], c16, s17, c17);

endmodule