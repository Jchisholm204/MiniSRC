`timescale 1ns/1ps

module sim_PROC();
wire Clk;
ClockGenerator(
    .nRst(1'b1),
    .oClk(Clk)
);

Processor


endmodule
