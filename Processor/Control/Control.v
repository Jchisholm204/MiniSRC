`include "ISA.vh"
`include "ALU.vh"


module Control (
    // Clock, reset and ready signals
    // Ready is an active high that allows the next step to continue
    iClk, nRst, iRdy,
    // Memory Signals/Control
    iMemData, oMemRead, oMemWrite,
    // Pipe Control
    oPipe_nRst,
    // Program Counter Control
    oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm,
    // Register File Control
    oRF_Write,
    oRF_AddrA, oRF_AddrB, oRF_AddrC,
    // Write Back Register Control
    oRWB_en,
    // ALU Control
    oALU_Ctrl, oRA_en, oRB_en,
    oRZH_en, oRZL_en, oRAS_en,
    // Memory Control
    oRMA_en, oRMD_en,
    // Multiplexers
    oMUX_BIS, oMUX_RZHS, oMUX_WBM, oMUX_MAP, oMUX_ASS,
    // Imm32 Output
    oImm32
);

// Clock, reset and ready signals
// Ready is an active high that allows the next step to continue
input wire iClk, nRst, iRdy;
// Memory Signals/Control
input wire [31:0] iMemData;
output wire oMemRead, oMemWrite;
// Pipe Control
output wire oPipe_nRst;
// Program Counter Control
output wire oPC_nRst, oPC_en, oPC_jmp, oPC_loadRA, oPC_loadImm;
// Register File Control
output wire oRF_Write;
output wire [3:0] oRF_AddrA, oRF_AddrB, oRF_AddrC;
// Write Back Register Control
output wire oRWB_en;
// ALU Control
output wire [3:0] oALU_Ctrl;
output wire oRA_en, oRB_en;
output wire oRZH_en, oRZL_en, oRAS_en;
// Memory Control
output wire oRMA_en, oRMD_en;
// Multiplexers
output wire oMUX_BIS, oMUX_RZHS, oMUX_WBM, oMUX_MAP, oMUX_ASS;
// Imm32 Output
output wire [31:0] oImm32;

// Step Counter
reg [5:1] Cycle;

// IR
wire IR_en;
wire [31:0] IR_out;

// Decoder IO
wire [3:0] ID_RA, ID_RB, ID_RC;
wire [4:0] ID_OpCode;
wire [31:0] ID_imm32, ID_JFR, ID_JMP;

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
// (Useful for data path MUX Assignments)
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

// Instruction Register
assign IR_en = Cycle[1];
REG32 IR(.iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out));

// Decoder
Decode decoder(
    .iINS(IR_out),
    .oImm32(ID_imm32),
    .oRa(ID_RA),
    .oRb(ID_RB),
    .oRc(ID_RC),
    .oCode(ID_OpCode),
    .oJFR(ID_JFR),
    .oJMP(ID_JMP)
);

// Assign OP-Code Types

// Assign R-Format Wires
assign OP_ADD = (ID_OpCode == `ISA_ADD);
assign OP_SUB = (ID_OpCode == `ISA_SUB);
assign OP_AND = (ID_OpCode == `ISA_AND);
assign OP_OR  = (ID_OpCode == `ISA_OR);
assign OP_ROR = (ID_OpCode == `ISA_ROR);
assign OP_ROL = (ID_OpCode == `ISA_ROL);
assign OP_SRL = (ID_OpCode == `ISA_SRL);
assign OP_SRA = (ID_OpCode == `ISA_SRA);
assign OP_SLL = (ID_OpCode == `ISA_SLL);
// Opcode Format Wire (Useful for data path MUX Assignments)
assign OPF_R  = (OP_ADD || OP_SUB || OP_AND || OP_OR || OP_ROR || OP_ROL || OP_SRL || OP_SRA || OP_SLL);
// Assign I-Format Wires
assign OP_LD  = (ID_OpCode == `ISA_LD);
assign OP_LI  = (ID_OpCode == `ISA_LI);
assign OP_ST  = (ID_OpCode == `ISA_ST);
assign OP_ADDI = (ID_OpCode == `ISA_ADDI);
assign OP_ANDI = (ID_OpCode == `ISA_ANDI);
assign OP_ORI  = (ID_OpCode == `ISA_ORI);
assign OP_DIV  = (ID_OpCode == `ISA_DIV);
assign OP_MUL  = (ID_OpCode == `ISA_MUL);
assign OP_NEG  = (ID_OpCode == `ISA_NEG);
assign OP_NOT  = (ID_OpCode == `ISA_NOT);
// Opcode Format Wire (Useful for data path MUX Assignments)
assign OPF_I   = (OP_LD || OP_LI || OP_ST || OP_ADDI || OP_ANDI || OP_ORI || OP_DIV || OP_MUL || OP_NEG || OP_NOT);
// Assign B-Format Wires
assign OP_BRx = (ID_OpCode == `ISA_BRx);
// Opcode Format Wire (Useful for data path MUX Assignments)
assign OPF_B = OP_BRx;
// Assign J-Format Wires
assign OP_JAL = (ID_OpCode == `ISA_JAL);
assign OP_JFR = (ID_OpCode == `ISA_JFR);
assign OP_MFL = (ID_OpCode == `ISA_MFL);
assign OP_MFH = (ID_OpCode == `ISA_MFH);
// Opcode Format Wire (Useful for data path MUX Assignments)
assign OPF_J  = (OP_JAL || OP_JFR || OP_MFL || OP_MFH);
// Assign M-Format Wires
assign OP_NOP = (ID_OpCode == `ISA_NOP);
assign OP_HLT = (ID_OpCode == `ISA_HLT);
// Opcode Format Wire (Useful for data path MUX Assignments)
assign OPF_M  =  (OP_NOP || OP_HLT);

// Assign Control outputs based on Codes and Cycle

// Pipe Reset Signal
assign oPipe_nRst = nRst;

// Program Counter Control Signals (NOT CORRECT)
// PC Reset (Should only be reset on CPU reset)
assign oPC_nRst = nRst;
// PC Load Enable
assign oPC_en = Cycle[1] || (Cycle[3] && (OP_BRx || OP_JAL || OP_JFR));
// PC Jump Enable
assign oPC_jmp = Cycle[3] && OP_BRx;
assign oPC_loadRA = Cycle[3] && (OP_JFR || OP_JAL);
assign oPC_loadImm = 1'b0;

// Register File Control Signals
assign oRF_Write = Cycle[5] && ((OPF_R && ~OP_ST) || (OPF_I && ~OP_DIV && ~OP_MUL) || OP_MFH || OP_MFL);
// Note: Most ISA's use RC as the write back address, MiniSRC uses RA 
// RA is dependent on ISA type, use R0 if RA is not specified
assign oRF_AddrA =  (OPF_R | OPF_I) ? ID_RB : 4'h0;
// RB is dependent on ISA type, use R0 if RB is not specified
assign oRF_AddrB =  (OPF_I) ? ID_RA :
                    (OPF_R) ? ID_RC : 4'h0;
// Store is always RA
assign oRF_AddrC = ID_RA;

// Register File Write Back Register Load Enable
assign oRWB_en = 1'b1;

// ALU Control Signals
assign oALU_Ctrl =  (OP_ADD || OP_ADDI) ? `CTRL_ALU_ADD :
                    (OP_SUB)            ? `CTRL_ALU_SUB :
                    (OP_OR  || OP_ORI)  ? `CTRL_ALU_OR  :
                    (OP_AND || OP_ANDI) ? `CTRL_ALU_AND :
                    (OP_MUL)            ? `CTRL_ALU_MUL :
                    (OP_DIV)            ? `CTRL_ALU_DIV :
                    (OP_SLL)            ? `CTRL_ALU_SLL :
                    (OP_SRL)            ? `CTRL_ALU_SRL :
                    (OP_SRA)            ? `CTRL_ALU_SRA :
                    (OP_ROR)            ? `CTRL_ALU_ROR :
                    (OP_ROL)            ? `CTRL_ALU_ROL :
                    (OP_NOT)            ? `CTRL_ALU_NOT :
                    (OP_NEG)            ? `CTRL_ALU_NEG :
                    // ALU Add is default for most instructions
                    `CTRL_ALU_ADD;
// ALU Input A Register Load Enable
assign oRA_en = 1'b1; 
// ALU Input B Register Load Enable
assign oRB_en = 1'b1;

// ALU Result High Load EN
assign oRZH_en = 1'b1;
// ALU Result Low Load EN
assign oRZL_en = 1'b1;
// ALU Result Save EN
assign oRAS_en = (OP_DIV || OP_MUL);

// Memory Address Register EN
assign oRMA_en = Cycle[1] || Cycle[4];
// Memory Data Register EN
assign oRMD_en = 1'b1;
// ALU B Input Select (Selects Imm)
assign oMUX_BIS = OPF_I && ~(OP_DIV || OP_MUL);
// ALU Result High Select
assign oMUX_RZHS = (OP_MFH);
// RF Write Back Select
assign oMUX_WBM = (OP_LD || OP_LI);
// Memory Address Output Select
// assign oMUX_MA = Cycle[1];
assign oMUX_MAP = ~((OP_LD || OP_ST || OP_LI) && Cycle[4]);
// ALU Storage Select
assign oMUX_ASS = (OP_MFL || OP_MFH);
// Immediate value output
assign oImm32 = ID_imm32;

// Memory Read/Write Signals
assign oMemRead = Cycle[1] || (Cycle[4] && (OP_LD || OP_LI));
assign oMemWrite = Cycle[4] && OP_ST;

endmodule
