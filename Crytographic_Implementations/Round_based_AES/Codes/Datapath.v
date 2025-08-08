
module Datapath(clk, rst, PRNG, pt_share, key_share, 
    op_ctrl, s20_ctrl, inp_ctrl, state_in_ctrl, rotate_ctrl,
    RK_ctrl, Kron_sel, SB_in_sel, En_round, round_num, out_valid, Out);

    input clk, rst, s20_ctrl, inp_ctrl,
    state_in_ctrl, rotate_ctrl, out_valid,
    Kron_sel, SB_in_sel, En_round;
    input [1 : 0] op_ctrl,RK_ctrl;
    input [15 : 0] pt_share, key_share;
    input [18 : 0] PRNG;
    output [3 : 0] round_num;
    output [255 : 0] Out;

    wire [15 : 0] RK, shared_SB_in, shared_kron_in,
    to_kronecker, k00_out , k03_out, k13_2sbox, 
    state_out, s01, s11, s21, s31,
    SB_out, SB_out2reg1, SB_out2reg2, SB_out2reg3;
    wire [15 : 0] pt, key;
    wire [63:0] MCout, MCin;
    register #(16) pip_pt  (pt_share,  clk, pt);
    register #(16) pip_key (key_share, clk, key);

    round_counting inst_round_counter (clk, rst, En_round, round_num);

    round_key inst_RK0 (RK_ctrl, round_num, k00_out, k03_out, SB_out, RK);

    key_array inst_KS (clk, inp_ctrl, rotate_ctrl, RK, key, k00_out, k13_2sbox, k03_out);

    state_array inst_DS (clk, op_ctrl, inp_ctrl, s20_ctrl,
        state_in_ctrl, pt, RK, key, SB_out,
        MCout, state_out, to_kronecker,
        MCin, Out);

    mux_2to1 #(16) inst_mux0 (state_out, k13_2sbox, SB_in_sel, shared_SB_in);
    mux_2to1 #(16) inst_mux1 (to_kronecker, k03_out, Kron_sel, shared_kron_in);
    Sbox inst_SBOX(clk, PRNG, shared_SB_in, shared_kron_in, SB_out);
    
    mix_columns inst_MC0 (MCin[7 : 0], MCin[23:16], MCin[39:32], MCin[55:48],
        MCout[7 : 0], MCout[23:16], MCout[39:32], MCout[55:48]);
    mix_columns inst_MC1 (MCin[15 : 8], MCin[31:24], MCin[47:40], MCin[63:56],
        MCout[15 : 8], MCout[31:24], MCout[47:40], MCout[63 : 56]);


endmodule
