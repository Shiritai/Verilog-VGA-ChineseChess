`timescale 1ns / 1ps

// of resolution-related variables
`define RESO_SUBSC [9:0]
`define PX_WIDTH [11:0]

module vga_controller (
    input wire pclk,reset,
    output wire hsync,vsync,valid,
    output wire `RESO_SUBSC h_cnt,
    output wire `RESO_SUBSC v_cnt
);
    
reg `RESO_SUBSC pixel_cnt;
reg `RESO_SUBSC line_cnt;
reg hsync_i,vsync_i;

localparam HD = 640; // Horizontal visiable area
localparam HF = 16; // Horizontal front porch
localparam HS = 96; // Horizontal sync pulse
localparam HB = 48; // Horizonatl back porch
localparam HT = HD + HF + HS + HB;  // Horizontal whole line
localparam VD = 480; // Vertical visiable area
localparam VF = 10; // Vertical front porch
localparam VS = 2; // Vertical sync pulse
localparam VB = 33; // Vertical back porch
localparam VT = VD + VF + VS + VB; // Vertical whole line
localparam hsync_default = 1'b1;
localparam vsync_default = 1'b1;
     
// Horizontal counter
always@(posedge pclk)
    if(reset)
        pixel_cnt <= 0;
    else if(pixel_cnt < (HT - 1))
        pixel_cnt <= pixel_cnt + 1;
    else
        pixel_cnt <= 0;

// Generate Horizontal Sync Pulse
always@(posedge pclk)
    if(reset)
        hsync_i <= hsync_default;
    else if((pixel_cnt >= (HD + HF - 1))&&(pixel_cnt < (HD + HF + HS - 1)))
        hsync_i <= ~hsync_default;
    else
        hsync_i <= hsync_default; 

// Vertical scan line counter
always@(posedge pclk)
    if(reset)
        line_cnt <= 0;
    else if(pixel_cnt == (HT -1))
        if(line_cnt < (VT - 1))
            line_cnt <= line_cnt + 1;
        else
            line_cnt <= 0;
    else
        line_cnt <= line_cnt;

// Generate Vertical Sync Pulse
always@(posedge pclk)
    if(reset)
        vsync_i <= vsync_default; 
    else if((line_cnt >= (VD + VF - 1))&&(line_cnt < (VD + VF + VS - 1)))
        vsync_i <= ~vsync_default; 
    else
        vsync_i <= vsync_default; 

assign hsync = hsync_i;
assign vsync = vsync_i;
assign valid = ((pixel_cnt < HD) && (line_cnt < VD));

assign h_cnt = (pixel_cnt < HD) ? pixel_cnt:10'd0;
assign v_cnt = (line_cnt < VD) ? line_cnt:10'd0;

endmodule