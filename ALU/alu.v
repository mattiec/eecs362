
module alu(a, b, ALUCtrl, out, zero_signal);
    parameter width = 32;

    input [0:width-1] a, b;
	input [0:3] ALUCtrl;
    output [0:width-1] out;
	output zero_signal;

	wire [0:width-1] adder_out, sub_out, and_out, mult_out, or_out, xor_out;
	wire [0:width-1] tmp0110, tmp0111, tmp1101, tmp1111;
	wire [0:width-1] SEQ, SNE, SGE, SLE, SGT, SLT;

	wire [0:width-1] shift_left, shift_right_arith, shift_right_logic;

	wire cout;

	assign tmp0110 = 32'h0;
	assign tmp0111 = 32'h0;
	assign tmp1101 = 32'h0;
	assign tmp1111 = 32'h0;

	fa_32bit adder (a, b, ALUCtrl[0],adder_out, cout); //ALUCtrl[0] is cin, so 1 is subtract and 0 is addition 
	assign sub_out = adder_out;

	and32 and1(a,b,and_out);
	or32 or1(a,b,or_out);
	xor32 xor1(a,b,xor_out);
	
	mult32bit mult1(a,b,mult_out);
	shift shift1(a,b,ALUCtrl[2:3],shift_left);
	assign shift_right_arith = shift_left;
	assign shift_right_logic = shift_left;
	
	seq seq1(a,b,SEQ); //SEL = 1000
	sne sne1(a,b,SNE); //SEL = 1001
	sge sge1(a,b,SGE); //SEL = 1010
	sle sle1(a,b,SLE); //SEL = 1011
	sgt sgt1(a,b,SGT); //SEL = 1100
	slt slt1(a,b,SLT); //SEL = 1110

	mux16to1 out_mux(and_out, or_out, xor_out, mult_out, shift_left, adder_out, shift_right_arith, shift_right_logic, SEQ, SNE, SGE, SLE, SGT, sub_out, SLT, tmp1111, ALUCtrl,out);

	assign zero_signal = ~(out[0] | out[1] | out[2] | out[3] | out[4] | out[5] | out[6] | out[7] | out[8] | out[9] | out[10] | out[11] | out[12] | out[13] | out[14] | out[15] | out[16] | out[17] | out[18] | out[19] | out[20] | out[21] | out[22] | out[23] | out[24] | out[25] | out[26] | out[27] | out[28] | out[29] | out[30] | out[31]);


endmodule
