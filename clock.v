'timescale 1ns/100ps
module clk10M(clock);
    output clock;
    reg    clock;

    initial
        #5 clock = 1;

    always
        #50 clock = ~ clock;
endmodule


