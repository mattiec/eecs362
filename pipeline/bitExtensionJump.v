module bitExtensionJump(in, out);
        input [0:23] in;
        output reg [0:29] out;
        always@(in) begin
                if (in[0] ==1) begin
                        out = {6'b111111, in};
                end else begin
                        out = {6'b000000, in};
                end
        end
endmodule

