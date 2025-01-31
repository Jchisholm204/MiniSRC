module Control (
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    iClk, nRst, iRdy,
    // Memory IO
    iMemData, oMemAddr,
    oMemRead, oMemWrite,
    // ALU/Data path Control
    oALUOP, oRA, oRB, oRC,
    // ALU MUX A/B Select
    oMAS, oMBS,
    // Memory Mux Select / Mux Y Select
    oMMS, oMYS,
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