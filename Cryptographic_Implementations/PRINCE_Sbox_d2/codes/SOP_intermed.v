module Sop_intermed (reg_g0, reg_r0, g1_out, out_sh0, out_sh1);

    input  [13 : 0] reg_g0, reg_r0, g1_out;
    output [13 : 0] out_sh0, out_sh1;

    assign out_sh0[0] = reg_g0[0];
    assign out_sh1[0] = reg_r0[0] ^ g1_out[0];

    assign out_sh0[1] = reg_g0[1];
    assign out_sh1[1] = reg_r0[1] ^ g1_out[1];

    assign out_sh0[2] = reg_g0[2];
    assign out_sh1[2] = reg_r0[2] ^ g1_out[2];

    assign out_sh0[3] = reg_g0[3];
    assign out_sh1[3] = reg_r0[3] ^ g1_out[3];
    ////------------
    assign out_sh0[4] = reg_g0[4] ^ (reg_g0[0] & g1_out[1]) ^ (reg_g0[1] & g1_out[0]);
    assign out_sh1[4] = reg_r0[4] ^ (reg_r0[0] & g1_out[1]) ^ (reg_r0[1] & g1_out[0]) ^ g1_out[4];

    assign out_sh0[5] = reg_g0[5] ^ (reg_g0[0] & g1_out[2]) ^ (reg_g0[2] & g1_out[0]);
    assign out_sh1[5] = reg_r0[5] ^ (reg_r0[0] & g1_out[2]) ^ (reg_r0[2] & g1_out[0]) ^ g1_out[5];

    assign out_sh0[6] = reg_g0[6] ^ (reg_g0[0] & g1_out[3]) ^ (reg_g0[3] & g1_out[0]);
    assign out_sh1[6] = reg_r0[6] ^ (reg_r0[0] & g1_out[3]) ^ (reg_r0[3] & g1_out[0]) ^ g1_out[6];

    assign out_sh0[7] = reg_g0[7] ^ (reg_g0[1] & g1_out[2]) ^ (reg_g0[2] & g1_out[1]);
    assign out_sh1[7] = reg_r0[7] ^ (reg_r0[1] & g1_out[2]) ^ (reg_r0[2] & g1_out[1]) ^ g1_out[7];;

    assign out_sh0[8] = reg_g0[8] ^ (reg_g0[1] & g1_out[3]) ^ (reg_g0[3] & g1_out[1]);
    assign out_sh1[8] = reg_r0[8] ^ (reg_r0[1] & g1_out[3]) ^ (reg_r0[3] & g1_out[1]) ^ g1_out[8];;

    assign out_sh0[9] = reg_g0[9] ^ (reg_g0[2] & g1_out[3]) ^ (reg_g0[3] & g1_out[2]);
    assign out_sh1[9] = reg_r0[9] ^ (reg_r0[2] & g1_out[3]) ^ (reg_r0[3] & g1_out[2]) ^ g1_out[9];

    /////----------
    assign out_sh0[10] = out_sh0[4] & g1_out[2] ^ reg_g0[10] ^ reg_g0[5] & g1_out[1] ^ 
           reg_g0[7] & g1_out[0] ^ reg_g0[2] & g1_out[4];
    assign out_sh1[10] = out_sh1[4] & g1_out[2] ^ reg_r0[10] ^ reg_r0[5] & g1_out[1] ^ reg_r0[7] & g1_out[0] ^ reg_r0[2] & g1_out[4];

    assign out_sh0[11] = out_sh0[4] & g1_out[3] ^ reg_g0[11] ^ reg_g0[6] & g1_out[1] ^ 
           reg_g0[8] & g1_out[0] ^ reg_g0[3] & g1_out[4];
    assign out_sh1[11] = out_sh1[4] & g1_out[3] ^ reg_r0[11] ^ reg_r0[6] & g1_out[1] ^ reg_r0[8] & g1_out[0] ^ reg_r0[3] & g1_out[4];
    
    assign out_sh0[12] = out_sh0[5] & g1_out[3] ^ reg_g0[12] ^ reg_g0[6] & g1_out[2] ^ 
           reg_g0[9] & g1_out[0] ^ reg_g0[3] & g1_out[5];
    assign out_sh1[12] = out_sh1[5] & g1_out[3] ^ reg_r0[12] ^ reg_r0[6] & g1_out[2] ^ reg_r0[9] & g1_out[0] ^ reg_r0[3] & g1_out[5];

    assign out_sh0[13] = out_sh0[7] & g1_out[3] ^ reg_g0[13] ^ reg_g0[8] & g1_out[2] ^ 
           reg_g0[9] & g1_out[1] ^ reg_g0[3] & g1_out[7];
    assign out_sh1[13] = out_sh1[7] & g1_out[3] ^ reg_r0[13] ^ reg_r0[8] & g1_out[2] ^ reg_r0[9] & g1_out[1] ^ reg_r0[3] & g1_out[7];
    
endmodule

