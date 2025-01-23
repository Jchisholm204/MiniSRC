module registers(
    iClk, nRst, iWrite,
    iAddrA, iAddrB, iAddrC,
    oRegA, oRegB, iRegC
);

// Module IO
input wire iClk, nRst, iWrite;
input wire [3:0] iAddrA, iAddrB, iAddrC;
output wire [31:0] oRegA, oRegB;
input wire [31:0] iRegC;


// Register IO
wire r1_write, r2_write, r3_write, r5_write, r6_write,
     r7_write, r8_write, r9_write, r10_write, r11_write,
     r12_write, r13_write, r14_write, r15_write;

wire [31:0] r1_out, r2_out, r3_out, r4_out, r5_out,
            r6_out, r7_out, r8_out, r9_out, r10_out,
            r11_out, r12_out, r13_out, r14_out, r15_out;

// Write Signal Assert
assign r1_write  = (iAddrC == 4'b0001) && iWrite;
assign r2_write  = (iAddrC == 4'b0010) && iWrite;
assign r3_write  = (iAddrC == 4'b0011) && iWrite;
assign r4_write  = (iAddrC == 4'b0100) && iWrite;
assign r5_write  = (iAddrC == 4'b0101) && iWrite;
assign r6_write  = (iAddrC == 4'b0110) && iWrite;
assign r7_write  = (iAddrC == 4'b0111) && iWrite;
assign r8_write  = (iAddrC == 4'b1000) && iWrite;
assign r9_write  = (iAddrC == 4'b1001) && iWrite;
assign r10_write = (iAddrC == 4'b1010) && iWrite;
assign r11_write = (iAddrC == 4'b1011) && iWrite;
assign r12_write = (iAddrC == 4'b1100) && iWrite;
assign r13_write = (iAddrC == 4'b1101) && iWrite;
assign r14_write = (iAddrC == 4'b1110) && iWrite;
assign r15_write = (iAddrC == 4'b1111) && iWrite;


// Output Register A assignment
assign oRegA =  (iAddrA == 4'b0001) ? r1_out  :
                (iAddrA == 4'b0010) ? r2_out  :
                (iAddrA == 4'b0011) ? r3_out  :
                (iAddrA == 4'b0100) ? r4_out  :
                (iAddrA == 4'b0101) ? r5_out  :
                (iAddrA == 4'b0110) ? r6_out  :
                (iAddrA == 4'b0111) ? r7_out  :
                (iAddrA == 4'b1000) ? r8_out  :
                (iAddrA == 4'b1001) ? r9_out  :
                (iAddrA == 4'b1010) ? r10_out :
                (iAddrA == 4'b1011) ? r11_out :
                (iAddrA == 4'b1100) ? r12_out :
                (iAddrA == 4'b1101) ? r13_out :
                (iAddrA == 4'b1110) ? r14_out :
                (iAddrA == 4'b1111) ? r15_out :
                32'd0;

// Output Register A assignment
assign oRegB =  (iAddrB == 4'b0001) ? r1_out  :
                (iAddrB == 4'b0010) ? r2_out  :
                (iAddrB == 4'b0011) ? r3_out  :
                (iAddrB == 4'b0100) ? r4_out  :
                (iAddrB == 4'b0101) ? r5_out  :
                (iAddrB == 4'b0110) ? r6_out  :
                (iAddrB == 4'b0111) ? r7_out  :
                (iAddrB == 4'b1000) ? r8_out  :
                (iAddrB == 4'b1001) ? r9_out  :
                (iAddrB == 4'b1010) ? r10_out :
                (iAddrB == 4'b1011) ? r11_out :
                (iAddrB == 4'b1100) ? r12_out :
                (iAddrB == 4'b1101) ? r13_out :
                (iAddrB == 4'b1110) ? r14_out :
                (iAddrB == 4'b1111) ? r15_out :
                (iAddrB == 4'b10000) ? r16_out :
                32'd0;

// Registers
REG32 r1(  .iClk(iClk), .nRst(nRst), .iEn(r1_write),  .iD(iRegC), .oQ(r1_out)  );
REG32 r2(  .iClk(iClk), .nRst(nRst), .iEn(r2_write),  .iD(iRegC), .oQ(r2_out)  );
REG32 r3(  .iClk(iClk), .nRst(nRst), .iEn(r3_write),  .iD(iRegC), .oQ(r3_out)  );
REG32 r4(  .iClk(iClk), .nRst(nRst), .iEn(r4_write),  .iD(iRegC), .oQ(r4_out)  );
REG32 r5(  .iClk(iClk), .nRst(nRst), .iEn(r5_write),  .iD(iRegC), .oQ(r5_out)  );
REG32 r6(  .iClk(iClk), .nRst(nRst), .iEn(r6_write),  .iD(iRegC), .oQ(r6_out)  );
REG32 r7(  .iClk(iClk), .nRst(nRst), .iEn(r7_write),  .iD(iRegC), .oQ(r7_out)  );
REG32 r8(  .iClk(iClk), .nRst(nRst), .iEn(r8_write),  .iD(iRegC), .oQ(r8_out)  );
REG32 r9(  .iClk(iClk), .nRst(nRst), .iEn(r9_write),  .iD(iRegC), .oQ(r9_out)  );
REG32 r10( .iClk(iClk), .nRst(nRst), .iEn(r10_write), .iD(iRegC), .oQ(r10_out) );
REG32 r11( .iClk(iClk), .nRst(nRst), .iEn(r11_write), .iD(iRegC), .oQ(r11_out) );
REG32 r12( .iClk(iClk), .nRst(nRst), .iEn(r12_write), .iD(iRegC), .oQ(r12_out) );
REG32 r13( .iClk(iClk), .nRst(nRst), .iEn(r13_write), .iD(iRegC), .oQ(r13_out) );
REG32 r14( .iClk(iClk), .nRst(nRst), .iEn(r14_write), .iD(iRegC), .oQ(r14_out) );
REG32 r15( .iClk(iClk), .nRst(nRst), .iEn(r15_write), .iD(iRegC), .oQ(r15_out) );


endmodule

