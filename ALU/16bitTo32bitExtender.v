//module extender(a,out);
//	input [0:15] a;
//	output [0:31] out;

	module extender (
input signed [15:0] a,
output signed [31:0] out);

assign out = a; // sign-extends

endmodule



//	always@(a)
//	begin
//		if(a[15] == 1'b1)
//			assign out = (16'hFFFF,a);
//		end
//	end

//	always@(a);
//	begin
//	out <= $signed(a);
	
//		if(in[15] === 1'bX) begin
//			out = {16'hXXXX,a};
//		end else begin
//			out = {16'h000,in};
//		end
//	end
//endmodule	
