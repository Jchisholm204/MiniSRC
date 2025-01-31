`timescale 1ps/1ps
module sim_ALU();

reg [31:0] A, B;
wire [31:0] C_hi, C_lo;
reg [3:0] Ctrl;
wire zero, neg;

ALU alu(
    .iA(A),
    .iB(B),
    .iCtrl(Ctrl),
    .oC({C_hi, C_lo}),
    .oZero(zero),
    .oNeg(neg)
);

initial begin
    // Add Testing
    Ctrl = alu.ALUC_ADD;
    A = 32'd5;
    B = 32'd5;
    // Res = 10
    #1
    A = 32'd12;
    B = 32'd400;
    // Rez = 412
    #1
    A = -32'd5;
    B = 32'd5;
    // Rez = 0
    #1
    A = -32'd5;
    B = -32'd5;
    // Rez = -10
    #1
    A = 32'd33;
    B = -32'd3;
    // Rez = -10
    #1
    // SUB Testing
    Ctrl = alu.ALUC_SUB;
    A = 32'd5;
    B = 32'd5;
    // Res = 0
    #1
    A = 32'd12;
    B = 32'd400;
    // Rez = -388
    #1
    A = -32'd5;
    B = 32'd5;
    // Rez = -10
    #1
    A = -32'd5;
    B = -32'd5;
    // Rez = 0
    #1
    A = 32'd33;
    B = -32'd3;
    // Rez = -36
end

endmodule