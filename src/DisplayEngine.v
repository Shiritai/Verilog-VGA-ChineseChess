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

module DisplayEngine #(
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
    input [`CHESS_MAP_WIDTH-1:0] chess_arr,
    input [`EFFECT_MAP_WIDTH-1:0] effect_arr,
    input [1:0] result,
    output reg `PX_WIDTH pixel
);

wire `PX_WIDTH board_px, chess_px;
wire chess_en;

ChessDisplay #(
    .GRID_DIFF(GRID_DIFF),
    .INNER_WIDTH(INNER_WIDTH),
    .OUTER_WIDTH(OUTER_WIDTH),
    .H_OUTER_0(H_OUTER_0),
    .H0(H0),    .H1(H1),
    .H2(H2),    .H3(H3),
    .H4(H4),    .H5(H5),
    .H6(H6),    .H7(H7),
    .H8(H8),
    .H_OUTER_1(H_OUTER_1),
    .V_OUTER_0(V_OUTER_0),
    .V0(V0),    .V1(V1),
    .V2(V2),    .V3(V3),
    .V4(V4),    .V5(V5),
    .V6(V6),    .V7(V7),
    .V8(V8),    .V9(V9),
    .V_OUTER_1(V_OUTER_1),
    .BOARD_BACK(BOARD_BACK),
    .BOARD_LINE(BOARD_LINE)
) _CD (
    .vga_clk(vga_clk),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .chess_arr(chess_arr),
    .effect_arr(effect_arr),
    .valid(chess_en),
    .pixel(chess_px)
);

localparam CHESS_RAD = 20;
localparam CHESS_DIA = CHESS_RAD * 2;

BoardDisplay #(
    .GRID_DIFF(GRID_DIFF),
    .INNER_WIDTH(INNER_WIDTH),
    .OUTER_WIDTH(OUTER_WIDTH),
    .H_OUTER_0(H_OUTER_0),
    .H0(H0),    .H1(H1),
    .H2(H2),    .H3(H3),
    .H4(H4),    .H5(H5),
    .H6(H6),    .H7(H7),
    .H8(H8),
    .H_OUTER_1(H_OUTER_1),
    .V_OUTER_0(V_OUTER_0),
    .V0(V0),    .V1(V1),
    .V2(V2),    .V3(V3),
    .V4(V4),    .V5(V5),
    .V6(V6),    .V7(V7),
    .V8(V8),    .V9(V9),
    .V_OUTER_1(V_OUTER_1),
    .BOARD_BACK(BOARD_BACK),
    .BOARD_LINE(BOARD_LINE)
) _BD (
    .vga_clk(vga_clk),   .rst_n(rst_n),
    .h_cnt(h_cnt),       .v_cnt(v_cnt),
    .rr_timer(rr_timer), .rt_timer(rt_timer),
    .br_timer(br_timer), .bt_timer(bt_timer),
    .pixel(board_px),    .result(result)
);

always @(*) begin
    if (chess_en) begin
        pixel = chess_px;
    end
    else begin
        pixel = board_px;
    end
end
    
endmodule