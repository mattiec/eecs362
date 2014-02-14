module instrfetch(mux0,mux1,muxSelect,adderSum,imemOut);
        parameter width = 30;
	input [0:width-1] mux0,mux1;
	input muxSelect;
        output [0:31] imemOut;
	reg [0:width-1] programCounter;
	output [0:width-1] adderSum;
	wire adderCout;
	wire [0:31] PCoutExtend; 
        wire [0:width-1] PCin;
	
	//always@(*)
	//mux1 takes the input from the 4th step of the 5 step cycle
	//mux0 takes value from ex/mem step
	mux2to1edit muxInit(mux0,mux1,muxSelect,PCin);
        //this is 30 bits 
	//programCounter = PCin;

	//adderCout is not necessary
	//fa_30bit add(programCounter, 30'h0004, 1, adderSum, adderCout); 
	
	fa_30bit add(PCin, 30'h0004, 0, adderSum, adderCout);

	//assign PCoutExtend = programCounter;	
	assign PCoutExtend = PCin;

	imem instrMemory(PCoutExtend,imemOut);
	//end
endmodule

module fa_30bit(a, b_in, cin, sum, cout);
        parameter width = 30;

        input [0:width-1] a, b_in;
        input cin;

        output [0:width-1] sum;
        output cout;

        wire [0:width-1] b, b_tmp;

        wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7;
        wire cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
        wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23;
        wire cout24, cout25, cout26, cout27, cout28, cout29;

        assign b_tmp = ~b_in;
        mux2to1edit mux_sub(b_in, b_tmp, cin, b);

        fa add0(a[0], b[0], cin, sum[0], cout0);
        fa add1(a[1], b[1], cout0, sum[1], cout1);
        fa add2(a[2], b[2], cout1, sum[2], cout2);
        fa add3(a[3], b[3], cout2, sum[3], cout3);
        fa add4(a[4], b[4], cout3, sum[4], cout4);
        fa add5(a[5], b[5], cout4, sum[5], cout5);
        fa add6(a[6], b[6], cout5, sum[6], cout6);
        fa add7(a[7], b[7], cout6, sum[7], cout7);
        fa add8(a[8], b[8], cout7, sum[8], cout8);
        fa add9(a[9], b[9], cout8, sum[9], cout9);
        fa add10(a[10], b[10], cout9, sum[10], cout10);
        fa add11(a[11], b[11], cout10, sum[11], cout11);
        fa add12(a[12], b[12], cout11, sum[12], cout12);
        fa add13(a[13], b[13], cout12, sum[13], cout13);
        fa add14(a[14], b[14], cout13, sum[14], cout14);
        fa add15(a[15], b[15], cout14, sum[15], cout15);
        fa add16(a[16], b[16], cout15, sum[16], cout16);
	fa add17(a[17], b[17], cout16, sum[17], cout17);
        fa add18(a[18], b[18], cout17, sum[18], cout18);
        fa add19(a[19], b[19], cout18, sum[19], cout19);
        fa add20(a[20], b[20], cout19, sum[20], cout20);
        fa add21(a[21], b[21], cout20, sum[21], cout21);
        fa add22(a[22], b[22], cout21, sum[22], cout22);
        fa add23(a[23], b[23], cout22, sum[23], cout23);
        fa add24(a[24], b[24], cout23, sum[24], cout24);
        fa add25(a[25], b[25], cout24, sum[25], cout25);
        fa add26(a[26], b[26], cout25, sum[26], cout26);
        fa add27(a[27], b[27], cout26, sum[27], cout27);
        fa add28(a[28], b[28], cout27, sum[28], cout28);
        fa add29(a[29], b[29], cout28, sum[29], cout);

endmodule

module fa(a, b, cin, sum, cout);
        input a, b, cin;
        output sum, cout;

        assign sum = (a ^ b) ^ cin;
        
        assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module imem(addr, instr);
    parameter SIZE=4096;
    parameter OFFSET=0;

    input [0:31] addr;
    output [0:31] instr;
    reg [0:7] mem[0:(SIZE-1)];

    wire [0:31] phys_addr;

    assign phys_addr = addr - OFFSET;
    assign instr = {mem[phys_addr],mem[phys_addr+1],mem[phys_addr+2],mem[phys_addr+3]};
endmodule // imem

module mux2to1edit(a,b,sel,out);
        parameter width = 30;
        input [width-1:0] a,b;
        input sel;

        output [width-1:0] out;

	assign out[0] = (a[0] & !sel) | (b[0] & sel);
        assign out[1] = (a[1] & !sel) | (b[1] & sel);
        assign out[2] = (a[2] & !sel) | (b[2] & sel);     
        assign out[3] = (a[3] & !sel) | (b[3] & sel);
        assign out[4] = (a[4] & !sel) | (b[4] & sel);
        assign out[5] = (a[5] & !sel) | (b[5] & sel);
        assign out[6] = (a[6] & !sel) | (b[6] & sel);
        assign out[7] = (a[7] & !sel) | (b[7] & sel);
        assign out[8] = (a[8] & !sel) | (b[8] & sel);
        assign out[9] = (a[9] & !sel) | (b[9] & sel);
        assign out[10] = (a[10] & !sel) | (b[10] & sel);
        assign out[11] = (a[11] & !sel) | (b[11] & sel);
        assign out[12] = (a[12] & !sel) | (b[12] & sel);
        assign out[13] = (a[13] & !sel) | (b[13] & sel);
        assign out[14] = (a[14] & !sel) | (b[14] & sel);
        assign out[15] = (a[15] & !sel) | (b[15] & sel);
        assign out[16] = (a[16] & !sel) | (b[16] & sel);
        assign out[17] = (a[17] & !sel) | (b[17] & sel);
        assign out[18] = (a[18] & !sel) | (b[18] & sel);
        assign out[19] = (a[19] & !sel) | (b[19] & sel);
        assign out[20] = (a[20] & !sel) | (b[20] & sel);
        assign out[21] = (a[21] & !sel) | (b[21] & sel);
        assign out[22] = (a[22] & !sel) | (b[22] & sel);
        assign out[23] = (a[23] & !sel) | (b[23] & sel);
        assign out[24] = (a[24] & !sel) | (b[24] & sel);
        assign out[25] = (a[25] & !sel) | (b[25] & sel);
        assign out[26] = (a[26] & !sel) | (b[26] & sel);
        assign out[27] = (a[27] & !sel) | (b[27] & sel);
        assign out[28] = (a[28] & !sel) | (b[28] & sel);
        assign out[29] = (a[29] & !sel) | (b[29] & sel);

endmodule

