`timescale 1ps/1ps
module sim_DIV();

reg [3:0] Q, D;
wire [3:0] rez, rmdr;

DIV divider(
    .iA(Q),
    .iB(D),
    .oQ(rez),
    .oR(rmdr)
);

initial begin
    Q = 4'd5;
    D = 4'd1;
    #10
    Q = 4'd4;
    D = 4'd2;
    #10
    Q = 4'd3;
    D = 4'd3;
end


endmodule