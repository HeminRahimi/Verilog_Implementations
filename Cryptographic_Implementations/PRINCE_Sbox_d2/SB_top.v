module SB_TSM_d2 (clk, PRNG, inp_sh0, inp_sh1, inp_sh2, F_sh0, F_sh1, F_sh2);

    input clk;
    input [53 : 0] PRNG;
    input [3 : 0] inp_sh0, inp_sh1, inp_sh2;
    output [3 : 0] F_sh0, F_sh1, F_sh2;

    wire [3 : 0] refreshed_inp_sh0, refreshed_inp_sh1, reg_refreshed_inp_sh1,
        refreshed_inp_sh2, reg1_refreshed_inp_sh2, reg2_refreshed_inp_sh2;

    wire [13 : 0] g0_out, g1_out, g2_out, r0, r10, r11, r10_XOR_r11, reg_r10_XOR_r11,
        g0_refreshed, reg_g0_refreshed, reg_r0, Sop_out0, Sop_out1, Sop_out2,
        intmed_sop_0, reg_intmed_sop_0, intmed_sop_1, reg_intmed_sop_1,
        refreshed_intmed_sop_0, refreshed_intmed_sop_1;

    wire [11 : 0] rand_refresh;
    assign rand_refresh = PRNG[53 : 42];

    assign r0 = PRNG[25 : 12];
    assign r10 = PRNG[39 : 26];
    assign r11 = PRNG[53 : 40];

    inp_referesher inst_input_refresher (inp_sh0, inp_sh1, inp_sh2, rand_refresh, 
        refreshed_inp_sh0, refreshed_inp_sh1, refreshed_inp_sh2);
    
    gi_func inst_g0 (refreshed_inp_sh0, g0_out);
    signal_blinder #(14) inst_g0_refrehser (g0_out, r0, g0_refreshed);
    Register #(14) inst_reg_g0 (g0_refreshed, clk, reg_g0_refreshed);
    Register #(14) inst_reg_r0 (r0, clk, reg_r0);

    Register #(4) inst_reg_sh1(refreshed_inp_sh1, clk, reg_refreshed_inp_sh1);
    gi_func inst_g1 (reg_refreshed_inp_sh1, g1_out);
    
    Sop_intermed  inst_sop_intermed (reg_g0_refreshed, reg_r0, g1_out, intmed_sop_0, intmed_sop_1);

    signal_blinder #(14) inst_refresh_sh0 (intmed_sop_0, r10, refreshed_intmed_sop_0);
    signal_blinder #(14) inst_refresh_sh1 (intmed_sop_1, r11, refreshed_intmed_sop_1);

    Register #(14) inst_after_Sop0 (refreshed_intmed_sop_0, clk, reg_intmed_sop_0);
    Register #(14) inst_after_Sop1 (refreshed_intmed_sop_1, clk, reg_intmed_sop_1);
    assign r10_XOR_r11 = (r10 ^ r11);
    Register #(14) inst_rand_after_sop(r10_XOR_r11, clk, reg_r10_XOR_r11);

    Register #(4) inst_reg1_sh2(refreshed_inp_sh2, clk, reg1_refreshed_inp_sh2);
    Register #(4) inst_reg2_sh2(reg1_refreshed_inp_sh2, clk, reg2_refreshed_inp_sh2);
    gi_func inst_g2 (reg2_refreshed_inp_sh2, g2_out);
    
    Sop_at_out inst_final_SOP (reg_intmed_sop_0, reg_intmed_sop_1, reg_r10_XOR_r11, g2_out, Sop_out0,  Sop_out1, Sop_out2);

    assign F_sh0[0] = 1'b1 ^ Sop_out0[0] ^ Sop_out0[1] ^ Sop_out0[4] ^ Sop_out0[6] ^ Sop_out0[7] ^ Sop_out0[9] ^ Sop_out0[13]; 
    assign F_sh0[1] = 1'b1 ^ Sop_out0[5] ^ Sop_out0[7] ^ Sop_out0[8] ^ Sop_out0[10] ^ Sop_out0[13];
    assign F_sh0[2] = Sop_out0[0] ^ Sop_out0[3] ^ Sop_out0[5] ^ Sop_out0[6] ^ Sop_out0[9] ^ Sop_out0[10] ^ Sop_out0[12];
    assign F_sh0[3] = 1'b1 ^ Sop_out0[0] ^ Sop_out0[2] ^ Sop_out0[4] ^ Sop_out0[7] ^ Sop_out0[11] ^ Sop_out0[12] ^ Sop_out0[13];

    assign F_sh1[0] = Sop_out1[0] ^ Sop_out1[1] ^ Sop_out1[4] ^ Sop_out1[6]  ^ Sop_out1[7]  ^ Sop_out1[9]  ^ Sop_out1[13];
    assign F_sh1[1] = Sop_out1[5] ^ Sop_out1[7] ^ Sop_out1[8] ^ Sop_out1[10] ^ Sop_out1[13];
    assign F_sh1[2] = Sop_out1[0] ^ Sop_out1[3] ^ Sop_out1[5] ^ Sop_out1[6]  ^ Sop_out1[9]  ^ Sop_out1[10] ^ Sop_out1[12];
    assign F_sh1[3] = Sop_out1[0] ^ Sop_out1[2] ^ Sop_out1[4] ^ Sop_out1[7]  ^ Sop_out1[11] ^ Sop_out1[12] ^ Sop_out1[13];

    assign F_sh2[0] = Sop_out2[0] ^ Sop_out2[1] ^ Sop_out2[4] ^ Sop_out2[6]  ^ Sop_out2[7]  ^ Sop_out2[9]  ^ Sop_out2[13];
    assign F_sh2[1] = Sop_out2[5] ^ Sop_out2[7] ^ Sop_out2[8] ^ Sop_out2[10] ^ Sop_out2[13];
    assign F_sh2[2] = Sop_out2[0] ^ Sop_out2[3] ^ Sop_out2[5] ^ Sop_out2[6]  ^ Sop_out2[9]  ^ Sop_out2[10] ^ Sop_out2[12];
    assign F_sh2[3] = Sop_out2[0] ^ Sop_out2[2] ^ Sop_out2[4] ^ Sop_out2[7]  ^ Sop_out2[11] ^ Sop_out2[12] ^ Sop_out2[13];

endmodule

