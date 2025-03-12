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
    mem[8'h00] = `INS_I(`ISA_ADDI, 4'd3, 4'd0, 19'h65); // ldi R3, 0x65 ; R3 = 0x65 // addi r3, r0, 0x65
    mem[8'h01] = `INS_I(`ISA_ADDI, 4'd3, 4'd3, 19'h3);  // ldi R3, 3(R3) ; R3 = 0x68 // addi R3, R3, 3
    mem[8'h02] = `INS_I(`ISA_LD, 4'd2, 4'd0, 19'h54);   // ld R2, 0x54 ; R2 = (0x54) = 0x97
    // ldi R2, 1(R2) ; R2 = 0x98 
    // ld R0, -6(R2) ; R0 = (0x92) = 0x46 
    // ldi R1, 3 ; R1 = 3 
    // ldi R3, 0x57 ; R3 = 0x57 
    // brmi R3, 3 ; continue with the next instruction (will not branch) 
    // ldi R3, 3(R3) ; R3 = 0x5A 
    // ld R4, -6(R3) ; R4 = (0x5A - 6) = 0x97 
    // nop brpl R4, 2 ; continue with the instruction at “target” (will branch) 
    // ldi R6, 7(R3) ; this instruction will not execute 
    // ldi R5, -4(R6) ; this instruction will not execute 
    // add R3, R3, R1 ; R3 = 0x5D 
    // addi R4, R4, 2 ; R4 = 0x99 
    // neg R4, R4 ; R4 = 0xFFFFFF67 
    // not R4, R4 ; R4 = 0x98 
    // andi R4, R4, 0xF ; R4 = 8 
    // ror R2, R0, R1 ; R2 = 0xC0000008 
    // ori R4, R2, 7 ; R4 = 0xC000000F 
    // shra R2, R4, R1 ; R2 = 0xF8000001 
    // shr R3, R3, R1 ; R3 = 0xB 
    // st 0x92, R3 ; (0x92) = 0xB new value in memory with address 0x92 
    // rol R3, R0, R1 ; R3 = 0x230 
    // or R5, R1, R0 ; R5 = 0x47 
    // and R2, R3, R0 ; R2 = 0 
    // st 0x54(R2), R5 ; (0x54) = 0x47 new value in memory with address 0x54 
    // sub R0, R3, R5 ; R0 = 0x1E9 
    // shl R2, R3, R1 ; R2 = 0x1180 
    // ldi R5, 8 ; R5 = 8 
    // ldi R6, 0x17 ; R6 = 0x17 
    // mul R6, R5 ; HI = 0; LO = 0xB8 
    // mfhi R4 ; R4 = 0 
    // mflo R7 ; R7 = 0xB8 
    // div R6, R5 ; HI = 7 , LO = 2 
    // ldi R10, 1(R5) ; R10 = 9 setting up argument registers 
    // ldi R11, -3(R6) ; R11 = 0x14 R10, R11, R12, 
    // and R13 ldi R12, 1(R7) ; R12 = 0xB9 
    // ldi R13, 4(R4) ; R13 = 4 jal R12 ; address of subroutine subA in R12 - return address in R8 
    // halt ; upon return, the program halts 

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
