module Control (
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    iClk, nRst, iRdy,
    // Memory IO
    iMemData, oMemAddr,
    oMemRead, oMemWrite,
    // Pipe Control
    oPipe_nRst,
    // Program Counter Control
    oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm,
    // Register File Control
    oRF_Write,
    oRF_AddrA, oRF_AddrB, oRF_AddrC,
    // ALU Control
    oALU_Ctrl, oRA_en, oRB_en,
    oRZH_en, oRZL_en, oRAS_en,
    // Memory Control
    oRMA_en, oRMD_en;
    // Multiplexers
    oMUX_B, oMUX_RZHS, oMUX_WB, oMUX_MA, oMUX_AS;
    // Imm32 Output
    oImm32
);

input wire iClk, nRst, iRdy;
input wire [31:0] iMemData;
output wire [31:0] oMemAddr;
output wire oMemRead, oMemWrite;
output wire [3:0] oALUOP, oRA, oRB, oRC;
output wire [1:0] oMAS, oMBS, oMMS, oMYS;
output wire [31:0] oImm32;

// PC
// wire V

// Decode dec(
//     .
// )

endmodule