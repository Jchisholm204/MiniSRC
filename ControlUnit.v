module ControlUnit(
    ir, nRst, clock,
    mb_select, minc_select, rf_write, my_select, mc_select, alu_control,
    ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable
);
    input wire nRst, clock;
    input wire [31:0]ir;
    output wire ra_enable, rb_enable, rz0_enable, rz1_enable, rm_enable, ir_enable, ry_enable, rpc_enable, rpc_temp_enable;    
    output wire mb_select, minc_select;
    output wire rf_write;
    output wire [1:0] my_select, mc_select;
    output wire [3:0] alu_control;

    reg cycle;

    // Counts cycles 1-5
    always @(posedge clock)
    begin
        case(cycle)
            1   :   cycle = 2;
            2   :   cycle = 3;
            3   :   cycle = 4;
            4   :   cycle = 5;
            5   :   cycle = 1;
        endcase
    end

    assign ir_enable = (cycle == 1) ? 1 : 0;
    assign rpc_enable = (cycle == 1) ? 1 : 0;
    assign rpc_temp_enable = 0;                 // idk yet

    assign mb_select = (ir[31:28] == 4'b0000) ? 1 : 0 | (ir[31:27] == 4'b00010) ? 1 : 0 | (ir[31:28] == 4'b0110) ? 1 : 0 | (ir[31:27] == 4'b01110) ? 1 : 0;
    // assign minc_select =
    /*
    need some external loged from alu into control unit for this
    br if 0
    br if not 0 
    br if pos
    br if neg
    */
    // assign rf_write = 
    // assign my_select =
    // assign mc_select =
    // assign alu_control =

    assign ra_enable = 1;
    assign rb_enable = 1;
    assign rz0_enable = 1;
    assign rz1_enable = 1;
    assign rm_enable = 1;
    assign ry_enable = 1;

endmodule