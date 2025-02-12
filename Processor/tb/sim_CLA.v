`timescale 1ns/1ps
module sim_CLA();

wire iCarry, Carry, Overflow, Zero, Negative;
reg [31:0] X, Y;
wire [31:0] sum;

wire [31:0] ref_sum;
assign ref_sum = X + Y;

wire success;
assign success = (sum == ref_sum);

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

integer seedX = 1;
integer seedY = 2;
initial begin
    X = 32'd5;
    Y = 32'd10;
    #10
    X = 32'd1;
    Y = 32'd7;
    #10
    X = 32'd400;
    Y = 32'd33;
    #10
    // random tests
    while (1) begin
        X = $random(seedX) & 32'h00FFFFFF;
        Y = $random(seedY) & 32'h00FFFFFF;
        if (!success && !Overflow) begin
            $display("X = %d, Y = %d, sum = %d, ref_sum = %d", X, Y, sum, ref_sum);
        end
        #10;
    end
end


endmodule