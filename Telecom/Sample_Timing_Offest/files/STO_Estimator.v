// ------------------------------------------------
// Project Name: Sample Timing Offset Estimation
// Author: Hemin Rahimi
// Date: November 2023
// Version: 1.0

module STO_Estimator(clk, reset, go, com_delay, Ng, Nfft, est_STO, done);
    input clk, reset, go;
    input [11 : 0] Ng, Nfft, com_delay;
    output [11 : 0] est_STO;
    output done;

    wire cnt_start, in_valid, accu_rst, accu_ld, mf_rst,
    mf_ld, sto_calc_en, inc_nofdm, cnt_end, func_valid;

    STO__DP DP (clk, cnt_start, in_valid, accu_rst, accu_ld, mf_rst, mf_ld,
        sto_calc_en, Ng, com_delay, Nfft, est_STO, func_valid, inc_nofdm, cnt_end);

    STO_Controller CTRL (clk, reset, go, inc_nofdm, cnt_end,
    cnt_start, in_valid, accu_rst, accu_ld, mf_rst, mf_ld, sto_calc_en, done);

endmodule
