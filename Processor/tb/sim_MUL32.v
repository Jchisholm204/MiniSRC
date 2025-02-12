`timescale 1ns/1ps

module sim_MUL32;

reg [63:0] I;
wire signed [31:0] a, b;
wire signed [63:0] p_sim, p_ref;

assign {a, b} = I;
// assign a_ext = {{32{a[31]}}, a}, b_ext = {{32{b[31]}}, b};

MUL32 multiplier (a, b, p_sim);

assign p_ref = $signed(a) * $signed(b);

wire success;
assign success = p_sim === p_ref;

integer seed1 = 1;
integer seed2 = 2;

initial begin: test
    integer i;
    // edge cases
    I = 64'h00000000_00000000; // success
    #1;
    I = 64'hFFFFFFFF_FFFFFFFF; // success
    #1;
    I = 64'h80000000_80000000; // success
    #1;
    I = 64'h7FFFFFFF_7FFFFFFF; // success
    #1;
    I = 64'h7FFFFFFF_80000000; // success
    #1;
    I = 64'h80000000_7FFFFFFF; // success
    #1;
    I = 64'h80000000_7FFFFFFE; // success
    #1;
    I = 64'h80000000_7FFFFFFD; // success
    #1;
    I = 64'h80000000_7FFFFFFC; // success
    #1;
    I = 64'h80000000_00000000; // success 
    #1;
    I = 64'h80000000_00000001; // success
    #1;
    I = 64'h80000000_00000002; // success
    #1;
    I = 64'h80000000_00000003; // success
    #1;
    I = 64'h80000001_7FFFFFFF; // success
    #1;
    // not any more: These always fail on the top 32 bits, if: 1 < I[31:0] or I[31:0] < -1.
    i = 0;
    while (1) begin
        I[63:32] = 32'h80000000;
        I[31:0] = i;
        i = i + 1;
        #1;
    end
    // random cases
    // while (1) begin
    //     I = {$random(seed1), $random(seed2)};
    //     #1;
    // end
end

always @(p_sim) begin
    if (!success) begin
        $display("Error: a*b=%H*%H, p_sim=%H, p_ref=%H", a, b, p_sim, p_ref);
    end 
    // else begin
    //     $display("Success: a*b=%H * %H, p_sim=%H, p_ref=%H", a, b, p_sim, p_ref);
    // end
end
endmodule
/*
p_sim=407eeb0239880000, p_ref=
      3ffe6b0239880000
sim   9c428a70cc627cb8, p_ref=
      1bc18a70cc627cb8

p_sim=f810b8e962b9819c, p_ref=
      f81038e962b9819c
0011
0011

p_sim=8cf96e437fe35d80, p_ref=
      0cf8ee437fe35d80
*/
