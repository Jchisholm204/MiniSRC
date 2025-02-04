module Processor(
    iClk, nRst,
    oMemAddr, oMemData,
    iMemData, iMemRdy,
    oMemRead, oMemWrite
);

input wire iClk, nRst, iMemRdy;
output wire oMemRead, oMemWrite;
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;

wire Clk;
assign Clk = iClk & nRst;
wire pipe_rst;

// Program Counter Signals
wire PC_nRst, PC_en, PC_jmp, PC_loadRA, PC_loadImm;
wire [31:0] PC_out, PC_tOut;

// Register File IO
wire RF_iWrite;
wire [3:0] RF_iAddrA, RF_iAddrB, RF_iAddrC;
wire [31:0] RF_oRegA, RF_oRegB, RF_iRegC;

// ALU IO
wire [31:0] ALU_iA, ALU_iB, ALU_oC_hi, ALU_oC_lo;
wire [3:0]  ALU_iCtrl;
wire ALU_oZero, ALU_oNeg;

// ALU Immediate Registers
wire RA_en, RB_en;
wire [31:0] RA_out, RB_out;
wire RZH_en, RZL_en;
wire [31:0] RZH_out, RZL_out, RZ_out;
// ALU Storage Registers
wire RAS_en;
wire [31:0] RASH_out, RASL_out, RAS_out;
// ALU Output
wire [31:0] RZX_out;

// Memory Signals
wire RMA_en, RMD_en;
wire [31:0] MemAddr_out, MemData_out;

// Multiplexer Signals
wire MUX_B, MUX_RZHS, MUX_WB, MUX_MA, MUX_AS;

// Control Signals
wire [31:0] CT_imm32;

// Control Unit
Control Ctrl(
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    .iClk(iClk),
    .nRst(nRst),
    .iRdy(iMemRdy),
    // Memory Signals/Control
    .iMemData(iMemData),
    .oMemRead(oMemRead),
    .oMemWrite(oMemWrite),
    // Pipe Control
    .oPipe_nRst(pipe_rst),
    // Program Counter Control
    .oPC_nRst(PC_nRst), 
    .oPC_en(PC_en),
    .oPC_jmp(PC_jmp),
    .oPC_loadRA(PC_loadRA),
    .oPC_loadImm(PC_loadImm),
    // Register File Control
    .oRF_Write(RF_iWrite),
    .oRF_AddrA(RF_iAddrA),
    .oRF_AddrB(RF_iAddrB),
    .oRF_AddrC(RF_iAddrC),
    // ALU Control
    .oALU_Ctrl(ALU_iCtrl),
    .oRA_en(RA_en), 
    .oRB_en(RB_en),
    .oRZH_en(RZH_en),
    .oRZL_en(RZL_en),
    .oRAS_en(RAS_en),
    // Memory Control
    .oRMA_en(RMA_en),
    .oRMD_en(RMD_en),
    // Multiplexers
    .oMUX_B(MUX_B),
    .oMUX_RZHS(MUX_RZHS),
    .oMUX_WB(MUX_WB),
    .oMUX_MA(MUX_MA),
    .oMUX_AS(MUX_AS),
    // Imm32 Output
    .oImm32(CT_imm32)
);

// Program Counter
PC pc(
    .iClk(Clk),
    .iEn(PC_en),
    .nRst(PC_nRst),
    .iJmpEn(PC_jmp),
    .iLoadRA(PC_loadRA),
    .iLoadImm(PC_loadImm),
    .iRA(RA_out),
    .iImm32(CT_imm32),
    .oPC(PC_out),
    .oPC_tmp(PC_tOut)
);


// Register File
RegFile RF(
    .iClk(Clk),
    .nRst(pipe_rst),
    .iWrite(RF_iWrite),
    .iAddrA(RF_iAddrA),
    .iAddrB(RF_iAddrB),
    .iAddrC(RF_iAddrC),
    .oRegA(RF_oRegA),
    .oRegB(RF_oRegB),
    .iRegC(RF_iRegC)
);

REG32 RA(.iClk(iClk), .nRst(pipe_rst), .iEn(RA_en), .iD(RF_oRegA), .oQ(RA_out));
REG32 RB(.iClk(iClk), .nRst(pipe_rst), .iEn(RB_en), .iD(RF_oRegB), .oQ(RB_out));

// ALU Input Multiplexers

assign ALU_iA = RA_out;
assign ALU_iB = MUX_B ? CT_imm32 : RB_out;

// ALU
ALU alu(
    .iA(ALU_iA),
    .iB(ALU_iB),
    .iCtrl(ALU_iCtrl),
    .oC_hi(ALU_oC_hi),
    .oC_lo(ALU_oC_lo),
    .oZero(ALU_oZero),
    .oNeg(ALU_oNeg)
);

// ALU Result Registers
REG32 RZH(.iClk(iClk), .nRst(pipe_rst), .iEn(RZH_en), .iD(ALU_oC_hi), .oQ(RZH_out));
REG32 RZL(.iClk(iClk), .nRst(pipe_rst), .iEn(RZL_en), .iD(ALU_oC_lo), .oQ(RZL_out));

// ALU Storage Registers - Persist data until reset or next H/L transaction
REG32 RASH(.iClk(iClk), .nRst(pipe_rst), .iEn(RAS_en), .iD(ALU_oC_hi), .oQ(RASH_out));
REG32 RASL(.iClk(iClk), .nRst(pipe_rst), .iEn(RAS_en), .iD(ALU_oC_lo), .oQ(RASL_out));

// 32 bit ALU result selection
assign RAS_out = MUX_RZHS ? RASH_out : RASL_out;
assign RZ_out  = MUX_RZHS ? RZH_out : RZL_out;
// Select between storage or current registers
assign RZX_out = MUX_AS ? RZ_out : RAS_out;

// Memory
assign MemAddr_out = MUX_MA ? RZX_out : PC_out;
assign MemData_out = RA_out;

// Memory Registers
REG32 RMA(.iClk(iClk), .nRst(pipe_rst), .iEn(RMA_en), .iD(MemAddr_out), .oQ(oMemAddr));
REG32 RMD(.iClk(iClk), .nRst(pipe_rst), .iEn(RMD_en), .iD(MemData_out), .oQ(oMemData));

// Write Back
assign RF_iRegC = MUX_WB ? RZX_out : iMemData;

endmodule
