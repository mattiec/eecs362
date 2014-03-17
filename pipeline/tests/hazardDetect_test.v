module hazardDetect_test;
	reg [0:4] reg_dst, rs, rt;
	reg [0:5] op;
	wire squash;

	hazardDetect hD_test(reg_dst, rs, rt, op, squash);

	initial begin
	 $monitor("reg_Dst = %d rs = %d rt = %d op = %d squash=%b compare2=%b", reg_dst, rs, rt, op, squash, hD_test.compare2);
	
	#0 reg_dst = 5'b00000; rs = 5'b00000; rt = 5'b01010; op = 6'b010101; 
	#1 reg_dst = 5'b00100; rs = 5'b00000; rt = 5'b00100; op = 6'b000000;
	#1 reg_dst = 5'b11111; rs = 5'b00000; rt = 5'b00000; op = 6'b010101;	
	#1 reg_dst = 5'b11111; rs = 5'b00000; rt = 5'b11111; op = 6'b010101;

	end
endmodule
