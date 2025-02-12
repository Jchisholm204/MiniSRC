`timescale 1ns / 1ps
module sim_BoothEncode_2bit_Nbit #(parameter N = 32);

reg signed [N-1:0] iA;
wire [(N+1)/2-1:0] oSign;
wire [1:0] Magnitude [N/2-1:0];

wire [N-1:0] oMagnitude;

wire signed [3:0] booth_values_2s_complement [N/2-1:0];

generate 
    genvar i;
    for (i = 0; i < N/2; i = i + 1) begin : gen
        assign Magnitude[i][1] = oMagnitude[i+N/2];
        assign Magnitude[i][0] = oMagnitude[i];
        assign booth_values_2s_complement[i] = oSign[i] == 0 ? {1'b0, Magnitude[i]} : ~{1'b0, Magnitude[i]} + 1;
    end
endgenerate

BoothEncode_2bit_Nbit #(N) uut (
    iA,
    oSign,
    oMagnitude[N-1:(N+1)/2],
    oMagnitude[(N+1)/2-1:0]
);

reg signed [N-1:0] sim_sum;

wire success;
assign success = sim_sum === iA;

initial begin: test
    // integer i;
    // for (i = 0; i < 100; i = i + 1) begin
    while (1) begin
        iA = $random;
        #1;
    end
end
always @(sim_sum) begin
    if (!success) begin
        $display("Error: iA=%d, sim_sum=%d", iA, sim_sum);
    end else begin
        $display("Success: iA=%d, sim_sum=%d", iA, sim_sum);
    end
end

always @(iA) begin: check
    integer j;
    sim_sum = 0;
    for (j = 0; j < N/2; j = j + 1) begin
        if (oSign[j] == 0) begin
            sim_sum = sim_sum + Magnitude[j]*(1 << (2*j)); 
        end else begin
            sim_sum = sim_sum - Magnitude[j]*(1 << (2*j));
        end
    end
end

endmodule