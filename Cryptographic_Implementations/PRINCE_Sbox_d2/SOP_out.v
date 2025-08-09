module Sop_at_out (share0, share1, reg_rnd, g2, Sop_out0,  Sop_out1, Sop_out2);

    input[13 : 0] share0, share1, reg_rnd, g2;
    output [13 : 0] Sop_out0,  Sop_out1, Sop_out2;

    assign Sop_out0[0] = share0[0];          //  a
    assign Sop_out1[0] = share1[0];
    assign Sop_out2[0] = reg_rnd [0] ^ g2[0];

    assign Sop_out0[1] = share0[1];          //  b
    assign Sop_out1[1] = share1[1];
    assign Sop_out2[1] = reg_rnd [1] ^ g2[1];

    assign Sop_out0[2] = share0[2];          //  c
    assign Sop_out1[2] = share1[2];
    assign Sop_out2[2] = reg_rnd [2] ^ g2[2];

    assign Sop_out0[3] = share0[3];          //  d
    assign Sop_out1[3] = share1[3];
    assign Sop_out2[3] = reg_rnd [3] ^ g2[3];
    ////
    assign Sop_out0[4] = share0[4] ^ (share0[0] & g2[1]) ^ (share0[1] & g2[0]);
    assign Sop_out1[4] = share1[4] ^ (share1[0] & g2[1]) ^ (share1[1] & g2[0]);
    assign Sop_out2[4] = reg_rnd [4] ^ (reg_rnd [0] & g2[1]) ^ (reg_rnd [1] & g2[0]) ^ g2[4];

    assign Sop_out0[5] = share0[5] ^ (share0[0] & g2[2]) ^ (share0[2] & g2[0]);
    assign Sop_out1[5] = share1[5] ^ (share1[0] & g2[2]) ^ (share1[2] & g2[0]);
    assign Sop_out2[5] = reg_rnd [5] ^ (reg_rnd [0] & g2[2]) ^ (reg_rnd [2] & g2[0]) ^ g2[5];

    assign Sop_out0[6] = share0[6] ^ (share0[0] & g2[3]) ^ (share0[3] & g2[0]);
    assign Sop_out1[6] = share1[6] ^ (share1[0] & g2[3]) ^ (share1[3] & g2[0]);
    assign Sop_out2[6] = reg_rnd [6] ^ (reg_rnd [0] & g2[3]) ^ (reg_rnd [3] & g2[0]) ^ g2[6];

    assign Sop_out0[7] = share0[7] ^ (share0[1] & g2[2]) ^ (share0[2] & g2[1]);
    assign Sop_out1[7] = share1[7] ^ (share1[1] & g2[2]) ^ (share1[2] & g2[1]);
    assign Sop_out2[7] = reg_rnd [7] ^ (reg_rnd [1] & g2[2]) ^ (reg_rnd [2] & g2[1]) ^ g2[7];;

    assign Sop_out0[8] = share0[8] ^ (share0[1] & g2[3]) ^ (share0[3] & g2[1]);
    assign Sop_out1[8] = share1[8] ^ (share1[1] & g2[3]) ^ (share1[3] & g2[1]);
    assign Sop_out2[8] = reg_rnd [8] ^ (reg_rnd [1] & g2[3]) ^ (reg_rnd [3] & g2[1]) ^ g2[8];;

    assign Sop_out0[9] = share0[9] ^ (share0[2] & g2[3]) ^ (share0[3] & g2[2]);
    assign Sop_out1[9] = share1[9] ^ (share1[2] & g2[3]) ^ (share1[3] & g2[2]);
    assign Sop_out2[9] = reg_rnd [9] ^ (reg_rnd [2] & g2[3]) ^ (reg_rnd [3] & g2[2]) ^ g2[9];

    ///----
    assign Sop_out0[10] = Sop_out0[4] & g2[2] ^ share0[10] ^ share0[5] & g2[1] ^ 
           share0[7] & g2[0] ^ share0[2] & g2[4];
    assign Sop_out1[10] = Sop_out1[4] & g2[2] ^ share1[10] ^ share1[5] & g2[1] ^ 
           share1[7] & g2[0] ^ share1[2] & g2[4];
    assign Sop_out2[10] = Sop_out2[4] & g2[2] ^ reg_rnd[10] ^ reg_rnd[5] & g2[1] ^ reg_rnd[7] & g2[0] ^ reg_rnd[2] & g2[4];
    
    assign Sop_out0[11] = Sop_out0[4] & g2[3] ^ share0[11] ^ share0[6] & g2[1] ^ 
           share0[8] & g2[0] ^ share0[3] & g2[4];
    assign Sop_out1[11] = Sop_out1[4] & g2[3] ^ share1[11] ^ share1[6] & g2[1] ^ 
           share1[8] & g2[0] ^ share1[3] & g2[4];
    assign Sop_out2[11] = Sop_out2[4] & g2[3] ^ reg_rnd[11] ^ reg_rnd[6] & g2[1] ^ reg_rnd[8] & g2[0] ^ reg_rnd[3] & g2[4];
     
    assign Sop_out0[12] = Sop_out0[5] & g2[3] ^ share0[12] ^ share0[6] & g2[2] ^ 
           share0[9] & g2[0] ^ share0[3] & g2[5];
    assign Sop_out1[12] = Sop_out1[5] & g2[3] ^ share1[12] ^ share1[6] & g2[2] ^ 
           share1[9] & g2[0] ^ share1[3] & g2[5];
    assign Sop_out2[12] = Sop_out2[5] & g2[3] ^ reg_rnd[12] ^ reg_rnd[6] & g2[2] ^ reg_rnd[9] & g2[0] ^ reg_rnd[3] & g2[5];

    assign Sop_out0[13] = Sop_out0[7] & g2[3] ^ share0[13] ^ share0[8] & g2[2] ^ 
           share0[9] & g2[1] ^ share0[3] & g2[7];
    assign Sop_out1[13] = Sop_out1[7] & g2[3] ^ share1[13] ^ share1[8] & g2[2] ^ 
           share1[9] & g2[1] ^ share1[3] & g2[7];
    assign Sop_out2[13] = Sop_out2[7] & g2[3] ^ reg_rnd[13] ^ reg_rnd[8] & g2[2] ^ reg_rnd[9] & g2[1] ^ reg_rnd[3] & g2[7];

endmodule