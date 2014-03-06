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

