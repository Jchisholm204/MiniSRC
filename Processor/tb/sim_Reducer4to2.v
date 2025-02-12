`timescale 1ns/1ps

module sim_Reducer4to2;

reg [4:0] A;
wire w, x, y, z, iCarry0;
wire c, s, oCarry1;
wire [2:0] simSum, checkSum;

assign simSum = (c << 1) + s + (oCarry1 << 1);
assign checkSum = w + x + y + z + iCarry0;

assign {iCarry0, w, x, y, z} = A;

Reducer4to2 r4to2({w,x,y,z}, iCarry0, {c, s}, oCarry1);

initial begin
    
    for (A = 0; A < 32; A = A + 1) begin
        if (simSum !== checkSum) begin
            $display("Error: {w, x, y, z, iCarry0}=%b, c=%b, s=%b, oCarry1=%b, simSum=%b, checkSum=%b", {w, x, y, z, iCarry0}, c, s, oCarry1, simSum, checkSum);
        end else begin
            $display("Success: {w, x, y, z, iCarry0}=%b, c=%b, s=%b, oCarry1=%b, simSum=%b, checkSum=%b", {w, x, y, z, iCarry0}, c, s, oCarry1, simSum, checkSum);
        end
        #1;
    end


end

endmodule