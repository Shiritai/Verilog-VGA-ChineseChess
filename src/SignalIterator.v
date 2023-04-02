`timescale 1ns / 1ps

module SignalIterator(
    input [15:0] nums,
    input [1:0] ssd_ctl_en,
    output [7:0] ssd_o,
    output reg [3:0] ssd_ctl
);

reg [3:0] NUMbuf;

always @* begin
    case (ssd_ctl_en)

    2'd0: begin
        ssd_ctl = 4'b1110;
        NUMbuf = nums[ 3: 0];
    end
    2'd1: begin
        ssd_ctl = 4'b1101;
        NUMbuf = nums[ 7: 4];
    end
    2'd2: begin
        ssd_ctl = 4'b1011;
        NUMbuf = nums[11: 8];
    end
    2'd3: begin
        ssd_ctl = 4'b0111;
        NUMbuf = nums[15:12];
    end
    default: begin
        // stand by...
        ssd_ctl = 4'b1111;
        NUMbuf = nums[3:0];
    end
    
    endcase
end

SevenSegmentDisplay DISPLAY(.num(NUMbuf), .ssd_o(ssd_o));

endmodule

module SevenSegmentDisplay (
    input       [3:0] num,
    output reg  [7:0] ssd_o
);

// definition of segment codes
localparam SS_0 = 8'b00000011;
localparam SS_1 = 8'b10011111;
localparam SS_2 = 8'b00100101;
localparam SS_3 = 8'b00001101;
localparam SS_4 = 8'b10011001;
localparam SS_5 = 8'b01001001;
localparam SS_6 = 8'b01000001;
localparam SS_7 = 8'b00011111;
localparam SS_8 = 8'b00000001;
localparam SS_9 = 8'b00001001;
localparam SS_SPACE = 8'b11111111;

always @* begin
    case (num)
        4'h0: ssd_o = SS_0;
        4'h1: ssd_o = SS_1;
        4'h2: ssd_o = SS_2;
        4'h3: ssd_o = SS_3;
        4'h4: ssd_o = SS_4;
        4'h5: ssd_o = SS_5;
        4'h6: ssd_o = SS_6;
        4'h7: ssd_o = SS_7;
        4'h8: ssd_o = SS_8;
        4'h9: ssd_o = SS_9;
        default: ssd_o = SS_SPACE;
    endcase
end

endmodule