`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"

module sim_LAB4_prog();

parameter SA = `START_PC_ADDRESS;
`define MEM_MAX (1023)

wire Clk;
reg nRst = 1'b0;

ClockGenerator cg(
    .nRst(nRst),
    .oClk(Clk)
);

wire mem_read, mem_write;
wire [31:0] proc_mem_out, proc_byte_mem_addr;
reg [31:0] proc_mem_in;
reg [31:0] word_mem[0:`MEM_MAX];
wire [31:0] oPort;
wire [31:0] iPort = 32'h000000C0; // No input port

wire [31:2] word_addr;
assign word_addr = proc_byte_mem_addr[31:2];

always @(proc_mem_out, proc_mem_in, word_addr) begin
    if(mem_write)
        word_mem[word_addr] <= proc_mem_out;
    proc_mem_in <= word_mem[word_addr];
end

initial begin
    // replace with the correct absolute path to the program.hex file
    $readmemh("Processor/tb/lab4demo/program.hex", word_mem);
    #1;
    nRst = 1'b1; // Release reset after 1ns
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

