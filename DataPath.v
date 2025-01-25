module Processor(
    iClk,
    nRst,
    mem_data_out,
    mem_data_in,
    mem_addr,
    mem_read,
    mem_write,
    instruction_mem_in,
    instruction_mem_addr,
    instruction_mem_read
);
    // Signels to external things
    input wire iClk, nRst;
    input wire [31:0] mem_data_in, instruction_mem_in;
    output wire mem_read, mem_write, instruction_mem_read;
    output wire [31:0] mem_data_out, mem_addr, instruction_mem_addr;

    // For control unit
    wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable;
    wire mb_select, minc_select;
    wire rf_write;
    wire [1:0] my_select, mc_select;
    wire [3:0] alu_control;

    // For connection between modules
    wire [31:0] rfa_to_ra, rfb_to_rb, ra_to_alua, rb_to_mb, mb_to_alub, aluc0_to_rz0, aluc1_to_rz1, rz0_to_my, rz1_to_my, my_to_ry, ry_to_rfc, rb_to_rm, mc_to_rfac, ir_out;
    wire [31:0] mpc_to_rpc, rpc_out, rpc_temp_to_my, pcadderc_to_mpc, minc_to_pcaddera;
    wire alu_zero_flag;

    REG32 ir(
        .iClk(iClk),
        .iEn(ir_enable),
        .nRst(nRst),                // idk where to connect this
        .iD(instruction_mem_in),   // output of instruction memory
        .oQ(ir_out)                       // into many things
    );

    registers rf(
        .iClk(iClk), 
        .nRst(nRst), 
        .iWrite(rf_write),
        .iAddrA(ir_out[26:23]), 
        .iAddrB(ir_out[22:19]),
        .iAddrC(mc_to_rfac), // mux rf 
        .oRegA(rfa_to_ra), 
        .oRegB(rfb_to_rb), 
        .iRegC(ry_to_rfc)
    );

    Mux4_1_32b mc(
        .in0(ir_out[23:19]),
        .in1(ir_out[18:15]),
        .in2(32'd0),     // link reg
        .in3(32'd0),     // 0's
        .sel(mc_select),
        .out(mc_to_rfac)
    );

    REG32 ra(
        .iClk(iClk),
        .iEn(ra_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(rfa_to_ra),                  // output of register file port A
        .oQ(ra_to_alua)                   // input to ALU port A
    );

    REG32 rb(
        .iClk(iClk),
        .iEn(rb_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(rfb_to_rb),                  // output of register file port A
        .oQ(rb_to_mb)                   // input 0 of Mux b 
    );

    REG32 rm(
        .iClk(iClk),
        .iEn(rm_enable),
        .nRst(nRst),              // idk where to connect this
        .iD(rb_to_rm),
        .oQ(mem_data_out)       // input 0 of Mux b 
    );

    Mux2_1_32b mb(
        .in0(rb_to_mb),
        .in1(32'd0),                 // immediate value
        .sel(mb_select),
        .out(mb_to_alub)                  // input B of ALU
    );

    ALU alu(
        .A(ra_to_alua), 
        .B(mb_to_alub), 
        .C0(aluc0_to_rz0),                  // input to rz0
        .C1(aluc1_to_rz1),                  // input to rz1 
        .control(alu_control),              // 0000 add, 0001, subtract, 0010 or, 0011 and , 0100 divide, 0101 multiply
        .zero(alu_zero_flag)          // output for branch instructions
    );

    REG32 rz0(
        .iClk(iClk),
        .iEn(rz0_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(aluc0_to_rz0),            // output of register file port A
        .oQ(rz0_to_my)                   // input 0 of Mux y
    );
    REG32 rz1(
        .iClk(iClk),
        .iEn(rz1_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(aluc1_to_rz1),            // output of register file port A
        .oQ(rz1_to_my)                   // input 0 of Mux b 
    );

    Mux4_1_32b my(
        .in0(rz0_to_my),
        .in1(rz1_to_my),
        .in2(32'd0),                 // memory out
        .in3(32'd0),                 // return address
        .sel(my_select),        // mux y select control signal
        .out(my_to_ry)                  // register y
    );

    REG32 ry(
        .iClk(iClk),
        .iEn(ry_enable),
        .nRst(nRst),                // idk where to connect this
        .iD(my_to_ry),              // output of mux y
        .oQ(ry_to_rfc)              // input of register file
    );

    REG32 rpc(
        .iClk(iClk),
        .iEn(rpc_enable),
        .nRst(nRst),
        .iD(mpc_to_rpc),
        .oQ(rpc_out)
    );

    REG32 rpc_temp(
        .iClk(iClk),
        .iEn(rpc_temp_enable),
        .nRst(nRst),
        .iD(rpc_out),
        .oQ(rpc_temp_to_my)
    );

    Mux2_1_32b mpc(
        .in0(32'd0),                     // RA
        .in1(pcadderc_to_mpc),      // PcAdder
        .sel(mpc_select),
        .out(mpc_to_rpc) 
    );

    Mux2_1_32b minc(
        .in0(32'd4),                // 4
        .in1(ir_out[18:0]),         // sign extend?
        .sel(minc_select),
        .out(minc_to_pcaddera) 
    );

    FastAdder pcadder(
        .x_in(rpc_out), 
        .y_in(minc_to_pcaddera), 
        .sum_out(pcadderc_to_mpc), 
        .c_in(32'd0), 
        .c_out()                    // idk what to connect this to?
    );

endmodule

/*
// Testing Layout
// Clock Cycle 1
- Instruction memory read
- rf_read
- addr a, b, c for rf
- IR_enable high

// Clock cycle 2
- Decode instruction
- ra_enable high - always?
- rb_enable high - always?

// Clock cycle 3
- mb_select
- alu_control
- rz0_enable high
- rz1_enable high
- rm_high

// Clock cycle 4
- data memory read
- my_select
- ry_enable high

// Clock cycle 5
- rf_write
- mc_select

*/

`timescale 1ns/10ps
module Processor_tb();
    reg tb_clock, tb_nRst;
    reg [31:0] tb_instruction_mem_in;
    wire clock, nRst;
    wire [31:0] mem_data_out, mem_data_in, mem_addr, instruction_mem_in, instruction_mem_addr;
    wire mem_read, mem_write, instruction_mem_read;
    Processor p(
        .iClk(clock),
        .nRst(nRst),
        .mem_data_out(mem_data_out),
        .mem_data_in(mem_data_in),
        .mem_addr(mem_addr),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .instruction_mem_in(instruction_mem_in),
        .instruction_mem_addr(instruction_mem_addr),
        .instruction_mem_read(instruction_mem_read)
    );

    reg [3:0] p_state = 5;

    // Generates clock signal
    initial tb_clock = 0;
    always #10 tb_clock = ~ tb_clock;
    assign clock = tb_clock;
    assign nRst = tb_nRst;
    assign instruction_mem_in = tb_instruction_mem_in;

    // Cycles through 0-4 for a 5 cycle processor
    always @(posedge clock)
        begin
            case(p_state)
                5           :   p_state = 0;
                0           :   p_state = 1;
                1           :   p_state = 2;
                2           :   p_state = 3;
                3           :   p_state = 4;
                4           :   p_state = 0;
            endcase
        end 

    // Simulates control signals
    initial begin
        // Initialize inputs
        tb_nRst = 0; // Active low reset
        // tb_mem_data_in = 0;
        tb_instruction_mem_in = 0;

        #5 tb_nRst = 1; 
        
        // Cycle 1: Fetch instruction
        #15 begin
            tb_instruction_mem_in = 32'hDEADBEEF; 
        end

        // Cycle 2: Decode instruction
        #20 begin
            // Enable IR (instruction register) and other decode logic
        end

        // Cycle 3: Execute instruction
        #20 begin
            // Assign ALU control signals and register enables
        end

        // Cycle 4: Memory access
        #20 begin
            // Simulate memory read/write and assign memory-related signals
        end

        // Cycle 5: Write-back
        #20 begin
            // Simulate register write-back logic
        end

        // End of simulation
        #20 $finish;
    end


endmodule