
module mux2to1 (a,b,sel,out);
        parameter width = 32;
        input [0:width-1] a,b;
        input  sel;

        output [0:width-1] out;

        assign out = (sel == 1'b0) ? a : b;
endmodule
