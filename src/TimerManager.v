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

module TimerManager (
    input clk_100Hz, // 100Hz clock
    input rst_n,
    input start,
    input switch, // switch player
    input swap,   // swap showing clock
    output reg [15:0] clock,
    output [15:0] rr_timer,
    output [15:0] rt_timer,
    output [15:0] br_timer,
    output [15:0] bt_timer,
    output reg times_up, // whether the player has no time (lose)
    output [1:0] state
);

reg nxt_times_up;

localparam RED = 0;
localparam BLK = 1;

reg to_start,
    nxt_to_start;

reg turn,
    nxt_turn;

localparam ROUND = 0;
localparam TOTAL = 1;

reg show,
    nxt_show;

// for debugging
assign state = { show, turn };

PlayerTimer PRED (
    .clk_100Hz(clk_100Hz && to_start),
    .rst_n(rst_n),
    .en(turn == RED),
    .round_clock(rr_timer),
    .total_clock(rt_timer)
);

PlayerTimer PBLK (
    .clk_100Hz(clk_100Hz && to_start),
    .rst_n(rst_n),
    .en(turn == BLK),
    .round_clock(br_timer),
    .total_clock(bt_timer)
);

always @(posedge clk_100Hz, negedge rst_n) begin
    if (~rst_n) begin
        to_start <= 0;
        times_up <= 0;
        show     <= RED;
        turn     <= ROUND;
    end
    else begin
        to_start <= nxt_to_start;
        times_up <= nxt_times_up;
        show     <= nxt_show;
        turn     <= nxt_turn;
    end
end

always @(*) begin

    nxt_show     = show;
    nxt_turn     = turn;
    nxt_times_up = times_up;
    nxt_to_start = start ? ~to_start : to_start;
    
    case (turn)
        RED: begin

            if (switch) begin
                nxt_turn = BLK;
                nxt_show = ROUND;
            end
            else if (swap) begin
                nxt_show = ~show;
            end
            
            if (rr_timer == 0) begin
                nxt_times_up = 1;
            end

            if (show == ROUND) begin
                clock = rr_timer;
            end
            else begin
                clock = rt_timer;
            end
        end
        BLK: begin

            if (switch) begin
                nxt_turn = RED;
                nxt_show = ROUND;
            end
            else if (swap) begin
                nxt_show = ~show;
            end
            
            if (br_timer == 0) begin
                nxt_times_up = 1;
            end

            if (show == ROUND) begin
                clock = br_timer;
            end
            else begin
                clock = bt_timer;
            end
        end
    endcase
end
    
endmodule

module PlayerTimer (
    input clk_100Hz,
    input rst_n,
    input en,
    output [15:0] round_clock,
    output [15:0] total_clock
);

reg en_delay;
reg [6:0] cnt;
wire cnt_to_end = cnt == 99 && round_clock > 0;

always @(posedge clk_100Hz, negedge rst_n) begin
    if (~rst_n) begin
        cnt      <= 0;
        en_delay <= 0;
    end
    else begin
        cnt      <= cnt_to_end ? 0 : cnt + 1;
        en_delay <= en;
    end
end

HourClock TOTAL (
    .clk(clk_100Hz),
    .rst_n(rst_n),
    .en(en & cnt_to_end),
    .clock(total_clock)
);

RoundClock SC2 (
    .clk(clk_100Hz),
    .rst_n(rst_n),
    .to_inject(~en_delay & en), // catch negedge en
    .inject_num(
        total_clock > 16'h100 ?
        16'h100 : (
            total_clock > 16'h15 ?
            total_clock : 16'h15
        )
    ),
    .en(en & cnt_to_end),
    .clock(round_clock)
);

endmodule

/**
 * The one-hour clock that can stop by ifself
 * when counted to zero
 */
module HourClock (
    input clk,
    input rst_n,
    input en,
    output [15:0] clock
);

wire [3:0] cry_arr; // carry array

//* Second
OneDigitCounter #(
    .START(4'h9), .END(4'h0), 
    .CRY_SYS(4'ha)
) S_UNIT (
    .clk(clk), .rst_n(rst_n),
    .en(en),
    .direction(`DOWN_COUNTING),
    .to_inject(1'b0), .inject_num(4'b0),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(clock[`DIGIT_LEN-1:0]),
    .cry(cry_arr[0])
);

OneDigitCounter #(
    .START(4'h5), .END(4'h0), 
    .CRY_SYS(4'h6)
) S_TENS (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[0]),
    .direction(`DOWN_COUNTING),
    .to_inject(1'b0), .inject_num(4'b0),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            2*`DIGIT_LEN-1:
            `DIGIT_LEN
        ]
    ),
    .cry(cry_arr[1])
);

//* Minute
OneDigitCounter #(
    .START(4'h9), .END(4'h0), 
    .CRY_SYS(4'ha)
) M_UNIT (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[1]),
    .direction(`DOWN_COUNTING),
    .to_inject(1'b0), .inject_num(4'b0),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            3*`DIGIT_LEN-1:
            2*`DIGIT_LEN
        ]
    ),
    .cry(cry_arr[2])
);

OneDigitCounter #(
    .START(4'h6), .END(4'h0), 
    .CRY_SYS(4'h7), .RST_NUM(4'h6)
) M_TENS (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[2]),
    .direction(`DOWN_COUNTING),
    .to_inject(1'b0), .inject_num(4'b0),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            4*`DIGIT_LEN-1:
            3*`DIGIT_LEN
        ]
    ),
    .cry()
);
    
endmodule

/**
 * The one-hour clock that can stop by ifself
 * when counted to zero
 */
module RoundClock (
    input clk,
    input rst_n,
    input to_inject,
    input [15:0] inject_num,
    input en,
    output [15:0] clock
);

wire [3:0] cry_arr; // carry array

//* Second
OneDigitCounter #(
    .START(4'h9), .END(4'h0), 
    .CRY_SYS(4'ha)
) S_UNIT (
    .clk(clk), .rst_n(rst_n),
    .en(en),
    .direction(`DOWN_COUNTING),
    .to_inject(to_inject),
    .inject_num(inject_num[3:0]),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(clock[`DIGIT_LEN-1:0]),
    .cry(cry_arr[0])
);

OneDigitCounter #(
    .START(4'h5), .END(4'h0), 
    .CRY_SYS(4'h6)
) S_TENS (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[0]),
    .direction(`DOWN_COUNTING),
    .to_inject(to_inject),
    .inject_num(inject_num[7:4]),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            2*`DIGIT_LEN-1:
            `DIGIT_LEN
        ]
    ),
    .cry(cry_arr[1])
);

//* Minute
OneDigitCounter #(
    .START(4'h9), .END(4'h0), 
    .CRY_SYS(4'ha), .RST_NUM(4'h1)
) M_UNIT (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[1]),
    .direction(`DOWN_COUNTING),
    .to_inject(to_inject),
    .inject_num(inject_num[11:8]),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            3*`DIGIT_LEN-1:
            2*`DIGIT_LEN
        ]
    ),
    .cry(cry_arr[2])
);

OneDigitCounter #(
    .START(4'h6), .END(4'h0), 
    .CRY_SYS(4'h7), .RST_NUM(4'h0)
) M_TENS (
    .clk(clk), .rst_n(rst_n),
    .en(cry_arr[2]),
    .direction(`DOWN_COUNTING),
    .to_inject(to_inject),
    .inject_num(inject_num[15:12]),
    .val_after_cry(`AFTER_CRY_USE_CRSYS),
    .num(
        clock[
            4*`DIGIT_LEN-1:
            3*`DIGIT_LEN
        ]
    ),
    .cry()
);
    
endmodule

/**
 * A one digit counter, DEFAULT COUNTING DOWN
 * You should assign the START parameter to be 
 * the high value, and the END parameter to be
 * the low value, and the STEP will always 
 * treats as an positive integer.
 * By assigning the direction input signal, 
 * you can decide whether to down or up count
 */
module OneDigitCounter
#(
    /* Assigniable members of this module object! */
    parameter START     = 4'hf, // start value of counting
    parameter CRY_SYS   = 16,   // carry system, support up to 16
    parameter END       = 4'h0, // end value of counting
    parameter STEP      = 1,    // value change in each iteration
    parameter RST_NUM   = 4'h0
)
(
    input clk,
    input rst_n,
    input en,         // count if enabled
    
    input direction,  // assign use macro 
    
    // can directly inject number to this module
    // Notice that you can only inject number 
    // WHEN en IS DISABLES!!!!!!!!!!!!!!!!!!!
    // or the injection will do nothing
    input to_inject,  // enable of injection
    input [`DIGIT_LEN-1:0] inject_num,

    // value after borrowing according to 
    // CRY_SYS (AFTER_CRY_USE_CRSYS) 
    // or START (AFTER_CRY_USE_BOUND)
    input val_after_cry,// value after carrying
    
    output [`DIGIT_LEN-1:0] num,
    output reg cry    // carry-up or down, depends on up or down counting
);

reg [`DIGIT_LEN-1:0] cur_num, nxt_num;
reg nxt_cry; // (next) carry

/* DFF of result number */
always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        cur_num <= RST_NUM;
        cry <= 0;
    end
    else begin
        cur_num <= nxt_num;
        cry <= nxt_cry;
    end
end

wire [`DIGIT_LEN:0] _CRY_SYS_DEPEND_VAL // consider carry up-down at the same time with ? operator
    = (direction == `DOWN_COUNTING) ? CRY_SYS - 1 : 0;

wire [`DIGIT_LEN-1:0] CRY_SYS_DEPEND_VAL // consider carry up-down at the same time with ? operator
    = _CRY_SYS_DEPEND_VAL[`DIGIT_LEN-1 : 0];

/* logic of value after carry up-down */
reg [`DIGIT_LEN-1:0] AFTER_CRY_VAL; // consider carry up-down at the same time with ? operator
always @(*) begin
    case (val_after_cry)
    `AFTER_CRY_USE_BOUND: 
        AFTER_CRY_VAL 
            = direction
                == `DOWN_COUNTING ? START : END;
    `AFTER_CRY_USE_CRSYS: 
        AFTER_CRY_VAL = CRY_SYS_DEPEND_VAL;
    endcase
end

wire _REACHED_END // whether cur_num reaches end
    = cur_num == END && direction == `DOWN_COUNTING;
wire _REACHED_START // whether cur_num reaches start
    = cur_num == START && direction == `UP_COUNTING;

wire toChg // to change (up or down count)
    = ~(_REACHED_END | _REACHED_START) & en;

wire toCry // to carry up-down
    = (_REACHED_END | _REACHED_START) & en;

wire injectable = ~en & to_inject;

/* MUX to decide next-state number */
always @* begin
    if (injectable) begin
        nxt_num = inject_num;
    end
    else if (toChg) begin
        if (direction == `UP_COUNTING)
            nxt_num = cur_num + STEP;
        else 
            nxt_num = cur_num - STEP;
    end
    else if (toCry)
        nxt_num = AFTER_CRY_VAL;
    else 
        nxt_num = cur_num;
end

/* MUX to decide next-state borrow */
always @* begin
    if (injectable)
        nxt_cry = `DISABLE;
    else if (toCry)
        nxt_cry = `ENABLE;
    else 
        nxt_cry = `DISABLE;
end

assign num = cur_num;

endmodule