module fourBitAdder(x_in, y_in, c_in, sum_out, c_out, p_out, g_out);
    input wire [3:0] x_in, y_in;
    input wire c_in;
    output wire [3:0] sum_out;
    output wire c_out, p_out, g_out;

    wire [3:0] c, p, g;

    assign p = x_in | y_in;

    assign g = x_in & y_in;

    assign c[0] = c_in;
    assign c[1] = g[0] | p[0] & c[0];
    assign c[2] = g[1] | p[1] & g[0] | p[1] & p[0] & c[0];
    assign c[3] = g[2] | p[2] & g[1] | p[2] & p[1] & g[0] | p[2] & p[1] & p[0] & c[0];

    assign g_out = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
    assign p_out = p[3] & p[2] & p[1] & p[0];

    assign c_out = g_out | p_out & c_in;
    assign sum_out = x_in ^ y_in ^ c;

endmodule

module sixteenBitAdder(x_in, y_in, c_in, sum_out, c_out, g_out, p_out);
    input wire [15:0] x_in, y_in;
    input wire c_in;
    output wire [15:0] sum_out;
    output wire c_out;
    output wire g_out, p_out;

    wire [3:1] c;

    fourBitAdder a0 (
        .x_in(x_in[3:0]),
        .y_in(y_in[3:0]),
        .c_in(c_in),
        .sum_out(sum_out[3:0])
    );

    assign c[1] = a0.g_out | a0.p_out & c_in;

    fourBitAdder a1 (
        .x_in(x_in[7:4]),
        .y_in(y_in[7:4]),
        .c_in(c[1]),
        .sum_out(sum_out[7:4])
    );

    assign c[2] = a1.g_out | a1.p_out & a0.g_out | a1.p_out & a0.p_out & c_in;

    fourBitAdder a2 (
        .x_in(x_in[11:8]),
        .y_in(y_in[11:8]),
        .c_in(c[2]),
        .sum_out(sum_out[11:8])
    );

    assign c[3] = a2.g_out | a2.p_out & a1.g_out | a2.p_out & a1.p_out & a0.g_out | a2.p_out & a1.p_out & a0.p_out * c_in;

    fourBitAdder a3 (
        .x_in(x_in[15:12]),
        .y_in(y_in[15:12]),
        .c_in(c[3]),
        .sum_out(sum_out[15:12])
    );

    assign c_out = a3.g_out | a3.p_out & a2.g_out | a3.p_out & a2.p_out & a1.g_out | a3.p_out & a2.p_out & a1.p_out & a0.g_out | a3.p_out & a2.p_out & a1.p_out & a0.p_out * c_in;

    assign g_out = a3.g_out | a3.p_out & a2.g_out | a3.p_out & a2.p_out & a1.g_out | a3.p_out & a2.p_out & a1.p_out & a0.g_out;
    assign p_out = a3.p_out & a2.p_out & a1.p_out & a0.p_out;
endmodule

module FastAdder (x_in, y_in, sum_out, c_in, c_out);
input wire [31:0] x_in, y_in;
input wire c_in;
output wire [31:0] sum_out;
output wire c_out;

wire c;

sixteenBitAdder a0(
    .x_in(x_in[15:0]),
    .y_in(y_in[15:0]),
    .c_in(c_in),
    .sum_out(sum_out[15:0]),
    .p_out(),
    .g_out()
);

assign c = a0.g_out | a0.p_out & c_in;

sixteenBitAdder a1(
    .x_in(x_in[31:16]),
    .y_in(y_in[31:16]),
    .c_in(c),
    .sum_out(sum_out[31:16]),
    .p_out(),
    .g_out()
);

assign c_out = a1.g_out | a1.p_out & a0.g_out | a1.p_out & a0.p_out & c_in;
endmodule