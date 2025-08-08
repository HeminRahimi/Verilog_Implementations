// ------------------------------------------------
// Project Name: Career Frequency Offset Estimation (CFO)
// Author: Hemin Rahimi
// Date: November 2023
// Description: Career frequency offset estimation based on the cyclic prefix method.
// Version: 1.0
// Notes: 
//  - This version is not necessarily synthesizable.
//  - Designed using VIVADO 2022.1.
//  - If using a different version of VIVADO, you may need to redesign IPs based on your current version.
// ------------------------------------------------

module cfo_calc(Ng, nfft, go, reset, clk, done, cfo);
    input go, reset, clk;
    input [11:0] Ng, nfft;
    output done;
    output [11:0] cfo;

    wire End, cntf, mode, cen, cnt_rst, reg_rst, reg_ld, t_valid;

    Controller M1 (clk, reset, go, End, cntf, mode, cen, cnt_rst,
        reg_rst, reg_ld, t_valid, done);
    datapath #(9) M2 (clk, Ng, nfft, reg_rst, reg_ld, cnt_rst,
        cen, mode, t_valid, cfo, End, cntf);
endmodule
