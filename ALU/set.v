module seq(out_zero,set); // synopsys template 
//ALUCtr = 1000
	input  out_zero;
	output reg [31:0] set;

	always @(out_zero)
	begin
		if(out_zero == 1'b0)
			set = 32'b1;
		else
			set = 32'b0;
	end

endmodule

module seq1bit(a,b,set); // synopsys template  
//ALUCtr = 1000
	parameter width = 32;
	input [0:width-1] a, b;
	wire [0:width-1] out;
	wire cout;
	output reg set;

//if cin is 1 in mux_sub, then it is subtractor

	fa_32bit setEqual(a, b, 1'b1, out, cout);
	
//the out of the fa 32 bit is the value we care about. disregard the cout.
	
	always @(out)
	begin
		if(out == 32'b0)
			set = 1'b1;
		else
			set = 1'b0;
	end

endmodule

module sne(out_zero,set);  // synopsys template 
//ALUCtr = 1001
	input out_zero;
	output reg [31:0] set;

	always @(out_zero)
	begin
		if(out_zero == 32'b0)
			set = 32'b0;
		else	
			set = 32'b1;
	end
endmodule

module sge(cout,set);  // synopsys template
 //ALUCtr = 1010
	//set greater than or equal

	input cout;
	output reg [31:0] set;

	always @(cout)
	begin
		if(cout == 1'b0)
			set = 32'b0;
		else
			set = 32'b1;

	end
endmodule

module sle(out_zero, cout,set); // synopsys template   
//ALUCtr = 1011

	input  out_zero;
	input cout;
	output reg [31:0] set;

	always @(out_zero or cout)
	begin
		if(cout == 1'b0 || out_zero == 1'b0)
			set = 32'b1;
		else
			set = 32'b0;
	end
endmodule

module sgt(out_zero, cout, set); // synopsys template
  //ALUCtr = 1100

	input out_zero;
	input cout;
	output reg [31:0] set;

	always @(out_zero or cout)
	begin
		if(cout == 1'b0 || out_zero == 1'b0)
				set = 32'b0;
		else
				set = 32'b1;
	end
endmodule

module slt(cout, set);  // synopsys template
//ALUCtr = 1110

	input cout;
	output reg [31:0] set;

	always @(cout)
	begin
		if(cout == 1'b0)
			set = 32'b1;
		else
			set = 32'b0;
	end
endmodule
