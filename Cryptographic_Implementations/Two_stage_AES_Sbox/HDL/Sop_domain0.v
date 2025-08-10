module Sop_domain0 (gi_reg, hi_out, output_share0);

    input [14 : 0] gi_reg, hi_out;
    output [14 : 0] output_share0;

    wire a_share0, b_share0, c_share0, d_share0,
    ab_share0, ac_share0, ad_share0,
    bc_share0,bd_share0, cd_share0,
    abc_share0, abd_share0, bcd_share0, acd_share0, abcd_share0;

    assign a_share0 = gi_reg[0];
    assign b_share0 = gi_reg[1];
    assign c_share0 = gi_reg[2];
    assign d_share0 = gi_reg[3];

    assign ab_share0 = gi_reg[4] ^ (gi_reg[0] & hi_out[1]) ^ (gi_reg[1] & hi_out[0]);
    assign ac_share0 = gi_reg[5] ^ (gi_reg[0] & hi_out[2]) ^ (gi_reg[2] & hi_out[0]);
    assign ad_share0 = gi_reg[6] ^ (gi_reg[0] & hi_out[3]) ^ (gi_reg[3] & hi_out[0]);
    assign bc_share0 = gi_reg[7] ^ (gi_reg[1] & hi_out[2]) ^ (gi_reg[2] & hi_out[1]);
    assign bd_share0 = gi_reg[8] ^ (gi_reg[1] & hi_out[3]) ^ (gi_reg[3] & hi_out[1]);
    assign cd_share0 = gi_reg[9] ^ (gi_reg[2] & hi_out[3]) ^ (gi_reg[3] & hi_out[2]);

    assign abc_share0 = (ab_share0 & hi_out[2]) ^ (gi_reg[10]) ^ (gi_reg[5] & hi_out[1]) ^ (gi_reg[7] & hi_out[0]) ^ (gi_reg[2] & hi_out[4]);
    assign abd_share0 = (ab_share0 & hi_out[3]) ^ (gi_reg[11]) ^ (gi_reg[6] & hi_out[1]) ^ (gi_reg[8] & hi_out[0]) ^ (gi_reg[3] & hi_out[4]);
    assign acd_share0 = (ac_share0 & hi_out[3]) ^ (gi_reg[12]) ^ (gi_reg[6] & hi_out[2]) ^ (gi_reg[9] & hi_out[0]) ^ (gi_reg[3] & hi_out[5]);
    assign bcd_share0 = (bc_share0 & hi_out[3]) ^ (gi_reg[13]) ^ (gi_reg[8] & hi_out[2]) ^ (gi_reg[9] & hi_out[1]) ^ (gi_reg[3] & hi_out[7]);
    assign abcd_share0 = bcd_share0 & hi_out[0] ^ acd_share0 & hi_out[1] ^ cd_share0 & hi_out[4] ^
    hi_out[2] & gi_reg[11] ^ hi_out[3]  & gi_reg[10] ^ hi_out[9]  & gi_reg[4] ^ gi_reg[14] ;

    assign output_share0 = {a_share0, b_share0, c_share0, d_share0, ab_share0, ac_share0, ad_share0, bc_share0, bd_share0, cd_share0,
    abc_share0, abd_share0, acd_share0, bcd_share0, abcd_share0};

endmodule
