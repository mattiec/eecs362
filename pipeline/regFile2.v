module register(out, in, ctl, rst, clk); // synopsys template
   parameter width = 32, init = 32'b0;
   output [0:width-1] out;
   reg [0:width-1] out;
   input [0:width-1] in;
   input ctl;
   input clk, rst;

   always @ (negedge clk or posedge rst) begin	
     if (rst)
		out <= init;
     else if (ctl)
        out <= in;
     end
endmodule // PipeCtlReg



module regFile2(rst, clk, ftpt_write, ftpt_read, WrAddr, WrEn, WrData, ReadAddr1, ReadAddr2, ReadData1, ReadData2);
   
	input [0:31] WrData;
	input [0:4] WrAddr, ReadAddr1, ReadAddr2;
    input WrEn, clk, rst, ftpt_write, ftpt_read;

    output [0:31] ReadData1, ReadData2;
	
	wire D00,D01,D02,D03,D04,D05,D06,D07,D08,D09,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31;
	wire [0:31] O00,O01,O02,O03,O04,O05,O06,O07,O08,O09,O10,O11,O12,O13,O14,O15,O16,O17,O18,O19,O20,O21,O22,O23,O24,O25,O26,O27,O28,O29,O30,O31;
	wire [0:31] OF00,OF01,OF02,OF03,OF04,OF05,OF06,OF07,OF08,OF09,OF10,OF11,OF12,OF13,OF14,OF15,OF16,OF17,OF18,OF19,OF20,OF21,OF22,OF23,OF24,OF25,OF26,OF27,OF28,OF29,OF30,OF31;
	
	wire [0:31] ReadIData1, ReadIData2, ReadFPData1, ReadFPData2;
	
    decoder5to32 decode532(WrAddr, WrEn, D00,D01,D02,D03,D04,D05,D06,D07,D08,D09,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,D24,D25,D26,D27,D28,D29,D30,D31);

	//only write to interger registers when ftpt_write == 0
	//based on decorder output to d-wires the correct register will be written to if WrEn is 1
	
	register ireg00(O00, WrData, ~ftpt_write & WrEn & D00, rst, clk);
	register ireg01(O01, WrData, ~ftpt_write & WrEn & D01, rst, clk);
	register ireg02(O02, WrData, ~ftpt_write & WrEn & D02, rst, clk);
	register ireg03(O03, WrData, ~ftpt_write & WrEn & D03, rst, clk);
	register ireg04(O04, WrData, ~ftpt_write & WrEn & D04, rst, clk);
	register ireg05(O05, WrData, ~ftpt_write & WrEn & D05, rst, clk);
	register ireg06(O06, WrData, ~ftpt_write & WrEn & D06, rst, clk);
	register ireg07(O07, WrData, ~ftpt_write & WrEn & D07, rst, clk);
	register ireg08(O08, WrData, ~ftpt_write & WrEn & D08, rst, clk);
	register ireg09(O09, WrData, ~ftpt_write & WrEn & D09, rst, clk);
	register ireg10(O10, WrData, ~ftpt_write & WrEn & D10, rst, clk);
	register ireg11(O11, WrData, ~ftpt_write & WrEn & D11, rst, clk);
	register ireg12(O12, WrData, ~ftpt_write & WrEn & D12, rst, clk);
	register ireg13(O13, WrData, ~ftpt_write & WrEn & D13, rst, clk);
	register ireg14(O14, WrData, ~ftpt_write & WrEn & D14, rst, clk);
	register ireg15(O15, WrData, ~ftpt_write & WrEn & D15, rst, clk);
	register ireg16(O16, WrData, ~ftpt_write & WrEn & D16, rst, clk);
	register ireg17(O17, WrData, ~ftpt_write & WrEn & D17, rst, clk);
	register ireg18(O18, WrData, ~ftpt_write & WrEn & D18, rst, clk);
	register ireg19(O19, WrData, ~ftpt_write & WrEn & D19, rst, clk);
	register ireg20(O20, WrData, ~ftpt_write & WrEn & D20, rst, clk);
	register ireg21(O21, WrData, ~ftpt_write & WrEn & D21, rst, clk);
	register ireg22(O22, WrData, ~ftpt_write & WrEn & D22, rst, clk);
	register ireg23(O23, WrData, ~ftpt_write & WrEn & D23, rst, clk);
	register ireg24(O24, WrData, ~ftpt_write & WrEn & D24, rst, clk);
	register ireg25(O25, WrData, ~ftpt_write & WrEn & D25, rst, clk);
	register ireg26(O26, WrData, ~ftpt_write & WrEn & D26, rst, clk);
	register ireg27(O27, WrData, ~ftpt_write & WrEn & D27, rst, clk);
	register ireg28(O28, WrData, ~ftpt_write & WrEn & D28, rst, clk);
	register ireg29(O29, WrData, ~ftpt_write & WrEn & D29, rst, clk);
	register ireg30(O30, WrData, ~ftpt_write & WrEn & D30, rst, clk);
	register ireg31(O31, WrData, ~ftpt_write & WrEn & D31, rst, clk);
	
	
	
	//only write to floating point registers when ftpt_write == 1
	//based on decorder output to d-wires the correct register will be written to if WrEn is 1
	
	register fpreg00(OF00, WrData, ftpt_write & WrEn & D00, rst, clk);
	register fpreg01(OF01, WrData, ftpt_write & WrEn & D01, rst, clk);
	register fpreg02(OF02, WrData, ftpt_write & WrEn & D02, rst, clk);
	register fpreg03(OF03, WrData, ftpt_write & WrEn & D03, rst, clk);
	register fpreg04(OF04, WrData, ftpt_write & WrEn & D04, rst, clk);
	register fpreg05(OF05, WrData, ftpt_write & WrEn & D05, rst, clk);
	register fpreg06(OF06, WrData, ftpt_write & WrEn & D06, rst, clk);
	register fpreg07(OF07, WrData, ftpt_write & WrEn & D07, rst, clk);
	register fpreg08(OF08, WrData, ftpt_write & WrEn & D08, rst, clk);
	register fpreg09(OF09, WrData, ftpt_write & WrEn & D09, rst, clk);
	register fpreg10(OF10, WrData, ftpt_write & WrEn & D10, rst, clk);
	register fpreg11(OF11, WrData, ftpt_write & WrEn & D11, rst, clk);
	register fpreg12(OF12, WrData, ftpt_write & WrEn & D12, rst, clk);
	register fpreg13(OF13, WrData, ftpt_write & WrEn & D13, rst, clk);
	register fpreg14(OF14, WrData, ftpt_write & WrEn & D14, rst, clk);
	register fpreg15(OF15, WrData, ftpt_write & WrEn & D15, rst, clk);
	register fpreg16(OF16, WrData, ftpt_write & WrEn & D16, rst, clk);
	register fpreg17(OF17, WrData, ftpt_write & WrEn & D17, rst, clk);
	register fpreg18(OF18, WrData, ftpt_write & WrEn & D18, rst, clk);
	register fpreg19(OF19, WrData, ftpt_write & WrEn & D19, rst, clk);
	register fpreg20(OF20, WrData, ftpt_write & WrEn & D20, rst, clk);
	register fpreg21(OF21, WrData, ftpt_write & WrEn & D21, rst, clk);
	register fpreg22(OF22, WrData, ftpt_write & WrEn & D22, rst, clk);
	register fpreg23(OF23, WrData, ftpt_write & WrEn & D23, rst, clk);
	register fpreg24(OF24, WrData, ftpt_write & WrEn & D24, rst, clk);
	register fpreg25(OF25, WrData, ftpt_write & WrEn & D25, rst, clk);
	register fpreg26(OF26, WrData, ftpt_write & WrEn & D26, rst, clk);
	register fpreg27(OF27, WrData, ftpt_write & WrEn & D27, rst, clk);
	register fpreg28(OF28, WrData, ftpt_write & WrEn & D28, rst, clk);
	register fpreg29(OF29, WrData, ftpt_write & WrEn & D29, rst, clk);
	register fpreg30(OF30, WrData, ftpt_write & WrEn & D30, rst, clk);
	register fpreg31(OF31, WrData, ftpt_write & WrEn & D31, rst, clk);
	
	
	
	mux32to1 readI1(O00,O01,O02,O03,O04,O05,O06,O07,O08,O09,O10,O11,O12,O13,O14,O15,O16,O17,O18,O19,O20,O21,O22,O23,O24,O25,O26,O27,O28,O29,O30,O31,ReadAddr1,ReadIData1);
	mux32to1 readI2(O00,O01,O02,O03,O04,O05,O06,O07,O08,O09,O10,O11,O12,O13,O14,O15,O16,O17,O18,O19,O20,O21,O22,O23,O24,O25,O26,O27,O28,O29,O30,O31,ReadAddr2,ReadIData2);
	
	
	mux32to1 read1F(OF00,OF01,OF02,OF03,OF04,OF05,OF06,OF07,OF08,OF09,OF10,OF11,OF12,OF13,OF14,OF15,OF16,OF17,OF18,OF19,OF20,OF21,OF22,OF23,OF24,OF25,OF26,OF27,OF28,OF29,OF30,OF31,ReadAddr1,ReadFPData1);
	mux32to1 read2F(OF00,OF01,OF02,OF03,OF04,OF05,OF06,OF07,OF08,OF09,OF10,OF11,OF12,OF13,OF14,OF15,OF16,OF17,OF18,OF19,OF20,OF21,OF22,OF23,OF24,OF25,OF26,OF27,OF28,OF29,OF30,OF31,ReadAddr2,ReadFPData2);
	
	//Choose between reading integer or floating point registers to output
	//ftpt_read = 0 read integer registers and vice versa
	mux2to1 read1(ReadIData1, ReadFPData1, ftpt_read, ReadData1);
	mux2to1 read2(ReadIData2, ReadFPData2, ftpt_read, ReadData2);
	
endmodule
