`include "../Control/ALU.vh"
module ALU(
    // 32 bit Inputs
    iA, iB, 
    // Control Signal
    iCtrl,
    // 64 bit output
    oC_hi, oC_lo,
    // Zero Output / Negative Output
    oZero, oNeg
);

input wire [31:0] iA, iB;
input wire [3:0] iCtrl;
output wire [31:0] oC_hi, oC_lo;
output wire oZero, oNeg;

// Module output
wire [31:0] out_hi, out_lo;

// Adder/Subtract/Not IO
wire [31:0] cla_out, cla_iB, cla_iA;
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

// ROL / ROR IO
wire [31:0] ROR_out, ROL_out;

// NOT
wire [31:0] NOT_out;

// Adder/Subtract

// XOR input B for subtraction and set carry to 1
assign cla_iA = (iCtrl == `CTRL_ALU_NEG) ? 32'd0 : iA;
assign cla_iA = (iCtrl == `CTRL_ALU_NEG) ? 32'd0 : iA;

assign cla_iB = (iCtrl == `CTRL_ALU_SUB) ? 32'hFFFFFFFF ^ iB :
                (iCtrl == `CTRL_ALU_NEG) ? 32'hFFFFFFFF ^ iA : iB;

assign cla_iCarry = (iCtrl == `CTRL_ALU_SUB || iCtrl == `CTRL_ALU_NEG);

CLA cla(
    .iX(cla_iA),
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
assign sft_arith = ~(iCtrl == `CTRL_ALU_SRA);
assign sft_left  = ~(iCtrl == `CTRL_ALU_SLL);

SHIFT sft(
    .iD(sft_data),
    .iShamt(sft_shamt),
    .nArith(sft_arith),
    .nLeft(sft_left),
    .oD(sft_out)
);

// Multiplier

MUL32 mul(
    .iA(iA),
    .iB(iB),
    .oP(mul_out)
);

// assign mul_out = iA * iB;
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

// ROR
ROR ror(
    .iD(iA),
    .iShamt(iB[4:0]),
    .oD(ROR_out)
);

// ROL
ROL rol(
    .iD(iA),
    .iShamt(iB[4:0]),
    .oD(ROL_out)
);

// NOT
generate
    genvar i;
    for(i = 0; i < 32; i = i + 1) begin
        not (NOT_out[i], iA[i]);
    end
endgenerate

// Module Outputs
// Set low output register
assign out_lo = (iCtrl == `CTRL_ALU_ADD) ? cla_out :
                (iCtrl == `CTRL_ALU_SUB) ? cla_out :
                (iCtrl == `CTRL_ALU_OR)  ? or_out  :
                (iCtrl == `CTRL_ALU_XOR) ? xor_out :
                (iCtrl == `CTRL_ALU_AND) ? and_out :
                (iCtrl == `CTRL_ALU_MUL) ? mul_out[31:0] :
                (iCtrl == `CTRL_ALU_DIV) ? div_rmdr :
                (iCtrl == `CTRL_ALU_SLL) ? sft_out :
                (iCtrl == `CTRL_ALU_SRL) ? sft_out :
                (iCtrl == `CTRL_ALU_SRA) ? sft_out :
                (iCtrl == `CTRL_ALU_ROR) ? ROR_out :
                (iCtrl == `CTRL_ALU_ROL) ? ROL_out :
                (iCtrl == `CTRL_ALU_NOT) ? NOT_out:
                32'h00000000;

// Set high output register (Zero on anything not needing 64 bits)
assign out_hi = (iCtrl == `CTRL_ALU_MUL) ? mul_out[63:32] :
                (iCtrl == `CTRL_ALU_DIV) ? div_qtnt :
                32'h00000000;

// Output register 
assign oC_lo = out_lo;
assign oC_hi = out_hi;

// Assign the negative outputs based on the control inputs
assign oNeg =   (iCtrl == `CTRL_ALU_ADD) ? cla_neg :
                (iCtrl == `CTRL_ALU_SUB) ? cla_neg :
                (iCtrl == `CTRL_ALU_MUL) ? mul_neg :
                (iCtrl == `CTRL_ALU_DIV) ? div_neg :
                out_lo[31];

// Assign zero if both the high and low registers are zero
assign oZero = ({out_hi, out_lo} == 64'd0);


endmodule
