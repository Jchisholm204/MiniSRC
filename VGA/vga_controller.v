// Simple VGA Controller
// 640x480 Resolution

module vga_controller(
    iClk_50,
    nRst,
    iVGA_colorData,
    oVGA_colorAddress,
    oVGA_R,
    oVGA_G,
    oVGA_B,
    oVGA_Clk,
    oVGA_Blank,
    oVGA_HSync,
    oVGA_VSync,
    oVGA_Sync,
);

input wire iClk_50, nRst;
input wire [29:0]  iVGA_colorData;
output wire [31:0] oVGA_colorAddress;
output wire [9:0] oVGA_R, oVGA_G, oVGA_B;
output wire oVGA_Clk, oVGA_Blank, oVGA_HSync, oVGA_VSync, oVGA_Sync;

parameter WIDTH = 16'd639;
parameter HEIGHT = 16'd479;

// Signal States
// Active Video
parameter SS_AV = 3'd0;
// Front Porch
parameter SS_FP = 3'd1;
// Sync Pulse
parameter SS_SP = 3'd2;
// Back Porch
parameter SS_BP = 3'd3;
// Blank
parameter SS_BL = 3'd4;

// Video States
// Active Video
parameter VS_AV = 2'd0;
// Horizontal Sync
parameter VS_HS = 2'd1;
// Vertical Sync
parameter VS_VS = 2'd2;

// Video State
reg [1:0] videoState, videoState_next;
// Horizontal and Vertical Signal States
reg [2:0] hState, vState;
reg [2:0] hState_next, vState_next;

// Signal Clock Counters
reg [15:0] s_width, s_height;

// In/Out Color Data
assign oVGA_colorAddress = {s_height, s_width};
wire [9:0] cR, cG, cB;
assign cR = iVGA_colorData[9:0];
assign cG = iVGA_colorData[19:10];
assign cB = iVGA_colorData[29:20];

// Clock Divider
reg Clk_25;
always @(posedge iClk_50, negedge nRst) begin
    if(~nRst) Clk_25 = 1'b0;
    else Clk_25 = ~Clk_25;
end

always @(posedge Clk_25, negedge nRst) begin
    if(~nRst) begin
        videoState = VS_AV;
        hState = SS_AV;
        vState = SS_AV;
    end
    else begin
        videoState = videoState_next;
        vState = vState_next;
        hState = hState_next;
        case(videoState)
            // Active Video
            VS_AV: begin
                oVGA_R = cR;
                oVGA_G = cG;
                oVGA_B = cB;
                if (s_width == WIDTH) begin 
                    s_width = 16'd0;
                    if(s_height == HEIGHT) begin
                        s_height = 16'd0;
                        videoState_next = VS_VS;
                        vState_next = SS_FP;
                        hState_next = SS_BL;
                    end else begin
                        s_height = s_height + 16'd1;
                        videoState_next = VS_HS;
                        vState_next = SS_AV;
                        hState_next = SS_FP;
                    end
                end else begin
                    s_width = s_width + 16'd1;
                    videoState_next = VS_AV;
                    vState_next = SS_AV;
                    hState_next = SS_AV;
                end
            end
            // Vertical Sync
            VS_VS: begin
                oVGA_R = 10'd0;
                oVGA_G = 10'd0;
                oVGA_B = 10'd0;
                case(vState)
                    SS_FP:;
                    SS_SP:;
                    SS_BP:;
                    default: begin
                        videoState_next = VS_AV;
                        vState_next = SS_AV;
                        hState_next = SS_AV;
                    end
                endcase
            end
            // Horizontal Sync
            VS_HS: begin
            end
            default: begin
                videoState_next = VS_AV;
                vState_next = SS_AV;
                hState_next = SS_AV;
            end
        endcase
    end
end

endmodule
