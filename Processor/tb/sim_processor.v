`timescale 1ns/1ps
`include "../Control/ISA.vh"
`include "../constants.vh"
`include "sim_ISA.vh"

module sim_PROC();

parameter SA = `START_PC_ADDRESS;
`define N_instructions 5

wire Clk;
reg nRst = 1'b0;

ClockGenerator cg(
    .nRst(nRst),
    .oClk(Clk)
);

wire mem_read, mem_write;
wire [31:0] proc_mem_out, proc_mem_addr;
reg [31:0] proc_mem_in;
reg [31:0] instructions[0:`N_instructions];
// `INS_I(`ISA_ADDI, 4'd1, 4'd1, 19'd10);

Processor proc(
    .iClk(Clk),
    .nRst(nRst),
    .oMemAddr(proc_mem_addr),
    .oMemData(proc_mem_out),
    .iMemData(proc_mem_in),
    .iMemRdy(1'b1),
    .oMemRead(mem_read),
    .oMemWrite(mem_write)
);

initial begin
    instructions[0] = `INS_I(`ISA_ADDI, 4'd1, 4'd1, 19'd10);
    instructions[1] = `INS_I(`ISA_ADDI, 4'd1, 4'd1, 19'd5);
    instructions[2] = `INS_I(`ISA_ADDI, 4'd1, 4'd1, 19'd7);
    instructions[3] = `INS_I(`ISA_ST, 4'd1, 4'd0, 19'd14);
    #1
    nRst = 1'b1;
end

always @(mem_read, mem_write) begin
    if(mem_read)
        proc_mem_in = instructions[((proc_mem_addr-SA)/4)];
    else
        proc_mem_in = `INS_M(`ISA_NOP);
    if(mem_write)
        $display("Write %0d %0d", proc_mem_addr, proc_mem_out);
end

endmodule
