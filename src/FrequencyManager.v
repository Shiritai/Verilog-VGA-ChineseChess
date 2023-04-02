`timescale 1ns / 1ps

// clock constant
`define BASIC_CLOCK_RATE 100_000_000
`define CLOCK_WIDTH 27
`define ONE_HZ_COUNT 50_000_000

/**
 * The clock manager to instantiate
 * a bunch of signal with assigned frequency
 * efficiently and mistake-freely using
 * using frequency dividers.
 */
module FrequencyManager #(
    parameter NUMS = 1, // number of signal to divide frequency
    parameter CNT_WIDTH // width of the value of each count limit
        = `CLOCK_WIDTH,
    parameter [CNT_WIDTH*NUMS-1:0] NUMBER_OF_COUNT_ARR // count limit array
        = `ONE_HZ_COUNT,
    parameter ITER_WIDTH // width of the iterating signal
        = 2
)
(
    input clk,
    input rst_n,
    output [NUMS-1:0] fd_clk_arr, // output signal array after dividing frequency
    output [ITER_WIDTH-1:0] iter_sig // iterating signal
);

// first FrequencyDivider will output the iterating signal
FrequencyDivider #(
    .CNT_WIDTH(CNT_WIDTH),
    .NUMBER_OF_COUNT(
        NUMBER_OF_COUNT_ARR[
            CNT_WIDTH-1:0
        ]
    ),
    .ITER_WIDTH(ITER_WIDTH)
) _FD (
    .f_in(clk), .rst_n(rst_n),
    .f_out(fd_clk_arr[0]),
    .iter_sig(iter_sig)
);

genvar i;
generate
    for (i = 1; i < NUMS; i = i + 1) begin
        FrequencyDivider #(
            .CNT_WIDTH(CNT_WIDTH),
            .NUMBER_OF_COUNT(
                NUMBER_OF_COUNT_ARR[
                    CNT_WIDTH*(i+1)-1:
                    CNT_WIDTH*i
                ]
            )
        ) _FD (
            .f_in(clk), .rst_n(rst_n),
            .f_out(fd_clk_arr[i]),
            .iter_sig()
        );
    end
endgenerate
    
endmodule

/**
 * A general frequency divider.
 * Please assign to COUNT_LIMIT (how many 
 * clock count to trigger invertion of signal)
 * and CNT_WIDTH to specify the width in bits
 * to the value of COUNT_LIMIT
 */
module FrequencyDivider #(
    parameter NUMBER_OF_COUNT // default to generate 1Hz divided signal
        = `ONE_HZ_COUNT,
    parameter CNT_WIDTH // default to generate 1Hz divided signal
        = `CLOCK_WIDTH,
    parameter ITER_WIDTH = 2 // width of iterating counting signal, usually for ssd
)
(
    input f_in,
    input rst_n,
    output [ITER_WIDTH-1:0] iter_sig, // iterating counting signal, usually for ssd
    output reg f_out // frequency-divided signal
);

localparam UPPED_BOUND = NUMBER_OF_COUNT - 1;

reg [CNT_WIDTH-1:0] cnt,
                    nxt_cnt;
reg nxt_f_out;

always @(posedge f_in, negedge rst_n) begin
    if (~rst_n) begin
        f_out <= 0;
        cnt   <= 0;
    end
    else begin
        f_out <= nxt_f_out;
        cnt   <= nxt_cnt;
    end
end

always @(*) begin
    if (cnt == UPPED_BOUND) begin
        nxt_cnt = 0;
        nxt_f_out = ~f_out;
    end
    else begin
        nxt_cnt = cnt + 1;
        nxt_f_out = f_out;
    end
end

// logic of iterating counting signal
localparam ITER_INDEX
    = (NUMBER_OF_COUNT >= 8192) ? 13 : ITER_WIDTH;

assign iter_sig = cnt[
    ITER_INDEX - 1:
    ITER_INDEX - ITER_WIDTH
];

endmodule