module and32 (a, b, andRes); // synopsys template
	parameter width = 32;
	
	input [0:width-1] a, b;
	output [0:width-1] andRes;
	
	assign andRes = a & b;
	
endmodule



module or32  (a, b, orRes); // synopsys template

	parameter width = 32;
	
	input [0:width-1] a, b;
	output [0:width-1] orRes;
	
	assign orRes = a | b;
	
endmodule




module xor32  (a, b, xorRes); // synopsys template

	parameter width = 32;
	
	input [0:width-1] a, b;
	output [0:width-1] xorRes;
	
	assign xorRes = a ^ b;
	
	
endmodule
