// TODO: Fix failure on edge cases.
// TODO: Figure out how to limit the width of the carry-save adders (don't need 64 bits at each level).
// TODO: Implement the ability to do this with unsigned numbers also. 
// EXTRA: index the carry-save adder structure so this multiplier works for N being any power of 2.

// FAILS on edge cases, see sim_MUL32.v.
// This assumes that the inputs are 32-bit 2's-complement signed integers.
// Multiply (multiplicand) A by (multiplier) B to get (product) P.
// It would be nice if there was a way to make this work for both signed and unsigned numbers.
module MUL32 (input signed [31:0] iA, input signed [31:0] iB, output signed [63:0] oP);

// Compute the Booth Encoding of the multiplier (B).
localparam N = 32;

// -2A, -A, 0, A, 2A selection and shifts using Booth Encoding.
// The number of booth encoded values is N/2.
localparam BTH = (N+1)/2; // = 16
// For an ideal cascade of 4-to-2 reducers to align with the number of inputs, we need N to be a power of 2.
// Number of levels of Carry-Save Addition (CSA) using 4-to-2 reducers.
// localparam CSA_levels = $clog2(BTH); // = 4
// # of 4-to-2 reducers in each level of CSA.
// localparam reducers_in_CSA_level1 = BTH/4; // = 4
// localparam reducers_in_CSA_level2 = CSA_level1*2/4; // = 2
// localparam reducers_in_CSA_level3 = CSA_level2*2/4; // = 1
// Final Carry-Propagate Addition (CPA) is done using the final 2 outputs from the last level of CSA.

wire signed [N-1:0] notA, negA;
wire signed [N:0] A2, negA2;
wire signed [N:0] A_ext, negA_ext;
wire [BTH-1:0] booth_sign;
wire [1:0] booth_magnitude [BTH-1:0];
wire [2*BTH-1:0] flat_booth_magnitude;

assign negA = notA + 1'b1;
assign A2 = {iA, 1'b0};
assign negA2 = {negA, 1'b0};
assign A_ext = {iA[N-1], iA};
assign negA_ext = {negA[N-1], negA};

genvar i;
generate
for (i = 0; i < N; i = i + 1) begin : gen_notA
    assign notA[i] = ~iA[i];
end
for (i = 0; i < BTH; i = i + 1) begin : map_booth_magnitude
    assign booth_magnitude[i] = {flat_booth_magnitude[i+BTH], flat_booth_magnitude[i]};
end
endgenerate

BoothEncode_2bit_Nbit #(N) be2bit(iB, booth_sign, flat_booth_magnitude[2*BTH-1:BTH], flat_booth_magnitude[BTH-1:0]);

// if sign is negative, then we have to do sign extension.
// if booth is 0, then just add with zero.
// if booth is 1, then add A with an input carry of 0.
// if booth is 2, then add A shifted left by one with an input carry of 0.
// if booth is -2, then add notA shifted left by one with an input carry of 2. (since notA will be shifted, we can accomplish an input carry of 2 by replacing the least significant bit with 1 and having a carry in of 1)
// if booth is -1, then add notA with an input carry of 1.
// We know that it's impossible to have consecutive -2 or 2 in the booth encoding. Look at the table to see why.
// After a 0, you can have either -2, or +2.
// After a +1, you can have either a 0, +1, or -2, -1. (so just not +2)
// After a +2, you can have either a +1, or -1.
// After a -2, you can have either a +1, or -1.
// After a -1, you can have either a +1, or -1, or +2, or 0. (so just not -2)


// There will be N/2 Booth Encoded values to be added.
// If they are all 2A or -2A, then they are all N+1 bits long.

wire signed [N:0] initialValue[BTH-1:0];

generate
    for (i = 0; i < BTH; i = i + 1) begin : gen_initialValue
        assign initialValue[i] = booth_magnitude[i][1] ? (booth_sign[i] ? negA2 : A2)
            : (booth_magnitude[i][0] ? (booth_sign[i] ? negA_ext : A_ext) 
            : {(N+1){1'b0}});
    end
endgenerate
// Now testing to ensure the initial values are calculated correctly.
/*
         00000000
0000000 000000000
00000 000000000
000 000000000
0 000000000
*/
wire signed [2*N-1:0] shiftedInitialValue[BTH-1:0];
generate
    for (i = 0; i < BTH; i = i + 1) begin : gen_shiftedInitialValue
        assign shiftedInitialValue[i] = {{(N-1-2*i){initialValue[i][32]}}, initialValue[i], {(2*i){1'b0}}};
    end
endgenerate

// assign oP = shiftedInitialValue[0] + shiftedInitialValue[1] + shiftedInitialValue[2] + shiftedInitialValue[3] + shiftedInitialValue[4] + shiftedInitialValue[5] + shiftedInitialValue[6] + shiftedInitialValue[7] + shiftedInitialValue[8] + shiftedInitialValue[9] + shiftedInitialValue[10] + shiftedInitialValue[11] + shiftedInitialValue[12] + shiftedInitialValue[13] + shiftedInitialValue[14] + shiftedInitialValue[15];


// need to make sure that sign extension is done properly.
// wire signed [38:0] iCSA1[3:0][3:0];
// wire signed [39:0] oCSA1[3:0][1:0];
// genvar j;
// generate
//     // i is the index of each reducer in the first layer.
//     for (i = 0; i < 4; i = i + 1) begin : gen_CSA1
//         for (j = 0; j < 4; j = j + 1)
//             assign iCSA1[i][j] = {{(6-2*j){initialValue[4*i+j][32]}}, initialValue[4*i+j], {2*j{1'b0}}};
//         Reducer4to2_Nbit #(39) CSA1_i(
//             .iW(iCSA1[i][3]), .iX(iCSA1[i][2]), .iY(iCSA1[i][1]), .iZ(iCSA1[i][0]), .iCarry(1'b0), 
//             .oSum1(oCSA1[i][1][39:1]), .oSum0(oCSA1[i][0][39:0]));
//         assign oCSA1[i][1][0] = 1'b0;
//     end
// endgenerate

// assign oP = iCSA1[0][0] + iCSA1[0][1] + iCSA1[0][2] + iCSA1[0][3] + {iCSA1[1][0], 8'b0} + {iCSA1[1][1], 8'b0} + {iCSA1[1][2], 8'b0} + {iCSA1[1][3], 8'b0} + {iCSA1[2][0], 16'b0} + {iCSA1[2][1], 16'b0} + {iCSA1[2][2], 16'b0} + {iCSA1[2][3], 16'b0} + {iCSA1[3][0], 24'b0} + {iCSA1[3][1], 24'b0} + {iCSA1[3][2], 24'b0} + {iCSA1[3][3], 24'b0};

// assign oP = {{24{oCSA1[0][0][39]}}, oCSA1[0][0]} + {{24{oCSA1[0][1][39]}}, oCSA1[0][1]} + {{16{oCSA1[1][0][39]}}, oCSA1[1][0], 8'b0} + {{16{oCSA1[1][1][39]}}, oCSA1[1][1], 8'b0} + {{8{oCSA1[2][0][39]}}, oCSA1[2][0], 16'b0} + {{8{oCSA1[2][1][39]}}, oCSA1[2][1], 16'b0} + {oCSA1[3][0], 24'b0} + {oCSA1[3][1], 24'b0};

// Carry-Save Addition using 4-to-2 reducers.
/* same as this but with 32-bit numbers.
0 0000 0000 0000 0000
------00000000000000000 i = 0, j = 0
----00000000000000000--        j = 1
--00000000000000000----        j = 2
00000000000000000------        j = 3
....................... i = 1, j = 0
*/
// need to make sure that sign extension is done properly.
wire signed [2*N-1:0] iCSA1[3:0][3:0];
wire signed [2*N:0] oCSA1[3:0][1:0];
genvar j;
generate
    // i is the index of each reducer in the first layer.
    for (i = 0; i < 4; i = i + 1) begin : gen_CSA1
        for (j = 0; j < 4; j = j + 1)
            assign iCSA1[i][j] = shiftedInitialValue[4*i+j];
        Reducer4to2_Nbit #(2*N) CSA1_i(
            .iW(iCSA1[i][3]), .iX(iCSA1[i][2]), .iY(iCSA1[i][1]), .iZ(iCSA1[i][0]), .iCarry(1'b0), 
            .oSum1(oCSA1[i][1][2*N:1]), .oSum0(oCSA1[i][0][2*N:0]));
        assign oCSA1[i][1][0] = 1'b0;
    end
endgenerate

// assign oP = oCSA1[0][0] + oCSA1[0][1] + oCSA1[1][0] + oCSA1[1][1] + oCSA1[2][0] + oCSA1[2][1] + oCSA1[3][0] + oCSA1[3][1];

// CSA Layer 1: 16 numbers (33-bit each+shifts) -> 4*4-to-2 reducers. -> 8 numbers (40-bit each + shifts)

// 1 shift may occur due to multiplication by 2 (just condidering numbers as 33 bit for this sake). 2 shifts due to increase in place value.

// 1st number shifted 0 -> 32:0 (33 bit)
// 2nd number shifted 2 -> 34:2
// 3rd number shifted 4 -> 36:4 
// 4th number shifted 6 -> 38:6 
// 38-0+1=39-bit vectors coming out of CSA11. shifted by 0.
// 39:1 for c11, 38:0 for s11, and 39:39 for c_out11 (last bit of s).
// may be fewer bits since there is some missed overlap. (the first 2 bits can go straight to the output)

// 5th number shifted 8   -> 40:8
// 6th number shifted 10 -> 42:10
// 7th number shifted 12 -> 44:12
// 8th number shifted 14 -> 46:14
// 46-8+1=39-bit vectors coming out of CSA11. shifted by 8.
// 47:9 for c12, 46:8 for s12, and 47:47 for c_out12 (last bit of s).

// 9th number shifted 16  -> 48:16
// 10th number shifted 18 -> 50:18
// 11th number shifted 20 -> 52:20
// 12th number shifted 22 -> 54:22
// 54-16+1=39-bit vectors coming out of CSA11. shifted by 16.
// 55:17 for c13, 54:16 for s13, and 55:55 for c_out13 (last bit of s).

// 13th number shifted 24 -> 56:24
// 14th number shifted 26 -> 58:26
// 15th number shifted 28 -> 60:28
// 16th number shifted 30 -> 62:30
// 62-24+1=39-bit vectors coming out of CSA11. shifted by 24.
// 63:25 for c14, 62:24 for s14, and 63:63 for c_out14 (last bit of s).

// wire [47:0] iCSA2[1:0][3:0];
// wire [48:0] oCSA2[1:0][1:0];
// generate
//     for (i = 0; i < 2; i = i + 1) begin : gen_CSA2
//         // Sign extension from previous layer.
//         assign iCSA2[i][0] = {{8{oCSA1[2*i][0][39]}}, oCSA1[2*i][0]};
//         assign iCSA2[i][1] = {{8{oCSA1[2*i][1][39]}}, oCSA1[2*i][1]};
//         assign iCSA2[i][2] = {oCSA1[2*i+1][0], 8'b0};
//         assign iCSA2[i][3] = {oCSA1[2*i+1][1], 8'b0};
//         Reducer4to2_Nbit #(48) CSA2_i(
//             .iW(iCSA2[i][3]), .iX(iCSA2[i][2]), .iY(iCSA2[i][1]), .iZ(iCSA2[i][0]), .iCarry(1'b0), 
//             .oSum1(oCSA2[i][1][48:1]), .oSum0(oCSA2[i][0][48:0]));
//         assign oCSA2[i][1][0] = 1'b0;
//     end
// endgenerate
wire [2*N-1:0] iCSA2[1:0][3:0];
wire [2*N:0] oCSA2[1:0][1:0];
generate
    for (i = 0; i < 2; i = i + 1) begin : gen_CSA2
        // Sign extension from previous layer.
        assign iCSA2[i][0] = oCSA1[2*i][0][63:0];
        assign iCSA2[i][1] = oCSA1[2*i][1][63:0];
        assign iCSA2[i][2] = oCSA1[2*i+1][0][63:0];
        assign iCSA2[i][3] = oCSA1[2*i+1][1][63:0];
        Reducer4to2_Nbit #(2*N) CSA2_i(
            .iW(iCSA2[i][3]), .iX(iCSA2[i][2]), .iY(iCSA2[i][1]), .iZ(iCSA2[i][0]), .iCarry(1'b0), 
            .oSum1(oCSA2[i][1][64:1]), .oSum0(oCSA2[i][0][64:0]));
        assign oCSA2[i][1][0] = 1'b0;
    end
endgenerate

// CSA Layer 2: 8 numbers (40-bit each) -> 2*4-to-2 reducers. -> 4 numbers

// 1st number shifted 0 -> 39:0 oCSA1[0][0]
// 2nd number shifted 0 -> 39:0 oCSA1[0][1]
// 3rd number shifted 8 -> 47:8 oCSA1[1][0]
// 4th number shifted 8 -> 47:8 oCSA1[1][1]
// 47-0+1=48-bit vectors coming out of CSA21. shifted by 0.
// 48:1 for c21, 47:0 for s21, and 48:48 for c_out21 (last bit of s).
// two 49-bit numbers to add in the next layer, shifted by 0.

// 5th number shifted 16 -> 55:16 oCSA1[2][0]
// 6th number shifted 16 -> 55:16 oCSA1[2][1]
// 7th number shifted 24 -> 63:24 oCSA1[3][0]
// 8th number shifted 24 -> 63:24 oCSA1[3][1]
// 63-16+1=48-bit vectors coming out of CSA21. shifted by 16.
// 64:17 for c22, 63:16 for s22, and 64:64 for c_out22 (last bit of s).
// two 49-bit numbers to add in the next layer, shifted by 16.

// wire [64:0] iCSA3[3:0];
// wire [65:0] oCSA3[1:0];

// assign iCSA3[0] = {{16{oCSA2[0][0][48]}}, oCSA2[0][0]};
// assign iCSA3[1] = {{16{oCSA2[0][1][48]}}, oCSA2[0][1]};
// assign iCSA3[2] = {oCSA2[1][0], 16'b0};
// assign iCSA3[3] = {oCSA2[1][1], 16'b0};
// Reducer4to2_Nbit #(65) CSA3(
//     .iW(iCSA3[3]), .iX(iCSA3[2]), .iY(iCSA3[1]), .iZ(iCSA3[0]), .iCarry(1'b0), 
//     .oSum1(oCSA3[1][65:1]), .oSum0(oCSA3[0][65:0]));
// assign oCSA3[1][0] = 1'b0;
wire [2*N-1:0] iCSA3[3:0];
wire [2*N:0] oCSA3[1:0];

generate
    for (i = 0; i < 4; i = i + 1) 
        assign iCSA3[i] = oCSA2[i/2][i%2][2*N-1:0];
endgenerate
Reducer4to2_Nbit #(64) CSA3(
    .iW(iCSA3[3]), .iX(iCSA3[2]), .iY(iCSA3[1]), .iZ(iCSA3[0]), .iCarry(1'b0), 
    .oSum1(oCSA3[1][64:1]), .oSum0(oCSA3[0][64:0]));
assign oCSA3[1][0] = 1'b0;

// CSA Layer 3: 4 numbers (49-bit each) -> 1*4-to-2 reducer -> 2 numbers (63-bit each)

// 1st number shifted 0 -> 48:0
// 2nd number shifted 0 -> 48:1
// 3rd number shifted 16 -> 64:16
// 4th number shifted 16 -> 64:17
// 64-0+1=65-bit vectors coming out of CSA31. shifted by 0.
// 65:1 for c31, 64:0 for s31, and 65:65 for c_out31 (last bit of s).
// two 66-bit numbers to add in the next layer. (the bits don't actually add up that much, but I'm just going to keep it as 66 for now).

// Carry-Propagate Addition using final 2 outputs from carry-save adders.

// // Should change to use the CLA adder.
assign oP = oCSA3[1][63:0] + oCSA3[0][63:0];

endmodule

module BoothEncode_2bit_Nbit #(parameter N = 32) (input signed [N-1:0] iA, output [(N+1)/2-1:0] oSign, output [(N+1)/2-1:0] oMagnitude1, output [(N+1)/2-1:0] oMagnitude0);

wire [N+2:0] A2;
assign A2 = {iA[N-1], iA, 1'b0};


genvar i;
generate
    for (i = 1; i < N+1; i = i + 2) begin : gen
        BoothEncode_2bit be2bit(A2[i+1:i-1], oSign[i/2], {oMagnitude1[i/2], oMagnitude0[i/2]});
    end
endgenerate
endmodule


// 0, 1, 2, -2, -1,
// 1 bit for sign: 0 = positive/zero, 1 = negative
// 2 bits for magnitude: 0 = 00, 1 = 01, 2 = 10
// table
//     // iA  : oSign  oMagnitude
//     3'b000 : 0      2'b00;
//     3'b001 : 0      2'b01;
//     3'b010 : 0      2'b01;
//     3'b011 : 0      2'b10;
//     3'b100 : 1      2'b10;
//     3'b101 : 1      2'b01;
//     3'b110 : 1      2'b01;
//     3'b111 : 0      2'b00; // making sure that there is no sign for zero.
// endtable
module BoothEncode_2bit(input [2:0] iA, output oSign, output [1:0] oMagnitude);

assign oSign = iA[2] & (~iA[1] | ~iA[0]);
assign oMagnitude[0] = iA[1] ^ iA[0];
assign oMagnitude[1] = (iA[2] && !(iA[1] || iA[0])) || (!iA[2] && (iA[1] && iA[0]));

endmodule

module Reducer4to2_Nbit #(parameter N = 32) (input [N-1:0] iW, input [N-1:0] iX, input [N-1:0] iY, input [N-1:0] iZ, input iCarry, output [N-1:0] oSum1, output [N:0] oSum0);

wire carry [N:0];

assign carry[0] = iCarry;

genvar i;
generate
for (i = 0; i < N; i = i + 1) begin : gen
    Reducer4to2 r4to2({iW[i], iX[i], iY[i], iZ[i]}, carry[i], {oSum1[i], oSum0[i]}, carry[i+1]);
end
endgenerate

assign oSum0[N] = carry[N];

endmodule

// oCarry is of the same place value of the most significant bit of the sum.
module Reducer4to2 (input [3:0] iA, input iCarry, output [1:0] oSum, output oCarry);
wire w, x, y, z;
assign {w, x, y, z} = iA;

// used Karnaugh Maps to simplify the equations (https://www.charlie-coleman.com/experiments/kmap/)
// All the commented out assignments are equivalent to the uncommented equations.

// may have to reduce max fan out of the following equation. Currently, it is 9.
// assign oSum[1] = (iCarry | w) & (iCarry | x) & (iCarry | y) & (iCarry | z) & (w | x | y | z) & (w | x | ~y | ~z) & (w | ~x | y | ~z) & (w | ~x | ~y | z) & (~w | x | y | ~z) & (~w | x | ~y | z) & (~w | ~x | y | z);
// assign oSum[1] = (w & x & y & z) | (iCarry & ~w & ~x & ~y & z) | (iCarry & ~w & ~x & y & ~z) | (iCarry & ~w & x & ~y & ~z) | (iCarry & x & y & z) | (iCarry & w & ~x & ~y & ~z) | (iCarry & w & y & z) | (iCarry & w & x & z) | (iCarry & w & x & y);
assign oSum[1] = (w & x & y & z) | (iCarry & (w ^ x ^ y ^ z));


// may have to reduce fan out of the following equation. Currently, it is 16.
// assign oSum[0] = (iCarry | w | x | y | z) & (iCarry | w | x | ~y | ~z) & (iCarry | w | ~x | y | ~z) & (iCarry | w | ~x | ~y | z) & (iCarry | ~w | x | y | ~z) & (iCarry | ~w | x | ~y | z) & (iCarry | ~w | ~x | y | z) & (iCarry | ~w | ~x | ~y | ~z) & (~iCarry | w | x | y | ~z) & (~iCarry | w | x | ~y | z) & (~iCarry | w | ~x | y | z) & (~iCarry | w | ~x | ~y | ~z) & (~iCarry | ~w | x | y | z) & (~iCarry | ~w | x | ~y | ~z) & (~iCarry | ~w | ~x | y | ~z) & (~iCarry | ~w | ~x | ~y | z);
// assign oSum[0] = (~iCarry & ~w & ~x & ~y & z) | (~iCarry & ~w & ~x & y & ~z) | (~iCarry & ~w & x & ~y & ~z) | (~iCarry & ~w & x & y & z) | (~iCarry & w & ~x & ~y & ~z) | (~iCarry & w & ~x & y & z) | (~iCarry & w & x & ~y & z) | (~iCarry & w & x & y & ~z) | (iCarry & ~w & ~x & ~y & ~z) | (iCarry & ~w & ~x & y & z) | (iCarry & ~w & x & ~y & z) | (iCarry & ~w & x & y & ~z) | (iCarry & w & ~x & ~y & z) | (iCarry & w & ~x & y & ~z) | (iCarry & w & x & ~y & ~z) | (iCarry & w & x & y & z);
assign oSum[0] = iCarry ^ w ^ x ^ y ^ z;

// Two or more of the inputs are 1.
// assign oCarry = (y & z) | (x & z) | (x & y) | (w & z) | (w & y) | (w & x);
assign oCarry = (w | x | y) & (w | x | z) & (w | y | z) & (x | y | z);

endmodule
