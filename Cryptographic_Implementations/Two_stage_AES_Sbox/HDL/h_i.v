module h_i (inp, out);
  
    input [3 : 0] inp;
    output [14 : 0] out;
                                
    wire a_1, b_1, c_1, d_1;
    assign {a_1, b_1, c_1, d_1} = inp;
                                
    assign out[0] = a_1;
    assign out[1] = b_1;
    assign out[2] = c_1;
    assign out[3] = d_1;
                                
    assign out[4] = a_1 & b_1;
    assign out[5] = a_1 & c_1;
    assign out[6] = a_1 & d_1;
    assign out[7] = b_1 & c_1;
    assign out[8] = b_1 & d_1;
    assign out[9] = c_1 & d_1;
                                
    assign out[10] = a_1 & b_1 & c_1;
    assign out[11] = a_1 & b_1 & d_1;
    assign out[12] = a_1 & c_1 & d_1;
    assign out[13] = b_1 & c_1 & d_1;
    assign out[14] = a_1 & b_1 & c_1 & d_1;
                                
endmodule
