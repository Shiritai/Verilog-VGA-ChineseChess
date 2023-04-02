// team
`define RED 1'b1
`define BLK 1'b0
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

module RandomGenerator (
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