`include "../Processor/Control/ISA.vh"
`include "../Processor/tb/sim_ISA.vh"
module memory(
    iClk, iRead, iWrite,
    iData, iAddr,
    oData
);

input wire iClk, iRead, iWrite;
input wire [31:0] iData, iAddr;
output reg [31:0] oData;

reg [31:0] mem[0:1023];

wire [31:2] Addri;
assign Addri = iAddr[31:2];

// assign oData = iRead ? mem[Addri] : 32'd0;

always @(posedge iClk) begin
    if(iWrite)
        mem[Addri] <= iData;
    oData <= mem[Addri];
end

initial $readmemh("program.hex", mem);

// initial begin 
//     // Set the output port to the value in R1
//     // mem[0] = `INS_J(`ISA_IN, 4'h1);
//     // mem[1] = `INS_J(`ISA_OUT, 4'h1);
//     // mem[2] = `INS_J(`ISA_JFR, 4'h0);
//     // Go back to the beginning of the code
//     // Initialize Data Memory
//     // Initialize memory locations 0x54 and 0x92 with the 32-bit hexadecimal values 0x97 and 0x46, respectively.
//     mem[8'h54]  = 32'h97;
//     mem[8'h92] = 32'h46;

//     // we can't use R0 the way they wanted to use it here, because we have R0 as a constant R0 = 0; so we will use register R9 instead.
//     // Encode your program in memory with the starting address zero
//     mem[8'h00] = `INS_I(`ISA_ADDI, 4'd3, 4'd0, 19'h65); // ldi R3, 0x65 ; R3 = 0x65 // addi r3, r0, 0x65 ; R3 = 0x65
//     mem[8'h01] = `INS_I(`ISA_ADDI, 4'd3, 4'd3, 19'h3);  // ldi R3, 3(R3) ; R3 = 0x68 // addi R3, R3, 3 ; R3 = 0x68 
//     mem[8'h02] = `INS_I(`ISA_LD, 4'd2, 4'd0, 19'h54);   // ld R2, 0x54 ; R2 = (0x54) = 0x97
//     mem[8'h03] = `INS_I(`ISA_ADDI, 4'd2, 4'd2, 19'd1); // ldi R2, 1(R2) ; R2 = 0x98 
//     mem[8'h04] = `INS_I(`ISA_LD, 4'd9, 4'd2, -19'd6); // ld R0, -6(R2) ; R0 = (0x92) = 0x46 // ld R9, -6(R2) ; R9 = (0x92) = 0x46
//     mem[8'h05] = `INS_I(`ISA_ADDI, 4'd1, 4'd0, 19'd3); // ldi R1, 3 ; R1 = 3 
//     mem[8'h06] = `INS_I(`ISA_ADDI, 4'd3, 4'd0, 19'h57); // ldi R3, 0x57 ; R3 = 0x57 
//     mem[8'h07] = `INS_B(`ISA_BRx, 4'h3, `ISA_BR_NEGA, 19'd3); // brmi R3, 3 ; continue with the next instruction (will not branch) 
//     mem[8'h08] = `INS_I(`ISA_ADDI, 4'd3, 4'd3, 19'd3); // ldi R3, 3(R3) ; R3 = 0x5A 
//     mem[8'h09] = `INS_I(`ISA_LD, 4'd4, 4'd3, -19'd6); // ld R4, -6(R3) ; R4 = (0x5A - 6) = 0x97 
//     mem[8'h0A] = `INS_M(`ISA_NOP); // nop
//     mem[8'h0B] = `INS_B(`ISA_BRx, 4'd4, `ISA_BR_POSI, 19'd1); // brpl R4, 2 ; continue with the instruction at "target" (will branch) // brpl R4, 1 ; continue with the instruction at "target" (will branch) (mem[8'h0F])
//     mem[8'h0C] = `INS_I(`ISA_ADDI, 4'd6, 4'd3, 19'd7); // ldi R6, 7(R3) ; this instruction will not execute 
//     mem[8'h0D] = `INS_I(`ISA_ADDI, 4'd5, 4'd6, -19'd4); // ldi R5, -4(R6) ; this instruction will not execute 
//     mem[8'h0E] = `INS_M(`ISA_NOP); // filled this in because we are incrementing PC by 1 and branches are multiplied by 4.
//     mem[8'h0F] = `INS_M(`ISA_NOP); 
//     mem[8'h10] = `INS_R(`ISA_ADD, 4'd3, 4'd3, 4'd1); // add R3, R3, R1 ; R3 = 0x5D 
//     mem[8'h11] = `INS_I(`ISA_ADDI, 4'd4, 4'd4, 19'd2); // addi R4, R4, 2 ; R4 = 0x99 
//     mem[8'h12] = `INS_I(`ISA_NEG, 4'd4, 4'd4, 19'd0); // neg R4, R4 ; R4 = 0xFFFFFF67 
//     mem[8'h13] = `INS_I(`ISA_NOT, 4'd4, 4'd4, 19'd0); // not R4, R4 ; R4 = 0x98 
//     mem[8'h14] = `INS_I(`ISA_ANDI, 4'd4, 4'd4, 19'hF); // andi R4, R4, 0xF ; R4 = 8 
//     mem[8'h15] = `INS_R(`ISA_ROR, 4'd2, 4'd9, 4'd1); // ror R2, R0, R1 ; R2 = 0xC0000008 // ror R2, R9, R1 ; R2 = 0xC0000008
//     mem[8'h16] = `INS_I(`ISA_ORI, 4'd4, 4'd2, 19'd7); // ori R4, R2, 7 ; R4 = 0xC000000F 
//     mem[8'h17] = `INS_R(`ISA_SRA, 4'd2, 4'd4, 4'd1); // shra R2, R4, R1 ; R2 = 0xF8000001 
//     mem[8'h18] = `INS_R(`ISA_SRA, 4'd3, 4'd3, 4'd1); // shr R3, R3, R1 ; R3 = 0xB 
//     mem[8'h19] = `INS_I(`ISA_ST, 4'd3, 4'd0, 19'h92); // st 0x92, R3 ; (0x92) = 0xB new value in memory with address 0x92 
//     mem[8'h1A] = `INS_R(`ISA_ROL, 4'd3, 4'd9, 4'd1); // rol R3, R0, R1 ; R3 = 0x230 // rol R3, R9, R1 ; R3 = 0x230
//     mem[8'h1B] = `INS_R(`ISA_OR, 4'd5, 4'd1, 4'd9); // or R5, R1, R0 ; R5 = 0x47  // or R5, R1, R9 ; R5 = 0x47
//     mem[8'h1C] = `INS_R(`ISA_AND, 4'd2, 4'd3, 4'd9); // and R2, R3, R0 ; R2 = 0 // and R2, R3, R9 ; R2 = 0
//     mem[8'h1D] = `INS_I(`ISA_ST, 4'd5, 4'd2, 19'h54); // st 0x54(R2), R5 ; (0x54) = 0x47 new value in memory with address 0x54 
//     mem[8'h1E] = `INS_R(`ISA_SUB, 4'd9, 4'd3, 4'd5); // sub R0, R3, R5 ; R0 = 0x1E9 // sub R9, R3, R5 ; R9 = 0x1E9
//     mem[8'h1F] = `INS_R(`ISA_SLL, 4'd2, 4'd3, 4'd1); // shl R2, R3, R1 ; R2 = 0x1180 
//     mem[8'h20] = `INS_I(`ISA_ADDI, 4'd5, 4'd0, 19'd8); // ldi R5, 8 ; R5 = 8 
//     mem[8'h21] = `INS_I(`ISA_ADDI, 4'd6, 4'd0, 19'h17); // ldi R6, 0x17 ; R6 = 0x17 
//     mem[8'h22] = `INS_I(`ISA_MUL, 4'd5, 4'd6, 19'd0); // mul R6, R5 ; HI = 0; LO = 0xB8  // note that the registers are swapped in the instruction encoding
//     mem[8'h23] = `INS_J(`ISA_MFH, 4'd4); // mfhi R4 ; R4 = 0 
//     mem[8'h24] = `INS_J(`ISA_MFL, 4'd7); // mflo R7 ; R7 = 0xB8 
//     mem[8'h25] = `INS_I(`ISA_DIV, 4'd5, 4'd6, 19'd0); // div R6, R5 ; HI = 7 , LO = 2 // note that the registers are swapped in the instruction encoding
//     mem[8'h26] = `INS_I(`ISA_ADDI, 4'd10, 4'd5, 19'd1); // ldi R10, 1(R5) ; R10 = 9 setting up argument registers 
//     mem[8'h27] = `INS_I(`ISA_ADDI, 4'd11, 4'd6, -19'd3); // ldi R11, -3(R6) ; R11 = 0x14 R10, R11, R12, and R13 
//     mem[8'h28] = `INS_I(`ISA_ADDI, 4'd12, 4'd7, 19'd1); // ldi R12, 1(R7) ; R12 = 0xB9 
//     mem[8'h29] = `INS_I(`ISA_ADDI, 4'd13, 4'd4, 19'd4); // ldi R13, 4(R4) ; R13 = 4 
//     mem[8'h2A] = `INS_J(`ISA_JAL, 4'd12); // jal R12 ; address of subroutine subA in R12 - return address in R8 
//     mem[8'h2B] = `INS_M(`ISA_HLT); // halt ; upon return, the program halts 

//     // ORG 0xB9
//     mem[8'hB9] = `INS_R(`ISA_ADD, 4'd15, 4'd10, 4'd12); // add R15, R10, R12 ; R14 and R15 are return value registers R15 = 0xC2
//     mem[8'hBA] = `INS_R(`ISA_SUB, 4'd14, 4'd11, 4'd13); // sub R14, R11, R13 ; R15 = 0xC2, R14 = 0x10 
//     mem[8'hBB] = `INS_R(`ISA_SUB, 4'd15, 4'd15, 4'd14); // sub R15, R15, R14 ; R15 = 0xB2 
//     mem[8'hBC] = `INS_J(`ISA_JFR, 4'd8); // jr R8 
// end

// initial begin 
//     // Set the output port to the value in R1
//     mem[0] = `INS_J(`ISA_OUT, 4'h1);
//     // Increase R1 by 1
//     mem[1] = `INS_I(`ISA_ADDI, 4'h1, 4'h1, 19'd1);
//     // Load the counter value from the in port into R2
//     mem[2] = `INS_J(`ISA_IN, 4'h2);
//     // Loop for the duration of R2
//     mem[3] = `INS_I(`ISA_ADDI, 4'h2, 4'h2, -19'd1);
//     mem[4] = `INS_B(`ISA_BRx, 4'h2, `ISA_BR_NZRO, -19'd4);
//     // Go back to the beginning of the code
//     mem[5] = `INS_J(`ISA_JFR, 4'h0);
// end

endmodule