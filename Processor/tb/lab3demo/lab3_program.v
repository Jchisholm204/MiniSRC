`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"

module sim_LAB3_prog();

parameter SA = `START_PC_ADDRESS;
// largest valid memory address
`define MEM_MAX ((8'hB9) + 3)

wire Clk;
reg nRst = 1'b0;

ClockGenerator cg(
    .nRst(nRst),
    .oClk(Clk)
);

wire mem_read, mem_write;
wire [31:0] proc_mem_out, proc_mem_addr;
reg [31:0] proc_mem_in;
reg [31:0] mem[0:`MEM_MAX];
wire [31:0] oPort;

Processor proc(
    .iClk(Clk),
    .nRst(nRst),
    .oMemAddr(proc_mem_addr),
    .oMemData(proc_mem_out),
    .iMemData(proc_mem_in),
    .iMemRdy(1'b1),
    .oMemRead(mem_read),
    .oMemWrite(mem_write)
    // ,.iPort(0)
    // ,.oPort(oPort)
);

initial begin
    // Initialize Data Memory
    // Initialize memory locations 0x54 and 0x92 with the 32-bit hexadecimal values 0x97 and 0x46, respectively.
    mem[8'h54]  = 32'h97;
    mem[8'h92] = 32'h46;

    // TODO: Initialize Instruction Memory.
    // Encode your program in memory with the starting address zero
    mem[8'h0] = `INS_I(`ISA_ADDI, 4'd3, 4'd0, 19'h65);

    #1
    // Initialize registers R0 - R15 and the PC to 0 with the Reset input signal. 
    nRst = 1'b1;
end

always @(mem_read, mem_write) begin
    if (proc_mem_addr > `MEM_MAX) begin
        $display("Memory address out of bounds: %0d", proc_mem_addr);
        proc_mem_in = `INS_M(`ISA_NOP);
    end
    else if (mem_read) begin
        proc_mem_in = mem[proc_mem_addr];
    end
    else if (mem_write) begin
        mem[proc_mem_addr] = proc_mem_out;
        $display("Write addr: %0d data: %0d", proc_mem_addr, proc_mem_out);
    end
end

endmodule

