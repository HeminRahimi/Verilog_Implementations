`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module STO_calc(en, idx, Nfft, Ng, com_delay, est_STO);
    input en;
    input [11 : 0] Ng, Nfft, com_delay;
    input [12 : 0] idx;
    output reg [11 : 0] est_STO;


    always @ (*) begin
        if (en)
            est_STO = (Nfft + Ng) - (com_delay) - idx;
        else
            est_STO = est_STO;
    end
endmodule
