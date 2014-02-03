module instrfetch(PC,PCnext,PCsel,addroff);
	input PC,PCsel,addroff;
	output PCnext;
	reg [0:31] P1,P2;

always@(posedge clock)
	begin
	 P1<=PC+'100';
	 P2<=P1+addroff;
	 PCnext<=(PCsel==0)? P1:P2;
	end
endmodule

