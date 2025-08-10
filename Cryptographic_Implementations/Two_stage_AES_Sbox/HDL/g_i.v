module gi_prime (inp, rnd_val, out);
  
    input [3 : 0] inp;
    input [14 : 0] rnd_val;
    output [14 : 0] out;

    wire a_0, b_0, c_0, d_0;
    assign {a_0, b_0, c_0, d_0} = inp;

    assign out[0] = a_0 ^ rnd_val[0];
    assign out[1] = b_0 ^ rnd_val[1];
    assign out[2] = c_0 ^ rnd_val[2];
    assign out[3] = d_0 ^ rnd_val[3];

    assign out[4] = a_0 & b_0 ^ rnd_val[4];
    assign out[5] = a_0 & c_0 ^ rnd_val[5];
    assign out[6] = a_0 & d_0 ^ rnd_val[6];
    assign out[7] = b_0 & c_0 ^ rnd_val[7];
    assign out[8] = b_0 & d_0 ^ rnd_val[8];
    assign out[9] = c_0 & d_0 ^ rnd_val[9];

    assign out[10] = a_0 & b_0 & c_0 ^ rnd_val[10];
    assign out[11] = a_0 & b_0 & d_0 ^ rnd_val[11];
    assign out[12] = a_0 & c_0 & d_0 ^ rnd_val[12];
    assign out[13] = b_0 & c_0 & d_0 ^ rnd_val[13];
    assign out[14] = a_0 & b_0 & c_0 & d_0 ^ rnd_val[14];

endmodule
