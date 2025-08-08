
module datapath #(parameter N = 9)(clk, Ng, nfft, reg_rst, reg_ld, 
                                   cnt_rst, cen, mode, t_valid, cfo, out_valid, cntf);
                                
    input [11:0] Ng, nfft;
    input clk, reg_rst, reg_ld, cnt_rst, cen, mode, t_valid;
    output [11 : 0] cfo ;
    output out_valid, cntf;

    wire dout_tready;
    wire [N-1 : 0] re1, re2, img1, neg_img1, img2; 
    wire [23 : 0] mult_out_re, mult_out_img, atan_out,adder_re_inp, 
                  re_adderout, img_adderout, adder_img_inp, tmp_out;
    wire [11 : 0] cfo_realtime;
    wire [11 : 0] Out_cnt; 
    wire [47 : 0] comb_out;
    Re_me M_r (clk, mode, Out_cnt, nfft, re1, re2);
  
    Img_me M_i (clk, mode, Out_cnt, nfft, img1, img2);
    negation neg_inst (img1, neg_img1);
    Cmplx_Mult #(N) mult_inst (re1, neg_img1, re2, img2, 
                        mult_out_re, mult_out_img);
    Adder adder_inst (mult_out_re, mult_out_img, adder_re_inp, 
                   adder_img_inp, re_adderout, img_adderout);   
    PIPO_reg reg_inst (re_adderout, img_adderout, clk, reg_ld, reg_rst,
                      adder_re_inp, adder_img_inp);                            
    Combiner combiner_inst (re_adderout, img_adderout, comb_out);             
       
    arc_tan atan_inst (clk, comb_out, t_valid, atan_out, dout_tready);
    
    Divby2 div_inst (dout_tready, atan_out, tmp_out, out_valid);
    divideby4 div4_inst (atan_out, cfo_realtime);
    up_cnt #(12) cnt_inst (Ng, cen, cnt_rst, clk, Out_cnt, cntf);
 
    assign cfo = tmp_out [23:12];
endmodule
