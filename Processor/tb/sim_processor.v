`timescale 1ns/1ps
`include "../Control/ISA.vh"
`include "sim_ISA.vh"

module sim_PROC();

wire Clk;

ClockGenerator cg(
    .nRst(1'b1),
    .oClk(Clk)
);

reg proc_reset = 1'b0;
wire mem_read, mem_write;
wire [31:0] proc_mem_out, proc_mem_addr;
reg [31:0] proc_mem_in = `INS_I(`ISA_ADDI, 4'd1, 4'd1, 19'd10);

Processor proc(
    .iClk(Clk),
    .nRst(proc_reset),
    .oMemAddr(proc_mem_addr),
    .oMemData(proc_mem_out),
    .iMemData(proc_mem_in),
    .iMemRdy(1'b1),
    .oMemRead(mem_read),
    .oMemWrite(mem_write)
);

initial begin
    #1
    proc_reset = 1'b1;
end

endmodule
