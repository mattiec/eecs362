`include "./fa_30bit.v"
`include "./bitExtension.v"
`include "./mux2to130bit.v"
`include "./bitExtensionJump.v"

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
wire [0:29] jumpInstructionExtended;
wire [0:29] branchMUXout;
wire [0:29] jumpMUXout;
wire [0:29] jumpMUXoutFinal;
wire [0:29] nextPC;
wire [0:29] nextPCout;
wire [0:29] secondValue;
wire cout3;
wire cout2;
wire cout1;
wire tmpCout;
wire [0:29] oneExtended;
wire [0:29] twoExtended;
wire [0:29] addValue;
wire [0:29] PCout;
wire [0:29] finalJumpOut;


PipeReg programCounter(PCout,PCin,clock,reset);

assign oneExtended[29] = 1;
assign oneExtended[0:28]=29'b0000;

assign twoExtended = 30'h00000002;

//mux2to130bit JALmux(oneExtended,twoExtended,JALcheck,addValue);

fa_30bit add1(PCout,oneExtended,0,nextPC,cout2);

fa_30bit outputAdder(nextPC, oneExtended,0,PCoutput[0:29], cout3);
//assign PCoutput[0:29] = nextPC[0:29];
assign PCoutput[30] = 0;
assign PCoutput[31] = 0;

assign immediateExtension[0:15] = branchInstruction[0:15];

bitExtension signExtend(immediateExtension,extendedImmediate);

fa_30bit add2(extendedImmediate,nextPC,0,nextPCout,cout1);

assign andBranch = (branchEqual & zero) | (branchNE & ~zero);

mux2to130bit branchMUX(nextPC,nextPCout,andBranch,branchMUXout);

//assign immediate26[6:29] = jumpInstruction[0:23];
//assign immediate26[0:5] = PCout[0:5];
bitExtensionJump signExtendJump(jumpInstruction[0:23], jumpInstructionExtended);
fa_30bit jumpAdder(jumpInstructionExtended, nextPC, 0, immediate26, tmpCout);

//needs to be added to pc --> not jump straight to immediate26
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

