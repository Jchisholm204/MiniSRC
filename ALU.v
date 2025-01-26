
module ALU(A, B, C0, C1, control, zero);

input wire [31:0] A, B;
input wire [3:0] control;
output wire [31:0 ]C0, C1;
output wire zero;

wire [31:0] adder_out, subtraction_out, or_out, and_out, div_out, mul_out, shr_out, shra_out, shl_out, neg_out, not_out, rotr_out, rotl_out;

/*
/ ------------ Addition and Subtraction Logic --------------
*/
wire [31:0] B_xor, m1_out;
// ~c3 & ~c2 & ~c1 & c0
wire sub_en = (~control[3]) & (~control[2]) & (~control[1]) & control[0];

assign B_xor = B ^ 32'hFFFFFFFF;

Mux2_1_32b m1(
    .in0(A),
    .in1(B_xor),
    .out(m1_out),
    .sel(sub_en)
);

FastAdder a(
    .x_in(A),
    .y_in(m1_out),
    .c_in(sub_en),
    .sum_out(adder_out)
);

/*
/ ------------ OR Logic --------------
*/
assign or_out = A | B;

/*
/ ------------ AND Logic --------------
*/
assign and_out = A & B;

/*
/ ------------ Rotate RIght Logic --------------
*/
assign rotr_out = A>>B;

/*
/ ------------ Rotate Left Logic --------------
*/
assign rotl_out = A<<B;

/*
/ ------------ Shift Right Logic --------------
*/
assign shr_out = A>>B;           

/*
/ ------------ Shift Right A Logic --------------
*/
assign shra_out = A>>B;                               // what do i put for this?

/*
/ ------------ Shift Left Logic --------------
*/
assign shl_out = A<<B;

/*
/ ------------ Division Logic --------------
*/
assign div_out = A/B;

/*
/ ------------ Multiplication Logic --------------
*/
assign mul_out = A*B;

/*
/ ------------ Negate Logic --------------
*/
assign neg_out = ~A;

/*
/ ------------ NOT Logic --------------      // what do i put for this?
*/
assign not_out = ~A;


// 16-1 Mux to select which module to connect to C1
Mux16_1_32b m(
    .sel(5'd0 | control),
    .in0(adder_out),    // add
    .in1(adder_out),    // sub
    .in2(and_out),      
    .in3(or_out),
    .in4(rotr_out),
    .in5(rotl_out),
    .in6(shr_out),
    .in7(shra_out),
    .in8(shl_out),
    .in9(div_out),
    .in10(mul_out),
    .in11(neg_out),
    .in12(not_out),
    .in13(32'd0),
    .in14(32'd0),
    .in15(32'd0),
    .out(C0)
);

assign zero = (C0 == 32'd0) ? 1 : 0;

endmodule