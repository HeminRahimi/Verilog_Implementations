module A0 (state, out);
    input [3 : 0] state;
    output [3 : 0] out;

    assign out[0] = 1 ^ state [1];
    assign out[1] = state [0] ^ state [1] ^ state [2];
    assign out[2] = 1 ^ state [3];
    assign out[3] = state [2];
    
endmodule

////////////////-----------/////////////////

module A1 (state, out);
    input [3 : 0] state;
    output [3 : 0] out;

    assign out[0] = state [1];
    assign out[1] = state [0] ^ state [1] ^ state [2];
    assign out[2] = state [3];
    assign out[3] = state [2];
    
endmodule

////////////////-----------/////////////////

module A_share0 (state, out);
    input  [63 : 0] state;
    output [63 : 0] out;

    genvar i;
    generate
        for (i = 0 ; i < 16 ; i = i + 1) begin : A_blks_sh0
            A0 inst_in_loop (state[(4 * i) + 3 : 4*i], 
			out[(4 * i) + 3 : 4*i]);
        end
    endgenerate

endmodule 

////////////////-----------////////////////

module A_share1 (state, out);
    input [63 : 0] state;
    output [63 : 0] out;

    genvar i;
    generate
        for (i = 0 ; i < 16 ; i = i + 1) begin : A_blks_sh1
            A1 inst_in_loop (state[(4 * i) + 3 : 4*i], 
			out[(4 * i) + 3 : 4*i]);
        end
    endgenerate

endmodule 
