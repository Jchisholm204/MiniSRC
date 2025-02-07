module Decode (
    // Input Instruction
    iINS,
    // Immediate Value (Sign Extended)
    oImm32,
    // Reg A, Reg B, Reg C addresses
    oRa, oRb, oRc,
    // OP Code
    oCode,
    // Jump from register distance
    oJFR,
    // Branch Distance
    oJMP,
    // Branch Code
    oBRC
);

// Taken from instruction formats: section 2.1 of the Processor specifications

input wire [31:0] iINS;
output wire [31:0] oImm32;
output wire [3:0] oRa, oRb, oRc;
output wire [4:0] oCode;
output wire [31:0] oJFR, oJMP;
output wire [1:0] oBRC;

assign oCode  = iINS[31:27];
assign oRa    = iINS[26:23];
assign oRb    = iINS[22:19];
assign oRc    = iINS[18:15];
assign oImm32 = {{13{iINS[18]}}, iINS[18:0]};
assign oJFR   = {{9{iINS[22]}}, iINS[22:0]};
assign oJMP   = {{5{iINS[26]}}, iINS[26:0]};
assign oBRC   = iINS[20:19];

endmodule