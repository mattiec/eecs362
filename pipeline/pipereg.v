module PipeReg106(out, in, clk, rst); // synopsys template
   parameter width = 106, init = 0;
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

module PipeReg193(out, in, clk, rst); // synopsys template
   parameter width = 193, init = 0;
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

module PipeReg71(out, in, clk, rst); // synopsys template
   parameter width = 71, init = 0;
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