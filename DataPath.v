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
    wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable, rlo_enable;
    wire mb_select, minc_select, mpc_select;
    wire rf_write;
    wire [1:0] my_select, mc_select;
    wire [3:0] alu_control;
    wire alu_zero_flag, rz_b31;

    // For connection between modules
    wire [31:0] rfa_to_ra, rfb_to_rb, ra_to_alua, rb_to_mb, mb_to_alub, aluc0_to_rz0, aluc1_to_rz1, rz0_out, rz1_to_my, my_to_ry, ry_to_rfc, rb_to_rm, mc_to_rfac, ir_out;
    wire [31:0] mpc_to_rpc, rpc_out, rpc_temp_to_my, pcadderc_to_mpc, minc_to_pcaddera, rlo_to_my;

    assign rz_b31 = rz0_out[31];

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
        .iAddrC(mc_to_rfac),        // should also be 4 bit oopss
        .oRegA(rfa_to_ra), 
        .oRegB(rfb_to_rb), 
        .iRegC(ry_to_rfc)
    );

    Mux4_1_4b mc(               // needs to be 4 bit mux oops
        .in0(ir_out[26:23]),    // address a
        .in1(ir_out[22:19]),    // address b
        .in2(ir_out[18:15]),    // address c
        .in2(4'b1111),          // r15
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
        .oQ(rz0_out)                   // input 0 of Mux y
    );
    REG32 rz1(
        .iClk(iClk),
        .iEn(rz1_enable),
        .nRst(nRst),               // idk where to connect this
        .iD(aluc1_to_rz1),            // output of register file port A
        .oQ(rz1_to_my)                   // input 0 of Mux b 
    );
    REG32 rlo(
        .iClk(iClk),
        .iEn(rlo_enable),
        .nRst(nRst),                    // idk where to connect this
        .iD(aluc1_to_rz1),              // output of register file port A
        .oQ(rlo_to_my)                  // input 0 of Mux b 
    );

    Mux5_1_32b my(
        .in0(rz0_out),                      // rz
        .in1(rz1_to_my),                    // HI
        .in2(mem_data_in),                  // memory in
        .in3(rlo_to_my),                    // LO
        .in4(rpc_temp_to_my),                        // link register/ pc_temp
        .sel(my_select),                    // mux y select control signal
        .out(my_to_ry)                      // register y
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
        .in0(ra_to_alua),           // RA
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


`timescale 1ns/10ps
module Processor_tb();
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

    reg clock_reg, nRst_reg;
    reg [31:0] mem_data_out_reg, mem_data_in_reg, mem_addr_reg, instruction_mem_in_reg, instruction_mem_addr_reg;
    reg mem_read_reg, mem_write_reg, instruction_mem_read_reg;

    reg ra_enable_reg, rb_enable_reg, rz0_enable_reg, rz1_enable_reg, rm_enable_reg, ir_enable_reg, ry_enable_reg, rpc_enable_reg, rpc_temp_enable_reg;
    reg mb_select_reg, minc_select_reg;
    reg rf_write_reg;
    reg [1:0] my_select_reg, mc_select_reg;
    reg [3:0] alu_control_reg;

    // For connection between modules

    assign clock = clock_reg;
    assign nRst = nRst_reg;
    assign mem_data_out = mem_data_out_reg;
    assign mem_data_in = mem_data_in_reg;
    assign mem_addr = mem_addr_reg;
    assign instruction_mem_in = instruction_mem_in_reg;
    assign instruction_mem_addr = instruction_mem_addr_reg;
    assign mem_read = mem_read_reg;
    assign mem_write = mem_write_reg;
    assign instruction_mem_read = instruction_mem_read_reg;


    // Generates clock signal

    initial
        begin
            clock_reg = 0;
            forever #10 clock_reg = ~ clock_reg;
        end

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
        nRst_reg = 0; // Active low reset
        // tb_mem_data_in = 0;
        instruction_mem_in_reg = 0;

        #5 nRst_reg = 1;
        
        // Cycle 1: Fetch instruction
        #15 begin

        end

        // Cycle 2: Decode instruction
        #20 begin

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