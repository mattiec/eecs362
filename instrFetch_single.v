module instrFetch(branchEqual,branchNE,jumpInput,jump,jump2,JALcheck,zero,branchInstruction,jumpInstruction,clock,reset,imemOut,PCoutput);
parameter width = 30;
input branchEqual,branchNE,jump,jump2,JALcheck,clock,zero,reset;
input [0:23] jumpInstruction;
input [0:15] branchInstruction;
input [0:29] jumpInput;
output [0:31] imemOut;
output [0:31] PCoutput;

reg[0:29] regFile;

wire [0:15] immediateExtension;
wire [0:29] immediate26;
wire [0:29] PCin; //= 30'h0000;

wire [0:31] imemAddr;
wire andBranch;
wire [0:29] extendedImmediate;
wire [0:29] branchMUXout;
wire [0:29] jumpMUXout;
wire [0:29] jumpMUXoutFinal;
wire [0:29] nextPC;
wire [0:29] nextPCout;
wire [0:29] secondValue;
wire cout2;
wire cout1;
wire [0:29] oneExtended;
wire [0:29] twoExtended;
wire [0:29] addValue;
wire [0:29] PCout;
wire [0:29] finalJumpOut;


PipeReg programCounter(PCout,PCin,clock,reset);

assign oneExtended[29] = 1;
assign oneExtended[0:28]=29'b0000;

assign twoExtended = 30'h00000002;

mux2to130bit JALmux(oneExtended,twoExtended,JALcheck,addValue);

fa_30bit add1(PCout,addValue,0,nextPC,cout2);

assign PCoutput[0:29] = nextPC[0:29];
assign PCoutput[30] = 0;
assign PCoutput[31] = 0;

assign immediateExtension[0:15] = branchInstruction[0:15];

bitExtension signExtend(immediateExtension,extendedImmediate);


fa_30bit add2(extendedImmediate,nextPC,0,nextPCout,cout1);

assign andBranch = (branchEqual & zero) | (branchNE & ~zero);

mux2to130bit branchMUX(nextPC,nextPCout,andBranch,branchMUXout);

assign immediate26[6:29] = jumpInstruction[0:23];
assign immediate26[0:5] = PCout[0:5];

mux2to130bit jumpMUX(branchMUXout,immediate26,jump,jumpMUXout);

mux2to130bit jumpMUX2(jumpMUXout,jumpInput,jump2,jumpMUXoutFinal);

assign PCin[0:29]=jumpMUXoutFinal[0:29];

assign imemAddr[31] = 0;
assign imemAddr[30] = 0;
assign imemAddr[0:29] = PCout[0:29];

imem instrMemory(imemAddr,imemOut);

endmodule

/*
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

*/



module PipeReg(out, in, clk, rst); // synopsys template
   parameter width = 30, init = 0;
   output [0:width-1] out;
   reg [0:width-1]    out;
   input [0:width-1]  in;
   input              clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else
       out <= in;

endmodule // PipeReg





module bitExtension(in,out);
        input [0:15] in;
        output reg [0:29] out;
	always@(in) begin 
             if (in[0]==1) begin 
                  out = {14'b11111111111111,in};
             end else begin
                  out = in;
             end
	end
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
        mux2to130bit mux_sub(b_in, b_tmp, cin, b);

        fa add0(a[29], b[29], cin, sum[29], cout0);
        fa add1(a[28], b[28], cout0, sum[28], cout1);
        fa add2(a[27], b[27], cout1, sum[27], cout2);
        fa add3(a[26], b[26], cout2, sum[26], cout3);
        fa add4(a[25], b[25], cout3, sum[25], cout4);
        fa add5(a[24], b[24], cout4, sum[24], cout5);
        fa add6(a[23], b[23], cout5, sum[23], cout6);
        fa add7(a[22], b[22], cout6, sum[22], cout7);
        fa add8(a[21], b[21], cout7, sum[21], cout8);
        fa add9(a[20], b[20], cout8, sum[20], cout9);
        fa add10(a[19], b[19], cout9, sum[19], cout10);
        fa add11(a[18], b[18], cout10, sum[18], cout11);
        fa add12(a[17], b[17], cout11, sum[17], cout12);
        fa add13(a[16], b[16], cout12, sum[16], cout13);
        fa add14(a[15], b[15], cout13, sum[15], cout14);
        fa add15(a[14], b[14], cout14, sum[14], cout15);
        fa add16(a[13], b[13], cout15, sum[13], cout16);
        fa add17(a[12], b[12], cout16, sum[12], cout17);
        fa add18(a[11], b[11], cout17, sum[11], cout18);
        fa add19(a[10], b[10], cout18, sum[10], cout19);
        fa add20(a[9], b[9], cout19, sum[9], cout20);
        fa add21(a[8], b[8], cout20, sum[8], cout21);
        fa add22(a[7], b[7], cout21, sum[7], cout22);
        fa add23(a[6], b[6], cout22, sum[6], cout23);
        fa add24(a[5], b[5], cout23, sum[5], cout24);
        fa add25(a[4], b[4], cout24, sum[4], cout25);
        fa add26(a[3], b[3], cout25, sum[3], cout26);
        fa add27(a[2], b[2], cout26, sum[2], cout27);
        fa add28(a[1], b[1], cout27, sum[1], cout28);
        fa add29(a[0], b[0], cout28, sum[0], cout);

endmodule




module mux2to130bit(a,b,sel,out);
        parameter width = 30;
        input [0:width-1] a,b;
        input sel;

        output [0:width-1] out;

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

