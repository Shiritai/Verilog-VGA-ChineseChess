`timescale 1ns / 1ps

module KeyboardReader (
    input clk,
    input clk_100Hz, // for short/long-press detection
    input rst_n,
    inout PS2_CLK,
    inout PS2_DATA,
    output s_key_up,
    output s_key_dn,
    output s_key_lf,
    output s_key_rt,
    output s_key_lshift,
    output s_key_w,
    output s_key_s,
    output s_key_a,
    output s_key_d,
    output s_key_rshift, // right shift key press
    output l_key_up,
    output l_key_dn,
    output l_key_lf,
    output l_key_rt,
    output l_key_w,
    output l_key_s,
    output l_key_a,
    output l_key_d,
    output s_key_space,   // space key press
    output s_key_bkspace  // backspace key press
);

wire [511:0] key_down;

KeyboardDecoder KB_DEC (
    .clk(clk), .rst(~rst_n),
    .PS2_CLK(PS2_CLK),
    .PS2_DATA(PS2_DATA),
    .key_down(key_down),
    .last_change(),
    .key_valid() // we don't need this in this lab
);

wire l_key_lshift, l_key_rshift, l_key_space, l_key_bkspace; // no usage

localparam KEY_UP      = 9'h044; // o
localparam KEY_DN      = 9'h04B; // l
localparam KEY_LF      = 9'h042; // k
localparam KEY_RT      = 9'h04C; // :
localparam KEY_W       = 9'h01D;
localparam KEY_S       = 9'h01B;
localparam KEY_A       = 9'h01C;
localparam KEY_D       = 9'h023;
localparam KEY_LSHIFT  = 9'h012;
localparam KEY_RSHIFT  = 9'h059;
localparam KEY_SPACE   = 9'h029;
localparam KEY_BKSPACE = 9'h066;

PressSignalArray #(
    .SIZE(12),
    .CNT_WIDTH(4)
) KBP (
    .user_clk(clk_100Hz),
    .rst_n(rst_n),
    .sig_arr({
        key_down[KEY_UP],
        key_down[KEY_DN],
        key_down[KEY_LF],
        key_down[KEY_RT],
        key_down[KEY_W],
        key_down[KEY_A],
        key_down[KEY_S],
        key_down[KEY_D],
        key_down[KEY_LSHIFT],
        key_down[KEY_RSHIFT],
        key_down[KEY_SPACE],
        key_down[KEY_BKSPACE]
    }),
    .s_sig_arr_o({
        s_key_up, s_key_dn,
        s_key_lf, s_key_rt,
        s_key_w,  s_key_a,
        s_key_s,  s_key_d,
        s_key_lshift,
        s_key_rshift,
        s_key_space,
        s_key_bkspace
    }),
    .l_sig_arr_o({
        l_key_up, l_key_dn,
        l_key_lf, l_key_rt,
        l_key_w,  l_key_a,
        l_key_s,  l_key_d,
        l_key_lshift, // no usage
        l_key_rshift, // no usage
        l_key_space,  // no usage
        l_key_bkspace // no usage
    })
);
    
endmodule