`timescale 1ms/1ps
module sim_DIV32();

reg [32:0] Q, D;
wire [32:0] rez, rmdr;


DIV32 divider(
    .iQ(Q),
    .iD(D),
    .oQ(rez),
    .oR(rmdr)
);

initial begin
    Q = 32'd8;
    D = 32'd3;
    #1
    Q = 32'd44;
    D = 32'd11;
    #1
    Q = 32'd3;
    D = 32'd3;
    #1
    Q = 32'd447;
    D = 32'd12;
    #1
    Q = 32'd3000;
    D = 32'd200;
    #1
    Q = 32'd300;
    D = 32'd20;
    #1
    Q = 32'd30;
    D = 32'd2;

end


endmodule
