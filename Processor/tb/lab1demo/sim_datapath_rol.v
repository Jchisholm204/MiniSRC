`timescale 1ns/10ps
module SIM_DATAPATH_ROL;

`include "../../Control/ISA.vh"
`include "../../Control/ALU.vh"
`include "../sim_ISA.vh"

// 10ns per cycle.
localparam ClockPeriod_ns = 10;
reg Clock, nReset = 0;
initial begin
    #(ClockPeriod_ns/2)
    nReset = 1'b1;
    Clock = 1'b0;
    forever #(ClockPeriod_ns/2) Clock = ~Clock;
end

reg [31:0] iMemData;
wire [31:0] oMemAddr, oMemData;

// Program Counter Signals
reg PC_nRst, PC_en, PC_jmp, PC_loadRA, PC_loadImm;

// Register File IO
reg RF_iWrite;
reg [3:0] RF_iAddrA, RF_iAddrB, RF_iAddrC;
reg RWB_en;

// ALU IO
reg [3:0]  ALU_iCtrl;
wire ALU_oZero, ALU_oNeg;

// ALU Immediate Register enable signals
reg RA_en, RB_en;
reg RZH_en, RZL_en;
// ALU Storage Register enable signal
reg RAS_en;

// Jump/Branch Signals
// wire J_zero, J_nZero, J_pos, J_neg;

// Multiplexer Signals
reg MUX_BIS, MUX_RZHS, MUX_WBM, MUX_MAP, MUX_ASS, MUX_WBP;

// Control Signals
reg [31:0] CT_imm32;

localparam Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
reg [3:0] Present_State = Default;

Datapath DUT(
    // Clock and reset signals (reset is active low)
    .iClk(Clock),
    .nRst(nReset),
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
    .oJ_zero(),
    .oJ_nZero(),
    .oJ_pos(),
    .oJ_neg(),
    // ALU Results
    .oALU_neg(ALU_oNeg),
    .oALU_zero(ALU_oZero),
    // Multiplexers
    .iMUX_BIS(MUX_BIS), // ALU B Input/Immediate Select
    .iMUX_RZHS(MUX_RZHS), // ALU Result High Select
    .iMUX_WBM(MUX_WBM), // Write back in Memory Select
    .iMUX_WBP(MUX_WBP),
    .iMUX_MAP(MUX_MAP), // Memory Address out PC Select
    .iMUX_ASS(MUX_ASS), // ALU Storage Select
    // Imm32 Output
    .iImm32(CT_imm32)
);

always @(posedge Clock) begin // Change state of machine through each step.
    case (Present_State) 
        Default     :   Present_State = Reg_load1a;
        Reg_load1a  :   Present_State = Reg_load1b;
        Reg_load1b  :   Present_State = Reg_load2a;
        Reg_load2a  :   Present_State = Reg_load2b;
        Reg_load2b  :   Present_State = Reg_load3a;
        Reg_load3a  :   Present_State = Reg_load3b;
        Reg_load3b  :   Present_State = T0;
        T0          :   Present_State = T1;
        T1          :   Present_State = T2;
        T2          :   Present_State = T3;
        T3          :   Present_State = T4;
        T4          :   Present_State = T5;
    endcase
end


always @(Present_State) begin
    case (Present_State)
        Default     :   begin
            // Initialization
            // Memory
            iMemData <= 0;

            // Program Counter
            PC_nRst <= 0;
            PC_en <= 0;
            PC_jmp <= 0;
            PC_loadRA <= 0;
            PC_loadImm <= 0;
            // Register File
            RF_iWrite <= 0;
            RF_iAddrA <= 0;
            RF_iAddrB <= 0;
            RF_iAddrC <= 0;
            // ALU Control
            ALU_iCtrl <= 0;
            RA_en <= 0;
            RB_en <= 0;
            RZH_en <= 0;
            RZL_en <= 0;
            RAS_en <= 0;
            RWB_en <= 0;
            // Ignore Jump Feedback
            // ALU Multiplexers
            MUX_BIS <= 0;
            MUX_RZHS <= 0;
            MUX_WBM <= 0;
            MUX_WBP <= 0;
            MUX_MAP <= 0;
            MUX_ASS <= 0;
            CT_imm32 <= 0;
        end 
        Reg_load1a  :   begin
            iMemData <= 32'h22;
            MUX_WBM <= 1;
            RWB_en <= 1;
            #(ClockPeriod_ns) MUX_WBM <= 0; RWB_en <= 0;
        end 
        Reg_load1b  :   begin
            RF_iWrite <= 1;
            RF_iAddrC <= 4'd3; // load 32'h22 into R3
            #(ClockPeriod_ns) RF_iWrite <= 0;
        end   
        Reg_load2a  :   begin
            iMemData <= 32'h24;
            MUX_WBM <= 1;
            RWB_en <= 1;
            #(ClockPeriod_ns) MUX_WBM <= 0; RWB_en <= 0;
        end   
        Reg_load2b  :   begin
            RF_iWrite <= 1;
            RF_iAddrC <= 4'd7; // load 32'h24 into R7
            #(ClockPeriod_ns) RF_iWrite <= 0;
        end   
        Reg_load3a  :   begin
            iMemData <= 32'h28;
            MUX_WBM <= 1;
            RWB_en <= 1;
            #(ClockPeriod_ns) MUX_WBM <= 0; RWB_en <= 0;
        end   
        Reg_load3b  :   begin
            RF_iWrite <= 1;
            RF_iAddrC <= 4'd4; // load 32'h28 into R4
            #(ClockPeriod_ns) RF_iWrite <= 0;
        end   
        T0          :   begin
            // Instruction fetch and Increment PC.
            PC_nRst <= 1;
            MUX_MAP <= 1;
            PC_en <= 1;
            PC_jmp <= 1;
            iMemData <= `INS_R(`ISA_ROL, 4'd4, 4'd3, 4'd7);
            // Not putting this into IR because the IR is not part of the datapath, it's part of the control unit which is not being tested here.
            #(ClockPeriod_ns) PC_en <= 0; MUX_MAP <= 0;
        end   
        T1          :   begin
            // Decode instruction and load registers into ALU inputs.
            RF_iAddrA <= 4'd3;
            RF_iAddrB <= 4'd7;
            MUX_BIS <= 0;
            RA_en <= 1; RB_en <= 1;
            #(ClockPeriod_ns) iMemData <= 0; RA_en <= 0; RB_en <= 0;
        end   
        T2          :   begin
            // Assert ALU control signal for ROL operation.
            ALU_iCtrl <= `CTRL_ALU_ROL;
            // Enable RZH and RZL registers to store the result of the ALU operation.
            RZH_en <= 1; RZL_en <= 1;
            // Select ZLow as ALU output into RWB.
            MUX_RZHS <= 0;
            MUX_ASS <= 0;
            MUX_WBM <= 0;
            MUX_WBP <= 0;
            #(ClockPeriod_ns) RZH_en <= 0; RZL_en <= 0;
        end   
        T3          :   begin
            // Store in Write Back Register.
            RWB_en <= 1;
            #(ClockPeriod_ns) RWB_en <= 0;
        end   
        T4          :   begin
            // Load from Write Back Register into R4 inside Register File.
            RF_iAddrC <= 4'd4;
            RF_iWrite <= 1;
            #(ClockPeriod_ns) RF_iWrite <= 0;
        end
    endcase
end

endmodule