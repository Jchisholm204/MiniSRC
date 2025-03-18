`timescale 1ns/1ps
`include "../../Control/ISA.vh"
`include "../../constants.vh"
`include "../sim_ISA.vh"

module sim_LAB2_BRx();

parameter SA = `START_PC_ADDRESS;
`define BRANCH_OFFSET 27
// `BRANCH_OFFSET*4*4 because branch jumps are multiplied by 4 since memory is byte addressed
`define N_instructions (13+`BRANCH_OFFSET*4*4 + 1)

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
    d_mem[0]  = 32'd2;
    d_mem[1] = 32'd1;

    // brzr r1, 27
    // addi r1, r0, 1
    i_mem[0] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'd1);
    // branch not taken
    i_mem[1] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_ZERO, 19'd`BRANCH_OFFSET);
    // addi r1, r0, 0
    i_mem[2] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'd0);
    // branch taken
    i_mem[3] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_ZERO, 19'd`BRANCH_OFFSET);
    // instruction should get ignored
    // addi r1, r0, 0xBAD
    i_mem[4] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'hBAD);

    // brnz r1, 27
    // branch not taken
    i_mem[4+`BRANCH_OFFSET*4] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_NZRO, 19'd`BRANCH_OFFSET);
    // addi r1, r0, -1
    i_mem[5+`BRANCH_OFFSET*4] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, -19'd1);
    // branch taken
    i_mem[6+`BRANCH_OFFSET*4] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_NZRO, 19'd27);
    // instruction should get ignored
    // addi r1, r0, 0xBAD
    i_mem[7+`BRANCH_OFFSET*4] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'hBAD);

    // brpl r1, 27
    // branch not taken
    i_mem[7+`BRANCH_OFFSET*4*2] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_POSI, 19'd`BRANCH_OFFSET);
    // addi r1, r0, 1
    i_mem[8+`BRANCH_OFFSET*4*2] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'd1);
    // branch taken
    i_mem[9+`BRANCH_OFFSET*4*2] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_POSI, 19'd`BRANCH_OFFSET);
    // instruction should get ignored
    // addi r1, r0, 0xBAD
    i_mem[10+`BRANCH_OFFSET*4*2] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'hBAD);

    // brmi r2, 27
    // branch not taken
    i_mem[10+`BRANCH_OFFSET*4*3] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_NEGA, 19'd`BRANCH_OFFSET);
    // addi r1, r0, -1
    i_mem[11+`BRANCH_OFFSET*4*3] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, -19'd1);
    // branch taken
    i_mem[12+`BRANCH_OFFSET*4*3] = `INS_B(`ISA_BRx, 4'd1, `ISA_BR_NEGA, 19'd`BRANCH_OFFSET);
    // instruction should get ignored
    // addi r1, r0, 0xBAD
    i_mem[13+`BRANCH_OFFSET*4*3] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'hBAD);
    
    // halt
    i_mem[13+`BRANCH_OFFSET*4*4] = `INS_M(`ISA_HLT);
    #1
    nRst = 1'b1;
end

always @(mem_read, mem_write) begin
    if(mem_read) begin
        if(proc_mem_addr < `N_instructions) begin
            proc_mem_in = i_mem[((proc_mem_addr-SA))];
        end
        else begin
            proc_mem_in = d_mem[proc_mem_addr-`N_instructions];
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

