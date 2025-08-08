
module inversion (X, Out);
    input [0 : 7] X;
    output [7 : 0] Out;

    wire [45 : 0] t;
    wire [17 : 0] z;
    wire y1, y2, y3, y4, y5, y6, y7, y8, y9, y10,
    y11, y12, y13, y14, y15, y16, y17, y18, y19,
    y20, y21;

    // linear transformation U 
    assign t[0] = X[1] ^ X[2];
    assign t[1] = X[4] ^ y12;
    assign y1 = t[0] ^ X[7];
    assign y2 = y1 ^ X[0];
    assign y3 = y5 ^ y8;
    assign y4 = y1 ^ X[3];
    assign y5 = y1 ^ X[6];
    assign y6 = y15 ^ X[7];
    assign y7 = X[7] ^ y11;
    assign y8 = X[0] ^ X[5];
    assign y9 = X[0] ^ X[3];
    assign y10 = y15 ^ t[0];
    assign y11 = y20 ^ y9;
    assign y12 = y13 ^ y14;
    assign y13 = X[0] ^ X[6];
    assign y14 = X[3] ^ X[5];
    assign y15 = t[1] ^ X[5];
    assign y16 = t[0] ^ y11;
    assign y17 = y10 ^ y11;
    assign y18 = X[0] ^ y16;
    assign y19 = y10 ^ y8;
    assign y20 = t[1] ^ X[1];
    assign y21 = y13 ^ y16;


    // nonlinear middle part
    assign t[2] = y12 & y15;
    assign t[3] = y3 & y6;
    assign t[4] = t[3] ^ t[2];
    assign t[5] = y4 & X[7];
    assign t[6] = t[5] ^ t[2];
    assign t[7] = y13 & y16;
    assign t[8] = y5 & y1;
    assign t[9] = t[8] ^ t[7];
    assign t[10] = y2 & y7;
    assign t[11] = t[10] ^ t[7];
    assign t[12] = y9 & y11;
    assign t[13] = y14 & y17;
    assign t[14] = t[13] ^ t[12];
    assign t[15] = y8 & y10;
    assign t[16] = t[15] ^ t[12];
    assign t[17] = t[4] ^ t[14];
    assign t[18] = t[6] ^ t[16];
    assign t[19] = t[9] ^ t[14];
    assign t[20] = t[11] ^ t[16];
    assign t[21] = t[17] ^ y20;
    assign t[22] = t[18] ^ y19;
    assign t[23] = t[19] ^ y21;
    assign t[24] = t[20] ^ y18;
    assign t[25] = t[21] ^ t[22];
    assign t[26] = t[21] & t[23];
    assign t[27] = t[24] ^ t[26];
    assign t[28] = t[25] & t[27];
    assign t[29] = t[28] ^ t[22];
    assign t[30] = t[23] ^ t[24];
    assign t[31] = t[22] ^ t[26];
    assign t[32] = t[31] & t[30];
    assign t[33] = t[32] ^ t[24];
    assign t[34] = t[23] ^ t[33];
    assign t[35] = t[27] ^ t[33];
    assign t[36] = t[24] & t[35];
    assign t[37] = t[36] ^ t[34];
    assign t[38]= t[27] ^ t[36];
    assign t[39] = t[29] & t[38];
    assign t[40]  = t[25] ^ t[39];
    assign t[41] = t[40] ^ t[37];
    assign t[42] = t[29] ^ t[33];
    assign t[43] = t[29] ^ t[40];
    assign t[44] = t[33] ^ t[37];
    assign t[45] = t[42] ^ t[41];

    assign z[0] = t[44] & y15;
    assign z[1] = t[37] & y6;
    assign z[2] = t[33] & X[7];
    assign z[3] = t[43] & y16;
    assign z[4] = t[40] & y1;
    assign z[5] = t[29] & y7;
    assign z[6] = t[42] & y11;
    assign z[7] = t[45] & y17;
    assign z[8] = t[41] & y10;
    assign z[9] = t[44] & y12;
    assign z[10] = t[37] & y3;
    assign z[11] = t[33] & y4;
    assign z[12] = t[43] & y13;
    assign z[13] = t[40] & y5;
    assign z[14] = t[29] & y2;
    assign z[15] = t[42] & y9;
    assign z[16] = t[45] & y14;
    assign z[17] = t[41] & y8;


    assign Out[0] = z[9] ^ z[11] ^ z[15] ^ z[17] ;

    assign Out[1] = z[3] ^ z[4] ^ z[6] ^ z[7] ^ z[12] ^ z[13] ^ z[15] ^ z[16];

    assign Out[2] = z[0] ^ z[1] ^ z[4] ^ z[5] ^ z[6] ^ z[8] ^ z[12] ^ z[13] ^
    z[15] ^ z[16];

    assign Out[3] = z[0] ^ z[2] ^ z[4] ^ z[5] ^ z[6] ^ z[7] ^ z[10] ^ z[11] ^
    z[12] ^ z[13] ^ z[15] ^ z[17];

    assign Out[4] = z[0] ^ z[2] ^ z[6] ^ z[8] ^ z[12] ^ z[13] ^ z[15] ^ z[16] ;

    assign Out[5] = z[1] ^ z[2] ^ z[3] ^ z[4] ^ z[6] ^ z[8] ^ z[10] ^ z[11] ^
    z[12] ^ z[14] ^ z[15] ^ z[16];

    assign Out[6] = z[1] ^ z[2] ^ z[3] ^ z[4] ^ z[6] ^ z[8] ^ z[9] ^ z[10] ^
    z[13] ^ z[14]^ z[15] ^ z[17];

    assign Out[7] = z[3] ^ z[5] ^ z[6] ^ z[8] ^ z[12] ^ z[13] ^ z[15] ^ z[16] ;


endmodule

///////////////////////