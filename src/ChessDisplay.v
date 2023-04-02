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

module ChessDisplay #(
    parameter CHESS_RAD = 20,
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
    input `RESO_SUBSC h_cnt,
    input `RESO_SUBSC v_cnt,
    input [`CHESS_MAP_WIDTH-1:0] chess_arr,
    input [`EFFECT_MAP_WIDTH-1:0] effect_arr,
    output `PX_WIDTH pixel,
    output valid // whether the pixel is valid
);
    
wire [`CHESS_LEN-1:0] chess_ram [`BOARD_R-1:0][`BOARD_C-1:0];
wire [`EFFECT_LEN-1:0] effect_ram [`BOARD_R-1:0][`BOARD_C-1:0];

// assign array to memory
genvar i, j;
generate
    for (i = 0; i < `BOARD_R; i = i + 1) begin
        for (j = 0; j < `BOARD_C; j = j + 1) begin
            assign chess_ram[i][j] = chess_arr[
                (i*`BOARD_C + (j+1)) * `CHESS_LEN-1:
                (i*`BOARD_C +   j  ) * `CHESS_LEN
            ];
            assign effect_ram[i][j] = effect_arr[
                (i*`BOARD_C + (j+1)) * `EFFECT_LEN-1:
                (i*`BOARD_C +   j  ) * `EFFECT_LEN
            ];
        end
    end
endgenerate

localparam CHESS_DIA = CHESS_RAD * 2;
localparam H0L = H0 - CHESS_RAD - 1;
localparam H0R = H0 + CHESS_RAD - 1;
wire in_H0 = h_cnt >= H0L && h_cnt < H0R;
localparam H1L = H1 - CHESS_RAD - 1;
localparam H1R = H1 + CHESS_RAD - 1;
wire in_H1 = h_cnt >= H1L && h_cnt < H1R;
localparam H2L = H2 - CHESS_RAD - 1;
localparam H2R = H2 + CHESS_RAD - 1;
wire in_H2 = h_cnt >= H2L && h_cnt < H2R;
localparam H3L = H3 - CHESS_RAD - 1;
localparam H3R = H3 + CHESS_RAD - 1;
wire in_H3 = h_cnt >= H3L && h_cnt < H3R;
localparam H4L = H4 - CHESS_RAD - 1;
localparam H4R = H4 + CHESS_RAD - 1;
wire in_H4 = h_cnt >= H4L && h_cnt < H4R;
localparam H5L = H5 - CHESS_RAD - 1;
localparam H5R = H5 + CHESS_RAD - 1;
wire in_H5 = h_cnt >= H5L && h_cnt < H5R;
localparam H6L = H6 - CHESS_RAD - 1;
localparam H6R = H6 + CHESS_RAD - 1;
wire in_H6 = h_cnt >= H6L && h_cnt < H6R;
localparam H7L = H7 - CHESS_RAD - 1;
localparam H7R = H7 + CHESS_RAD - 1;
wire in_H7 = h_cnt >= H7L && h_cnt < H7R;
localparam H8L = H8 - CHESS_RAD - 1;
localparam H8R = H8 + CHESS_RAD - 1;
wire in_H8 = h_cnt >= H8L && h_cnt < H8R;
localparam V0L = V0 - CHESS_RAD;
localparam V0R = V0 + CHESS_RAD;
wire in_V0 = v_cnt >= V0L && v_cnt < V0R;
localparam V1L = V1 - CHESS_RAD;
localparam V1R = V1 + CHESS_RAD;
wire in_V1 = v_cnt >= V1L && v_cnt < V1R;
localparam V2L = V2 - CHESS_RAD;
localparam V2R = V2 + CHESS_RAD;
wire in_V2 = v_cnt >= V2L && v_cnt < V2R;
localparam V3L = V3 - CHESS_RAD;
localparam V3R = V3 + CHESS_RAD;
wire in_V3 = v_cnt >= V3L && v_cnt < V3R;
localparam V4L = V4 - CHESS_RAD;
localparam V4R = V4 + CHESS_RAD;
wire in_V4 = v_cnt >= V4L && v_cnt < V4R;
localparam V5L = V5 - CHESS_RAD;
localparam V5R = V5 + CHESS_RAD;
wire in_V5 = v_cnt >= V5L && v_cnt < V5R;
localparam V6L = V6 - CHESS_RAD;
localparam V6R = V6 + CHESS_RAD;
wire in_V6 = v_cnt >= V6L && v_cnt < V6R;
localparam V7L = V7 - CHESS_RAD;
localparam V7R = V7 + CHESS_RAD;
wire in_V7 = v_cnt >= V7L && v_cnt < V7R;
localparam V8L = V8 - CHESS_RAD;
localparam V8R = V8 + CHESS_RAD;
wire in_V8 = v_cnt >= V8L && v_cnt < V8R;
localparam V9L = V9 - CHESS_RAD;
localparam V9R = V9 + CHESS_RAD;
wire in_V9 = v_cnt >= V9L && v_cnt < V9R;

wire [`CHESS_LEN-1:0] chess;
reg `RESO_SUBSC h_pivot,  // 錨點水平座標
                v_pivot;  // 錨點鉛直座標
reg h_valid, v_valid; // 水平或鉛直掃描是否掃到位置
reg [3:0] h_subsc, // 在 ram 的水平索引
          v_subsc; // 在 ram 的鉛直索引
wire `RESO_SUBSC h_pos = h_cnt - h_pivot, 
                 v_pos = v_cnt - v_pivot;

always @(*) begin
    h_valid = 1;
    h_pivot = 0;
    h_subsc = 0;
    v_valid = 1;
    v_pivot = 0;
    v_subsc = 0;
    
    if (in_H0) begin
        h_pivot = H0L;
        h_subsc = 0;
    end else if (in_H1) begin
        h_pivot = H1L;
        h_subsc = 1;
    end else if (in_H2) begin
        h_pivot = H2L;
        h_subsc = 2;
    end else if (in_H3) begin
        h_pivot = H3L;
        h_subsc = 3;
    end else if (in_H4) begin
        h_pivot = H4L;
        h_subsc = 4;
    end else if (in_H5) begin
        h_pivot = H5L;
        h_subsc = 5;
    end else if (in_H6) begin
        h_pivot = H6L;
        h_subsc = 6;
    end else if (in_H7) begin
        h_pivot = H7L;
        h_subsc = 7;
    end else if (in_H8) begin
        h_pivot = H8L;
        h_subsc = 8;
    end else begin
        h_valid = 0;
    end
    
    if (in_V0) begin
        v_pivot = V0L;
        v_subsc = 0;
    end else if (in_V1) begin
        v_pivot = V1L;
        v_subsc = 1;
    end else if (in_V2) begin
        v_pivot = V2L;
        v_subsc = 2;
    end else if (in_V3) begin
        v_pivot = V3L;
        v_subsc = 3;
    end else if (in_V4) begin
        v_pivot = V4L;
        v_subsc = 4;
    end else if (in_V5) begin
        v_pivot = V5L;
        v_subsc = 5;
    end else if (in_V6) begin
        v_pivot = V6L;
        v_subsc = 6;
    end else if (in_V7) begin
        v_pivot = V7L;
        v_subsc = 7;
    end else if (in_V8) begin
        v_pivot = V8L;
        v_subsc = 8;
    end else if (in_V9) begin
        v_pivot = V9L;
        v_subsc = 9;
    end else begin
        v_valid = 0;
    end
end

wire `PX_WIDTH _pixel;
wire valid_ch, valid_eff; // whether there is a chess

PixelChess #(
    .CHESS_RAD(CHESS_RAD),
    .BOARD_BACK(BOARD_BACK)
) PCS (
    .vga_clk(vga_clk),
    .h_pos(h_pos),
    .v_pos(v_pos),
    .chess(chess_ram[v_subsc][h_subsc]),
    .pixel(_pixel),
    .valid(valid_ch) // whether there is a chess
);

PixelEffectFilter #(
    .CHESS_RAD(CHESS_RAD)
) PXEFF (
    .pixel_i(_pixel),
    .h_pos(h_pos),
    .v_pos(v_pos),
    .effect(effect_ram[v_subsc][h_subsc]),
    .pixel_o(pixel),
    .valid(valid_eff)
); 

assign valid = h_valid & v_valid & 
    (valid_ch | valid_eff);

endmodule

module PixelEffectFilter #(
    parameter CHESS_RAD = 20,
    parameter OUTER = 6,
    parameter DIFF = 2
)
(
    input `PX_WIDTH pixel_i,
    input [`EFFECT_LEN-1:0] effect,
    input `RESO_SUBSC h_pos,
    input `RESO_SUBSC v_pos,
    output reg `PX_WIDTH pixel_o,
    output reg valid // whether there is a valid effect
);

localparam SEL_LEN = CHESS_RAD * 2 + 1;

wire outer_sel_mark_h =
    (h_pos >= 0 && h_pos < OUTER) ||
    (h_pos >= SEL_LEN - OUTER && 
        h_pos < SEL_LEN);

wire outer_sel_mark_v =
    (v_pos >= 0 && v_pos < OUTER) ||
    (v_pos >= SEL_LEN - OUTER && 
        v_pos < SEL_LEN);

wire outer_sel_mark = 
    outer_sel_mark_h & outer_sel_mark_v;

wire inner_sel_mark_h =
    h_pos >= DIFF && 
        h_pos < SEL_LEN - DIFF;

wire inner_sel_mark_v =
    v_pos >= DIFF && 
        v_pos < SEL_LEN - DIFF;

wire inner_sel_mark = 
    inner_sel_mark_h & inner_sel_mark_v;

wire in_sel_mark =
    outer_sel_mark & ~inner_sel_mark;

always @(*) begin
    pixel_o = pixel_i;
    valid = 0;

    if (in_sel_mark) begin
        case (effect)

        `R_TRAV: begin
            pixel_o = `COLOR_BROWN;
            valid = 1;
        end

        `B_TRAV: begin
            pixel_o = `COLOR_GREEN;
            valid = 1;
        end

        `SELECTED: begin
            pixel_o = `COLOR_BLUE;
            valid = 1;
        end
        
        endcase
    end
end
    
endmodule

module PixelChess #(
    parameter CHESS_RAD = 20, // chess radius
    parameter BOARD_BACK = 12'hfda 
)
(
    input vga_clk,
    input `RESO_SUBSC h_pos,
    input `RESO_SUBSC v_pos,
    input [`CHESS_LEN-1:0] chess,
    output `PX_WIDTH pixel,
    output valid // whether the output is in valid space
);

localparam CHESS_DIA = CHESS_RAD * 2;
localparam CHESS_AREA = CHESS_DIA * CHESS_DIA;

// address of all chess
wire [10:0] chess_addr = 
    (h_pos % CHESS_DIA) + 
    (v_pos % CHESS_DIA) * CHESS_DIA;
wire in_range = h_pos < CHESS_DIA && h_pos > 1 &&
    v_pos < CHESS_DIA;

// output pixel of each chess
wire `PX_WIDTH general_bk_px, advisor_bk_px, 
    elephant_bk_px, chariot_bk_px, horse_bk_px, 
    cannon_bk_px, soldier_bk_px, general_rd_px, 
    advisor_rd_px, elephant_rd_px, chariot_rd_px, 
    horse_rd_px, cannon_rd_px, soldier_rd_px;

// memory of each chess
GeneralBK BK_GMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(general_bk_px)
);
advisor_bk_mem BK_ADMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(advisor_bk_px)
);
elephant_bk_mem BK_ELEMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(elephant_bk_px)
);
chariot_bk_mem BK_CHMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(chariot_bk_px)
);
horse_bk_mem BK_HMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(horse_bk_px)
);
cannon_bk_mem BK_CNMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(cannon_bk_px)
);
soldier_bk_mem BK_SDMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(soldier_bk_px)
);
GeneralRD RD_GMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(general_rd_px)
);
advisor_rd_mem RD_ADMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(advisor_rd_px)
);
elephant_rd_mem RD_ELEMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(elephant_rd_px)
);
chariot_rd_mem RD_CHMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(chariot_rd_px)
);
horse_rd_mem RD_HMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(horse_rd_px)
);
cannon_rd_mem RD_CNMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(cannon_rd_px)
);
soldier_rd_mem RD_SDMEM (
    .clka(vga_clk),
    .wea(0),
    .addra(chess_addr),
    .dina(), // we don't need this...
    .douta(soldier_rd_px)
);

reg `PX_WIDTH _pixel;

always @(*) begin
    _pixel = 0;

    case (chess[`CHESS_LEN-2:0])

    `R_GENERAL:  _pixel = general_rd_px;
    `R_ADVISOR:  _pixel = advisor_rd_px;
    `R_ELEPHANT: _pixel = elephant_rd_px;
    `R_CHARIOT:  _pixel = chariot_rd_px;
    `R_HORSE:    _pixel = horse_rd_px;
    `R_CANNON:   _pixel = cannon_rd_px;
    `R_SOLDIER:  _pixel = soldier_rd_px;
    `B_GENERAL:  _pixel = general_bk_px;
    `B_ADVISOR:  _pixel = advisor_bk_px;
    `B_ELEPHANT: _pixel = elephant_bk_px;
    `B_CHARIOT:  _pixel = chariot_bk_px;
    `B_HORSE:    _pixel = horse_bk_px;
    `B_CANNON:   _pixel = cannon_bk_px;
    `B_SOLDIER:  _pixel = soldier_bk_px;

    endcase
end

wire excluded = 
    _pixel[11:8] >= 4'hc &&
    _pixel[ 7:4] >= 4'hc &&
    _pixel[ 3:0] >= 4'h9;

wire refresh =
    _pixel[11:8] >= 4'he &&
    _pixel[ 7:4] >= 4'hb &&
    _pixel[ 3:0] >= 4'h4;

assign pixel = excluded ? BOARD_BACK : 
    (chess[`CHESS_LEN-1] == `HIDDEN ? 
        `COLOR_GREEN : refresh ? 12'hfc5 : _pixel);
assign valid = chess != `NONE_CHESS && in_range && ~excluded;

endmodule