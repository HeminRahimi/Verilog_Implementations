module  TSM_k4 (clk, PRNG, inp_share0, inp_share1, F0, F1);
            
    input clk;
    input  [18 : 0] PRNG;
    input  [3 : 0] inp_share0, inp_share1;
    output [14 : 0] F0, F1;
            
    wire [3 : 0] inp_share0_refereshed, inp_share1_refereshed, inp_sahre1_reg;
    wire [14 : 0] gi_out, gi_reg, hi_out, reg_rnd;
            
    inp_referesher inst_share0(inp_share0, PRNG[18 : 15], inp_share0_refereshed);
    inp_referesher inst_share1(inp_share1, PRNG[18 : 15], inp_share1_refereshed);
            
    gi_prime inst_gi_func_calc (inp_share0_refereshed, PRNG[14 : 0], gi_out);
    h_i inst_hi_func_calc(inp_sahre1_reg, hi_out);
            
    Register #(15) inst_reg_gi (gi_out, clk, gi_reg);
    Register #(15) inst_reg_rand_vals (PRNG[14 : 0], clk, reg_rnd);
    Register #(4) inst_reg_inp_share1 (inp_share1_refereshed, clk, inp_sahre1_reg);
            
    Sop_domain0 inst_sum_of_prod0 (gi_reg, hi_out, F0);
    Sop_domain1 inst_sum_of_prod1 (hi_out, reg_rnd, F1);
            
endmodule
