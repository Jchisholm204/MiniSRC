`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"

// Complete simulation in 153100ns with iPort = 0x00000000.

module sim_LAB4_prog();

parameter SA = `START_PC_ADDRESS;

wire Clk;
reg nRst = 1'b0;

ClockGenerator cg(
    .nRst(nRst),
    .oClk(Clk)
);

wire mem_read, mem_write;
wire [31:0] proc_mem_out, proc_byte_mem_addr;
reg [31:0] proc_mem_in;
wire [31:0] oPort;
wire [31:0] iPort = 32'h00000000; 

wire [31:2] word_addr;
assign word_addr = proc_byte_mem_addr[31:2];

`define MEM_MAX (511)
reg [31:0] word_mem[0:`MEM_MAX];

integer i;
initial begin
    for (i = 0; i <= `MEM_MAX; i = i + 1) begin
        word_mem[i] = 32'h00000000; // Initialize memory to zero
    end
    $readmemh("Processor/tb/lab4demo/program.hex", word_mem); // initialize memory with program
    #1;
    nRst = 1'b1; // Release reset after 1ns
end

always @(proc_mem_out, proc_mem_in, word_addr) begin
    if(mem_write)
        word_mem[word_addr] <= proc_mem_out;
    proc_mem_in <= word_mem[word_addr];
end

Processor proc(
    .iClk(Clk),
    .nRst(nRst),
    .oMemAddr(proc_byte_mem_addr),
    .oMemData(proc_mem_out),
    .iMemData(proc_mem_in),
    .iMemRdy(1'b1),
    .oMemRead(mem_read),
    .oMemWrite(mem_write)
    ,.iPORT(iPort)
    ,.oPORT(oPort)
);

endmodule

