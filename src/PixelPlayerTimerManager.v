`timescale 1ns / 1ps

// for the declaration and subscription 
// of resolution-related variables
`define RESO_SUBSC [9:0]
`define PX_WIDTH [11:0]
`define BOARD_R 10
`define BOARD_C 9
`define CHESS_LEN 5
`define EFFECT_LEN 2
`define CHESS_MAP_WIDTH `BOARD_R*`BOARD_C*`CHESS_LEN
`define EFFECT_MAP_WIDTH `BOARD_R*`BOARD_C*`EFFECT_LEN
// color code
`define COLOR_BLUE 12'h39f
`define COLOR_RED 12'hf33
`define COLOR_BROWN 12'hf75
`define COLOR_GREEN 12'hbb6

module PixelPlayerTimerManager #(
    parameter LL_PIVOT_H_RED = 0, // 玩家一左上角的時間錨點 (水平)
    parameter LL_PIVOT_V_RED = 0, // 玩家一左上角的時間錨點 (垂直)
    parameter LL_PIVOT_H_BLK = 0, // 玩家二左上角的時間錨點 (水平)
    parameter LL_PIVOT_V_BLK = 0, // 玩家二左上角的時間錨點 (垂直)
    parameter BOARD_BACK = 12'hfda,
    parameter TOT_COLOR = 12'h0,
    parameter RND_COLOR = 12'h0,
    parameter SSD_LEN   = 16,
    parameter SSD_WID   = 4,
    parameter SSD_STEP  = 12
)
(
    input `RESO_SUBSC h_cnt,
    input `RESO_SUBSC v_cnt,
    input [15:0] rr_timer,
    input [15:0] rt_timer,
    input [15:0] br_timer,
    input [15:0] bt_timer,
    output valid,
    output `PX_WIDTH pixel
);

wire `PX_WIDTH red_px, blk_px;
wire red_valid, blk_valid;

PixelPlayerTimer #(
    .LL_PIVOT_H(LL_PIVOT_H_RED),
    .LL_PIVOT_V(LL_PIVOT_V_RED),
    .BOARD_BACK(BOARD_BACK),
    .TOT_COLOR(TOT_COLOR),
    .RND_COLOR(RND_COLOR),
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP)
) PPT_RED (
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .round(rr_timer),
    .total(rt_timer),
    .pixel(red_px),
    .valid(red_valid)
);

PixelPlayerTimer #(
    .LL_PIVOT_H(LL_PIVOT_H_BLK),
    .LL_PIVOT_V(LL_PIVOT_V_BLK),
    .BOARD_BACK(BOARD_BACK),
    .TOT_COLOR(TOT_COLOR),
    .RND_COLOR(RND_COLOR),
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP)
) PPT_BLK (
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .round(br_timer),
    .total(bt_timer),
    .pixel(blk_px),
    .valid(blk_valid)
);

assign pixel = red_valid ? red_px : blk_px;
assign valid = red_valid ^ blk_valid;

endmodule

module PixelPlayerTimer #(
    parameter LL_PIVOT_H = 0,
    parameter LL_PIVOT_V = 0,
    parameter BOARD_BACK = 12'hfda,
    parameter TOT_COLOR = 12'h0,
    parameter RND_COLOR = 12'h0,
    parameter SSD_LEN   = 16,
    parameter SSD_WID   = 4,
    parameter SSD_STEP  = 12
)
(
    input `RESO_SUBSC h_cnt,
    input `RESO_SUBSC v_cnt,
    input [15:0] round,
    input [15:0] total,
    output valid,
    output `PX_WIDTH pixel
);

localparam TIMER_LEN = (SSD_LEN + 2 * SSD_WID) * 4  // 一組時鐘的長度
    + SSD_STEP * 3;
localparam TIMER_WID = SSD_LEN * 2 + SSD_WID * 3;
localparam TIMER_2_WID = TIMER_WID * 2 + SSD_STEP;

wire `PX_WIDTH total_px, round_px;

PixelTimer #(
    .LL_PIVOT_H(LL_PIVOT_H),
    .LL_PIVOT_V(LL_PIVOT_V),
    .BOARD_BACK(BOARD_BACK),
    .BOARD_LINE(TOT_COLOR),
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP)
) PIXEL_TOT (
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .timer(total),
    .pixel(total_px)
);

PixelTimer #(
    .LL_PIVOT_H(LL_PIVOT_H),
    .LL_PIVOT_V(LL_PIVOT_V + TIMER_WID + SSD_STEP),
    .BOARD_BACK(BOARD_BACK),
    .BOARD_LINE(RND_COLOR),
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP)
) PIXEL_RND (
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .timer(round),
    .pixel(round_px)
);

assign valid = h_cnt >= LL_PIVOT_H && 
    h_cnt < LL_PIVOT_H + TIMER_LEN &&
    v_cnt >= LL_PIVOT_V &&
    v_cnt < LL_PIVOT_V + TIMER_2_WID;

assign pixel = v_cnt >= LL_PIVOT_V &&
    v_cnt < LL_PIVOT_V + TIMER_WID ?
        total_px : round_px;
    
endmodule

module PixelTimer #(
    parameter LL_PIVOT_H = 0,
    parameter LL_PIVOT_V = 0,
    parameter BOARD_BACK = 12'hfda,
    parameter BOARD_LINE = 12'h0,
    parameter SSD_LEN   = 16,
    parameter SSD_WID   = 4,
    parameter SSD_STEP  = 12
)
(
    input `RESO_SUBSC h_cnt,
    input `RESO_SUBSC v_cnt,
    input [15:0] timer,
    output `PX_WIDTH pixel
);

localparam TIMER_LEN = (SSD_LEN + 2 * SSD_WID) * 4  // 一組時鐘的長度
    + SSD_STEP * 3;
localparam TIMER_WID = SSD_LEN * 2 + SSD_WID * 3;

localparam TIMER_H1L = LL_PIVOT_H;
localparam TIMER_H1R = TIMER_H1L + 
    SSD_LEN + 2 * SSD_WID;
localparam TIMER_H2L = TIMER_H1R + SSD_STEP;
localparam TIMER_H2R = TIMER_H2L + 
    SSD_LEN + 2 * SSD_WID;
localparam TIMER_H3L = TIMER_H2R + SSD_STEP;
localparam TIMER_H3R = TIMER_H3L + 
    SSD_LEN + 2 * SSD_WID;
localparam TIMER_H4L = TIMER_H3R + SSD_STEP;
localparam TIMER_H4R = TIMER_H4L + 
    SSD_LEN + 2 * SSD_WID;
localparam TIMER_V1 = LL_PIVOT_V;
localparam TIMER_V2 = LL_PIVOT_V + TIMER_WID;

wire `PX_WIDTH _pixel;
reg valid;
reg in_dot;
reg [3:0] digit;
reg `RESO_SUBSC h_pos;
reg `RESO_SUBSC v_pos;

always @(*) begin

    digit  = 0;
    h_pos  = 0;
    v_pos  = 0;
    in_dot = 0;
    valid  = 0;

    if (v_cnt >= TIMER_V1 && v_cnt < TIMER_V2) begin
        v_pos = v_cnt - TIMER_V1;
        
        if (h_cnt >= TIMER_H1L && h_cnt < TIMER_H1R) begin
            digit = timer[15:12];
            h_pos = h_cnt - TIMER_H1L;
            valid = 1;
        end
        else if (h_cnt >= TIMER_H2L && h_cnt < TIMER_H2R) begin
            digit = timer[11: 8];
            h_pos = h_cnt - TIMER_H2L;
            valid = 1;
        end
        else if (h_cnt >= TIMER_H3L && h_cnt < TIMER_H3R) begin
            digit = timer[ 7: 4];
            h_pos = h_cnt - TIMER_H3L;
            valid = 1;
        end
        else if (h_cnt >= TIMER_H4L && h_cnt < TIMER_H4R) begin
            digit = timer[ 3: 0];
            h_pos = h_cnt - TIMER_H4L;
            valid = 1;
        end

        if (((v_cnt >= TIMER_V1 + SSD_LEN - SSD_WID &&
            v_cnt < TIMER_V1 + SSD_LEN) ||
            (v_cnt >= TIMER_V2 - SSD_LEN &&
            v_cnt < TIMER_V2 - SSD_LEN + SSD_WID)) &&
            h_cnt >= TIMER_H2R + SSD_WID && h_cnt < TIMER_H3L - SSD_WID) begin
            in_dot = 1;
        end
    end
end

PixelSSD #(
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP),
    .BOARD_BACK(BOARD_BACK),
    .BOARD_LINE(BOARD_LINE)
) PIXELSSD (
    .digit(digit),
    .h_pos(h_pos),
    .v_pos(v_pos),
    .pixel(_pixel)
);

assign pixel = in_dot ? BOARD_LINE : 
    (valid ? _pixel : BOARD_BACK);

endmodule

module PixelSSD #(
    parameter SSD_LEN  = 16,
    parameter SSD_WID  = 4,
    parameter SSD_STEP = 12,
    parameter BOARD_BACK = 12'hfda,
    parameter BOARD_LINE = 12'h0
)
(
    input [3:0] digit,
    input `RESO_SUBSC h_pos, // 水平相對距離
    input `RESO_SUBSC v_pos, // 垂直相對距離
    output `PX_WIDTH pixel
);

localparam SSD_H0 = 0;
localparam SSD_H1 = SSD_H0 + SSD_WID;
localparam SSD_H2 = SSD_H1 + SSD_LEN;
localparam SSD_H3 = SSD_H2 + SSD_WID;

localparam SSD_V0 = 0;
localparam SSD_V1 = SSD_V0 + SSD_WID;
localparam SSD_V2 = SSD_V1 + SSD_LEN;
localparam SSD_V3 = SSD_V2 + SSD_WID;
localparam SSD_V4 = SSD_V3 + SSD_LEN;
localparam SSD_V5 = SSD_V4 + SSD_WID;

wire [7:0] value;
reg result;

SevenSegmentDisplay _SSD (
    .num(digit),
    .ssd_o(value)
);

always @(*) begin
    // bar 0
    if (h_pos >= SSD_H1 && h_pos < SSD_H2 &&
        v_pos >= SSD_V0 && v_pos < SSD_V1) begin
        result = value[7] == 0;
    end
    else if (h_pos >= SSD_H2 && h_pos < SSD_H3 &&
        v_pos >= SSD_V1 && v_pos < SSD_V2) begin
        result = value[6] == 0;
    end
    else if (h_pos >= SSD_H2 && h_pos < SSD_H3 &&
        v_pos >= SSD_V3 && v_pos < SSD_V4) begin
        result = value[5] == 0;
    end
    else if (h_pos >= SSD_H1 && h_pos < SSD_H2 &&
        v_pos >= SSD_V4 && v_pos < SSD_V5) begin
        result = value[4] == 0;
    end
    else if (h_pos >= SSD_H0 && h_pos < SSD_H1 &&
        v_pos >= SSD_V3 && v_pos < SSD_V4) begin
        result = value[3] == 0;
    end
    else if (h_pos >= SSD_H0 && h_pos < SSD_H1 &&
        v_pos >= SSD_V1 && v_pos < SSD_V2) begin
        result = value[2] == 0;
    end
    else if (h_pos >= SSD_H1 && h_pos < SSD_H2 &&
        v_pos >= SSD_V2 && v_pos < SSD_V3) begin
        result = value[1] == 0;
    end
    else begin
        result = 0;
    end
end

assign pixel = result ? BOARD_LINE : BOARD_BACK;

endmodule
