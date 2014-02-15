module testbench;
        reg CLOCK;

clk10M CLK10M(.clock(CLOCK));

initial begin
        $monitor("CLOCK=%b",CLOCK);
#0 CLOCK=1'b0;
end
endmodule


