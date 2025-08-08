`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module STO_Controller (clk, reset, go, inc_ofdm, cnt_end,
    cnt_start, in_valid, accu_rst, accu_ld, mf_rst,
    mf_ld, sto_calc_en, done);
    input clk, reset, go, inc_ofdm, cnt_end ;
    output reg cnt_start, in_valid, accu_rst,
    accu_ld, mf_rst, mf_ld, sto_calc_en, done ;

    parameter s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6, s7=7;

    reg [3:0] P , N ;

    always @ (go, P, inc_ofdm, cnt_end) begin
        N = s0;
        cnt_start = 0 ; in_valid = 0 ; accu_rst = 0;
        accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 0;
        sto_calc_en = 0;
        case (P)

            //////////
            s0: begin
                cnt_start = 0 ; in_valid = 0 ; accu_rst = 0;
                accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 0;
                if (go == 1'b1)
                    N = s1 ;
                else
                    N = s0 ;
            end

            /////////
            s1: begin
                cnt_start = 0 ; in_valid = 0 ; accu_rst = 1;
                accu_ld = 0 ; mf_rst = 1; mf_ld = 0; done = 0;
                N = s2 ;
            end
            ///////////
            s2: begin
                cnt_start = 1 ; in_valid = 0 ; accu_rst = 1;
                accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 0;
                N = s3 ;
            end

            ///////////
            s3: begin
                cnt_start = 0 ; in_valid = 1 ; accu_rst = 1;
                accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 0;
                N = s4 ;
            end

            ///////////
            s4: begin
                cnt_start = 0 ; in_valid = 0 ; accu_rst = 1;
                accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 0;
                N = s5 ;
            end

            ///////////
            s5: begin
                if (cnt_end == 1'b0) begin
                    if (inc_ofdm == 1'b0) begin
                        cnt_start = 0 ; in_valid = 0 ; accu_rst = 0;
                        accu_ld = 1 ; mf_rst = 0; mf_ld = 0; done = 0;
                        N = s5 ;
                    end
                    else
                        N = s6;
                end
                else begin
                    N = s7;

                end
            end
            ///////////
            s6: begin
                if (cnt_end ==1'b0) begin
                    N = s5 ;
                    cnt_start = 0 ; in_valid = 0 ; accu_rst = 1;
                    accu_ld = 0 ; mf_rst = 0; mf_ld = 1; done = 0;
                end
                else begin
                    N = s7;

                end
            end

            s7: begin
                N = s0 ;
                cnt_start = 0 ; in_valid = 0 ; accu_rst = 0;
                accu_ld = 0 ; mf_rst = 0; mf_ld = 0; done = 1;
                sto_calc_en = 1;
            end

        endcase

    end

    always @(posedge clk) begin
        if ( reset == 1'b1 )
            P <= s0 ;
        else
            P <= N ;
    end

endmodule
