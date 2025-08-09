
module Datapath(clk, cnt_rst, cnt_en, start_path, inv1_ctrl, inv2_ctrl, Dec_EncBar, PRNG,
    inp_share0, inp_share1, key, out_share0, out_share1, round_num);

    input clk, cnt_rst, Dec_EncBar, cnt_en, start_path, inv1_ctrl, inv2_ctrl;
    input  [287 : 0] PRNG;
    input  [127 : 0] key;
    input  [63  : 0] inp_share0, inp_share1;
    output [63  : 0] out_share0, out_share1;
    output [3   : 0] round_num;
    
    wire [63 : 0] k_0, k_0_prim, k_1, k0_from_mux, key_xor_inp_share0,
    SR_inv0_out, SR_inv1_out, Mp_share0_to_mux, Mp_share1_to_mux, SR_out_share0,
    SR_out_share1, RC, k1_xor_RC, SR_share0_xor_RCk1XORed, Aout_b4SB_share0,
    Aout_b4SB_share1, SB_in0, SB_in1, SB_out0, SB_out1, Aout_afterSB_share0, 
    Aout_afterSB_share1, A0_XORed_RCk1, SRinv_to_Mux_share0, SRinv_to_Mux_share1;
	
    wire [127 : 0] mux_starter_out, mux_to_SB, mux_to_Mp;
    
    Counter_4bit inst_CNT (clk, cnt_rst, cnt_en, round_num);

    Key_extraction inst_key_extractor (key, k_0, k_0_prim, k_1);

    RC_Sel inst_RC_selectoin (round_num, Dec_EncBar, RC);
    
    assign k1_xor_RC = k_1 ^ RC;

    Mux_2to1 #(64) inst_mux_key (k_0_prim, k_0, (start_path ^ Dec_EncBar), k0_from_mux);

    assign key_xor_inp_share0 = inp_share0 ^ k0_from_mux;

    SR_inv inst_SRinv_starter_share0 (key_xor_inp_share0, SR_inv0_out);
    SR_inv inst_SRinv_starter_share1 (inp_share1, SR_inv1_out);

    Mux_2to1 #(128) inst_starter_mux ({Mp_share1_to_mux, Mp_share0_to_mux},
        {SR_inv1_out, SR_inv0_out}, start_path, mux_starter_out);

    SR inst_SR_share0 (mux_starter_out[63 : 0], SR_out_share0);
    SR inst_SR_share1 (mux_starter_out[127 : 64], SR_out_share1);

    assign SR_share0_xor_RCk1XORed = SR_out_share0 ^ k1_xor_RC;

    A_share0 inst_A_up_share0 (mux_starter_out[63 : 0], Aout_b4SB_share0);
    A_share1 inst_A_up_share1 (mux_starter_out[127 : 64], Aout_b4SB_share1);

    Mux_2to1 #(128) inst_mux_before_SB ({SR_out_share1, SR_share0_xor_RCk1XORed},
        {Aout_b4SB_share1, Aout_b4SB_share0}, inv1_ctrl, mux_to_SB);

    assign SB_in0 = mux_to_SB[63  : 0];
    assign SB_in1 = mux_to_SB[127 : 64];
    
    genvar i;
    generate
        for (i = 0 ; i < 16 ; i = i + 1) begin : PRINCE_sbox_opt_block
            SB_PRINCE inst_SB (clk, PRNG[(18*i) + 17 : 18*i],
                SB_in0[(4 * i)+3 : 4 * i], SB_in1[(4 * i)+3 : 4 * i],
                SB_out0[(4 * i)+3 : 4 * i], SB_out1[(4 * i)+3 : 4 * i]);
        end
    endgenerate
    
    A_share0 inst_A_down_share0 (SB_out0, Aout_afterSB_share0);
    A_share1 inst_A_down_share1 (SB_out1, Aout_afterSB_share1);

    assign A0_XORed_RCk1 = Aout_afterSB_share0 ^ k1_xor_RC;

    SR_inv inst_SRinv_share0 (A0_XORed_RCk1,       SRinv_to_Mux_share0);
    SR_inv inst_SRinv_share1 (Aout_afterSB_share1, SRinv_to_Mux_share1);
    
    Mux_2to1 #(128) inst_mux_before_Mp ({SB_out1, SB_out0}, {SRinv_to_Mux_share1, SRinv_to_Mux_share0},
        inv2_ctrl, mux_to_Mp);
    
    M_prime inst_Mp_share0 (mux_to_Mp[63  : 0],   Mp_share0_to_mux);
    M_prime inst_Mp_share1 (mux_to_Mp[127 : 64], Mp_share1_to_mux);
    
    assign out_share0 = A0_XORed_RCk1 ^ k0_from_mux;
    assign out_share1 = Aout_afterSB_share1;
    
endmodule