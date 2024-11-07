`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module STO__DP(clk, cnt_starter, in_valid, accu_rst, accu_ld, mf_rst, mf_en,
    sto_calc_en, Ng, com_delay, Nfft, est_STO, func_valid, inc_nofdm, cnt_done);

    parameter  N = 36;
    input clk, cnt_starter, in_valid, accu_rst, accu_ld,
    mf_rst, mf_en, sto_calc_en;
    input [11 : 0] Ng, Nfft, com_delay;
    output cnt_done, func_valid, inc_nofdm;
    output [11 : 0] est_STO;

    wire cnt_rst;
    wire [12 : 0] CNT_Out_Ng, Out_Nofdm, min_loc;
    wire [8 : 0] r1, i1, r2, i2;
    wire [N - 1 : 0] func_out, accu_out;


    Re_me re_data (clk, 1'b1, CNT_Out_Ng, Nfft, r1, r2);
    Img_me im_data (clk, 1'b1, CNT_Out_Ng, Nfft, i1, i2);

    Func func_inst (clk, in_valid, r1, i1, r2, i2, func_out, func_valid);
    // 8-integer, 8-fract
    accumulatorN #(N) accu_inst (clk, {{8{func_out[N-1]}},func_out[N-2:N-29]},
        accu_rst, accu_ld, accu_out);

    min_finder  minfinder_inst (clk, mf_rst, mf_en, Out_Nofdm, accu_out, min_loc);

    STO_calc stocalc_inst (sto_calc_en, min_loc, Nfft, Ng, com_delay, est_STO);

    CNT counter_inst(clk, cnt_rst, cnt_starter, Nfft, Ng, com_delay, CNT_Out_Ng,
        Out_Nofdm, inc_nofdm, cnt_done);

endmodule
