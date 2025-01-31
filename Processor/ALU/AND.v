module AND(
    iA, iB, oC
);
input wire [31:0] iA, iB;
output wire [31:0] oC;

generate
    genvar i;
    for(i = 0; i < 32; i = i + 1) begin
        and (oC[i], iA[i], iB[i]);
    end
endgenerate

endmodule