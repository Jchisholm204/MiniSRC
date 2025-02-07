module Processor(
    iClk, nRst,
    oMemAddr, oMemData,
    iMemData, iMemRdy,
    oMemRead, oMemWrite
);

`include "constants.vh"

input wire iClk, nRst, iMemRdy;
output wire oMemRead, oMemWrite;
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;

// Program Counter Signals
wire PC_nRst, PC_en, PC_jmp, PC_loadRA, PC_loadImm;

// Register File IO
wire RF_iWrite;
wire [3:0] RF_iAddrA, RF_iAddrB, RF_iAddrC;
wire RWB_en;

// ALU IO
wire [3:0]  ALU_iCtrl;
wire ALU_oZero, ALU_oNeg;

// ALU Immediate Registers
wire RA_en, RB_en;
wire RZH_en, RZL_en;
// ALU Storage Registers
wire RAS_en;

// Jump/Branch Signals
wire J_zero, J_nZero, J_pos, J_neg;

// Multiplexer Signals
wire MUX_BIS, MUX_RZHS, MUX_WBM, MUX_MAP, MUX_ASS;
// Memory Multiplexers
wire RMA_en, RMD_en;

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
    .oRWB_en(RWB_en),
    // ALU Control
    .oALU_Ctrl(ALU_iCtrl),
    .oRA_en(RA_en), 
    .oRB_en(RB_en),
    .oRZH_en(RZH_en),
    .oRZL_en(RZL_en),
    .oRAS_en(RAS_en),
    // Jump Feedback
    .iJ_zero(J_zero),
    .iJ_nZero(J_nZero),
    .iJ_pos(J_pos),
    .iJ_neg(J_neg),
    // Memory Control
    .oRMA_en(RMA_en),
    .oRMD_en(RMD_en),
    // Multiplexers
    .oMUX_BIS(MUX_BIS),
    .oMUX_RZHS(MUX_RZHS),
    .oMUX_WBM(MUX_WBM),
    .oMUX_MAP(MUX_MAP),
    .oMUX_ASS(MUX_ASS),
    // Imm32 Output
    .oImm32(CT_imm32)
);

Datapath pipe(
    // Clock and reset signals (reset is active low)
    .iClk(iClk),
    .nRst(pipe_rst),
    // Memory Signals
    .iMemData(iMemData),
    .oMemAddr(oMemAddr),
    .oMemData(oMemData),
    // Program Counter Control
    .iPC_nRst(PC_nRst),
    .iPC_en(PC_en),
    .iPC_jmp(PC_jmp),
    .iPC_loadRA(PC_loadRA),
    .iPC_loadImm(PC_loadImm),
    // Register File Control
    .iRF_Write(RF_iWrite),
    .iRF_AddrA(RF_iAddrA),
    .iRF_AddrB(RF_iAddrB),
    .iRF_AddrC(RF_iAddrC),
    // Write Back Register Control
    .iRWB_en(RWB_en),
    // ALU Control
    .iALU_Ctrl(ALU_iCtrl),
    .iRA_en(RA_en),
    .iRB_en(RB_en),
    .iRZH_en(RZH_en),
    .iRZL_en(RZL_en),
    .iRAS_en(RAS_en),
    // Jump Feedback
    .oJ_zero(J_zero),
    .oJ_nZero(J_nZero),
    .oJ_pos(J_pos),
    .oJ_neg(J_neg),
    // ALU Results
    .oALU_neg(ALU_oNeg),
    .oALU_zero(ALU_oZero),
    // Memory Control
    .iRMA_en(RMA_en),
    .iRMD_en(RMD_en),
    // Multiplexers
    .iMUX_BIS(MUX_BIS), // ALU B Input/Immediate Select
    .iMUX_RZHS(MUX_RZHS), // ALU Result High Select
    .iMUX_WBM(MUX_WBM), // Write back in Memory Select
    .iMUX_MAP(MUX_MAP), // Memory Address out PC Select
    .iMUX_ASS(MUX_ASS), // ALU Storage Select
    // Imm32 Output
    .iImm32(CT_imm32)
);

endmodule
