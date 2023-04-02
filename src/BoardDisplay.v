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
`define PLAYING 2'h0
`define R_WIN 2'h1
`define B_WIN 2'h2
// color code
`define COLOR_BLUE 12'h39f
`define COLOR_RED 12'hf33
`define COLOR_BROWN 12'hf75
`define COLOR_GREEN 12'hbb6

module BoardDisplay #(
    parameter GRID_DIFF = 45,
    parameter INNER_WIDTH = 4,
    parameter OUTER_WIDTH = 2,
    parameter H_OUTER_0 = 138,
    parameter H0 = H_OUTER_0 + OUTER_WIDTH,
    parameter H1 = H0 + GRID_DIFF,
    parameter H2 = H1 + GRID_DIFF,
    parameter H3 = H2 + GRID_DIFF,
    parameter H4 = H3 + GRID_DIFF,
    parameter H5 = H4 + GRID_DIFF,
    parameter H6 = H5 + GRID_DIFF,
    parameter H7 = H6 + GRID_DIFF,
    parameter H8 = H7 + GRID_DIFF,
    parameter H_OUTER_1 = H8 + OUTER_WIDTH,
    parameter V_OUTER_0 = 35,
    parameter V0 = V_OUTER_0 + OUTER_WIDTH,
    parameter V1 = V0 + GRID_DIFF,
    parameter V2 = V1 + GRID_DIFF,
    parameter V3 = V2 + GRID_DIFF,
    parameter V4 = V3 + GRID_DIFF,
    parameter V5 = V4 + GRID_DIFF,
    parameter V6 = V5 + GRID_DIFF,
    parameter V7 = V6 + GRID_DIFF,
    parameter V8 = V7 + GRID_DIFF,
    parameter V9 = V8 + GRID_DIFF,
    parameter V_OUTER_1 = V9 + OUTER_WIDTH,

    parameter BOARD_BACK = 12'hfda,
    parameter BOARD_LINE = 12'h0
)
(
    input vga_clk,
    input rst_n,
    input `RESO_SUBSC h_cnt,
    input `RESO_SUBSC v_cnt,
    input [15:0] rr_timer,
    input [15:0] rt_timer,
    input [15:0] br_timer,
    input [15:0] bt_timer,
    input [1:0] result,
    output reg `PX_WIDTH pixel
);

wire in_outer = // 外邊線
    ((h_cnt == H_OUTER_0 || h_cnt == H_OUTER_1)
        && v_cnt >= V_OUTER_0 && v_cnt <= V_OUTER_1)
    || ((v_cnt == V_OUTER_0 || v_cnt == V_OUTER_1)
        && h_cnt >= H_OUTER_0 && h_cnt <= H_OUTER_1);

localparam V_MID = (V4 + V5) / 2; // 中心 v
localparam RIVER_VU = V_MID - 20; // upper v of river
localparam RIVER_VL = V_MID + 20; // lower v of river
localparam RIVER_LL = H2 - 40;    // left bound of 楚河
localparam RIVER_LR = H2 + 40;    // right bound of 楚河
localparam RIVER_RL = H6 - 40;    // left bound of 漢界
localparam RIVER_RR = H6 + 40;    // right bound of 漢界

wire v_in_board = // v inside the board
    v_cnt >= V0 && v_cnt <= V9;

wire h_in_board = // h inside the board
    h_cnt >= H0 && h_cnt < H8;

localparam WIN_SIDE = 60;
localparam WIN_OFFSET = 30;
wire v_in_r_win = 
    v_cnt >= V5 + WIN_OFFSET 
        && v_cnt < V5 + WIN_OFFSET + WIN_SIDE;
wire h_in_r_win = // h inside the board
    h_cnt >= H8 + WIN_OFFSET 
        && h_cnt < H8 + WIN_OFFSET + WIN_SIDE;
wire in_r_win = h_in_r_win & v_in_r_win;

wire to_show_r_win = in_r_win 
    && h_cnt > H8 + WIN_OFFSET + 1 && result == `R_WIN;

wire v_in_b_win = 
    v_cnt <= V4 - WIN_OFFSET 
        && v_cnt > V4 - WIN_OFFSET - WIN_SIDE;
wire h_in_b_win = // h inside the board
    h_cnt <= H0 - WIN_OFFSET 
        && h_cnt > H0 - WIN_OFFSET - WIN_SIDE;
wire in_b_win = h_in_b_win & v_in_b_win;

wire to_show_b_win = in_b_win 
    && h_cnt > H0 - WIN_OFFSET - WIN_SIDE + 2 
        && result == `B_WIN;

localparam V_BASE_UU = V0;
localparam V_BASE_UL = V0 + 100;
localparam V_BASE_LU = V9 - 100;
localparam V_BASE_LL = V9;

wire in_upper_sentence = // the upper v range of 觀棋/起手 句
    v_cnt >= V_BASE_UU && v_cnt < V_BASE_UL;

wire in_lower_sentence = // the lower v range of 觀棋/起手 句
    v_cnt >= V_BASE_LU && v_cnt < V_BASE_LL;

localparam H_BASE_LL = H0 - 20;
localparam H_BASE_LR = H0 - 5;
localparam H_BASE_RL = H8 + 5;
localparam H_BASE_RR = H8 + 20;

wire in_upper_no_regret_now = // 左上之起手無回 茅點
    h_cnt == H_BASE_LL && v_cnt == V_BASE_UU;

wire in_upper_no_regret =
    h_cnt >= H_BASE_LL && h_cnt < H_BASE_LR
        && in_upper_sentence;

wire in_lower_no_regret_now =
    h_cnt == H_BASE_RL && v_cnt == V_BASE_LU;

wire in_lower_no_regret =
    h_cnt >= H_BASE_RL && h_cnt < H_BASE_RR
        && in_lower_sentence;

wire in_upper_no_talk_now =
    h_cnt == H_BASE_RL && v_cnt == V_BASE_UU;

wire in_upper_no_talk =
    h_cnt >= H_BASE_RL && h_cnt < H_BASE_RR
        && in_upper_sentence;

wire in_lower_no_talk_now =
    h_cnt == H_BASE_LL && v_cnt == V_BASE_LU;

wire in_lower_no_talk =
    h_cnt >= H_BASE_LL && h_cnt < H_BASE_LR
        && in_lower_sentence;

wire v_inside_river_word =
    v_cnt > RIVER_VU && v_cnt < RIVER_VL;

wire in_river_l = 
    h_cnt >= RIVER_LL 
        && h_cnt < RIVER_LR 
        && v_inside_river_word;

wire in_river_r = 
    h_cnt >= RIVER_RL 
        && h_cnt < RIVER_RR 
        && v_inside_river_word;

wire v_inside_river =
    v_cnt > V4 && v_cnt < V5;

wire in_upper_cross = 
    h_cnt > H3 && h_cnt < H5 
        && v_cnt > V0 && v_cnt < V2
        && (h_cnt == (v_cnt - V0) + H3 
            || h_cnt + (v_cnt - V0) == H5);

wire in_lower_cross = 
    h_cnt > H3 && h_cnt < H5 
        && v_cnt > V7 && v_cnt < V9
        && (h_cnt == (V9 - v_cnt) + H3 
            || h_cnt + (V9 - v_cnt) == H5);

wire _h_not_in_sol_line =
    (h_cnt > H0 + 3 && h_cnt < H0 + 11) ||
    (h_cnt > H2 + 3 && h_cnt < H2 + 11) ||
    (h_cnt > H2 - 11 && h_cnt < H2 - 3) ||
    (h_cnt > H4 + 3 && h_cnt < H4 + 11) ||
    (h_cnt > H4 - 11 && h_cnt < H4 - 3) ||
    (h_cnt > H6 + 3 && h_cnt < H6 + 11) ||
    (h_cnt > H6 - 11 && h_cnt < H6 - 3) ||
    (h_cnt > H8 - 11 && h_cnt < H8 - 3);

wire _v_not_in_sol_line =
    (v_cnt > V3 + 3 && v_cnt < V3 + 11) ||
    (v_cnt > V3 - 11 && v_cnt < V3 - 3) ||
    (v_cnt > V6 + 3 && v_cnt < V6 + 11) ||
    (v_cnt > V6 - 11 && v_cnt < V6 - 3);

wire _h_in_sol_line =
    (h_cnt > H0 + 2 && h_cnt < H0 + 10) ||
    (h_cnt > H2 + 2 && h_cnt < H2 + 10) ||
    (h_cnt > H2 - 10 && h_cnt < H2 - 2) ||
    (h_cnt > H4 + 2 && h_cnt < H4 + 10) ||
    (h_cnt > H4 - 10 && h_cnt < H4 - 2) ||
    (h_cnt > H6 + 2 && h_cnt < H6 + 10) ||
    (h_cnt > H6 - 10 && h_cnt < H6 - 2) ||
    (h_cnt > H8 - 10 && h_cnt < H8 - 2);

wire _v_in_sol_line =
    (v_cnt > V3 + 2 && v_cnt < V3 + 10) ||
    (v_cnt > V3 - 10 && v_cnt < V3 - 2) ||
    (v_cnt > V6 + 2 && v_cnt < V6 + 10) ||
    (v_cnt > V6 - 10 && v_cnt < V6 - 2);

wire _h_not_in_cannon_line =
    (h_cnt > H1 + 3 && h_cnt < H1 + 11) ||
    (h_cnt > H1 - 11 && h_cnt < H1 - 3) ||
    (h_cnt > H7 + 3 && h_cnt < H7 + 11) ||
    (h_cnt > H7 - 11 && h_cnt < H7 - 3);

wire _v_not_in_cannon_line =
    (v_cnt > V2 + 3 && v_cnt < V2 + 11) ||
    (v_cnt > V2 - 11 && v_cnt < V2 - 3) ||
    (v_cnt > V7 + 3 && v_cnt < V7 + 11) ||
    (v_cnt > V7 - 11 && v_cnt < V7 - 3);

wire _h_in_cannon_line =
    (h_cnt > H1 + 2 && h_cnt < H1 + 10) ||
    (h_cnt > H1 - 10 && h_cnt < H1 - 2) ||
    (h_cnt > H7 + 2 && h_cnt < H7 + 10) ||
    (h_cnt > H7 - 10 && h_cnt < H7 - 2);

wire _v_in_cannon_line =
    (v_cnt > V2 + 2 && v_cnt < V2 + 10) ||
    (v_cnt > V2 - 10 && v_cnt < V2 - 2) ||
    (v_cnt > V7 + 2 && v_cnt < V7 + 10) ||
    (v_cnt > V7 - 10 && v_cnt < V7 - 2);

wire in_sol_sup_line =
    _h_in_sol_line && _v_in_sol_line 
        && !(_h_not_in_sol_line 
            && _v_not_in_sol_line);

wire in_cannon_sup_line =
    _h_in_cannon_line && _v_in_cannon_line 
        && !(_h_not_in_cannon_line 
            && _v_not_in_cannon_line);

reg [11:0] river_l_addr, river_r_addr;
reg [10:0] no_talk_addr, no_regret_addr;
reg [11:0] win_addr;
wire `PX_WIDTH river_l_px, river_r_px,
               no_talk_px, no_regret_px, win_px;
reg `PX_WIDTH board_px, // 棋盤色 
              _img_px; // 圖片色，有待去噪
wire `PX_WIDTH timer_px, 
               img_px; // 去噪後的圖片色

river_l_mem RVLMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(river_l_addr),
    .dina(), // we don't need this...
    .douta(river_l_px)
);

river_r_mem RVRMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(river_r_addr),
    .dina(), // we don't need this...
    .douta(river_r_px)
);

no_talk_mem NTMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(no_talk_addr),
    .dina(), // we don't need this...
    .douta(no_talk_px)
);

no_regret_mem NRMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(no_regret_addr),
    .dina(), // we don't need this...
    .douta(no_regret_px)
);

win_mem WIN (
    .clka(vga_clk),
    .wea(0),
    .addra(win_addr),
    .dina(), // we don't need this...
    .douta(win_px)
);

localparam SSD_LEN   = 12;
localparam SSD_WID   = 3;
localparam SSD_STEP  = 9;
localparam TIMER_LEN = 4 * SSD_LEN + 
    8 * SSD_WID + 3 * SSD_STEP;
localparam TIMER_2_WID = 4 * SSD_LEN + 
    6 * SSD_WID + SSD_STEP;

wire timer_valid;

PixelPlayerTimerManager #(
    .LL_PIVOT_H_RED(H8 + 30), // 玩家一左上角的時間錨點 (水平)
    .LL_PIVOT_V_RED(V9 - TIMER_2_WID), // 玩家一左上角的時間錨點 (垂直)
    .LL_PIVOT_H_BLK(H0 - 30 - TIMER_LEN), // 玩家二左上角的時間錨點 (水平)
    .LL_PIVOT_V_BLK(V0), // 玩家二左上角的時間錨點 (垂直)
    .BOARD_BACK(BOARD_BACK),
    .TOT_COLOR(`COLOR_BLUE),
    .RND_COLOR(`COLOR_RED),
    .SSD_LEN(SSD_LEN),
    .SSD_WID(SSD_WID),
    .SSD_STEP(SSD_STEP)
) PPTM (
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .rr_timer(rr_timer),
    .rt_timer(rt_timer),
    .br_timer(br_timer),
    .bt_timer(bt_timer),
    .valid(timer_valid),
    .pixel(timer_px)
);

always @(posedge vga_clk, negedge rst_n) begin
    if (~rst_n) begin
        no_regret_addr <= 0;
        no_talk_addr   <= 0;
        river_l_addr   <= 0;
        river_r_addr   <= 0;
        win_addr       <= 0;
    end
    else begin
        // 起手無回大丈夫
        if (in_upper_no_regret_now) begin
            no_regret_addr <= 2;
        end
        else if (in_lower_no_regret_now) begin
            no_regret_addr <= 1497;
        end
        else 
        if (in_upper_no_regret) begin
            no_regret_addr <= no_regret_addr + 1;
        end
        else if (in_lower_no_regret) begin
            no_regret_addr <= no_regret_addr - 1;
        end
        else if (in_upper_sentence || in_lower_sentence) begin
            no_regret_addr <= no_regret_addr;
        end
        else begin
            no_regret_addr <= 0;
        end

        // 觀棋不語真君子
        if (in_upper_no_talk_now) begin
            no_talk_addr <= 2;
        end
        else if (in_lower_no_talk_now) begin
            no_talk_addr <= 1497;
        end
        else if (in_upper_no_talk) begin
            no_talk_addr <= no_talk_addr + 1;
        end
        else if (in_lower_no_talk) begin
            no_talk_addr <= no_talk_addr - 1;
        end
        else if (in_upper_sentence || in_lower_sentence) begin
            no_talk_addr <= no_talk_addr;
        end
        else begin
            no_talk_addr <= 0;
        end

        // 楚河
        if (in_river_l) begin
            river_l_addr <= river_l_addr + 1;
        end
        else if (v_inside_river_word) begin
            river_l_addr <= river_l_addr;
        end
        else begin
            river_l_addr <= 0;
        end

        // 漢界
        if (in_river_r) begin
            river_r_addr <= river_r_addr + 1;
        end
        else if (v_inside_river_word) begin
            river_r_addr <= river_r_addr;
        end
        else begin
            river_r_addr <= 0;
        end

        if (in_r_win | in_b_win) begin
            win_addr <= win_addr + 1;
        end
        else if (v_in_r_win | v_in_b_win) begin
            win_addr <= win_addr;
        end
        else begin
            win_addr <= 0;
        end
    end
end

// h-v grid line: determine board_px
always @(*) begin
    case (h_cnt)

    H0, H8: begin
        if (v_in_board) begin
            board_px = BOARD_LINE;
        end
        else begin
            board_px = BOARD_BACK;
        end
    end 
    
    H1, H2, H3, H4, H5, H6, H7: begin
        if (v_in_board && !v_inside_river) begin
            board_px = BOARD_LINE;
        end
        else begin
            board_px = BOARD_BACK;
        end
    end

    default: begin
        case (v_cnt)

        V0, V1, V2, V3, V4, V5, V6, V7, V8, V9: begin
            if (h_in_board) begin
                board_px = BOARD_LINE;
            end
            else begin
                board_px = BOARD_BACK;
            end
        end

        default:
            board_px = BOARD_BACK;
    
        endcase
    end
    
    endcase
end

// image-related pixel (_img_px)
always @(*) begin
    if (in_lower_no_regret || in_upper_no_regret) begin
        _img_px = no_regret_px;
    end
    else if (in_lower_no_talk || in_upper_no_talk) begin
        _img_px = no_talk_px;
    end
    else if (in_river_l) begin
        _img_px = river_l_px;
    end
    else if (in_river_r) begin
        _img_px = river_r_px;
    end
    else begin
        _img_px = BOARD_BACK;
    end
end

localparam DENOISE_LIM_R = 4'h8; // red color de-noise bound
localparam DENOISE_LIM_G = 4'h6; // green color de-noise bound
localparam DENOISE_LIM_B = 4'h4; // blue color de-noise bound

assign img_px = (
    _img_px[11:8] > DENOISE_LIM_R &&
    _img_px[ 7:4] > DENOISE_LIM_G &&
    _img_px[ 3:0] > DENOISE_LIM_B
) ? BOARD_BACK : _img_px;

// final output decision
always @(*) begin
    if (
        in_lower_no_regret || in_upper_no_regret || 
        in_lower_no_talk || in_upper_no_talk || 
        in_river_l || in_river_r
    ) begin
        pixel = img_px;
    end
    else if (
        (to_show_r_win | to_show_b_win) && 
        win_px > 12'h222
    ) begin
        pixel = win_px;
    end
    else if (timer_valid) begin
        pixel = timer_px;
    end
    else if (
        in_outer || 
        in_sol_sup_line || in_cannon_sup_line ||
        in_upper_cross || in_lower_cross
    ) begin
        pixel = BOARD_LINE;
    end
    else begin
        pixel = board_px;
    end
end
    
endmodule