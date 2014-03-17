module hazardDetect (reg_dst, Rs, Rt, opcode, squash); 
	input [0:4] reg_dst, Rs, Rt;
	input [0:5] opcode;
	output squash;

	wire compare1, compare2, Rt_enabled; 

	assign compare1 = (reg_dst[0] ~^ Rs[0]) & (reg_dst[1] ~^ Rs[1]) & (reg_dst[2] ~^ Rs[2]) & (reg_dst[3] ~^ Rs[3]) & (reg_dst[4] ~^ Rs[4]);	
	assign compare2 = (reg_dst[0] ~^ Rt[0]) & (reg_dst[1] ~^ Rt[1]) & (reg_dst[2] ~^ Rt[2]) & (reg_dst[3] ~^ Rt[3]) & (reg_dst[4] ~^ Rt[4]);

	assign Rt_enabled = compare2 & ~opcode[0] & ~opcode[1] & ~opcode[2] & ~opcode[3] & ~opcode[4] & ~opcode[5]; 
	
	assign squash = compare1 | Rt_enabled;

endmodule 
