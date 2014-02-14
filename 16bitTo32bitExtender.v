//module extender (
// input signed [15:0] a,
// output signed [31:0] out);
 
// assign out = a; // sign-extends
 
// endmodule



module extender(a,sign,out);
	input [15:0] a;
	input sign; //0 means unsigned, 1 means signed
	output reg [31:0] out;

	//begin
	always @* begin	
		if(sign == 0) begin //unsigned
			out = {16'h0000,a};
		end else begin //signed
		//else	
			if (a[15]==1) begin
				out = {16'hFFFF,a};
			end else begin
				out = a;
			end
		end
	end
endmodule
