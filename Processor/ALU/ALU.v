module ALU(
    // 32 bit Inputs
    iA, iB, 
    // Control Signal
    iCtrl,
    // 64 bit output
    oC, 
    // Zero Output / Negative Output
    oZero, oNeg
);

input wire [31:0] iA, iB;
input wire [3:0] iCtrl;
output wire [63:0] oC;
output wire oZero, oNeg;

// Control Parameters
parameter ALUC_ADD = 4'h0;
parameter ALUC_SUB = 4'h1;
parameter ALUC_OR  = 4'h2;
parameter ALUC_XOR = 4'h3;
parameter ALUC_AND = 4'h4;
parameter ALUC_MUL = 4'h5;
parameter ALUC_DIV = 4'h6;
parameter ALUC_SLL = 4'h7;
parameter ALUC_SRL = 4'h8;
parameter ALUC_SRA = 4'h9;

// Module output
wire [31:0] out_hi, out_lo;

// Adder IO
wire [31:0] cla_out, cla_iB;
wire cla_iCarry, cla_oCarry, cla_overflow, cla_zero, cla_neg;

// OR/XOR/AND IO
wire [31:0] or_out, xor_out, and_out;

// Shifter IO
wire [31:0] sft_data, sft_out;
wire [4:0] sft_shamt;
wire sft_arith, sft_left;

// Multiplier IO
wire [63:0] mul_out;
wire mul_neg;

// Divider IO
wire [31:0] div_q, div_r, div_m, div_d;
wire [31:0] div_rmdr, div_qtnt;
wire div_iNegA, div_iNegB, div_neg;

// Adder/Subtract

// XOR input B for subtraction and set carry to 1
assign cla_iB = (iCtrl == ALUC_SUB) ? 32'hFFFFFFFF ^ iB : iB;
assign cla_iCarry = (iCtrl == ALUC_SUB);

CLA cla(
    .iX(iA),
    .iY(cla_iB),
    .iCarry(cla_iCarry),
    .oS(cla_out),
    .oCarry(cla_oCarry),
    .oOverflow(cla_overflow),
    .oZero(cla_zero),
    .oNegative(cla_neg)
);

// OR
OR bor(
    .iA(iA),
    .iB(iB),
    .oC(or_out)
);

// XOR
XOR bxor(
    .iA(iA),
    .iB(iB),
    .oC(xor_out)
);

// AND
AND band(
    .iA(iA),
    .iB(iB),
    .oC(and_out)
);

// Bit Shifter
assign sft_data = iA;
assign sft_shamt = iB[4:0];
// Negate Arithmetic shift (logic low)
assign sft_arith = ~(iCtrl == ALUC_SRA);
assign sft_left  = (iCtrl == ALUC_SLL);

SHIFT sft(
    .iD(sft_data),
    .iShamt(sft_shamt),
    .nArith(sft_arith),
    .nLeft(sft_left),
    .oD(sft_out)
);

// Multiplier

assign mul_out = iA * iB;
assign mul_neg = mul_out[63];

// Divider
assign div_iNegA = iA[31];
assign div_iNegB = iB[31];

// If either is negative, the quotient must be negative
assign div_neg = div_iNegA ^ div_iNegB;

// If the divisor or dividend is negative, make it positive
assign div_m = div_iNegA ? 32'hFFFFFFFF ^ (iA - 1) : iA;
assign div_d = div_iNegB ? 32'hFFFFFFFF ^ (iB - 1) : iB;

DIV32 div(
    .iQ(div_m),
    .iD(div_d),
    .oQ(div_q),
    .oR(div_r)
);

// Quotient will be negative if A or B is negative but not both
assign div_qtnt = div_neg ? (32'hFFFFFFFF ^ div_q) + 1 : div_q;
// Remainder carries the same sign as the dividend
assign div_rmdr = div_iNegB ? (32'hFFFFFFFF ^ div_r) + 1 : div_r;

// Module Outputs
// Set low output register
assign out_lo = (iCtrl == ALUC_ADD) ? cla_out :
                (iCtrl == ALUC_SUB) ? cla_out :
                (iCtrl == ALUC_OR)  ? or_out  :
                (iCtrl == ALUC_XOR) ? xor_out :
                (iCtrl == ALUC_AND) ? and_out :
                (iCtrl == ALUC_MUL) ? mul_out[31:0] :
                (iCtrl == ALUC_DIV) ? div_rmdr :
                (iCtrl == ALUC_SLL) ? sft_out :
                (iCtrl == ALUC_SRL) ? sft_out :
                (iCtrl == ALUC_SRA) ? sft_out :
                32'h00000000;

// Set high output register (Zero on anything not needing 64 bits)
assign out_hi = (iCtrl == ALUC_MUL) ? mul_out[63:32] :
                (iCtrl == ALUC_DIV) ? div_qtnt :
                32'h00000000;

// Output register combines out high and low
assign oC = {out_hi, out_lo};

// Assign the negative outputs based on the control inputs
assign oNeg =   (iCtrl == ALUC_ADD) ? cla_neg :
                (iCtrl == ALUC_SUB) ? cla_neg :
                (iCtrl == ALUC_MUL) ? mul_neg :
                (iCtrl == ALUC_DIV) ? div_neg :
                out_lo[31];

// Assign zero if both the high and low registers are zero
assign oZero = ({out_hi, out_lo} == 64'd0);


endmodule