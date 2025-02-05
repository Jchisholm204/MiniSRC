// OR Data path simulation for lab1
// Run for 600 ns to see full result
// Will print out the result
`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"
module sim_PROC_OR();

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
reg [31:0] i_mem[0:`N_instructions];
reg [31:0] d_mem[0:255];
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
    // Initialize Data Memory
    d_mem[0]  = 32'h00000022;
    d_mem[1] = 32'h00000024;
    d_mem[2] = 32'h00000028;

    // ld r3, 20(r0)
    i_mem[0] = `INS_I(`ISA_LD, 4'd3, 4'd0, 19'd20);
    // ld r7, 21(r0)
    i_mem[1] = `INS_I(`ISA_LD, 4'd7, 4'd0, 19'd21);
    // ld r4, 22(r0)
    i_mem[2] = `INS_I(`ISA_LD, 4'd2, 4'd0, 19'd22);
    // and r4, r3, r7
    i_mem[3] = `INS_R(`ISA_OR, 4'd4, 4'd3, 4'd7);
    // st r4, 23(r0)
    i_mem[5] = `INS_I(`ISA_ST, 4'd4, 4'd0, 19'd23);
    #1
    nRst = 1'b1;
end

always @(mem_read, mem_write) begin
    if(mem_read) begin
        if(proc_mem_addr < 32'd20) begin
            proc_mem_in = i_mem[((proc_mem_addr-SA))];
        end
        else begin
            proc_mem_in = d_mem[proc_mem_addr-32'd20];
        end
    end
    else begin
        proc_mem_in = `INS_M(`ISA_NOP);
    end
    if(mem_write) begin
        d_mem[proc_mem_addr] = proc_mem_out;
        $display("Write addr: %0d data: %0d", proc_mem_addr, proc_mem_out);
    end
end

endmodule
