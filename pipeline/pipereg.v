module PipeReg111(out, in, clk, rst); // synopsys template
   parameter width = 111, init = 0;
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

module PipeReg198(out, in, clk, rst); // synopsys template
   parameter width = 198, init = 0;
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

module PipeReg76(out, in, clk, rst); // synopsys template
   parameter width = 76, init = 0;
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

module PipeReg64(out, in, clk, rst); // synopsys template
   parameter width = 64, init = 0;
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



module PipeReg32(out, in, clk, rst); // synopsys template
   parameter width = 32, init = 0;
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
