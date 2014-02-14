module extender (
 input signed [15:0] a,
 output signed [31:0] out);
 
 assign out = a; // sign-extends
 
 endmodule	
