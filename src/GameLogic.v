`timescale 1ns / 1ps

// for the declaration and subscription 
`define BOARD_R 10
`define BOARD_C 9
`define CHESS_LEN 5
`define EFFECT_LEN 2
`define CHESS_MAP_WIDTH `BOARD_R*`BOARD_C*`CHESS_LEN
`define EFFECT_MAP_WIDTH `BOARD_R*`BOARD_C*`EFFECT_LEN
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

// macro for convenience
`define RST_CHESS_RAM chess_ram[0][0]<=`B_CHARIOT;chess_ram[0][3]<=`B_ADVISOR;chess_ram[0][1]<=`B_HORSE;chess_ram[0][4]<=`B_GENERAL;chess_ram[0][2]<=`B_ELEPHANT;chess_ram[0][5]<=`B_ADVISOR;chess_ram[0][6]<=`B_ELEPHANT;chess_ram[1][0]<=`NONE_CHESS;chess_ram[0][7]<=`B_HORSE;chess_ram[1][1]<=`NONE_CHESS;chess_ram[0][8]<=`B_CHARIOT;chess_ram[1][2]<=`NONE_CHESS;chess_ram[1][3]<=`NONE_CHESS;chess_ram[1][6]<=`NONE_CHESS;chess_ram[1][4]<=`NONE_CHESS;chess_ram[1][7]<=`NONE_CHESS;chess_ram[1][5]<=`NONE_CHESS;chess_ram[1][8]<=`NONE_CHESS;chess_ram[2][0]<=`NONE_CHESS;chess_ram[2][3]<=`NONE_CHESS;chess_ram[2][1]<=`B_CANNON;chess_ram[2][4]<=`NONE_CHESS;chess_ram[2][2]<=`NONE_CHESS;chess_ram[2][5]<=`NONE_CHESS;chess_ram[2][6]<=`NONE_CHESS;chess_ram[3][0]<=`B_SOLDIER;chess_ram[2][7]<=`B_CANNON;chess_ram[3][1]<=`NONE_CHESS;chess_ram[2][8]<=`NONE_CHESS;chess_ram[3][2]<=`B_SOLDIER;chess_ram[3][3]<=`NONE_CHESS;chess_ram[3][6]<=`B_SOLDIER;chess_ram[3][4]<=`B_SOLDIER;chess_ram[3][7]<=`NONE_CHESS;chess_ram[3][5]<=`NONE_CHESS;chess_ram[3][8]<=`B_SOLDIER;chess_ram[4][0]<=`NONE_CHESS;chess_ram[4][3]<=`NONE_CHESS;chess_ram[4][1]<=`NONE_CHESS;chess_ram[4][4]<=`NONE_CHESS;chess_ram[4][2]<=`NONE_CHESS;chess_ram[4][5]<=`NONE_CHESS;chess_ram[4][6]<=`NONE_CHESS;chess_ram[5][0]<=`NONE_CHESS;chess_ram[4][7]<=`NONE_CHESS;chess_ram[5][1]<=`NONE_CHESS;chess_ram[4][8]<=`NONE_CHESS;chess_ram[5][2]<=`NONE_CHESS;chess_ram[5][3]<=`NONE_CHESS;chess_ram[5][6]<=`NONE_CHESS;chess_ram[5][4]<=`NONE_CHESS;chess_ram[5][7]<=`NONE_CHESS;chess_ram[5][5]<=`NONE_CHESS;chess_ram[5][8]<=`NONE_CHESS;chess_ram[6][0]<=`R_SOLDIER;chess_ram[6][3]<=`NONE_CHESS;chess_ram[6][1]<=`NONE_CHESS;chess_ram[6][4]<=`R_SOLDIER;chess_ram[6][2]<=`R_SOLDIER;chess_ram[6][5]<=`NONE_CHESS;chess_ram[6][6]<=`R_SOLDIER;chess_ram[7][0]<=`NONE_CHESS;chess_ram[6][7]<=`NONE_CHESS;chess_ram[7][1]<=`R_CANNON;chess_ram[6][8]<=`R_SOLDIER;chess_ram[7][2]<=`NONE_CHESS;chess_ram[7][3]<=`NONE_CHESS;chess_ram[7][6]<=`NONE_CHESS;chess_ram[7][4]<=`NONE_CHESS;chess_ram[7][7]<=`R_CANNON;chess_ram[7][5]<=`NONE_CHESS;chess_ram[7][8]<=`NONE_CHESS;chess_ram[8][0]<=`NONE_CHESS;chess_ram[8][3]<=`NONE_CHESS;chess_ram[8][1]<=`NONE_CHESS;chess_ram[8][4]<=`NONE_CHESS;chess_ram[8][2]<=`NONE_CHESS;chess_ram[8][5]<=`NONE_CHESS;chess_ram[8][6]<=`NONE_CHESS;chess_ram[9][0]<=`R_CHARIOT;chess_ram[8][7]<=`NONE_CHESS;chess_ram[9][1]<=`R_HORSE;chess_ram[8][8]<=`NONE_CHESS;chess_ram[9][2]<=`R_ELEPHANT;chess_ram[9][3]<=`R_ADVISOR;chess_ram[9][6]<=`R_ELEPHANT;chess_ram[9][4]<=`R_GENERAL;chess_ram[9][7]<=`R_HORSE;chess_ram[9][5]<=`R_ADVISOR;chess_ram[9][8]<=`R_CHARIOT;
`define RST_EFFECT_RAM effect_ram[0][0] <= `NO_EFFECT; effect_ram[0][3] <= `NO_EFFECT;        effect_ram[0][1] <= `NO_EFFECT; effect_ram[0][4] <= `NO_EFFECT;        effect_ram[0][2] <= `NO_EFFECT; effect_ram[0][5] <= `NO_EFFECT;        effect_ram[0][6] <= `NO_EFFECT; effect_ram[1][0] <= `NO_EFFECT;        effect_ram[0][7] <= `NO_EFFECT; effect_ram[1][1] <= `NO_EFFECT;        effect_ram[0][8] <= `NO_EFFECT; effect_ram[1][2] <= `NO_EFFECT;        effect_ram[1][3] <= `NO_EFFECT; effect_ram[1][6] <= `NO_EFFECT;        effect_ram[1][4] <= `B_TRAV;    effect_ram[1][7] <= `NO_EFFECT;        effect_ram[1][5] <= `NO_EFFECT; effect_ram[1][8] <= `NO_EFFECT;        effect_ram[2][0] <= `NO_EFFECT; effect_ram[2][3] <= `NO_EFFECT;        effect_ram[2][1] <= `NO_EFFECT; effect_ram[2][4] <= `NO_EFFECT;        effect_ram[2][2] <= `NO_EFFECT; effect_ram[2][5] <= `NO_EFFECT;        effect_ram[2][6] <= `NO_EFFECT; effect_ram[3][0] <= `NO_EFFECT;        effect_ram[2][7] <= `NO_EFFECT; effect_ram[3][1] <= `NO_EFFECT;        effect_ram[2][8] <= `NO_EFFECT; effect_ram[3][2] <= `NO_EFFECT;        effect_ram[3][3] <= `NO_EFFECT; effect_ram[3][6] <= `NO_EFFECT;        effect_ram[3][4] <= `NO_EFFECT; effect_ram[3][7] <= `NO_EFFECT;        effect_ram[3][5] <= `NO_EFFECT; effect_ram[3][8] <= `NO_EFFECT;        effect_ram[4][0] <= `NO_EFFECT; effect_ram[4][3] <= `NO_EFFECT;        effect_ram[4][1] <= `NO_EFFECT; effect_ram[4][4] <= `NO_EFFECT;        effect_ram[4][2] <= `NO_EFFECT; effect_ram[4][5] <= `NO_EFFECT;        effect_ram[4][6] <= `NO_EFFECT; effect_ram[5][0] <= `NO_EFFECT;        effect_ram[4][7] <= `NO_EFFECT; effect_ram[5][1] <= `NO_EFFECT;        effect_ram[4][8] <= `NO_EFFECT; effect_ram[5][2] <= `NO_EFFECT;        effect_ram[5][3] <= `NO_EFFECT; effect_ram[5][6] <= `NO_EFFECT;        effect_ram[5][4] <= `NO_EFFECT; effect_ram[5][7] <= `NO_EFFECT;        effect_ram[5][5] <= `NO_EFFECT; effect_ram[5][8] <= `NO_EFFECT;        effect_ram[6][0] <= `NO_EFFECT; effect_ram[6][3] <= `NO_EFFECT;        effect_ram[6][1] <= `NO_EFFECT; effect_ram[6][4] <= `NO_EFFECT;        effect_ram[6][2] <= `NO_EFFECT; effect_ram[6][5] <= `NO_EFFECT;        effect_ram[6][6] <= `NO_EFFECT; effect_ram[7][0] <= `NO_EFFECT;        effect_ram[6][7] <= `NO_EFFECT; effect_ram[7][1] <= `NO_EFFECT;        effect_ram[6][8] <= `NO_EFFECT; effect_ram[7][2] <= `NO_EFFECT;        effect_ram[7][3] <= `NO_EFFECT; effect_ram[7][6] <= `NO_EFFECT;        effect_ram[7][4] <= `NO_EFFECT; effect_ram[7][7] <= `NO_EFFECT;        effect_ram[7][5] <= `NO_EFFECT; effect_ram[7][8] <= `NO_EFFECT;        effect_ram[8][0] <= `NO_EFFECT; effect_ram[8][3] <= `NO_EFFECT;        effect_ram[8][1] <= `NO_EFFECT; effect_ram[8][4] <= `R_TRAV;        effect_ram[8][2] <= `NO_EFFECT; effect_ram[8][5] <= `NO_EFFECT;        effect_ram[8][6] <= `NO_EFFECT; effect_ram[9][0] <= `NO_EFFECT;        effect_ram[8][7] <= `NO_EFFECT; effect_ram[9][1] <= `NO_EFFECT;        effect_ram[8][8] <= `NO_EFFECT; effect_ram[9][2] <= `NO_EFFECT;        effect_ram[9][3] <= `NO_EFFECT; effect_ram[9][6] <= `NO_EFFECT;        effect_ram[9][4] <= `NO_EFFECT; effect_ram[9][7] <= `NO_EFFECT;        effect_ram[9][5] <= `NO_EFFECT; effect_ram[9][8] <= `NO_EFFECT;
`define ASSIGN_BACK_CHESS_RAM chess_ram[0][0] <= nxt_chess_ram[0][0]; chess_ram[0][3] <= nxt_chess_ram[0][3];        chess_ram[0][1] <= nxt_chess_ram[0][1]; chess_ram[0][4] <= nxt_chess_ram[0][4];        chess_ram[0][2] <= nxt_chess_ram[0][2]; chess_ram[0][5] <= nxt_chess_ram[0][5];        chess_ram[0][6] <= nxt_chess_ram[0][6]; chess_ram[1][0] <= nxt_chess_ram[1][0];        chess_ram[0][7] <= nxt_chess_ram[0][7]; chess_ram[1][1] <= nxt_chess_ram[1][1];        chess_ram[0][8] <= nxt_chess_ram[0][8]; chess_ram[1][2] <= nxt_chess_ram[1][2];        chess_ram[1][3] <= nxt_chess_ram[1][3]; chess_ram[1][6] <= nxt_chess_ram[1][6];        chess_ram[1][4] <= nxt_chess_ram[1][4]; chess_ram[1][7] <= nxt_chess_ram[1][7];        chess_ram[1][5] <= nxt_chess_ram[1][5]; chess_ram[1][8] <= nxt_chess_ram[1][8];        chess_ram[2][0] <= nxt_chess_ram[2][0]; chess_ram[2][3] <= nxt_chess_ram[2][3];        chess_ram[2][1] <= nxt_chess_ram[2][1]; chess_ram[2][4] <= nxt_chess_ram[2][4];        chess_ram[2][2] <= nxt_chess_ram[2][2]; chess_ram[2][5] <= nxt_chess_ram[2][5];        chess_ram[2][6] <= nxt_chess_ram[2][6]; chess_ram[3][0] <= nxt_chess_ram[3][0];        chess_ram[2][7] <= nxt_chess_ram[2][7]; chess_ram[3][1] <= nxt_chess_ram[3][1];        chess_ram[2][8] <= nxt_chess_ram[2][8]; chess_ram[3][2] <= nxt_chess_ram[3][2];        chess_ram[3][3] <= nxt_chess_ram[3][3]; chess_ram[3][6] <= nxt_chess_ram[3][6];        chess_ram[3][4] <= nxt_chess_ram[3][4]; chess_ram[3][7] <= nxt_chess_ram[3][7];        chess_ram[3][5] <= nxt_chess_ram[3][5]; chess_ram[3][8] <= nxt_chess_ram[3][8];        chess_ram[4][0] <= nxt_chess_ram[4][0]; chess_ram[4][3] <= nxt_chess_ram[4][3];        chess_ram[4][1] <= nxt_chess_ram[4][1]; chess_ram[4][4] <= nxt_chess_ram[4][4];        chess_ram[4][2] <= nxt_chess_ram[4][2]; chess_ram[4][5] <= nxt_chess_ram[4][5];        chess_ram[4][6] <= nxt_chess_ram[4][6]; chess_ram[5][0] <= nxt_chess_ram[5][0];        chess_ram[4][7] <= nxt_chess_ram[4][7]; chess_ram[5][1] <= nxt_chess_ram[5][1];        chess_ram[4][8] <= nxt_chess_ram[4][8]; chess_ram[5][2] <= nxt_chess_ram[5][2];        chess_ram[5][3] <= nxt_chess_ram[5][3]; chess_ram[5][6] <= nxt_chess_ram[5][6];        chess_ram[5][4] <= nxt_chess_ram[5][4]; chess_ram[5][7] <= nxt_chess_ram[5][7];        chess_ram[5][5] <= nxt_chess_ram[5][5]; chess_ram[5][8] <= nxt_chess_ram[5][8];        chess_ram[6][0] <= nxt_chess_ram[6][0]; chess_ram[6][3] <= nxt_chess_ram[6][3];        chess_ram[6][1] <= nxt_chess_ram[6][1]; chess_ram[6][4] <= nxt_chess_ram[6][4];        chess_ram[6][2] <= nxt_chess_ram[6][2]; chess_ram[6][5] <= nxt_chess_ram[6][5];        chess_ram[6][6] <= nxt_chess_ram[6][6]; chess_ram[7][0] <= nxt_chess_ram[7][0];        chess_ram[6][7] <= nxt_chess_ram[6][7]; chess_ram[7][1] <= nxt_chess_ram[7][1];        chess_ram[6][8] <= nxt_chess_ram[6][8]; chess_ram[7][2] <= nxt_chess_ram[7][2];        chess_ram[7][3] <= nxt_chess_ram[7][3]; chess_ram[7][6] <= nxt_chess_ram[7][6];        chess_ram[7][4] <= nxt_chess_ram[7][4]; chess_ram[7][7] <= nxt_chess_ram[7][7];        chess_ram[7][5] <= nxt_chess_ram[7][5]; chess_ram[7][8] <= nxt_chess_ram[7][8];        chess_ram[8][0] <= nxt_chess_ram[8][0]; chess_ram[8][3] <= nxt_chess_ram[8][3];        chess_ram[8][1] <= nxt_chess_ram[8][1]; chess_ram[8][4] <= nxt_chess_ram[8][4];        chess_ram[8][2] <= nxt_chess_ram[8][2]; chess_ram[8][5] <= nxt_chess_ram[8][5];        chess_ram[8][6] <= nxt_chess_ram[8][6]; chess_ram[9][0] <= nxt_chess_ram[9][0];        chess_ram[8][7] <= nxt_chess_ram[8][7]; chess_ram[9][1] <= nxt_chess_ram[9][1];        chess_ram[8][8] <= nxt_chess_ram[8][8]; chess_ram[9][2] <= nxt_chess_ram[9][2];        chess_ram[9][3] <= nxt_chess_ram[9][3]; chess_ram[9][6] <= nxt_chess_ram[9][6];        chess_ram[9][4] <= nxt_chess_ram[9][4]; chess_ram[9][7] <= nxt_chess_ram[9][7];        chess_ram[9][5] <= nxt_chess_ram[9][5]; chess_ram[9][8] <= nxt_chess_ram[9][8];
`define ASSIGN_BACK_EFFECT_RAM effect_ram[0][0] <= nxt_effect_ram[0][0]; effect_ram[0][3] <= nxt_effect_ram[0][3];        effect_ram[0][1] <= nxt_effect_ram[0][1]; effect_ram[0][4] <= nxt_effect_ram[0][4];        effect_ram[0][2] <= nxt_effect_ram[0][2]; effect_ram[0][5] <= nxt_effect_ram[0][5];        effect_ram[0][6] <= nxt_effect_ram[0][6]; effect_ram[1][0] <= nxt_effect_ram[1][0];        effect_ram[0][7] <= nxt_effect_ram[0][7]; effect_ram[1][1] <= nxt_effect_ram[1][1];        effect_ram[0][8] <= nxt_effect_ram[0][8]; effect_ram[1][2] <= nxt_effect_ram[1][2];        effect_ram[1][3] <= nxt_effect_ram[1][3]; effect_ram[1][6] <= nxt_effect_ram[1][6];        effect_ram[1][4] <= nxt_effect_ram[1][4]; effect_ram[1][7] <= nxt_effect_ram[1][7];        effect_ram[1][5] <= nxt_effect_ram[1][5]; effect_ram[1][8] <= nxt_effect_ram[1][8];        effect_ram[2][0] <= nxt_effect_ram[2][0]; effect_ram[2][3] <= nxt_effect_ram[2][3];        effect_ram[2][1] <= nxt_effect_ram[2][1]; effect_ram[2][4] <= nxt_effect_ram[2][4];        effect_ram[2][2] <= nxt_effect_ram[2][2]; effect_ram[2][5] <= nxt_effect_ram[2][5];        effect_ram[2][6] <= nxt_effect_ram[2][6]; effect_ram[3][0] <= nxt_effect_ram[3][0];        effect_ram[2][7] <= nxt_effect_ram[2][7]; effect_ram[3][1] <= nxt_effect_ram[3][1];        effect_ram[2][8] <= nxt_effect_ram[2][8]; effect_ram[3][2] <= nxt_effect_ram[3][2];        effect_ram[3][3] <= nxt_effect_ram[3][3]; effect_ram[3][6] <= nxt_effect_ram[3][6];        effect_ram[3][4] <= nxt_effect_ram[3][4]; effect_ram[3][7] <= nxt_effect_ram[3][7];        effect_ram[3][5] <= nxt_effect_ram[3][5]; effect_ram[3][8] <= nxt_effect_ram[3][8];        effect_ram[4][0] <= nxt_effect_ram[4][0]; effect_ram[4][3] <= nxt_effect_ram[4][3];        effect_ram[4][1] <= nxt_effect_ram[4][1]; effect_ram[4][4] <= nxt_effect_ram[4][4];        effect_ram[4][2] <= nxt_effect_ram[4][2]; effect_ram[4][5] <= nxt_effect_ram[4][5];        effect_ram[4][6] <= nxt_effect_ram[4][6]; effect_ram[5][0] <= nxt_effect_ram[5][0];        effect_ram[4][7] <= nxt_effect_ram[4][7]; effect_ram[5][1] <= nxt_effect_ram[5][1];        effect_ram[4][8] <= nxt_effect_ram[4][8]; effect_ram[5][2] <= nxt_effect_ram[5][2];        effect_ram[5][3] <= nxt_effect_ram[5][3]; effect_ram[5][6] <= nxt_effect_ram[5][6];        effect_ram[5][4] <= nxt_effect_ram[5][4]; effect_ram[5][7] <= nxt_effect_ram[5][7];        effect_ram[5][5] <= nxt_effect_ram[5][5]; effect_ram[5][8] <= nxt_effect_ram[5][8];        effect_ram[6][0] <= nxt_effect_ram[6][0]; effect_ram[6][3] <= nxt_effect_ram[6][3];        effect_ram[6][1] <= nxt_effect_ram[6][1]; effect_ram[6][4] <= nxt_effect_ram[6][4];        effect_ram[6][2] <= nxt_effect_ram[6][2]; effect_ram[6][5] <= nxt_effect_ram[6][5];        effect_ram[6][6] <= nxt_effect_ram[6][6]; effect_ram[7][0] <= nxt_effect_ram[7][0];        effect_ram[6][7] <= nxt_effect_ram[6][7]; effect_ram[7][1] <= nxt_effect_ram[7][1];        effect_ram[6][8] <= nxt_effect_ram[6][8]; effect_ram[7][2] <= nxt_effect_ram[7][2];        effect_ram[7][3] <= nxt_effect_ram[7][3]; effect_ram[7][6] <= nxt_effect_ram[7][6];        effect_ram[7][4] <= nxt_effect_ram[7][4]; effect_ram[7][7] <= nxt_effect_ram[7][7];        effect_ram[7][5] <= nxt_effect_ram[7][5]; effect_ram[7][8] <= nxt_effect_ram[7][8];        effect_ram[8][0] <= nxt_effect_ram[8][0]; effect_ram[8][3] <= nxt_effect_ram[8][3];        effect_ram[8][1] <= nxt_effect_ram[8][1]; effect_ram[8][4] <= nxt_effect_ram[8][4];        effect_ram[8][2] <= nxt_effect_ram[8][2]; effect_ram[8][5] <= nxt_effect_ram[8][5];        effect_ram[8][6] <= nxt_effect_ram[8][6]; effect_ram[9][0] <= nxt_effect_ram[9][0];        effect_ram[8][7] <= nxt_effect_ram[8][7]; effect_ram[9][1] <= nxt_effect_ram[9][1];        effect_ram[8][8] <= nxt_effect_ram[8][8]; effect_ram[9][2] <= nxt_effect_ram[9][2];        effect_ram[9][3] <= nxt_effect_ram[9][3]; effect_ram[9][6] <= nxt_effect_ram[9][6];        effect_ram[9][4] <= nxt_effect_ram[9][4]; effect_ram[9][7] <= nxt_effect_ram[9][7];        effect_ram[9][5] <= nxt_effect_ram[9][5]; effect_ram[9][8] <= nxt_effect_ram[9][8];
`define ASSIGN_CHESS_RAM nxt_chess_ram[0][0] = chess_ram[0][0]; nxt_chess_ram[0][3] = chess_ram[0][3];    nxt_chess_ram[0][1] = chess_ram[0][1]; nxt_chess_ram[0][4] = chess_ram[0][4];    nxt_chess_ram[0][2] = chess_ram[0][2]; nxt_chess_ram[0][5] = chess_ram[0][5];    nxt_chess_ram[0][6] = chess_ram[0][6]; nxt_chess_ram[1][0] = chess_ram[1][0];    nxt_chess_ram[0][7] = chess_ram[0][7]; nxt_chess_ram[1][1] = chess_ram[1][1];    nxt_chess_ram[0][8] = chess_ram[0][8]; nxt_chess_ram[1][2] = chess_ram[1][2];    nxt_chess_ram[1][3] = chess_ram[1][3]; nxt_chess_ram[1][6] = chess_ram[1][6];    nxt_chess_ram[1][4] = chess_ram[1][4]; nxt_chess_ram[1][7] = chess_ram[1][7];    nxt_chess_ram[1][5] = chess_ram[1][5]; nxt_chess_ram[1][8] = chess_ram[1][8];    nxt_chess_ram[2][0] = chess_ram[2][0]; nxt_chess_ram[2][3] = chess_ram[2][3];    nxt_chess_ram[2][1] = chess_ram[2][1]; nxt_chess_ram[2][4] = chess_ram[2][4];    nxt_chess_ram[2][2] = chess_ram[2][2]; nxt_chess_ram[2][5] = chess_ram[2][5];    nxt_chess_ram[2][6] = chess_ram[2][6]; nxt_chess_ram[3][0] = chess_ram[3][0];    nxt_chess_ram[2][7] = chess_ram[2][7]; nxt_chess_ram[3][1] = chess_ram[3][1];    nxt_chess_ram[2][8] = chess_ram[2][8]; nxt_chess_ram[3][2] = chess_ram[3][2];    nxt_chess_ram[3][3] = chess_ram[3][3]; nxt_chess_ram[3][6] = chess_ram[3][6];    nxt_chess_ram[3][4] = chess_ram[3][4]; nxt_chess_ram[3][7] = chess_ram[3][7];    nxt_chess_ram[3][5] = chess_ram[3][5]; nxt_chess_ram[3][8] = chess_ram[3][8];    nxt_chess_ram[4][0] = chess_ram[4][0]; nxt_chess_ram[4][3] = chess_ram[4][3];    nxt_chess_ram[4][1] = chess_ram[4][1]; nxt_chess_ram[4][4] = chess_ram[4][4];    nxt_chess_ram[4][2] = chess_ram[4][2]; nxt_chess_ram[4][5] = chess_ram[4][5];    nxt_chess_ram[4][6] = chess_ram[4][6]; nxt_chess_ram[5][0] = chess_ram[5][0];    nxt_chess_ram[4][7] = chess_ram[4][7]; nxt_chess_ram[5][1] = chess_ram[5][1];    nxt_chess_ram[4][8] = chess_ram[4][8]; nxt_chess_ram[5][2] = chess_ram[5][2];    nxt_chess_ram[5][3] = chess_ram[5][3]; nxt_chess_ram[5][6] = chess_ram[5][6];    nxt_chess_ram[5][4] = chess_ram[5][4]; nxt_chess_ram[5][7] = chess_ram[5][7];    nxt_chess_ram[5][5] = chess_ram[5][5]; nxt_chess_ram[5][8] = chess_ram[5][8];    nxt_chess_ram[6][0] = chess_ram[6][0]; nxt_chess_ram[6][3] = chess_ram[6][3];    nxt_chess_ram[6][1] = chess_ram[6][1]; nxt_chess_ram[6][4] = chess_ram[6][4];    nxt_chess_ram[6][2] = chess_ram[6][2]; nxt_chess_ram[6][5] = chess_ram[6][5];    nxt_chess_ram[6][6] = chess_ram[6][6]; nxt_chess_ram[7][0] = chess_ram[7][0];    nxt_chess_ram[6][7] = chess_ram[6][7]; nxt_chess_ram[7][1] = chess_ram[7][1];    nxt_chess_ram[6][8] = chess_ram[6][8]; nxt_chess_ram[7][2] = chess_ram[7][2];    nxt_chess_ram[7][3] = chess_ram[7][3]; nxt_chess_ram[7][6] = chess_ram[7][6];    nxt_chess_ram[7][4] = chess_ram[7][4]; nxt_chess_ram[7][7] = chess_ram[7][7];    nxt_chess_ram[7][5] = chess_ram[7][5]; nxt_chess_ram[7][8] = chess_ram[7][8];    nxt_chess_ram[8][0] = chess_ram[8][0]; nxt_chess_ram[8][3] = chess_ram[8][3];    nxt_chess_ram[8][1] = chess_ram[8][1]; nxt_chess_ram[8][4] = chess_ram[8][4];    nxt_chess_ram[8][2] = chess_ram[8][2]; nxt_chess_ram[8][5] = chess_ram[8][5];    nxt_chess_ram[8][6] = chess_ram[8][6]; nxt_chess_ram[9][0] = chess_ram[9][0];    nxt_chess_ram[8][7] = chess_ram[8][7]; nxt_chess_ram[9][1] = chess_ram[9][1];    nxt_chess_ram[8][8] = chess_ram[8][8]; nxt_chess_ram[9][2] = chess_ram[9][2];    nxt_chess_ram[9][3] = chess_ram[9][3]; nxt_chess_ram[9][6] = chess_ram[9][6];    nxt_chess_ram[9][4] = chess_ram[9][4]; nxt_chess_ram[9][7] = chess_ram[9][7];    nxt_chess_ram[9][5] = chess_ram[9][5]; nxt_chess_ram[9][8] = chess_ram[9][8];
`define ASSIGN_EFFECT_RAM nxt_effect_ram[0][0] = effect_ram[0][0]; nxt_effect_ram[0][3] = effect_ram[0][3];    nxt_effect_ram[0][1] = effect_ram[0][1]; nxt_effect_ram[0][4] = effect_ram[0][4];    nxt_effect_ram[0][2] = effect_ram[0][2]; nxt_effect_ram[0][5] = effect_ram[0][5];    nxt_effect_ram[0][6] = effect_ram[0][6]; nxt_effect_ram[1][0] = effect_ram[1][0];    nxt_effect_ram[0][7] = effect_ram[0][7]; nxt_effect_ram[1][1] = effect_ram[1][1];    nxt_effect_ram[0][8] = effect_ram[0][8]; nxt_effect_ram[1][2] = effect_ram[1][2];    nxt_effect_ram[1][3] = effect_ram[1][3]; nxt_effect_ram[1][6] = effect_ram[1][6];    nxt_effect_ram[1][4] = effect_ram[1][4]; nxt_effect_ram[1][7] = effect_ram[1][7];    nxt_effect_ram[1][5] = effect_ram[1][5]; nxt_effect_ram[1][8] = effect_ram[1][8];    nxt_effect_ram[2][0] = effect_ram[2][0]; nxt_effect_ram[2][3] = effect_ram[2][3];    nxt_effect_ram[2][1] = effect_ram[2][1]; nxt_effect_ram[2][4] = effect_ram[2][4];    nxt_effect_ram[2][2] = effect_ram[2][2]; nxt_effect_ram[2][5] = effect_ram[2][5];    nxt_effect_ram[2][6] = effect_ram[2][6]; nxt_effect_ram[3][0] = effect_ram[3][0];    nxt_effect_ram[2][7] = effect_ram[2][7]; nxt_effect_ram[3][1] = effect_ram[3][1];    nxt_effect_ram[2][8] = effect_ram[2][8]; nxt_effect_ram[3][2] = effect_ram[3][2];    nxt_effect_ram[3][3] = effect_ram[3][3]; nxt_effect_ram[3][6] = effect_ram[3][6];    nxt_effect_ram[3][4] = effect_ram[3][4]; nxt_effect_ram[3][7] = effect_ram[3][7];    nxt_effect_ram[3][5] = effect_ram[3][5]; nxt_effect_ram[3][8] = effect_ram[3][8];    nxt_effect_ram[4][0] = effect_ram[4][0]; nxt_effect_ram[4][3] = effect_ram[4][3];    nxt_effect_ram[4][1] = effect_ram[4][1]; nxt_effect_ram[4][4] = effect_ram[4][4];    nxt_effect_ram[4][2] = effect_ram[4][2]; nxt_effect_ram[4][5] = effect_ram[4][5];    nxt_effect_ram[4][6] = effect_ram[4][6]; nxt_effect_ram[5][0] = effect_ram[5][0];    nxt_effect_ram[4][7] = effect_ram[4][7]; nxt_effect_ram[5][1] = effect_ram[5][1];    nxt_effect_ram[4][8] = effect_ram[4][8]; nxt_effect_ram[5][2] = effect_ram[5][2];    nxt_effect_ram[5][3] = effect_ram[5][3]; nxt_effect_ram[5][6] = effect_ram[5][6];    nxt_effect_ram[5][4] = effect_ram[5][4]; nxt_effect_ram[5][7] = effect_ram[5][7];    nxt_effect_ram[5][5] = effect_ram[5][5]; nxt_effect_ram[5][8] = effect_ram[5][8];    nxt_effect_ram[6][0] = effect_ram[6][0]; nxt_effect_ram[6][3] = effect_ram[6][3];    nxt_effect_ram[6][1] = effect_ram[6][1]; nxt_effect_ram[6][4] = effect_ram[6][4];    nxt_effect_ram[6][2] = effect_ram[6][2]; nxt_effect_ram[6][5] = effect_ram[6][5];    nxt_effect_ram[6][6] = effect_ram[6][6]; nxt_effect_ram[7][0] = effect_ram[7][0];    nxt_effect_ram[6][7] = effect_ram[6][7]; nxt_effect_ram[7][1] = effect_ram[7][1];    nxt_effect_ram[6][8] = effect_ram[6][8]; nxt_effect_ram[7][2] = effect_ram[7][2];    nxt_effect_ram[7][3] = effect_ram[7][3]; nxt_effect_ram[7][6] = effect_ram[7][6];    nxt_effect_ram[7][4] = effect_ram[7][4]; nxt_effect_ram[7][7] = effect_ram[7][7];    nxt_effect_ram[7][5] = effect_ram[7][5]; nxt_effect_ram[7][8] = effect_ram[7][8];    nxt_effect_ram[8][0] = effect_ram[8][0]; nxt_effect_ram[8][3] = effect_ram[8][3];    nxt_effect_ram[8][1] = effect_ram[8][1]; nxt_effect_ram[8][4] = effect_ram[8][4];    nxt_effect_ram[8][2] = effect_ram[8][2]; nxt_effect_ram[8][5] = effect_ram[8][5];    nxt_effect_ram[8][6] = effect_ram[8][6]; nxt_effect_ram[9][0] = effect_ram[9][0];    nxt_effect_ram[8][7] = effect_ram[8][7]; nxt_effect_ram[9][1] = effect_ram[9][1];    nxt_effect_ram[8][8] = effect_ram[8][8]; nxt_effect_ram[9][2] = effect_ram[9][2];    nxt_effect_ram[9][3] = effect_ram[9][3]; nxt_effect_ram[9][6] = effect_ram[9][6];    nxt_effect_ram[9][4] = effect_ram[9][4]; nxt_effect_ram[9][7] = effect_ram[9][7];    nxt_effect_ram[9][5] = effect_ram[9][5]; nxt_effect_ram[9][8] = effect_ram[9][8];
`define RST_CHESS_RAM_HIDDEN chess_ram[0][0]<=`B_H_CHARIOT;chess_ram[0][3]<=`B_H_ADVISOR;chess_ram[0][1]<=`B_H_HORSE;chess_ram[0][4]<=`B_H_GENERAL;chess_ram[0][2]<=`B_H_ELEPHANT;chess_ram[0][5]<=`B_H_ADVISOR;chess_ram[0][6]<=`B_H_ELEPHANT;chess_ram[1][0]<=`NONE_CHESS;chess_ram[0][7]<=`B_H_HORSE;chess_ram[1][1]<=`NONE_CHESS;chess_ram[0][8]<=`B_H_CHARIOT;chess_ram[1][2]<=`NONE_CHESS;chess_ram[1][3]<=`NONE_CHESS;chess_ram[1][6]<=`NONE_CHESS;chess_ram[1][4]<=`NONE_CHESS;chess_ram[1][7]<=`NONE_CHESS;chess_ram[1][5]<=`NONE_CHESS;chess_ram[1][8]<=`NONE_CHESS;chess_ram[2][0]<=`NONE_CHESS;chess_ram[2][3]<=`NONE_CHESS;chess_ram[2][1]<=`B_H_CANNON;chess_ram[2][4]<=`NONE_CHESS;chess_ram[2][2]<=`NONE_CHESS;chess_ram[2][5]<=`NONE_CHESS;chess_ram[2][6]<=`NONE_CHESS;chess_ram[3][0]<=`B_H_SOLDIER;chess_ram[2][7]<=`B_H_CANNON;chess_ram[3][1]<=`NONE_CHESS;chess_ram[2][8]<=`NONE_CHESS;chess_ram[3][2]<=`B_H_SOLDIER;chess_ram[3][3]<=`NONE_CHESS;chess_ram[3][6]<=`B_H_SOLDIER;chess_ram[3][4]<=`B_H_SOLDIER;chess_ram[3][7]<=`NONE_CHESS;chess_ram[3][5]<=`NONE_CHESS;chess_ram[3][8]<=`B_H_SOLDIER;chess_ram[4][0]<=`NONE_CHESS;chess_ram[4][3]<=`NONE_CHESS;chess_ram[4][1]<=`NONE_CHESS;chess_ram[4][4]<=`NONE_CHESS;chess_ram[4][2]<=`NONE_CHESS;chess_ram[4][5]<=`NONE_CHESS;chess_ram[4][6]<=`NONE_CHESS;chess_ram[5][0]<=`NONE_CHESS;chess_ram[4][7]<=`NONE_CHESS;chess_ram[5][1]<=`NONE_CHESS;chess_ram[4][8]<=`NONE_CHESS;chess_ram[5][2]<=`NONE_CHESS;chess_ram[5][3]<=`NONE_CHESS;chess_ram[5][6]<=`NONE_CHESS;chess_ram[5][4]<=`NONE_CHESS;chess_ram[5][7]<=`NONE_CHESS;chess_ram[5][5]<=`NONE_CHESS;chess_ram[5][8]<=`NONE_CHESS;chess_ram[6][0]<=`R_H_SOLDIER;chess_ram[6][3]<=`NONE_CHESS;chess_ram[6][1]<=`NONE_CHESS;chess_ram[6][4]<=`R_H_SOLDIER;chess_ram[6][2]<=`R_H_SOLDIER;chess_ram[6][5]<=`NONE_CHESS;chess_ram[6][6]<=`R_H_SOLDIER;chess_ram[7][0]<=`NONE_CHESS;chess_ram[6][7]<=`NONE_CHESS;chess_ram[7][1]<=`R_H_CANNON;chess_ram[6][8]<=`R_H_SOLDIER;chess_ram[7][2]<=`NONE_CHESS;chess_ram[7][3]<=`NONE_CHESS;chess_ram[7][6]<=`NONE_CHESS;chess_ram[7][4]<=`NONE_CHESS;chess_ram[7][7]<=`R_H_CANNON;chess_ram[7][5]<=`NONE_CHESS;chess_ram[7][8]<=`NONE_CHESS;chess_ram[8][0]<=`NONE_CHESS;chess_ram[8][3]<=`NONE_CHESS;chess_ram[8][1]<=`NONE_CHESS;chess_ram[8][4]<=`NONE_CHESS;chess_ram[8][2]<=`NONE_CHESS;chess_ram[8][5]<=`NONE_CHESS;chess_ram[8][6]<=`NONE_CHESS;chess_ram[9][0]<=`R_H_CHARIOT;chess_ram[8][7]<=`NONE_CHESS;chess_ram[9][1]<=`R_H_HORSE;chess_ram[8][8]<=`NONE_CHESS;chess_ram[9][2]<=`R_H_ELEPHANT;chess_ram[9][3]<=`R_H_ADVISOR;chess_ram[9][6]<=`R_H_ELEPHANT;chess_ram[9][4]<=`R_H_GENERAL;chess_ram[9][7]<=`R_H_HORSE;chess_ram[9][5]<=`R_H_ADVISOR;chess_ram[9][8]<=`R_H_CHARIOT;
`define RST_CHESS_RAM_HIDDEN_RAND chess_ram[0][0][`CHESS_LEN-2:0]<=rd_chess_arr[3:0];chess_ram[0][3][`CHESS_LEN-2:0]<=rd_chess_arr[7:4];chess_ram[0][1][`CHESS_LEN-2:0]<=rd_chess_arr[11:8];chess_ram[0][4][`CHESS_LEN-2:0]<=rd_chess_arr[15:12];chess_ram[0][2][`CHESS_LEN-2:0]<=rd_chess_arr[19:16];chess_ram[0][5][`CHESS_LEN-2:0]<=rd_chess_arr[23:20];chess_ram[0][6][`CHESS_LEN-2:0]<=rd_chess_arr[27:24];chess_ram[0][7][`CHESS_LEN-2:0]<=rd_chess_arr[31:28];chess_ram[0][8][`CHESS_LEN-2:0]<=rd_chess_arr[35:32];chess_ram[2][1][`CHESS_LEN-2:0]<=rd_chess_arr[39:36];chess_ram[3][0][`CHESS_LEN-2:0]<=rd_chess_arr[43:40];chess_ram[2][7][`CHESS_LEN-2:0]<=rd_chess_arr[47:44];chess_ram[3][2][`CHESS_LEN-2:0]<=rd_chess_arr[51:48];chess_ram[3][6][`CHESS_LEN-2:0]<=rd_chess_arr[55:52];chess_ram[3][4][`CHESS_LEN-2:0]<=rd_chess_arr[59:56];chess_ram[3][8][`CHESS_LEN-2:0]<=rd_chess_arr[63:60];chess_ram[6][0][`CHESS_LEN-2:0]<=rd_chess_arr[67:64];chess_ram[6][4][`CHESS_LEN-2:0]<=rd_chess_arr[71:68];chess_ram[6][2][`CHESS_LEN-2:0]<=rd_chess_arr[75:72];chess_ram[6][6][`CHESS_LEN-2:0]<=rd_chess_arr[79:76];chess_ram[7][1][`CHESS_LEN-2:0]<=rd_chess_arr[83:80];chess_ram[6][8][`CHESS_LEN-2:0]<=rd_chess_arr[87:84];chess_ram[7][7][`CHESS_LEN-2:0]<=rd_chess_arr[91:88];chess_ram[9][0][`CHESS_LEN-2:0]<=rd_chess_arr[95:92];chess_ram[9][1][`CHESS_LEN-2:0]<=rd_chess_arr[99:96];chess_ram[9][2][`CHESS_LEN-2:0]<=rd_chess_arr[103:100];chess_ram[9][3][`CHESS_LEN-2:0]<=rd_chess_arr[107:104];chess_ram[9][6][`CHESS_LEN-2:0]<=rd_chess_arr[111:108];chess_ram[9][4][`CHESS_LEN-2:0]<=rd_chess_arr[115:112];chess_ram[9][7][`CHESS_LEN-2:0]<=rd_chess_arr[119:116];chess_ram[9][5][`CHESS_LEN-2:0]<=rd_chess_arr[123:120];chess_ram[9][8][`CHESS_LEN-2:0]<=rd_chess_arr[127:124];
`define RST_EFFECT_RAM_HIDDEN effect_ram[0][0] <= `NO_EFFECT; effect_ram[0][3] <= `NO_EFFECT;        effect_ram[0][1] <= `NO_EFFECT; effect_ram[0][4] <= `NO_EFFECT;        effect_ram[0][2] <= `NO_EFFECT; effect_ram[0][5] <= `NO_EFFECT;        effect_ram[0][6] <= `NO_EFFECT; effect_ram[1][0] <= `NO_EFFECT;        effect_ram[0][7] <= `NO_EFFECT; effect_ram[1][1] <= `NO_EFFECT;        effect_ram[0][8] <= `NO_EFFECT; effect_ram[1][2] <= `NO_EFFECT;        effect_ram[1][3] <= `NO_EFFECT; effect_ram[1][6] <= `NO_EFFECT;        effect_ram[1][4] <= `B_TRAV;    effect_ram[1][7] <= `NO_EFFECT;        effect_ram[1][5] <= `NO_EFFECT; effect_ram[1][8] <= `NO_EFFECT;        effect_ram[2][0] <= `NO_EFFECT; effect_ram[2][3] <= `NO_EFFECT;        effect_ram[2][1] <= `NO_EFFECT; effect_ram[2][4] <= `NO_EFFECT;        effect_ram[2][2] <= `NO_EFFECT; effect_ram[2][5] <= `NO_EFFECT;        effect_ram[2][6] <= `NO_EFFECT; effect_ram[3][0] <= `NO_EFFECT;        effect_ram[2][7] <= `NO_EFFECT; effect_ram[3][1] <= `NO_EFFECT;        effect_ram[2][8] <= `NO_EFFECT; effect_ram[3][2] <= `NO_EFFECT;        effect_ram[3][3] <= `NO_EFFECT; effect_ram[3][6] <= `NO_EFFECT;        effect_ram[3][4] <= `NO_EFFECT; effect_ram[3][7] <= `NO_EFFECT;        effect_ram[3][5] <= `NO_EFFECT; effect_ram[3][8] <= `NO_EFFECT;        effect_ram[4][0] <= `NO_EFFECT; effect_ram[4][3] <= `NO_EFFECT;        effect_ram[4][1] <= `NO_EFFECT; effect_ram[4][4] <= `NO_EFFECT;        effect_ram[4][2] <= `NO_EFFECT; effect_ram[4][5] <= `NO_EFFECT;        effect_ram[4][6] <= `NO_EFFECT; effect_ram[5][0] <= `NO_EFFECT;        effect_ram[4][7] <= `NO_EFFECT; effect_ram[5][1] <= `NO_EFFECT;        effect_ram[4][8] <= `NO_EFFECT; effect_ram[5][2] <= `NO_EFFECT;        effect_ram[5][3] <= `NO_EFFECT; effect_ram[5][6] <= `NO_EFFECT;        effect_ram[5][4] <= `NO_EFFECT; effect_ram[5][7] <= `NO_EFFECT;        effect_ram[5][5] <= `NO_EFFECT; effect_ram[5][8] <= `NO_EFFECT;        effect_ram[6][0] <= `NO_EFFECT; effect_ram[6][3] <= `NO_EFFECT;        effect_ram[6][1] <= `NO_EFFECT; effect_ram[6][4] <= `NO_EFFECT;        effect_ram[6][2] <= `NO_EFFECT; effect_ram[6][5] <= `NO_EFFECT;        effect_ram[6][6] <= `NO_EFFECT; effect_ram[7][0] <= `NO_EFFECT;        effect_ram[6][7] <= `NO_EFFECT; effect_ram[7][1] <= `NO_EFFECT;        effect_ram[6][8] <= `NO_EFFECT; effect_ram[7][2] <= `NO_EFFECT;        effect_ram[7][3] <= `NO_EFFECT; effect_ram[7][6] <= `NO_EFFECT;        effect_ram[7][4] <= `NO_EFFECT; effect_ram[7][7] <= `NO_EFFECT;        effect_ram[7][5] <= `NO_EFFECT; effect_ram[7][8] <= `NO_EFFECT;        effect_ram[8][0] <= `NO_EFFECT; effect_ram[8][3] <= `NO_EFFECT;        effect_ram[8][1] <= `NO_EFFECT; effect_ram[8][4] <= `R_TRAV;        effect_ram[8][2] <= `NO_EFFECT; effect_ram[8][5] <= `NO_EFFECT;        effect_ram[8][6] <= `NO_EFFECT; effect_ram[9][0] <= `NO_EFFECT;        effect_ram[8][7] <= `NO_EFFECT; effect_ram[9][1] <= `NO_EFFECT;        effect_ram[8][8] <= `NO_EFFECT; effect_ram[9][2] <= `NO_EFFECT;        effect_ram[9][3] <= `NO_EFFECT; effect_ram[9][6] <= `NO_EFFECT;        effect_ram[9][4] <= `NO_EFFECT; effect_ram[9][7] <= `NO_EFFECT;        effect_ram[9][5] <= `NO_EFFECT; effect_ram[9][8] <= `NO_EFFECT;
`define ASSIGN_BACK_CHESS_RAM_HIDDEN chess_ram[0][0] <= nxt_chess_ram[0][0]; chess_ram[0][3] <= nxt_chess_ram[0][3];        chess_ram[0][1] <= nxt_chess_ram[0][1]; chess_ram[0][4] <= nxt_chess_ram[0][4];        chess_ram[0][2] <= nxt_chess_ram[0][2]; chess_ram[0][5] <= nxt_chess_ram[0][5];        chess_ram[0][6] <= nxt_chess_ram[0][6]; chess_ram[1][0] <= nxt_chess_ram[1][0];        chess_ram[0][7] <= nxt_chess_ram[0][7]; chess_ram[1][1] <= nxt_chess_ram[1][1];        chess_ram[0][8] <= nxt_chess_ram[0][8]; chess_ram[1][2] <= nxt_chess_ram[1][2];        chess_ram[1][3] <= nxt_chess_ram[1][3]; chess_ram[1][6] <= nxt_chess_ram[1][6];        chess_ram[1][4] <= nxt_chess_ram[1][4]; chess_ram[1][7] <= nxt_chess_ram[1][7];        chess_ram[1][5] <= nxt_chess_ram[1][5]; chess_ram[1][8] <= nxt_chess_ram[1][8];        chess_ram[2][0] <= nxt_chess_ram[2][0]; chess_ram[2][3] <= nxt_chess_ram[2][3];        chess_ram[2][1] <= nxt_chess_ram[2][1]; chess_ram[2][4] <= nxt_chess_ram[2][4];        chess_ram[2][2] <= nxt_chess_ram[2][2]; chess_ram[2][5] <= nxt_chess_ram[2][5];        chess_ram[2][6] <= nxt_chess_ram[2][6]; chess_ram[3][0] <= nxt_chess_ram[3][0];        chess_ram[2][7] <= nxt_chess_ram[2][7]; chess_ram[3][1] <= nxt_chess_ram[3][1];        chess_ram[2][8] <= nxt_chess_ram[2][8]; chess_ram[3][2] <= nxt_chess_ram[3][2];        chess_ram[3][3] <= nxt_chess_ram[3][3]; chess_ram[3][6] <= nxt_chess_ram[3][6];        chess_ram[3][4] <= nxt_chess_ram[3][4]; chess_ram[3][7] <= nxt_chess_ram[3][7];        chess_ram[3][5] <= nxt_chess_ram[3][5]; chess_ram[3][8] <= nxt_chess_ram[3][8];        chess_ram[4][0] <= nxt_chess_ram[4][0]; chess_ram[4][3] <= nxt_chess_ram[4][3];        chess_ram[4][1] <= nxt_chess_ram[4][1]; chess_ram[4][4] <= nxt_chess_ram[4][4];        chess_ram[4][2] <= nxt_chess_ram[4][2]; chess_ram[4][5] <= nxt_chess_ram[4][5];        chess_ram[4][6] <= nxt_chess_ram[4][6]; chess_ram[5][0] <= nxt_chess_ram[5][0];        chess_ram[4][7] <= nxt_chess_ram[4][7]; chess_ram[5][1] <= nxt_chess_ram[5][1];        chess_ram[4][8] <= nxt_chess_ram[4][8]; chess_ram[5][2] <= nxt_chess_ram[5][2];        chess_ram[5][3] <= nxt_chess_ram[5][3]; chess_ram[5][6] <= nxt_chess_ram[5][6];        chess_ram[5][4] <= nxt_chess_ram[5][4]; chess_ram[5][7] <= nxt_chess_ram[5][7];        chess_ram[5][5] <= nxt_chess_ram[5][5]; chess_ram[5][8] <= nxt_chess_ram[5][8];        chess_ram[6][0] <= nxt_chess_ram[6][0]; chess_ram[6][3] <= nxt_chess_ram[6][3];        chess_ram[6][1] <= nxt_chess_ram[6][1]; chess_ram[6][4] <= nxt_chess_ram[6][4];        chess_ram[6][2] <= nxt_chess_ram[6][2]; chess_ram[6][5] <= nxt_chess_ram[6][5];        chess_ram[6][6] <= nxt_chess_ram[6][6]; chess_ram[7][0] <= nxt_chess_ram[7][0];        chess_ram[6][7] <= nxt_chess_ram[6][7]; chess_ram[7][1] <= nxt_chess_ram[7][1];        chess_ram[6][8] <= nxt_chess_ram[6][8]; chess_ram[7][2] <= nxt_chess_ram[7][2];        chess_ram[7][3] <= nxt_chess_ram[7][3]; chess_ram[7][6] <= nxt_chess_ram[7][6];        chess_ram[7][4] <= nxt_chess_ram[7][4]; chess_ram[7][7] <= nxt_chess_ram[7][7];        chess_ram[7][5] <= nxt_chess_ram[7][5]; chess_ram[7][8] <= nxt_chess_ram[7][8];        chess_ram[8][0] <= nxt_chess_ram[8][0]; chess_ram[8][3] <= nxt_chess_ram[8][3];        chess_ram[8][1] <= nxt_chess_ram[8][1]; chess_ram[8][4] <= nxt_chess_ram[8][4];        chess_ram[8][2] <= nxt_chess_ram[8][2]; chess_ram[8][5] <= nxt_chess_ram[8][5];        chess_ram[8][6] <= nxt_chess_ram[8][6]; chess_ram[9][0] <= nxt_chess_ram[9][0];        chess_ram[8][7] <= nxt_chess_ram[8][7]; chess_ram[9][1] <= nxt_chess_ram[9][1];        chess_ram[8][8] <= nxt_chess_ram[8][8]; chess_ram[9][2] <= nxt_chess_ram[9][2];        chess_ram[9][3] <= nxt_chess_ram[9][3]; chess_ram[9][6] <= nxt_chess_ram[9][6];        chess_ram[9][4] <= nxt_chess_ram[9][4]; chess_ram[9][7] <= nxt_chess_ram[9][7];        chess_ram[9][5] <= nxt_chess_ram[9][5]; chess_ram[9][8] <= nxt_chess_ram[9][8];
`define ASSIGN_BACK_EFFECT_RAM_HIDDEN effect_ram[0][0] <= nxt_effect_ram[0][0]; effect_ram[0][3] <= nxt_effect_ram[0][3];        effect_ram[0][1] <= nxt_effect_ram[0][1]; effect_ram[0][4] <= nxt_effect_ram[0][4];        effect_ram[0][2] <= nxt_effect_ram[0][2]; effect_ram[0][5] <= nxt_effect_ram[0][5];        effect_ram[0][6] <= nxt_effect_ram[0][6]; effect_ram[1][0] <= nxt_effect_ram[1][0];        effect_ram[0][7] <= nxt_effect_ram[0][7]; effect_ram[1][1] <= nxt_effect_ram[1][1];        effect_ram[0][8] <= nxt_effect_ram[0][8]; effect_ram[1][2] <= nxt_effect_ram[1][2];        effect_ram[1][3] <= nxt_effect_ram[1][3]; effect_ram[1][6] <= nxt_effect_ram[1][6];        effect_ram[1][4] <= nxt_effect_ram[1][4]; effect_ram[1][7] <= nxt_effect_ram[1][7];        effect_ram[1][5] <= nxt_effect_ram[1][5]; effect_ram[1][8] <= nxt_effect_ram[1][8];        effect_ram[2][0] <= nxt_effect_ram[2][0]; effect_ram[2][3] <= nxt_effect_ram[2][3];        effect_ram[2][1] <= nxt_effect_ram[2][1]; effect_ram[2][4] <= nxt_effect_ram[2][4];        effect_ram[2][2] <= nxt_effect_ram[2][2]; effect_ram[2][5] <= nxt_effect_ram[2][5];        effect_ram[2][6] <= nxt_effect_ram[2][6]; effect_ram[3][0] <= nxt_effect_ram[3][0];        effect_ram[2][7] <= nxt_effect_ram[2][7]; effect_ram[3][1] <= nxt_effect_ram[3][1];        effect_ram[2][8] <= nxt_effect_ram[2][8]; effect_ram[3][2] <= nxt_effect_ram[3][2];        effect_ram[3][3] <= nxt_effect_ram[3][3]; effect_ram[3][6] <= nxt_effect_ram[3][6];        effect_ram[3][4] <= nxt_effect_ram[3][4]; effect_ram[3][7] <= nxt_effect_ram[3][7];        effect_ram[3][5] <= nxt_effect_ram[3][5]; effect_ram[3][8] <= nxt_effect_ram[3][8];        effect_ram[4][0] <= nxt_effect_ram[4][0]; effect_ram[4][3] <= nxt_effect_ram[4][3];        effect_ram[4][1] <= nxt_effect_ram[4][1]; effect_ram[4][4] <= nxt_effect_ram[4][4];        effect_ram[4][2] <= nxt_effect_ram[4][2]; effect_ram[4][5] <= nxt_effect_ram[4][5];        effect_ram[4][6] <= nxt_effect_ram[4][6]; effect_ram[5][0] <= nxt_effect_ram[5][0];        effect_ram[4][7] <= nxt_effect_ram[4][7]; effect_ram[5][1] <= nxt_effect_ram[5][1];        effect_ram[4][8] <= nxt_effect_ram[4][8]; effect_ram[5][2] <= nxt_effect_ram[5][2];        effect_ram[5][3] <= nxt_effect_ram[5][3]; effect_ram[5][6] <= nxt_effect_ram[5][6];        effect_ram[5][4] <= nxt_effect_ram[5][4]; effect_ram[5][7] <= nxt_effect_ram[5][7];        effect_ram[5][5] <= nxt_effect_ram[5][5]; effect_ram[5][8] <= nxt_effect_ram[5][8];        effect_ram[6][0] <= nxt_effect_ram[6][0]; effect_ram[6][3] <= nxt_effect_ram[6][3];        effect_ram[6][1] <= nxt_effect_ram[6][1]; effect_ram[6][4] <= nxt_effect_ram[6][4];        effect_ram[6][2] <= nxt_effect_ram[6][2]; effect_ram[6][5] <= nxt_effect_ram[6][5];        effect_ram[6][6] <= nxt_effect_ram[6][6]; effect_ram[7][0] <= nxt_effect_ram[7][0];        effect_ram[6][7] <= nxt_effect_ram[6][7]; effect_ram[7][1] <= nxt_effect_ram[7][1];        effect_ram[6][8] <= nxt_effect_ram[6][8]; effect_ram[7][2] <= nxt_effect_ram[7][2];        effect_ram[7][3] <= nxt_effect_ram[7][3]; effect_ram[7][6] <= nxt_effect_ram[7][6];        effect_ram[7][4] <= nxt_effect_ram[7][4]; effect_ram[7][7] <= nxt_effect_ram[7][7];        effect_ram[7][5] <= nxt_effect_ram[7][5]; effect_ram[7][8] <= nxt_effect_ram[7][8];        effect_ram[8][0] <= nxt_effect_ram[8][0]; effect_ram[8][3] <= nxt_effect_ram[8][3];        effect_ram[8][1] <= nxt_effect_ram[8][1]; effect_ram[8][4] <= nxt_effect_ram[8][4];        effect_ram[8][2] <= nxt_effect_ram[8][2]; effect_ram[8][5] <= nxt_effect_ram[8][5];        effect_ram[8][6] <= nxt_effect_ram[8][6]; effect_ram[9][0] <= nxt_effect_ram[9][0];        effect_ram[8][7] <= nxt_effect_ram[8][7]; effect_ram[9][1] <= nxt_effect_ram[9][1];        effect_ram[8][8] <= nxt_effect_ram[8][8]; effect_ram[9][2] <= nxt_effect_ram[9][2];        effect_ram[9][3] <= nxt_effect_ram[9][3]; effect_ram[9][6] <= nxt_effect_ram[9][6];        effect_ram[9][4] <= nxt_effect_ram[9][4]; effect_ram[9][7] <= nxt_effect_ram[9][7];        effect_ram[9][5] <= nxt_effect_ram[9][5]; effect_ram[9][8] <= nxt_effect_ram[9][8];
`define ASSIGN_CHESS_RAM_HIDDEN nxt_chess_ram[0][0] = chess_ram[0][0]; nxt_chess_ram[0][3] = chess_ram[0][3];    nxt_chess_ram[0][1] = chess_ram[0][1]; nxt_chess_ram[0][4] = chess_ram[0][4];    nxt_chess_ram[0][2] = chess_ram[0][2]; nxt_chess_ram[0][5] = chess_ram[0][5];    nxt_chess_ram[0][6] = chess_ram[0][6]; nxt_chess_ram[1][0] = chess_ram[1][0];    nxt_chess_ram[0][7] = chess_ram[0][7]; nxt_chess_ram[1][1] = chess_ram[1][1];    nxt_chess_ram[0][8] = chess_ram[0][8]; nxt_chess_ram[1][2] = chess_ram[1][2];    nxt_chess_ram[1][3] = chess_ram[1][3]; nxt_chess_ram[1][6] = chess_ram[1][6];    nxt_chess_ram[1][4] = chess_ram[1][4]; nxt_chess_ram[1][7] = chess_ram[1][7];    nxt_chess_ram[1][5] = chess_ram[1][5]; nxt_chess_ram[1][8] = chess_ram[1][8];    nxt_chess_ram[2][0] = chess_ram[2][0]; nxt_chess_ram[2][3] = chess_ram[2][3];    nxt_chess_ram[2][1] = chess_ram[2][1]; nxt_chess_ram[2][4] = chess_ram[2][4];    nxt_chess_ram[2][2] = chess_ram[2][2]; nxt_chess_ram[2][5] = chess_ram[2][5];    nxt_chess_ram[2][6] = chess_ram[2][6]; nxt_chess_ram[3][0] = chess_ram[3][0];    nxt_chess_ram[2][7] = chess_ram[2][7]; nxt_chess_ram[3][1] = chess_ram[3][1];    nxt_chess_ram[2][8] = chess_ram[2][8]; nxt_chess_ram[3][2] = chess_ram[3][2];    nxt_chess_ram[3][3] = chess_ram[3][3]; nxt_chess_ram[3][6] = chess_ram[3][6];    nxt_chess_ram[3][4] = chess_ram[3][4]; nxt_chess_ram[3][7] = chess_ram[3][7];    nxt_chess_ram[3][5] = chess_ram[3][5]; nxt_chess_ram[3][8] = chess_ram[3][8];    nxt_chess_ram[4][0] = chess_ram[4][0]; nxt_chess_ram[4][3] = chess_ram[4][3];    nxt_chess_ram[4][1] = chess_ram[4][1]; nxt_chess_ram[4][4] = chess_ram[4][4];    nxt_chess_ram[4][2] = chess_ram[4][2]; nxt_chess_ram[4][5] = chess_ram[4][5];    nxt_chess_ram[4][6] = chess_ram[4][6]; nxt_chess_ram[5][0] = chess_ram[5][0];    nxt_chess_ram[4][7] = chess_ram[4][7]; nxt_chess_ram[5][1] = chess_ram[5][1];    nxt_chess_ram[4][8] = chess_ram[4][8]; nxt_chess_ram[5][2] = chess_ram[5][2];    nxt_chess_ram[5][3] = chess_ram[5][3]; nxt_chess_ram[5][6] = chess_ram[5][6];    nxt_chess_ram[5][4] = chess_ram[5][4]; nxt_chess_ram[5][7] = chess_ram[5][7];    nxt_chess_ram[5][5] = chess_ram[5][5]; nxt_chess_ram[5][8] = chess_ram[5][8];    nxt_chess_ram[6][0] = chess_ram[6][0]; nxt_chess_ram[6][3] = chess_ram[6][3];    nxt_chess_ram[6][1] = chess_ram[6][1]; nxt_chess_ram[6][4] = chess_ram[6][4];    nxt_chess_ram[6][2] = chess_ram[6][2]; nxt_chess_ram[6][5] = chess_ram[6][5];    nxt_chess_ram[6][6] = chess_ram[6][6]; nxt_chess_ram[7][0] = chess_ram[7][0];    nxt_chess_ram[6][7] = chess_ram[6][7]; nxt_chess_ram[7][1] = chess_ram[7][1];    nxt_chess_ram[6][8] = chess_ram[6][8]; nxt_chess_ram[7][2] = chess_ram[7][2];    nxt_chess_ram[7][3] = chess_ram[7][3]; nxt_chess_ram[7][6] = chess_ram[7][6];    nxt_chess_ram[7][4] = chess_ram[7][4]; nxt_chess_ram[7][7] = chess_ram[7][7];    nxt_chess_ram[7][5] = chess_ram[7][5]; nxt_chess_ram[7][8] = chess_ram[7][8];    nxt_chess_ram[8][0] = chess_ram[8][0]; nxt_chess_ram[8][3] = chess_ram[8][3];    nxt_chess_ram[8][1] = chess_ram[8][1]; nxt_chess_ram[8][4] = chess_ram[8][4];    nxt_chess_ram[8][2] = chess_ram[8][2]; nxt_chess_ram[8][5] = chess_ram[8][5];    nxt_chess_ram[8][6] = chess_ram[8][6]; nxt_chess_ram[9][0] = chess_ram[9][0];    nxt_chess_ram[8][7] = chess_ram[8][7]; nxt_chess_ram[9][1] = chess_ram[9][1];    nxt_chess_ram[8][8] = chess_ram[8][8]; nxt_chess_ram[9][2] = chess_ram[9][2];    nxt_chess_ram[9][3] = chess_ram[9][3]; nxt_chess_ram[9][6] = chess_ram[9][6];    nxt_chess_ram[9][4] = chess_ram[9][4]; nxt_chess_ram[9][7] = chess_ram[9][7];    nxt_chess_ram[9][5] = chess_ram[9][5]; nxt_chess_ram[9][8] = chess_ram[9][8];
`define ASSIGN_EFFECT_RAM_HIDDEN nxt_effect_ram[0][0] = effect_ram[0][0]; nxt_effect_ram[0][3] = effect_ram[0][3];    nxt_effect_ram[0][1] = effect_ram[0][1]; nxt_effect_ram[0][4] = effect_ram[0][4];    nxt_effect_ram[0][2] = effect_ram[0][2]; nxt_effect_ram[0][5] = effect_ram[0][5];    nxt_effect_ram[0][6] = effect_ram[0][6]; nxt_effect_ram[1][0] = effect_ram[1][0];    nxt_effect_ram[0][7] = effect_ram[0][7]; nxt_effect_ram[1][1] = effect_ram[1][1];    nxt_effect_ram[0][8] = effect_ram[0][8]; nxt_effect_ram[1][2] = effect_ram[1][2];    nxt_effect_ram[1][3] = effect_ram[1][3]; nxt_effect_ram[1][6] = effect_ram[1][6];    nxt_effect_ram[1][4] = effect_ram[1][4]; nxt_effect_ram[1][7] = effect_ram[1][7];    nxt_effect_ram[1][5] = effect_ram[1][5]; nxt_effect_ram[1][8] = effect_ram[1][8];    nxt_effect_ram[2][0] = effect_ram[2][0]; nxt_effect_ram[2][3] = effect_ram[2][3];    nxt_effect_ram[2][1] = effect_ram[2][1]; nxt_effect_ram[2][4] = effect_ram[2][4];    nxt_effect_ram[2][2] = effect_ram[2][2]; nxt_effect_ram[2][5] = effect_ram[2][5];    nxt_effect_ram[2][6] = effect_ram[2][6]; nxt_effect_ram[3][0] = effect_ram[3][0];    nxt_effect_ram[2][7] = effect_ram[2][7]; nxt_effect_ram[3][1] = effect_ram[3][1];    nxt_effect_ram[2][8] = effect_ram[2][8]; nxt_effect_ram[3][2] = effect_ram[3][2];    nxt_effect_ram[3][3] = effect_ram[3][3]; nxt_effect_ram[3][6] = effect_ram[3][6];    nxt_effect_ram[3][4] = effect_ram[3][4]; nxt_effect_ram[3][7] = effect_ram[3][7];    nxt_effect_ram[3][5] = effect_ram[3][5]; nxt_effect_ram[3][8] = effect_ram[3][8];    nxt_effect_ram[4][0] = effect_ram[4][0]; nxt_effect_ram[4][3] = effect_ram[4][3];    nxt_effect_ram[4][1] = effect_ram[4][1]; nxt_effect_ram[4][4] = effect_ram[4][4];    nxt_effect_ram[4][2] = effect_ram[4][2]; nxt_effect_ram[4][5] = effect_ram[4][5];    nxt_effect_ram[4][6] = effect_ram[4][6]; nxt_effect_ram[5][0] = effect_ram[5][0];    nxt_effect_ram[4][7] = effect_ram[4][7]; nxt_effect_ram[5][1] = effect_ram[5][1];    nxt_effect_ram[4][8] = effect_ram[4][8]; nxt_effect_ram[5][2] = effect_ram[5][2];    nxt_effect_ram[5][3] = effect_ram[5][3]; nxt_effect_ram[5][6] = effect_ram[5][6];    nxt_effect_ram[5][4] = effect_ram[5][4]; nxt_effect_ram[5][7] = effect_ram[5][7];    nxt_effect_ram[5][5] = effect_ram[5][5]; nxt_effect_ram[5][8] = effect_ram[5][8];    nxt_effect_ram[6][0] = effect_ram[6][0]; nxt_effect_ram[6][3] = effect_ram[6][3];    nxt_effect_ram[6][1] = effect_ram[6][1]; nxt_effect_ram[6][4] = effect_ram[6][4];    nxt_effect_ram[6][2] = effect_ram[6][2]; nxt_effect_ram[6][5] = effect_ram[6][5];    nxt_effect_ram[6][6] = effect_ram[6][6]; nxt_effect_ram[7][0] = effect_ram[7][0];    nxt_effect_ram[6][7] = effect_ram[6][7]; nxt_effect_ram[7][1] = effect_ram[7][1];    nxt_effect_ram[6][8] = effect_ram[6][8]; nxt_effect_ram[7][2] = effect_ram[7][2];    nxt_effect_ram[7][3] = effect_ram[7][3]; nxt_effect_ram[7][6] = effect_ram[7][6];    nxt_effect_ram[7][4] = effect_ram[7][4]; nxt_effect_ram[7][7] = effect_ram[7][7];    nxt_effect_ram[7][5] = effect_ram[7][5]; nxt_effect_ram[7][8] = effect_ram[7][8];    nxt_effect_ram[8][0] = effect_ram[8][0]; nxt_effect_ram[8][3] = effect_ram[8][3];    nxt_effect_ram[8][1] = effect_ram[8][1]; nxt_effect_ram[8][4] = effect_ram[8][4];    nxt_effect_ram[8][2] = effect_ram[8][2]; nxt_effect_ram[8][5] = effect_ram[8][5];    nxt_effect_ram[8][6] = effect_ram[8][6]; nxt_effect_ram[9][0] = effect_ram[9][0];    nxt_effect_ram[8][7] = effect_ram[8][7]; nxt_effect_ram[9][1] = effect_ram[9][1];    nxt_effect_ram[8][8] = effect_ram[8][8]; nxt_effect_ram[9][2] = effect_ram[9][2];    nxt_effect_ram[9][3] = effect_ram[9][3]; nxt_effect_ram[9][6] = effect_ram[9][6];    nxt_effect_ram[9][4] = effect_ram[9][4]; nxt_effect_ram[9][7] = effect_ram[9][7];    nxt_effect_ram[9][5] = effect_ram[9][5]; nxt_effect_ram[9][8] = effect_ram[9][8];
`define PLAYING 2'h0
`define R_WIN 2'h1
`define B_WIN 2'h2

module GameLogic (
    input user_clk,
    input rst_n,
    input s_key_up,
    input s_key_dn,
    input s_key_lf,
    input s_key_rt,
    input s_key_w,
    input s_key_s,
    input s_key_a,
    input s_key_d,
    input s_key_lshift,
    input s_key_rshift,
    input l_key_up,
    input l_key_dn,
    input l_key_lf,
    input l_key_rt,
    input l_key_w,
    input l_key_s,
    input l_key_a,
    input l_key_d,
    input s_key_space,
    input s_key_bkspace,
    input hidden_mode,
    input random_en,
    output [`CHESS_MAP_WIDTH-1:0] chess_arr,
    output [`EFFECT_MAP_WIDTH-1:0] effect_arr,
    output [15:0] clock,
    output [15:0] rr_timer,
    output [15:0] rt_timer,
    output [15:0] br_timer,
    output [15:0] bt_timer,
    output reg [1:0] result,
    output is_randomized // random ready
);

reg [1:0] nxt_result;

reg [`CHESS_LEN-1:0] chess_ram [`BOARD_R-1:0][`BOARD_C-1:0];
wire [127:0] rd_chess_arr;
reg [`CHESS_LEN-1:0] nxt_chess_ram [`BOARD_R-1:0][`BOARD_C-1:0];

reg [`EFFECT_LEN-1:0] effect_ram [`BOARD_R-1:0][`BOARD_C-1:0];
reg [`EFFECT_LEN-1:0] nxt_effect_ram [`BOARD_R-1:0][`BOARD_C-1:0];

// assign memory to array
genvar i, j;
generate
    for (i = 0; i < `BOARD_R; i = i + 1) begin
        for (j = 0; j < `BOARD_C; j = j + 1) begin
            assign chess_arr[
                (i*`BOARD_C + (j+1)) * `CHESS_LEN-1:
                (i*`BOARD_C +   j  ) * `CHESS_LEN
            ] = chess_ram[i][j];
            assign effect_arr[
                (i*`BOARD_C + (j+1)) * `EFFECT_LEN-1:
                (i*`BOARD_C +   j  ) * `EFFECT_LEN
            ] = effect_ram[i][j];
        end
    end
endgenerate

reg [16*`CHESS_LEN-1:0] r_died,     // 紅方死子 list
                        nxt_r_died, // (next) 紅方死子 list
                        b_died,     // 黑方死子 list
                        nxt_b_died; // (next) 黑方死子 list

reg [`CHESS_LEN-1:0] selected_x, // 被選的棋子
                     nxt_selected_x,
                     selected_y,
                     nxt_selected_y;

reg [3:0] rx, ry, bx, by,
          nxt_rx, nxt_ry, nxt_bx, nxt_by;

localparam R_SEL = 0;
localparam R_MOV = 1;
localparam B_SEL = 2;
localparam B_MOV = 3;

localparam AFTER_CHECK_IS_RED = 1'b0;
localparam AFTER_CHECK_IS_BLK = ~AFTER_CHECK_IS_RED;

reg after_check,
    nxt_after_check;

reg [1:0] state,
          nxt_state;

wire time_up;

reg ready;
wire _ready;
assign is_randomized = ready;
wire randomized = hidden_mode & _ready;
wire playing = result == `PLAYING;
wire has_nxt_result = nxt_result != `PLAYING;

reg [4:0] random_seed_cnt;

RandomChessGenerator RG (
    .clk(user_clk),
    .rst_n(rst_n & ~random_en),
    .ready(_ready),
    .random_seed(random_seed_cnt),
    .chess_arr(rd_chess_arr)
);

TimerManager TM (
    .clk_100Hz(user_clk & playing),
    .rst_n(rst_n),
    .start(
        playing & (has_nxt_result | s_key_space)
    ),
    .switch(
        (state != nxt_state && nxt_state == B_SEL) ||
        (state != nxt_state && nxt_state == R_SEL)
    ),
    .swap(s_key_bkspace),
    .clock(clock),
    .rr_timer(rr_timer),
    .rt_timer(rt_timer),
    .br_timer(br_timer),
    .bt_timer(bt_timer),
    .times_up(times_up),
    .state()
);

always @(posedge user_clk, negedge rst_n) begin
    if (~rst_n) begin
        state       <= R_SEL;
        rx          <= 4;
        ry          <= 8;
        bx          <= 4;
        by          <= 1;
        r_died      <= 0;
        b_died      <= 0;
        selected_x  <= `NONE;
        selected_y  <= `NONE;
        after_check <= AFTER_CHECK_IS_BLK;
        result      <= `PLAYING;
        ready       <= 0;
        random_seed_cnt <= 1;
    end
    else begin
        state       <= nxt_state;
        rx          <= nxt_rx;
        ry          <= nxt_ry;
        bx          <= nxt_bx;
        by          <= nxt_by;
        r_died      <= nxt_r_died;
        b_died      <= nxt_b_died;
        selected_x  <= nxt_selected_x;
        selected_y  <= nxt_selected_y;
        after_check <= nxt_after_check;
        result      <= nxt_result;
        ready       <= random_en ? 0 : randomized | ready;
        random_seed_cnt <= random_seed_cnt == 5'd31 
            ? 1 : random_seed_cnt + 1;
    end
end

// DFF logic of chess_ram
always @(posedge user_clk, negedge rst_n) begin
    if (~rst_n) begin
        if (hidden_mode) begin
            `RST_CHESS_RAM_HIDDEN
        end
        else begin
            `RST_CHESS_RAM
        end
        `RST_EFFECT_RAM
    end
    else begin
        if (randomized & ~ready) begin
            `RST_CHESS_RAM_HIDDEN_RAND
        end
        else begin
            `ASSIGN_BACK_CHESS_RAM
        end
        `ASSIGN_BACK_EFFECT_RAM
    end
end

wire [3:0] rx_rt = rx == 8 ? 0 : rx + 1;
wire [3:0] rx_lf = rx == 0 ? 8 : rx - 1;
wire [3:0] ry_up = ry == 0 ? 9 : ry - 1;
wire [3:0] ry_dn = ry == 9 ? 0 : ry + 1;
wire [3:0] bx_rt = bx == 8 ? 0 : bx + 1;
wire [3:0] bx_lf = bx == 0 ? 8 : bx - 1;
wire [3:0] by_up = by == 0 ? 9 : by - 1;
wire [3:0] by_dn = by == 9 ? 0 : by + 1;

wire same_place = rx == bx && ry == by; // 紅黑方游標是否在同一位置
wire is_r_at_red = chess_ram[ry][rx][3] == 1'b1; // 紅方游標是否在紅棋
wire is_r_at_blk = chess_ram[ry][rx][3] == 1'b0  // 紅方游標是否在黑棋
    && chess_ram[ry][rx] != `NONE_CHESS;
wire is_b_at_red = chess_ram[by][bx][3] == 1'b1; // 黑方游標是否在紅棋
wire is_b_at_blk = chess_ram[by][bx][3] == 1'b0  // 黑方游標是否在黑棋
    && chess_ram[by][bx] != `NONE_CHESS;
wire is_r_selected = effect_ram[ry][rx] == `SELECTED;
wire is_b_selected = effect_ram[by][bx] == `SELECTED;

always @(*) begin
    `ASSIGN_CHESS_RAM
    `ASSIGN_EFFECT_RAM
    
    nxt_state = state;
    nxt_rx    = rx;
    nxt_ry    = ry;
    nxt_bx    = bx;
    nxt_by    = by;
    nxt_r_died = r_died;
    nxt_b_died = b_died;
    nxt_selected_x = selected_x;
    nxt_selected_y = selected_y;
    nxt_after_check = after_check;
    nxt_result = result;

    if (playing) begin
        if (times_up) begin
            nxt_result = (state == R_SEL || state == R_MOV) 
                ? `B_WIN : `R_WIN;
        end
        // 方向鍵邏輯
        // 紅方方向鍵
        if (s_key_up | l_key_up) begin
            nxt_effect_ram[ry][rx] = is_r_selected ?
                `SELECTED : same_place ? `B_TRAV : `NO_EFFECT;
            nxt_effect_ram[ry_up][rx] = 
                effect_ram[ry_up][rx] == `SELECTED ? 
                    `SELECTED : `R_TRAV;
            nxt_ry = ry_up;
        end
        else if (s_key_dn | l_key_dn) begin
            nxt_effect_ram[ry][rx] = is_r_selected ?
                `SELECTED : same_place ? `B_TRAV : `NO_EFFECT;
            nxt_effect_ram[ry_dn][rx] = 
                effect_ram[ry_dn][rx] == `SELECTED ? 
                    `SELECTED : `R_TRAV;
            nxt_ry = ry_dn;
        end
        else if (s_key_lf | l_key_lf) begin
            nxt_effect_ram[ry][rx] = is_r_selected ?
                `SELECTED : same_place ? `B_TRAV : `NO_EFFECT;
            nxt_effect_ram[ry][rx_lf] = 
                effect_ram[ry][rx_lf] == `SELECTED ? 
                    `SELECTED : `R_TRAV;
            nxt_rx = rx_lf;
        end
        else if (s_key_rt | l_key_rt) begin
            nxt_effect_ram[ry][rx] = is_r_selected ?
                `SELECTED : same_place ? `B_TRAV : `NO_EFFECT;
            nxt_effect_ram[ry][rx_rt] = 
                effect_ram[ry][rx_rt] == `SELECTED ? 
                    `SELECTED : `R_TRAV;
            nxt_rx = rx_rt;
        end
        // 黑方方向鍵
        if (s_key_w | l_key_w) begin
            nxt_effect_ram[by][bx] = is_b_selected ?
                `SELECTED : same_place ? `R_TRAV : `NO_EFFECT;
            nxt_effect_ram[by_up][bx] = 
                effect_ram[by_up][bx] == `SELECTED ? 
                    `SELECTED : `B_TRAV;
            nxt_by = by_up;
        end
        else if (s_key_s | l_key_s) begin
            nxt_effect_ram[by][bx] = is_b_selected ?
                `SELECTED : same_place ? `R_TRAV : `NO_EFFECT;
            nxt_effect_ram[by_dn][bx] = 
                effect_ram[by_dn][bx] == `SELECTED ?
                    `SELECTED : `B_TRAV;
            nxt_by = by_dn;
        end
        else if (s_key_a | l_key_a) begin
            nxt_effect_ram[by][bx] = is_b_selected ?
                `SELECTED : same_place ? `R_TRAV : `NO_EFFECT;
            nxt_effect_ram[by][bx_lf] = 
                effect_ram[by][bx_lf] == `SELECTED ?
                    `SELECTED : `B_TRAV;
            nxt_bx = bx_lf;
        end
        else if (s_key_d | l_key_d) begin
            nxt_effect_ram[by][bx] = is_b_selected ?
                `SELECTED : same_place ? `R_TRAV : `NO_EFFECT;
            nxt_effect_ram[by][bx_rt] = 
                effect_ram[by][bx_rt] == `SELECTED ?
                    `SELECTED : `B_TRAV;
            nxt_bx = bx_rt;
        end

        // state transfer
        case (state)
        R_SEL: begin
            if (s_key_rshift) begin
                if (chess_ram[ry][rx][`CHESS_LEN-1] == `HIDDEN) begin
                    nxt_chess_ram[ry][rx][`CHESS_LEN-1] = `SHOWING;
                    nxt_state = B_SEL;
                end
                else if (is_r_at_red) begin
                // to R_MOV
                    nxt_effect_ram[ry][rx] = `SELECTED;
                    nxt_selected_x = rx;
                    nxt_selected_y = ry;
                    nxt_state = R_MOV;
                end
            end
        end 
        R_MOV: begin
            if (s_key_rshift) begin
                if (chess_ram[ry][rx][
                    `CHESS_LEN-1:`CHESS_LEN-2
                    ] == { `HIDDEN, `RED }) begin // open the chess
                    nxt_chess_ram[ry][rx][`CHESS_LEN-1] = `SHOWING;
                    nxt_state = B_SEL;
                    nxt_effect_ram[selected_y][selected_x] = 
                        selected_y != by || selected_x != bx ?
                            `NO_EFFECT : `B_TRAV;
                end
                else if (
                    chess_ram[ry][rx] == `NONE || 
                    chess_ram[ry][rx][3] == `BLK
                ) begin
                    // 未來可擴充
                    // if (chess_ram[ry][rx] != `NONE) begin
                    //     nxt_b_died = { // push list
                    //         b_died[15*`CHESS_LEN-1:0],
                    //         chess_ram[ry][rx]
                    //     };
                    // end
                    nxt_chess_ram[ry][rx] = // 放新子
                        chess_ram[selected_y][selected_x];
                    nxt_chess_ram[selected_y][selected_x] = `NONE; // 去舊子
                    nxt_effect_ram[selected_y][selected_x] = 
                        selected_y != by || selected_x != bx ?
                            `NO_EFFECT : `B_TRAV;
                    if (chess_ram[ry][rx][`CHESS_LEN-2:0] == `_B_GENERAL) begin
                        nxt_result = `R_WIN;
                    end
                    else begin
                        nxt_state = B_SEL;
                    end
                end
            end
        end 
        B_SEL: begin
            if (s_key_lshift) begin
                if (chess_ram[by][bx][`CHESS_LEN-1] == `HIDDEN) begin
                    nxt_chess_ram[by][bx][`CHESS_LEN-1] = `SHOWING;
                    nxt_state = R_SEL;
                end
                else if (is_b_at_blk) begin
                    // to B_MOV
                    nxt_effect_ram[by][bx] = `SELECTED;
                    nxt_selected_x = bx;
                    nxt_selected_y = by;
                    nxt_state = B_MOV;
                end
            end
        end 
        B_MOV: begin
            if (s_key_lshift) begin
                if (chess_ram[by][bx][
                    `CHESS_LEN-1:`CHESS_LEN-2
                    ] == { `HIDDEN, `BLK }) begin
                    nxt_chess_ram[by][bx][`CHESS_LEN-1] = `SHOWING;
                    nxt_state = R_SEL;
                    nxt_effect_ram[selected_y][selected_x] = 
                        selected_y != ry || selected_x != rx ?
                            `NO_EFFECT : `R_TRAV;
                end
                else if (
                    chess_ram[by][bx] == `NONE || 
                    chess_ram[by][bx][3] == `RED
                ) begin
                    // 未來可擴充
                    // if (chess_ram[by][bx] != `NONE) begin
                    //     nxt_r_died = { // push list
                    //         r_died[15*`CHESS_LEN-1:0],
                    //         chess_ram[by][bx]
                    //     };
                    // end
                    nxt_chess_ram[by][bx] = // 放新子
                        chess_ram[selected_y][selected_x];
                    nxt_chess_ram[selected_y][selected_x] = `NONE; // 去舊子
                    nxt_effect_ram[selected_y][selected_x] = 
                        selected_y != ry || selected_x != rx ?
                            `NO_EFFECT : `R_TRAV;
                    if (chess_ram[by][bx][`CHESS_LEN-2:0] == `_R_GENERAL) begin
                        nxt_result = `B_WIN;
                    end
                    else begin
                        nxt_state = R_SEL;
                    end
                end
            end
        end 

        endcase
    end

end

endmodule

module RandomChessGenerator (
    input clk,
    input rst_n,
    input [4:0] random_seed,
    output ready,
    output reg [127:0] chess_arr
);

reg [4:0] seed;
reg [3:0] resp_chess;
reg [4:0] cnt;

assign ready = cnt == 31;

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        chess_arr <= `_B_CANNON;
        seed      <= random_seed;
        cnt       <= 0;
    end
    else begin
        if (~ready) begin
            chess_arr <= { chess_arr[123:0], resp_chess };
            seed <= (seed << 1) | (seed[4] ^ seed[2]);
            cnt <= cnt + 1;
        end
        else begin
            chess_arr <= chess_arr;
            cnt <= cnt;
            seed <= seed;
        end
    end
end

always @(*) begin
    case (seed)

    1, 2, 3, 4, 5: resp_chess = `_R_SOLDIER;
    6:      resp_chess = `_R_GENERAL;
    7, 8:   resp_chess = `_R_ADVISOR;
    9, 10:  resp_chess = `_R_ELEPHANT;
    11, 12: resp_chess = `_R_CHARIOT;
    13, 14: resp_chess = `_R_HORSE;
    15, 16: resp_chess = `_R_CANNON;
    17, 18, 19, 20, 21: resp_chess = `_B_SOLDIER;
    22:      resp_chess = `_B_GENERAL;
    23, 24:  resp_chess = `_B_ADVISOR;
    25, 26:  resp_chess = `_B_ELEPHANT;
    27, 28:  resp_chess = `_B_CHARIOT;
    29, 30:  resp_chess = `_B_HORSE;
    31, 0:   resp_chess = `_B_CANNON;
    
    endcase
end
    
endmodule