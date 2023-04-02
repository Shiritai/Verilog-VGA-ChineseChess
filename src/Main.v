`timescale 1ns / 1ps

// for digit counter
`define AFTER_CRY_USE_CRSYS 1'b0
`define AFTER_CRY_USE_BOUND 1'b1
`define NOT_TO_INJECT 1'b0
`define TO_INJECT 1'b1
`define ENABLE 1'b1
`define DISABLE 1'b0
`define UP_COUNTING 1'b0
`define DOWN_COUNTING 1'b1
`define DIGIT_LEN 4
// clock constant
`define BASIC_CLOCK_RATE 100_000_000
`define CLOCK_WIDTH 27
`define ONE_HZ_COUNT 50_000_000
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
// team
`define RED 1'b1
`define BLK 1'b0
// hiden
`define SHOWING 1'b0
`define HIDDEN  1'b1
// chess type mark
`define NONE       3'h0
`define GENERAL    3'h1
`define ADVISOR    3'h2
`define ELEPHANT   3'h3
`define CHARIOT    3'h4
`define HORSE      3'h5
`define CANNON     3'h6
`define SOLDIER    3'h7
// chess specification
`define _B_GENERAL   { `BLK, `GENERAL }
`define _B_ADVISOR   { `BLK, `ADVISOR }
`define _B_ELEPHANT  { `BLK, `ELEPHANT }
`define _B_CHARIOT   { `BLK, `CHARIOT }
`define _B_HORSE     { `BLK, `HORSE }
`define _B_CANNON    { `BLK, `CANNON }
`define _B_SOLDIER   { `BLK, `SOLDIER }
`define _R_GENERAL   { `RED, `GENERAL }
`define _R_ADVISOR   { `RED, `ADVISOR }
`define _R_ELEPHANT  { `RED, `ELEPHANT }
`define _R_CHARIOT   { `RED, `CHARIOT }
`define _R_HORSE     { `RED, `HORSE }
`define _R_CANNON    { `RED, `CANNON }
`define _R_SOLDIER   { `RED, `SOLDIER }
`define NONE_CHESS   { `SHOWING, `BLK, `NONE }
`define B_GENERAL    { `SHOWING, `_B_GENERAL }
`define B_ADVISOR    { `SHOWING, `_B_ADVISOR }
`define B_ELEPHANT   { `SHOWING, `_B_ELEPHANT }
`define B_CHARIOT    { `SHOWING, `_B_CHARIOT }
`define B_HORSE      { `SHOWING, `_B_HORSE }
`define B_CANNON     { `SHOWING, `_B_CANNON }
`define B_SOLDIER    { `SHOWING, `_B_SOLDIER }
`define PRESV        { `SHOWING, `RED, `NONE }
`define R_GENERAL    { `SHOWING, `_R_GENERAL }
`define R_ADVISOR    { `SHOWING, `_R_ADVISOR }
`define R_ELEPHANT   { `SHOWING, `_R_ELEPHANT }
`define R_CHARIOT    { `SHOWING, `_R_CHARIOT }
`define R_HORSE      { `SHOWING, `_R_HORSE }
`define R_CANNON     { `SHOWING, `_R_CANNON }
`define R_SOLDIER    { `SHOWING, `_R_SOLDIER }
`define B_H_GENERAL  { `HIDDEN, `_B_GENERAL }
`define B_H_ADVISOR  { `HIDDEN, `_B_ADVISOR }
`define B_H_ELEPHANT { `HIDDEN, `_B_ELEPHANT }
`define B_H_CHARIOT  { `HIDDEN, `_B_CHARIOT }
`define B_H_HORSE    { `HIDDEN, `_B_HORSE }
`define B_H_CANNON   { `HIDDEN, `_B_CANNON }
`define B_H_SOLDIER  { `HIDDEN, `_B_SOLDIER }
`define R_H_GENERAL  { `HIDDEN, `_R_GENERAL }
`define R_H_ADVISOR  { `HIDDEN, `_R_ADVISOR }
`define R_H_ELEPHANT { `HIDDEN, `_R_ELEPHANT }
`define R_H_CHARIOT  { `HIDDEN, `_R_CHARIOT }
`define R_H_HORSE    { `HIDDEN, `_R_HORSE }
`define R_H_CANNON   { `HIDDEN, `_R_CANNON }
`define R_H_SOLDIER  { `HIDDEN, `_R_SOLDIER }
// effect
`define NO_EFFECT  2'h0
`define SELECTED   2'h3
`define R_TRAV     2'h2
`define B_TRAV     2'h1

module Main (
    input clk,
    input pb_rst,    // push button for global reset
    input pb_swap,   // push button for timer swap
    input pb_start,  // push button for start/pause game
    input pb_random,  // dip switch for randomizing chess
    input dip_hidden_game,  // dip switch for gaming mode
    inout PS2_CLK,   // PS2 (keyboard) data
    inout PS2_DATA,  // PS2 (keyboard) data
    output [7:0] ssd_o,
    output [3:0] ssd_ctl,
    output [3:0] vgaRed,   // red tune of VGA
    output [3:0] vgaGreen, // green tune of VGA
    output [3:0] vgaBlue,  // blue tune of VGA
    output hsync,  // horizontal sync
    output vsync,  // vertical sync
    output [2:0] LED
);

wire [1:0] ssd_ctl_en;
wire rst_n = ~pb_rst;
wire swap, start, random;
wire vga_clk, user_clk;

// keyboard
wire [8:0] last_change;
wire s_key_up, s_key_dn, s_key_lf, s_key_rt, // 紅方上下左右 (單步)
     s_key_w,  s_key_s,  s_key_a,  s_key_d,  // 黑方上下左右 (單步)
     s_key_lshift, s_key_rshift, // 回合切換
     l_key_up, l_key_dn, l_key_lf, l_key_rt, // 紅方上下左右 (快速移動)
     l_key_w,  l_key_s,  l_key_a,  l_key_d,  // 黑方上下左右 (快速移動)
     s_key_space,   // 切換單步／全局計時器
     s_key_bkspace; // 暫停／開始

// timer
wire [15:0] rr_timer, rt_timer,
            br_timer, bt_timer,
            clock; // for SSD

wire times_up;

// pixel wires
wire [16:0] pixel_addr; // address in the 1D memory array
wire `PX_WIDTH pixel; // current pixel (i.e. subscription of a pixel-array)
wire valid; // enable of displaying image

wire `RESO_SUBSC h_cnt, // 640
                 v_cnt; // 480

// chess board
wire [`CHESS_MAP_WIDTH-1:0] chess_arr;
wire [`EFFECT_MAP_WIDTH-1:0] effect_arr;

wire [1:0] result;

// generate 25Mhz vga clock and 100Hz clock
FrequencyManager #(
    .NUMBER_OF_COUNT_ARR({ 
        `CLOCK_WIDTH'd2, 
        `CLOCK_WIDTH'd500_000
    }),
    .NUMS(2)
) MY_CLOCK (
    .clk(clk), .rst_n(rst_n),
    .fd_clk_arr({
        vga_clk,
        user_clk
    }),
    .iter_sig(ssd_ctl_en)
);

ButtonPressArray #(
    .SIZE(3)
) BPARR (
    .clk_fast(clk),
    .clk_slow(user_clk),
    .rst_n(rst_n),
    .sig_arr({ pb_swap, pb_start, pb_random }),
    .s_sig_arr_o({ swap, start, random }),
    .l_sig_arr_o()
);

KeyboardReader KBREADER (
    .clk(clk),
    .clk_100Hz(user_clk), // for short/long-press detection
    .rst_n(rst_n),
    .PS2_CLK(PS2_CLK),
    .PS2_DATA(PS2_DATA),
    .s_key_up(s_key_up), .s_key_dn(s_key_dn),
    .s_key_lf(s_key_lf), .s_key_rt(s_key_rt),
    .s_key_w(s_key_w),   .s_key_s(s_key_s),
    .s_key_a(s_key_a),   .s_key_d(s_key_d),
    .s_key_lshift(s_key_lshift), 
    .s_key_rshift(s_key_rshift),
    .l_key_up(l_key_up), .l_key_dn(l_key_dn),
    .l_key_lf(l_key_lf), .l_key_rt(l_key_rt),
    .l_key_w(l_key_w),   .l_key_s(l_key_s), 
    .l_key_a(l_key_a),   .l_key_d(l_key_d),
    .s_key_space(s_key_space),
    .s_key_bkspace(s_key_bkspace)
);

SignalIterator SIGIT (
    .nums(clock),
    .ssd_ctl_en(ssd_ctl_en),
    .ssd_o(ssd_o),
    .ssd_ctl(ssd_ctl)
);

GameLogic GL (
    .user_clk(user_clk), 
    .rst_n(rst_n),
    .s_key_up(s_key_up), .s_key_dn(s_key_dn),
    .s_key_lf(s_key_lf), .s_key_rt(s_key_rt),
    .s_key_w(s_key_w),   .s_key_s(s_key_s),
    .s_key_a(s_key_a),   .s_key_d(s_key_d),
    .s_key_lshift(s_key_lshift), 
    .s_key_rshift(s_key_rshift),
    .l_key_up(l_key_up), .l_key_dn(l_key_dn),
    .l_key_lf(l_key_lf), .l_key_rt(l_key_rt),
    .l_key_w(l_key_w),   .l_key_s(l_key_s),
    .l_key_a(l_key_a),   .l_key_d(l_key_d),
    .s_key_space(s_key_space | start),
    .s_key_bkspace(s_key_bkspace | swap),
    .hidden_mode(dip_hidden_game),
    .random_en(random),
    .chess_arr(chess_arr),
    .effect_arr(effect_arr),
    .rr_timer(rr_timer),
    .rt_timer(rt_timer),
    .br_timer(br_timer),
    .bt_timer(bt_timer),
    .clock(clock),
    .result(result),
    .is_randomized(LED[2])
);

// Get current h/v count
// Render the picture by VGA controller
vga_controller VGA_CONTROL (
    .pclk(vga_clk),
    .reset(pb_rst), // pb_rst itself is a pos-edge trigger
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
);

DisplayEngine DPE (
    .vga_clk(vga_clk),     .rst_n(rst_n),
    .h_cnt(h_cnt),         .v_cnt(v_cnt),
    .rr_timer(rr_timer),   .rt_timer(rt_timer),
    .br_timer(br_timer),   .bt_timer(bt_timer),
    .chess_arr(chess_arr), .effect_arr(effect_arr),       
    .pixel(pixel),         .result(result)
);

assign LED[1:0] = result;

assign { vgaRed, vgaGreen, vgaBlue }
    = (valid == 1'b1) ? pixel : 0;

endmodule