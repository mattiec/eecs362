module seq(a,b,set); //ALUCtr = 1000
	parameter width = 32;
	input [0:width-1] a, b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

//if cin is 1 in mux_sub, then it is subtractor

	fa_32bit setEqual(a, b, 1, out, cout);
	
//the out of the fa 32 bit is the value we care about. disregard the cout.
	
	always @(out)
	begin
		if(out == 32'b0)
			assign set = 32'b1;
		else
			assign set = 32'b0;
	end

endmodule

module seq1bit(a,b,set); //ALUCtr = 1000
	parameter width = 32;
	input [0:width-1] a, b;
	wire [0:width-1] out;
	wire cout;
	output reg set;

//if cin is 1 in mux_sub, then it is subtractor

	fa_32bit setEqual(a, b, 1, out, cout);
	
//the out of the fa 32 bit is the value we care about. disregard the cout.
	
	always @(out)
	begin
		if(out == 32'b0)
			assign set = 1'b1;
		else
			assign set = 1'b0;
	end

endmodule

module sne(a,b,set);  //ALUCtr = 1001
	parameter width = 32;
	input [0:width-1] a,b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

	fa_32bit setEqual(a,b,1,out,cout);

	always @(out)
	begin
		if(out == 32'b0)
			assign set = 32'b0;
		else	
			assign set = 32'b1;
	end
endmodule

module sge(a,b,set);  //ALUCtr = 1010
	//set greater than or equal
	parameter width = 32;
	input [0:width-1] a,b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

	fa_32bit setEqual(a,b,1,out,cout);

	always @(out)
	begin
		if(cout == 1'b0)
			assign set = 32'b0;
		else
			assign set = 32'b1;

	end
endmodule

module sle(a,b,set);  //ALUCtr = 1011

	parameter width = 32;
	input [0:width-1] a,b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

	fa_32bit setEqual(a,b,1,out,cout);

	always @(out)
	begin
		if(cout == 1'b0 || out == 32'b0)
			assign set = 32'b1;
		else
			assign set = 32'b0;
	end
endmodule

module sgt(a,b,set);  //ALUCtr = 1100

	parameter width = 32;
	input [0:width-1] a,b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

	fa_32bit setEqual(a,b,1,out,cout);

	always @(out)
	begin
		if(cout == 1'b0 || out == 32'b0)
				assign set = 32'b0;
		else
				assign set = 32'b1;
	end
endmodule

module slt(a,b,set);  //ALUCtr = 1110

	parameter width = 32;
	input [0:width-1] a,b;
	wire [0:width-1] out;
	wire cout;
	output reg [31:0] set;

	fa_32bit setEqual(a,b,1,out,cout);

	always @(out)
	begin
		if(cout == 1'b0)
				assign set = 32'b1;
		else
				assign set = 32'b0;
	end
endmodule
