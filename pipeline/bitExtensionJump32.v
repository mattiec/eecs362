module bitExtensionJump32(in,out);
        input [0:23] in;
        output reg [0:31] out;
        always@(in) begin
             if (in[0]==1) begin
                  out = {8'b11111111,in};
             end else begin
                  out = in;
             end
        end
endmodule

