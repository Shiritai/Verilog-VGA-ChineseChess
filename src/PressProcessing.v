`timescale 1ns / 1ps

`define DIGIT_LEN 4

/** 
 * Button signal array, generating 
 * short-long press push button signal
 */
module PressSignalArray #(
    parameter SIZE = 1,
    parameter CNT_WIDTH = 5
)
(
    input user_clk,
    input rst_n,
    input  [SIZE-1:0] sig_arr,
    output [SIZE-1:0] s_sig_arr_o,
    output [SIZE-1:0] l_sig_arr_o
);

genvar i;
generate
    for (i = 0; i < SIZE; i = i + 1)
        PressSignal #(
            .CNT_WIDTH(CNT_WIDTH)
        ) _PS (
            .clk(user_clk),
            .rst_n(rst_n),
            .sig(sig_arr[i]),
            .s_sig_o(s_sig_arr_o[i]),
            .l_sig_o(l_sig_arr_o[i])
        );
endgenerate
    
endmodule

/** 
 * A press button supporting
 * long and short pressing.
 * 
 * Notice that if we constantly
 * sending pressing signal,
 * It'll give out a fixed-frequency 
 * output of long-pressing signal.
 */
module PressSignal #(
    // The waiting-clocks of long-press duration
    // in twos power.
    // For ezample, CNT_WIDTH = 5
    // means to wait 2^5 = 32 clocks
    parameter CNT_WIDTH = 5
)
(
    input clk,
    input rst_n,
    input sig, // push button signal
    output s_sig_o, // short push signal
    output l_sig_o // long push signal
);

reg sig_delay;
reg [CNT_WIDTH-1:0] cnt, nxt_cnt;

wire [CNT_WIDTH-1:0] CNT_LIMIT // counting limit based on CNT_WIDTH
    = { CNT_WIDTH {1'b1} };

reg [1:0] state, nxt_state;

localparam NONE_CHESS  = 0;
localparam LONG  = 1;
localparam SHORT = 2;

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        sig_delay <= 0;
        cnt       <= 0;
        state     <= NONE_CHESS;
    end
    else begin
        sig_delay <= sig;
        cnt       <= nxt_cnt;
        state     <= nxt_state;
    end
end

wire is_negedge // whether we're now in negedge
    = ~sig & sig_delay;

wire cntToEnd // count to the biggest number of cnt
    = cnt == CNT_LIMIT;

always @(*) begin

    nxt_state = state;
    nxt_cnt = cnt;

    case (state)

    NONE_CHESS: begin
        if (cntToEnd) begin
            nxt_state = LONG;
            nxt_cnt = 0;
        end
        else begin
            if (is_negedge) begin
                nxt_state = SHORT;
                nxt_cnt = 0;
            end
            else if (sig) begin
                nxt_cnt = cnt + 1;
            end
            else begin
                nxt_cnt = 0;
            end
        end
    end

    LONG: begin
        if (cntToEnd) begin
            nxt_cnt = 0;
        end
        else if (sig) begin
            nxt_cnt = cnt + 1;
        end
        
        if (is_negedge) begin
            nxt_state = NONE_CHESS;
            nxt_cnt = 0;
        end
    end

    SHORT: begin
        nxt_state = NONE_CHESS;
    end

    endcase
end

assign l_sig_o = state == LONG && cntToEnd == 1;
assign s_sig_o = state == SHORT;
    
endmodule

module Debounce (
    input clk,
    input rst_n,
    input but, // buttom input
    output reg db_but // debounced buttom
);

reg [3:0] db_wnd;
reg nxt_db_but; // next state og debounced buttom

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        db_but <= 1'b0;
        db_wnd <= 4'b0;
    end
    else begin
        db_but <= nxt_db_but;
        db_wnd <= { db_wnd[2:0], but };
    end
end

always @* begin
    if (db_wnd == 4'b1111)
        nxt_db_but = 1'b1;
    else 
        nxt_db_but = 1'b0;
end

endmodule

module ButtonPress #(
    // The waiting-clocks of long-press duration
    // in twos power.
    // For ezample, CNT_WIDTH = 5
    // means to wait 2^5 = 32 clocks
    parameter CNT_WIDTH = 5
)
(
    input clk_fast,
    input clk_slow,
    input rst_n,
    input sig,
    output s_sig_o,
    output l_sig_o
);

wire db_sig;

Debounce _DB(
    .clk(clk_fast), .rst_n(rst_n),
    .but(sig), .db_but(db_sig)
);

PressSignal #(
    .CNT_WIDTH(CNT_WIDTH)
) _PS(
    .clk(clk_slow),
    .rst_n(rst_n),
    .sig(sig),
    .s_sig_o(s_sig_o),
    .l_sig_o(l_sig_o)
);
    
endmodule

/** 
 * Button signal array, generating 
 * short-long press push button signal
 */
module ButtonPressArray #(
    parameter SIZE = 1,
    parameter CNT_WIDTH = 5
)
(
    input clk_fast,
    input clk_slow,
    input rst_n,
    input  [SIZE-1:0] sig_arr,
    output [SIZE-1:0] s_sig_arr_o,
    output [SIZE-1:0] l_sig_arr_o
);

genvar i;
generate
    for (i = 0; i < SIZE; i = i + 1)
        ButtonPress #(
            .CNT_WIDTH(CNT_WIDTH)
        ) _BP (
            .clk_fast(clk_fast),
            .clk_slow(clk_slow),
            .rst_n(rst_n),
            .sig(sig_arr[i]),
            .s_sig_o(s_sig_arr_o[i]),
            .l_sig_o(l_sig_arr_o[i])
        );
endgenerate

endmodule