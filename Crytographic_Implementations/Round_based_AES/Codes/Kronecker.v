module kronecker (clk, inp, rand, Z);
    input clk;
    input  [2 : 0] rand;
    input  [15 : 0] inp;
    output [1 : 0] Z;

    wire [1 : 0] w1, w2, w3, w4, w5, w6;
    wire r1, r2, r3, r4, r5, r6, r7;
    wire [1 : 0] bx0, by0, bx1, by1,
        bx2, by2, bx3, by3, tmp_out;
    wire [7 : 0] share0, share1;

    assign r1 = rand[0];
    assign r2 = rand[1];
    assign r3 = r1;
    assign r4 = r3;
    assign r5 = rand[2];
    register #(1) inst_r6 (r2 ^ r5, clk, r6);
    assign r7 = r1;

    assign share0 = inp[7 : 0];
    assign share1 = inp[15 : 8];

    assign bx0 = {share0[0], ~share1[0]};
    assign by0 = {share0[1], ~share1[1]};
    assign bx1 = {share0[2], ~share1[2]};
    assign by1 = {share0[3], ~share1[3]};
    assign bx2 = {share0[4], ~share1[4]};
    assign by2 = {share0[5], ~share1[5]};
    assign bx3 = {share0[6], ~share1[6]};
    assign by3 = {share0[7], ~share1[7]};

    And_DOM_indep_d1 G1 (bx0, by0, r1, clk, w1);
    And_DOM_indep_d1 G2 (bx1, by1, r2, clk, w2);
    And_DOM_indep_d1 G3 (bx2, by2, r3, clk, w3);
    And_DOM_indep_d1 G4 (bx3, by3, r4, clk, w4);
    And_DOM_indep_d1 G5 (w1, w2, r5, clk, w5);
    And_DOM_indep_d1 G6 (w3, w4, r6, clk, w6);
    And_DOM_indep_d1 G7 (w5, w6, r7, clk, Z);

endmodule