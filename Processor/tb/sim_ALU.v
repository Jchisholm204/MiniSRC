`timescale 1ps/1ps
module sim_ALU();

reg [31:0] A, B;
wire [31:0] C_hi, C_lo;
reg [3:0] Ctrl;
wire zero, neg;

ALU alu(
    .iA(A),
    .iB(B),
    .iCtrl(Ctrl),
    .oC_hi(C_hi),
    .oC_lo(C_lo),
    .oZero(zero),
    .oNeg(neg)
);

integer i;
integer j;
initial begin
    // Add Testing
    Ctrl = alu.ALUC_ADD;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_lo != (A+B))
                $display ("Add Failure %0d + %0d = %0d", A, B, C_lo);
            // else
            //     $display ("Add Success %0d + %0d = %0d", A, B, C_lo);
        end
    end
    // Subtraction Testing
    Ctrl = alu.ALUC_SUB;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_lo != (A-B))
                $display ("SUB Failure %0d + %0d = %0d", A, B, C_lo);
        end
    end
    // OR Test
    Ctrl = alu.ALUC_OR;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_lo != (A | B))
                $display ("OR Failure %0d + %0d = %0d", A, B, C_lo);
        end
    end
    // XOR  Test
    Ctrl = alu.ALUC_XOR;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_lo != (A ^ B))
                $display ("XOR Failure %0d + %0d = %0d", A, B, C_lo);
        end
    end
    // AND  Test
    Ctrl = alu.ALUC_AND;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_lo != (A & B))
                $display ("AND Failure %0d + %0d = %0d", A, B, C_lo);
        end
    end
    // DIV  Test
    Ctrl = alu.ALUC_DIV;
    for(i = 0; i < 31; i = i + 1) begin
        A = 32'b1 << i;  // Set only the i-th bit
        for(j = 0; j < 31; j = j + 1) begin
            B = 32'b1 << j;  // Set only the i-th bit
            #1
            if(C_hi != (A / B) || C_lo != (A % B))
                $display ("DIV Failure %0d / %0d = %0d %0d", A, B, C_hi, C_lo);
        end
    end
    for(i = 1000; i < 5000; i = i + 1) begin
        A = -i;
        for(j = 0; j < 1000; j = j + 1) begin
            #1
            B = 500 - j;
            // #1
            // Must verify manually - negative division has issues in v
            // if(C_hi != (A / B) || C_lo != (A % B))
            //     $display ("DIV Failure %0d / %0d = %0d %0d", A, B, C_hi, C_lo);
        end
    end
end

endmodule