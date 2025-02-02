`timescale 1ms/1ps

module sim_Reducer4to2_Nbit #(parameter N = 32);

reg [4*N:0] I;

wire [N-1:0] A[0:3];
wire iCarry;

assign {iCarry, A[3], A[2], A[1], A[0]} = I;

wire [N:0] oSum[0:1];
assign oSum[1][0] = 1'b0;

Reducer4to2_Nbit #(N) reducer4to2(A[0], A[1], A[2], A[3], iCarry, oSum[1][N:1], oSum[0][N:0]);

wire [N+3:0] sim_finalSum;

wire [N+3:0] ref_finalSum;

assign sim_finalSum = oSum[1] + oSum[0];
assign ref_finalSum = A[3] + A[2] + A[1] + A[0] + iCarry;

wire success;
assign success = sim_finalSum === ref_finalSum;


integer seed1 = 1;
integer seed2 = 2;
integer seed3 = 3;
integer seed4 = 4;
integer seed5 = 5;
initial begin: test
    integer i;
    for (i = 0; i < 100; i = i + 1) begin
        I = {$random(seed1), $random(seed2), $random(seed3), $random(seed4), $random(seed5)};
        if (!success) begin
            $display("Error: {iCarry, A[3], A[2], A[1], A[0]}=%b, sim_finalSum=%b, ref_finalSum=%b", {iCarry, A[3], A[2], A[1], A[0]}, sim_finalSum, ref_finalSum);
        end else begin
            $display("Success: {iCarry, A[3], A[2], A[1], A[0]}=%b, sim_finalSum=%b, ref_finalSum=%b", {iCarry, A[3], A[2], A[1], A[0]}, sim_finalSum, ref_finalSum);
        end
        #1;
    end
end

endmodule