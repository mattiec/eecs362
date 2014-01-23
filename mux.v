module 4to1mux(a,b,c,d,sel,out);
	parameter width = 32;
	input [0:width-1] a,b,c,d;
	input [0:1] sel;

	output [0:width-1] out;

	assign out = (sel == 2'b00) ? a:
		(sel == 2'b01) ? b:
		(sel == 2'b10) ? c:
		(sel == 2'b11) ? d;

endmodule
