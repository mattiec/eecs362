
module alu (a, b, ALUCtrl, out);
        parameter width = 32;

        input [0:width-1] a, b;
	input [0:3] ALUCtrl;
        output [0:width-1] out;

	wire [0:width-1] adder_out, and_out, mult_out, or_out, shift_out, xor_out;
	wire [0:width-1] tmp0, tmp1;

	wire cout;

	assign tmp0 = 32'h0;
	assign tmp1 = 32'h0;

	fa_32bit adder (a, b, ALUCtrl[0],adder_out, cout); //ALUCtrl[0] is cin, so 1 is subtract and 0 is addition 

	and32 and1(a,b,and_out);
	or32 or1(a,b,or_out);
	xor32 xor1(a,b,xor_out);
	
	mult32bit mult1(a,b,mult_out);
	shift shift1(a,b,ALUCtrl[1:2],shift_out);

	mux8to1 out_mux(and_out, or_out, xor_out, mult_out, shift_out, adder_out, tmp0, tmp1, ALUCtrl[1:3],out);


endmodule
