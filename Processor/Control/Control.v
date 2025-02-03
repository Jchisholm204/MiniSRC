module Control (
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    iClk, nRst, iRdy,
    iMemData,
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
    oRMA_en, oRMD_en,
    // Multiplexers
    oMUX_B, oMUX_RZHS, oMUX_WB, oMUX_MA, oMUX_AS,
    // Imm32 Output
    oImm32
);

input wire iClk, nRst, iRdy;
input wire [31:0] iMemData;
output wire oPipe_nRst;
output wire oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm;
output wire oRF_Write, oRF_AddrA, oRF_AddrB, oRF_AddrC;
output wire oALU_Ctrl, oRA_en, oRB_en;
output wire oRZH_en, oRZL_en, oRAS_en;
output wire oRMA_en, oRMD_en;
output wire oMUX_B, oMUX_RZHS, oMUX_WB, oMUX_MA, oMUX_AS;
output wire [31:0] oImm32;

// Step Counter
reg [5:1] Cycle;

// IR
wire IR_en;
wire [31:0] IR_out;
REG32 IR(.iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out));

// Decoder IO
wire [3:0] ID_RA, ID_RB, ID_RC;
wire [4:0] ID_OpCode;
wire [31:0] ID_imm32, ID_JFR, ID_JMP;

// Opcode Signatures
// R Format Instructions
localparam INS_LD  = 5'b00000;
localparam INS_LI  = 5'b00001;
localparam INS_ST  = 5'b00010;
localparam INS_ADD = 5'b00011;
localparam INS_SUB = 5'b00100;
localparam INS_AND = 5'b00101;
localparam INS_OR  = 5'b00110;
localparam INS_ROR = 5'b00111;
localparam INS_ROL = 5'b01000;
localparam INS_SRL = 5'b01001;
localparam INS_SRA = 5'b01010;
localparam INS_SLL = 5'b01011;
// I Format Instructions
localparam INS_ADDI = 5'b01100;
localparam INS_ANDI = 5'b01101;
localparam INS_ORI  = 5'b01110;
localparam INS_DIV = 5'b01111;
localparam INS_MUL = 5'b10000;
localparam INS_NEG = 5'b10001;
localparam INS_NOT = 5'b10010;
// B Format Instructions
localparam INS_BRx = 5'b10011;
// J Format Instructions
localparam INS_JAL = 5'b10100;
localparam INS_JFR = 5'b10101;
localparam INS_MFL = 5'b11000;
localparam INS_MFH = 5'b11001;
// M Format Instructions
localparam INS_NOP = 5'b11010;
localparam INS_HLT = 5'b11011;

// OpCode R-Format Wires
wire OP_LD, OP_LI,  OP_ST,  OP_ADD, OP_SUB, OP_AND, 
     OP_OR, OP_ROR, OP_ROL, OP_SRL, OP_SRA, OP_SLL;
// OpCode I-Format Wires
wire OP_ADDI, OP_ANDI, OP_ORI, OP_DIV, OP_MUL, OP_NEG, OP_NOT;
// OpCode B-Format Wires
wire OP_BRx;
// OpCode J-Format Wires
wire OP_JAL, OP_JFR, OP_MFL, OP_MFH;
// OpCode M-Format Wires
wire OP_NOP, OP_HLT;
// OpCode Format Wires
wire OPF_R, OPF_I, OPF_B, OPF_J, OPF_M;

// Assign Cycle
always @(posedge iClk or negedge nRst)
begin
    if(!nRst)
        Cycle = 5'b00001;
    else begin
        if(iRdy) Cycle = {Cycle[4:1], Cycle[5]};
    end
end

// Decoder
Decode decoder(
    .iINS(IR_out),
    .oImm32(ID_imm32),
    .oRa(ID_RA),
    .oRb(ID_RB),
    .oRc(ID_RC),
    .oCode(ID_OpCode)
    .oJFR(ID_JFR),
    .oJMP(ID_JMP),
);

// Assign OP-Code Types

// Assign R-Format Wires
assign OP_LD  = (ID_OpCode == INS_LD);
assign OP_LI  = (ID_OpCode == INS_LI);
assign OP_ST  = (ID_OpCode == INS_ST);
assign OP_ADD = (ID_OpCode == INS_ADD);
assign OP_SUB = (ID_OpCode == INS_SUB);
assign OP_AND = (ID_OpCode == INS_AND);
assign OP_OR  = (ID_OpCode == INS_OR);
assign OP_ROR = (ID_OpCode == INS_ROR);
assign OP_ROL = (ID_OpCode == INS_ROL);
assign OP_SRL = (ID_OpCode == INS_SRL);
assign OP_SRA = (ID_OpCode == INS_SRA);
assign OP_SLL = (ID_OpCode == INS_SLL);
assign OPF_R  = (OP_LD || OP_LI || OP_ST || OP_ADD || OP_SUB || OP_AND || OP_OR || OP_ROR || OP_ROL || OP_SRL || OP_SRA || OP_SLL);
// Assign I-Format Wires
assign OP_ADDI = (ID_OpCode == INS_ADDI);
assign OP_ANDI = (ID_OpCode == INS_ANDI);
assign OP_ORI  = (ID_OpCode == INS_ORI);
assign OP_DIV  = (ID_OpCode == INS_DIV);
assign OP_MUL  = (ID_OpCode == INS_MUL);
assign OP_NEG  = (ID_OpCode == INS_NEG);
assign OP_NOT  = (ID_OpCode == INS_NOT);
assign OPF_I   = (OP_ADDI || OP_ANDI || OP_ORI || OP_DIV || OP_MUL || OP_NEG || OP_NOT);
// Assign B-Format Wires
assign OP_BRx = (ID_OpCode == INS_BRx);
assign OPF_B = OP_BRx;
// Assign J-Format Wires
assign OP_JAL = (ID_OpCode == INS_JAL);
assign OP_JFR = (ID_OpCode == INS_JFR);
assign OP_MFL = (ID_OpCode == INS_MFL);
assign OP_MFH = (ID_OpCode == INS_MFH);
assign OPF_J  = (OP_JAL || OP_JFR || OP_MFL || OP_MFH);
// Assign M-Format Wires
assign OP_NOP = (ID_OpCode == INS_NOP);
assign OP_HLT = (ID_OpCode == INS_HLT);
assign OPF_M  =  (OP_NOP || OP_HLT);

// Assign Control outputs based on Codes and Cycle

assign oPipe_nRst;
// Program Counter Control Signals
assign oPC_nRst;
assign oPC_en;
assign oPC_jmp;
assign oPC_loadRA;
assign oPC_loadImm;

// Register File Control Signals
assign oRF_Write;
assign oRF_AddrA;
assign oRF_AddrB;
assign oRF_AddrC;

// ALU Control Signals
assign oALU_Ctrl;
assign oRA_en; 
assign oRB_en;

// ALU Result High Load EN
assign oRZH_en;
// ALU Result Low Load EN
assign oRZL_en;
// ALU Result Save EN
assign oRAS_en;

// Memory Address Register EN
assign oRMA_en;
// Memory Data Register EN
assign oRMD_en;
// ALU B Input Select
assign oMUX_B;
// ALU Result High Select
assign oMUX_RZHS;
// RF Write Back Select
assign oMUX_WB;
// Memory Address Output Select
assign oMUX_MA;
// ALU Storage Select
assign oMUX_AS;
// Immediate value output
assign oImm32;


endmodule
