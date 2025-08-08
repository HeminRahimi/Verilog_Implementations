

/////////////////////////////////////////////
module mix_columns (b0, b1, b2, b3, c0, c1, c2, c3);

    input [7:0] b0, b1, b2, b3;

    output reg [7:0] c0, c1, c2, c3;

    reg [7:0] mult_2b0;
    reg [7:0] mult_2b1;
    reg [7:0] mult_2b2;
    reg [7:0] mult_2b3;
    reg [7:0] mult_3b0;
    reg [7:0] mult_3b1;
    reg [7:0] mult_3b2;
    reg [7:0] mult_3b3;

    always @ (*) begin

        // 2*b0
        mult_2b0[0] = b0[7];
        mult_2b0[1] = b0[0] ^ b0[7];
        mult_2b0[2] = b0[1];
        mult_2b0[3] = b0[2] ^ b0[7];
        mult_2b0[4] = b0[3] ^ b0[7];
        mult_2b0[5] = b0[4];
        mult_2b0[6] = b0[5];
        mult_2b0[7] = b0[6];

        // 2*b1
        mult_2b1[0] = b1[7];
        mult_2b1[1] = b1[0] ^ b1[7];
        mult_2b1[2] = b1[1];
        mult_2b1[3] = b1[2] ^ b1[7];
        mult_2b1[4] = b1[3] ^ b1[7];
        mult_2b1[5] = b1[4];
        mult_2b1[6] = b1[5];
        mult_2b1[7] = b1[6];

        // 2*b2
        mult_2b2[0] = b2[7];
        mult_2b2[1] = b2[0] ^ b2[7];
        mult_2b2[2] = b2[1];
        mult_2b2[3] = b2[2] ^ b2[7];
        mult_2b2[4] = b2[3] ^ b2[7];
        mult_2b2[5] = b2[4];
        mult_2b2[6] = b2[5];
        mult_2b2[7] = b2[6];

        // 2*b3
        mult_2b3[0] = b3[7];
        mult_2b3[1] = b3[0] ^ b3[7];
        mult_2b3[2] = b3[1];
        mult_2b3[3] = b3[2] ^ b3[7];
        mult_2b3[4] = b3[3] ^ b3[7];
        mult_2b3[5] = b3[4];
        mult_2b3[6] = b3[5];
        mult_2b3[7] = b3[6];

        // 3*b0 = 2 * b0 + b0
        mult_3b0 = mult_2b0 ^ b0;

        // 3*b1 = 2 * b1 + b1
        mult_3b1 = mult_2b1 ^ b1;

        // 3*b2 = 2 * b2 + b2
        mult_3b2 = mult_2b2 ^ b2;

        // 3*b3 = 2 * b3 + b3
        mult_3b3 = mult_2b3 ^ b3;

        // c0 = 2*b0 + 3*b1 + 1*b2 + 1*b3
        c0 = mult_2b0 ^ mult_3b1 ^ b2 ^ b3;

        // c1 = 1*b0 + 2*b1 + 3*b2 + 1*b3
        c1 = b0 ^ mult_2b1 ^ mult_3b2 ^ b3;

        // c2 = 1*b0 + 1*b1 + 2*b2 + 3*b3
        c2 = b0 ^ b1 ^ mult_2b2 ^ mult_3b3;

        // c3 = 3*b0 + 1*b1 + 1*b2 + 2*b3
        c3 = mult_3b0 ^ b1 ^ b2 ^ mult_2b3;
    end

endmodule
