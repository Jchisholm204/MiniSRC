module Decode (
    // Input Instruction
    iINS,
    // Immediate Value (Sign Extended)
    oImm32,
    // Reg A, Reg B, Reg C addresses
    oRa, oRb, oRc,
    // OP Code
    oCode,
    // Branch Distance
    oBRD,
    // Branch Code
    oBRC
);

// Taken from instruction formats: section 2.1 of the Processor specifications

input wire [31:0] iINS;
output wire [31:0] oImm32;
output wire [3:0] oRa, oRb, oRc;
output wire [4:0] oCode;
output wire [31:0] oBRD;
output wire [1:0] oBRC;

assign oCode  = iINS[31:27];
assign oRa    = iINS[26:23];
assign oRb    = iINS[22:19];
assign oRc    = iINS[18:15];
assign oImm32 = {{13{iINS[18]}}, iINS[18:0]};
assign oBRD   = {{11{iINS[18]}}, iINS[18:0], 2'b00};
assign oBRC   = iINS[20:19];

endmodule