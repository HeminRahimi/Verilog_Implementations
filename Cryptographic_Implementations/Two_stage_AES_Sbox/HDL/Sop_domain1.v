module Sop_domain1 (hi_out, reg_rnd, output_share1);

    input [14 : 0] reg_rnd, hi_out;
    output [14 : 0] output_share1;

    wire a_share1, b_share1, c_share1, d_share1,
    ab_share1, ac_share1, ad_share1,
    bc_share1,bd_share1, cd_share1,
    abc_share1, abd_share1, bcd_share1, acd_share1;

    assign a_share1 = reg_rnd[0] ^ hi_out[0];
    assign b_share1 = reg_rnd[1] ^ hi_out[1];
    assign c_share1 = reg_rnd[2] ^ hi_out[2];
    assign d_share1 = reg_rnd[3] ^ hi_out[3];

    assign ab_share1 = reg_rnd[4] ^ (reg_rnd[0] & hi_out[1]) ^ (reg_rnd[1] & hi_out[0]) ^ (hi_out[4]);
    assign ac_share1 = reg_rnd[5] ^ (reg_rnd[0] & hi_out[2]) ^ (reg_rnd[2] & hi_out[0]) ^ (hi_out[5]);
    assign ad_share1 = reg_rnd[6] ^ (reg_rnd[0] & hi_out[3]) ^ (reg_rnd[3] & hi_out[0]) ^ (hi_out[6]);
    assign bc_share1 = reg_rnd[7] ^ (reg_rnd[1] & hi_out[2]) ^ (reg_rnd[2] & hi_out[1]) ^ (hi_out[7]);
    assign bd_share1 = reg_rnd[8] ^ (reg_rnd[1] & hi_out[3]) ^ (reg_rnd[3] & hi_out[1]) ^ (hi_out[8]);
    assign cd_share1 = reg_rnd[9] ^ (reg_rnd[2] & hi_out[3]) ^ (reg_rnd[3] & hi_out[2]) ^ (hi_out[9]);

    assign abc_share1 = (ab_share1 & hi_out[2]) ^ reg_rnd[10] ^ (reg_rnd[5] & hi_out[1]) ^
    (reg_rnd[7] & hi_out[0]) ^ (reg_rnd[2] & hi_out[4]);
    assign abd_share1 = (ab_share1 & hi_out[3]) ^ reg_rnd[11] ^ (reg_rnd[6] & hi_out[1]) ^
    (reg_rnd[8] & hi_out[0]) ^ (reg_rnd[3] & hi_out[4]);
    assign acd_share1 = (ac_share1 & hi_out[3]) ^ reg_rnd[12] ^ (reg_rnd[6] & hi_out[2]) ^
    (reg_rnd[9] & hi_out[0]) ^ (reg_rnd[3] & hi_out[5]);
    assign bcd_share1 = (bc_share1 & hi_out[3]) ^ reg_rnd[13] ^ (reg_rnd[8] & hi_out[2]) ^
    (reg_rnd[9] & hi_out[1]) ^ (reg_rnd[3] & hi_out[7]);
    assign abcd_share1 = hi_out[0] & bcd_share1 ^ hi_out[1] & acd_share1 ^ hi_out[4] & cd_share1 ^
    hi_out[2] & reg_rnd[11] ^ hi_out[3] & reg_rnd[10] ^ hi_out[9] & reg_rnd[4] ^ reg_rnd[14];


    assign output_share1 = {a_share1, b_share1, c_share1, d_share1, ab_share1, ac_share1, ad_share1, bc_share1, bd_share1, cd_share1,
    abc_share1, abd_share1, acd_share1, bcd_share1, abcd_share1};

endmodule
