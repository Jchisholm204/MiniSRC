`timescale 1ns/1ps

module sim_MUL32;

reg [63:0] I;
wire signed [31:0] a, b;
wire signed [63:0] p_sim, p_ref;

assign {a, b} = I;

MUL32 multiplier (a, b, p_sim);

assign p_ref = $signed(a) * $signed(b);

wire success;
assign success = p_sim === p_ref;

integer seed1 = 1;
integer seed2 = 2;

initial begin: test
    integer i;
    // edge cases
    I = 64'h00000000_00000000;
    #1;
    I = 64'hFFFFFFFF_FFFFFFFF; 
    #1;
    I = 64'h80000000_80000000; 
    #1;
    I = 64'h7FFFFFFF_7FFFFFFF; 
    #1;
    I = 64'h7FFFFFFF_80000000; 
    #1;
    I = 64'h80000000_7FFFFFFF; 
    #1;
    I = 64'h80000000_7FFFFFFE; 
    #1;
    I = 64'h80000000_7FFFFFFD; 
    #1;
    I = 64'h80000000_7FFFFFFC; 
    #1;
    I = 64'h80000000_00000000; 
    #1;
    I = 64'h80000000_00000001; 
    #1;
    I = 64'h80000000_00000002; 
    #1;
    I = 64'h80000000_00000003; 
    #1;
    I = 64'h80000001_7FFFFFFF; 
    #1;
    I = 64'h80000000_FFFFFFFF; 
    #1;
    // i = 0;
    // while (1) begin
        // I[63:32] = 32'h80000000;
        // I[31:0] = i;
        // i = i + 1;
        // #1;
    // end
    // random cases
    while (1) begin
        I = {$random(seed1), $random(seed2)};
        #1;
    end
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
