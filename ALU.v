
module ALU(A, B, C0, C1, control, conditions);

input wire [31:0] A, B;
input wire [3:0] control;
output wire [31:0 ]C0, C1;
output wire conditions;

wire [31:0] adder_out, subtraction_out, or_out, and_out, divide_out, multiplication_out;

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
/ ------------ Division Logic --------------
*/
assign divide_out = A/B;

/*
/ ------------ Multiplication Logic --------------
*/
assign multiplication_out = A*B;


// 16-1 Mux to select which module to connect to C1
Mux16_1_32b m(
    .sel(control),
    .in0(adder_out),    // add
    .in1(adder_out),    // subtract
    .in2(or_out),       // orr
    .in3(and_out),
    .in4(divide_out),
    .in5(multiplication_out),
    // .int6(32'd0),
    // .int7(32'd0),
    // .int8(32'd0),
    // .int9(32'd0),
    // .int10(32'd0),
    // .int11(32'd0),
    // .int12(32'd0),
    // .int13(32'd0),
    // .int14(32'd0),
    // .int15(32'd0),
    .out(C0)
);

endmodule