
module shift(a, b, ctrl,out);
        input [0:31] a, b;
        input [0:1] ctrl; //ctrl[1] is arithmetic or logical; ctrl[0] is right or left
	output [0:31] out;


	wire [0:31] ltmp0, ltmp1, ltmp2, ltmp3, ltmp4;
	wire [0:31] lout1, lout2, lout3, lout4, lout5;

	wire [0:31] rtmp0, rtmp1, rtmp2, rtmp3, rtmp4;
	wire [0:31] rout1, rout2, rout3, rout4, rout5;

	wire [0:15] log_or_arith;
	wire log;

	//shift left if ctrl[0] == 1		
	assign ltmp0 = {a[16:31],16'h0000};
	mux2to1 shift_left1(a, ltmp0, b[27], lout1);

	assign ltmp1 = {lout1[8:31], 8'h00};
	mux2to1 shift_left2(lout1, ltmp1, b[28], lout2);

	assign ltmp2 = {lout2[4:31], 4'h0};
	mux2to1 shift_left3(lout2, ltmp2, b[29], lout3);

	assign ltmp3 = {lout3[2:31], 2'b00};
	mux2to1 shift_left4(lout3, ltmp3, b[30], lout4);

	assign ltmp4 = {lout4[1:31], 1'b0};
	mux2to1 shift_left5(lout4, ltmp4, b[31], lout5);


	//shift right 
	assign log = (1'b0  & !ctrl[1]) | (a[0] & ctrl[1]);	
	assign log_or_arith = {log, log, log, log, log, log, log, log, log, log, log, log, log, log, log, log};

	assign rtmp0 = {log_or_arith,a[0:15]}; 
	mux2to1 shift_right1(a, rtmp0, b[27], rout1);

	assign rtmp1 = {log_or_arith[0:7], rout1[0:23]};
	mux2to1 shift_right2(rout1, rtmp1, b[28], rout2);

	assign rtmp2 = {log_or_arith[0:3], rout2[0:27]};
	mux2to1 shift_right3(rout2, rtmp2, b[29], rout3);

	assign rtmp3 = {log_or_arith[0:1], rout3[0:29]};
	mux2to1 shift_right4(rout3, rtmp3, b[30], rout4);

	assign rtmp4 = {log_or_arith[0], rout4[0:30]};
	mux2to1 shift_right5(rout4, rtmp4, b[31], rout5);


	mux2to1 outMux(lout5, rout5, ctrl[0], out);


	//  else begin
	//	if (ctrl[1]==0) begin
			//assign out = a >> b; //shift right arithmetic
	//	end else begin
			//assign out = a >> b | ~(32'hFFFFFFFF >> b); //shift right logical
	//	end
	//  end
endmodule
