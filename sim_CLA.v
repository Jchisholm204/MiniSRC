`timescale 1ps/1ps
module sim_CLA();

wire iCarry, Carry, Overflow, Zero, Negative;
reg [31:0] X, Y;
wire [31:0] sum;

CLA adder(
    .iX(X),
    .iY(Y),
    .iCarry(1'b0),
    .oS(sum),
    .oCarry(Carry),
    .oOverflow(Overflow),
    .oZero(Zero),
    .oNegative(Negative)
);

initial begin
    X = 32'd5;
    Y = 32'd10;
    #10
    X = 32'd1;
    Y = 32'd7;
    #10
    X = 32'd400;
    Y = 32'd33;
end


endmodule