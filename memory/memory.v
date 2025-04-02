`include "../Processor/Control/ISA.vh"
`include "../Processor/tb/sim_ISA.vh"
module memory(
    iClk, iRead, iWrite,
    iData, iAddr,
    oData
);

input wire iClk, iRead, iWrite;
input wire [31:0] iData, iAddr;
output reg [31:0] oData;

reg [31:0] mem[0:1023];

wire [31:2] Addri;
assign Addri = iAddr[31:2];

// assign oData = iRead ? mem[Addri] : 32'd0;

always @(posedge iClk) begin
    if(iWrite)
        mem[Addri] <= iData;
    oData <= mem[Addri];
end

// initial $readmemh("program.hex", mem);

initial begin 
    // Set the output port to the value in R1
    mem[0] = `INS_J(`ISA_OUT, 4'h1);
    // Increase R1 by 1
    mem[1] = `INS_I(`ISA_ADDI, 4'h1, 4'h1, 19'd1);
    // Load the counter value from the in port into R2
    mem[2] = `INS_J(`ISA_IN, 4'h2);
    // Loop for the duration of R2
    mem[3] = `INS_I(`ISA_ADDI, 4'h3, 4'h3, 19'd1);
    mem[4] = `INS_R(`ISA_SUB, 4'h4, 4'h2, 4'h3);
    mem[5] = `INS_B(`ISA_BRx, 4'h4, `ISA_BR_POSI, -19'd3);
    mem[6] = `INS_I(`ISA_ADDI, 4'h3, 4'h0, 19'd0);
    // Go back to the beginning of the code
    mem[7] = `INS_J(`ISA_JFR, 4'h0);
end

endmodule