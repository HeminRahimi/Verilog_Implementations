
module M_prime (state, out);
    input  [63:0] state;
    output [63:0] out;


    assign out =
    {
    state[59] ^ state[55] ^ state[51],
    state[62] ^ state[54] ^ state[50],
    state[61] ^ state[57] ^ state[49],
    state[60] ^ state[56] ^ state[52],
    
    state[63] ^ state[59] ^ state[55],
    state[58] ^ state[54] ^ state[50],
    state[61] ^ state[53] ^ state[49],
    state[60] ^ state[56] ^ state[48],
    
    state[63] ^ state[59] ^ state[51],
    state[62] ^ state[58] ^ state[54],
    state[57] ^ state[53] ^ state[49],
    state[60] ^ state[52] ^ state[48],
    
    state[63] ^ state[55] ^ state[51],
    state[62] ^ state[58] ^ state[50],
    state[61] ^ state[57] ^ state[53],
    state[56] ^ state[52] ^ state[48],
    
    state[47] ^ state[43] ^ state[39],
    state[42] ^ state[38] ^ state[34],
    state[45] ^ state[37] ^ state[33],
    state[44] ^ state[40] ^ state[32],
    
    state[47] ^ state[43] ^ state[35],
    state[46] ^ state[42] ^ state[38],
    state[41] ^ state[37] ^ state[33],
    state[44] ^ state[36] ^ state[32],
    
    state[47] ^ state[39] ^ state[35],
    state[46] ^ state[42] ^ state[34],
    state[45] ^ state[41] ^ state[37],
    state[40] ^ state[36] ^ state[32],
    
    state[43] ^ state[39] ^ state[35],
    state[46] ^ state[38] ^ state[34],
    state[45] ^ state[41] ^ state[33],
    state[44] ^ state[40] ^ state[36],
    
    state[31] ^ state[27] ^ state[23],
    state[26] ^ state[22] ^ state[18],
    state[29] ^ state[21] ^ state[17],
    state[28] ^ state[24] ^ state[16],
    
    state[31] ^ state[27] ^ state[19],
    state[30] ^ state[26] ^ state[22],
    state[25] ^ state[21] ^ state[17],
    state[28] ^ state[20] ^ state[16],
    
    state[31] ^ state[23] ^ state[19],
    state[30] ^ state[26] ^ state[18],
    state[29] ^ state[25] ^ state[21],
    state[24] ^ state[20] ^ state[16],
    
    state[27] ^ state[23] ^ state[19],
    state[30] ^ state[22] ^ state[18],
    state[29] ^ state[25] ^ state[17],
    state[28] ^ state[24] ^ state[20],
    
    state[11] ^ state[7] ^ state[3],
    state[14] ^ state[6] ^ state[2],
    state[13] ^ state[9] ^ state[1],
    state[12] ^ state[8] ^ state[4],
    
    state[15] ^ state[11] ^ state[7],
    state[10] ^ state[6] ^ state[2],
    state[13] ^ state[5] ^ state[1],
    state[12] ^ state[8] ^ state[0],
    
    state[15] ^ state[11] ^ state[3],
    state[14] ^ state[10] ^ state[6],
    state[9] ^ state[5] ^ state[1],
    state[12] ^ state[4] ^ state[0],
    
    state[15] ^ state[7] ^ state[3],
    state[14] ^ state[10] ^ state[2],
    state[13] ^ state[9] ^ state[5],
    state[8] ^ state[4] ^ state[0]
    };

endmodule