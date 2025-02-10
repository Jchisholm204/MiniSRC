`timescale 1ns/1ps
module sim_DIV32();

reg [31:0] Q, D;
wire [31:0] rez, rmdr;

DIV32 divider(
    .iQ(Q),
    .iD(D),
    .oQ(rez),
    .oR(rmdr)
);

wire [31:0] ref_rez, ref_rmdr;
wire success_rez, success_rmdr, success;

assign ref_rez = Q / D;
assign ref_rmdr = Q % D;

assign success_rez = rez == ref_rez;
assign success_rmdr = rmdr == ref_rmdr;
assign success = success_rez && success_rmdr;

integer seedQ = 1;
integer seedD = 2;
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
    #1
    Q = 32'h24;
    D = 32'h22;
    #1
    // edge cases
    Q = 32'd0;
    D = 32'd0;
    #1
    Q = 32'd1;
    D = 32'd0;
    #1
    Q = 32'h7000000;
    D = 32'd1;
    #1
    Q = 32'h7000000;
    D = 32'd2;
    #1
    Q = 32'h7000000;
    D = 32'h7000000;
    #1
    Q = 32'h7000000;
    D = 32'h7FFFFFF;
    #1
    Q = 32'h7FFFFFF;
    D = 32'h7000000;
    #1
    Q = 32'h7FFFFFF;
    D = 32'h7FFFFFF;
    #1
    Q = 32'h7FFFFFF;
    D = 32'd1;
    #1
    Q = 32'h7FFFFFF;
    D = 32'd2;
    #1
    Q = 32'd1;
    D = 32'h7000000;
    #1
    while (1) begin
        // forcing Q and D to be positive signed 2's-complement numbers.
        Q = $random(seedQ) & 32'h00FFFFFF;
        D = $random(seedD) & 32'h000FFFFF;
        if (!success) begin
            $display("FAILURE: Q = %h, D = %h, rez = %h, ref_rez = %h, rmdr = %h, ref_rmdr = %h", Q, D, rez, ref_rez, rmdr, ref_rmdr);
        end else begin
            $display("SUCCESS: Q = %h, D = %h, rez = %h, ref_rez = %h, rmdr = %h, ref_rmdr = %h", Q, D, rez, ref_rez, rmdr, ref_rmdr);
        end
        #1;
    end
end


endmodule
