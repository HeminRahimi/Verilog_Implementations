module AES_2stages (clk, PRNG, inp0, inp1, F0, F1); 

    input [7 : 0] inp0, inp1; 
    input [45 : 0] PRNG ; 
    input clk; 
    output [7 : 0] F0, F1;

    wire [14 : 0] P0_prime, P1_prime, Q0_prime, Q1_prime; 
    wire a_0, b_0, c_0, d_0, ab_0, ac_0, ad_0, bc_0, bd_0, 
    cd_0, abc_0, abd_0, acd_0, bcd_0, abcd_0, e_0, f_0, g_0, 
    h_0, ef_0, eg_0, eh_0, fg_0, fh_0, gh_0, efg_0, efh_0, 
    egh_0, fgh_0, efgh_0; 
    wire a_1, b_1, c_1, d_1, ab_1, ac_1, ad_1, bc_1, bd_1, 
    cd_1, abc_1, abd_1, acd_1, bcd_1, abcd_1, e_1, f_1, g_1, 
    h_1, ef_1, eg_1, eh_1, fg_1, fh_1, gh_1, efg_1, efh_1, 
    egh_1, fgh_1, efgh_1; 

    TSM_k4 inst_stage1 (clk, PRNG[18 : 0],  inp0[7 : 4], inp1[7 : 4],  P0_prime, P1_prime); 
    TSM_k4 inst_stage2 (clk, PRNG[37 : 19], inp0[3 : 0], inp1[3 : 0],  Q0_prime, Q1_prime); 

    wire [7 : 0] r_cross; 
    assign r_cross = PRNG [45 : 38]; 

    Cross_mult inst_mult (clk, r_cross, P0_prime, P1_prime, Q0_prime, Q1_prime, F0, F1); 

endmodule
