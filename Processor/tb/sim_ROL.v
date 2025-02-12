`timescale 1ns/1ps
module sim_ROL_ROR();

reg [31:0] IN;
reg [4:0] sham = 5'd0;
wire [31:0] ROL_out, ROR_out;

ROL rol(
    .iD(IN),
    .iShamt(sham),
    .oD(ROL_out)
);

ROR ror(
    .iD(IN),
    .iShamt(sham),
    .oD(ROR_out)
);

initial begin
    IN = 32'hF000000F;
    #1
    sham = 5'd1;
    #1
    sham = 5'd2;
    #1
    sham = 5'd3;
    #1
    sham = 5'd4;
    #1
    sham = 5'd5;
end

endmodule