`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"

module sim_LAB2_ADD();

parameter SA = `START_PC_ADDRESS;
`define N_instructions 9

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
    d_mem[0]  = 32'd2;
    d_mem[1] = 32'd1;

    // ld r1, 0(r0)
    i_mem[0] = `INS_I(`ISA_LD, 4'd1, 4'd0, 19'd20);
    // addi r1, r1, -1
    i_mem[1] = `INS_I(`ISA_ADDI, 4'd1, 4'd1, -19'd1);
    // brzr r1, -1
    i_mem[2] = `INS_B(`ISA_BRx, 4'd0, `ISA_BR_NZRO, 19'd1);
    // // ld r2, 1(r0)
    // i_mem[3] = `INS_I(`ISA_LD, 4'd1, 4'd0, 19'd21);
    // // brzr r1, -1
    // i_mem[4] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_ZERO, 19'd1);
    // brzr r0, 1
    i_mem[3] = `INS_B(`ISA_BRx, 4'd0, `ISA_BR_ZERO, 19'd1);
    i_mem[4] = `INS_J(`ISA_JFR, 4'd0);
    i_mem[5] = `INS_J(`ISA_JFR, 4'd0);
    i_mem[6] = `INS_J(`ISA_JFR, 4'd0);
    // i_mem[3] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_ZERO, -19'd1);
    // i_mem[3] = `INS_R(`ISA_ADD, 4'd3, 4'd1, 4'd2);
    // mfh r3
    // i_mem[4] = `INS_J(`ISA_MFH, 4'd3);
    // i_mem[3] = `INS_M(`ISA_NOP);
    // jal r0
    // i_mem[4] = `INS_J(`ISA_JFR, 4'hF);
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
