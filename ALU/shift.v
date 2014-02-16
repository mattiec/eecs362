module shift(a, b, ctrl,out);
        input [0:31] a, b;
        input [0:1] ctrl; //ctrl[1] is arithmetic or logical; ctrl[0] is right or left
	output reg [0:31] out;

	always@(ctrl or a or b)
	begin 
	  if (ctrl[0]==0) //shift left? 
		assign out = a << b;
	  else
		if (ctrl[1]==0)
			assign out = a >> b; //shift right arithmetic
		else
			assign out = a >> b | ~(32'hFFFFFFFF >> b); //shift right logical
	end
endmodule
