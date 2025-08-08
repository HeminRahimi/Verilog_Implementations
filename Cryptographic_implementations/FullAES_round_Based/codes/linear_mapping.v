
module linear_mapping(b, out);

    input [7:0] b;
    output [7:0] out;

    wire  a0, a1, a2, a3, a4, a5, a6, a7;

    assign a0 = b[0] ^ b[4] ^ b[5] ^ b[6] ^ b[7] ;
    assign a1 = b[1] ^ b[5] ^ b[6] ^ b[7] ^ b[0] ;
    assign a2 = b[2] ^ b[6] ^ b[7] ^ b[0] ^ b[1] ;
    assign a3 = b[3] ^ b[7] ^ b[0] ^ b[1] ^ b[2] ;
    assign a4 = b[4] ^ b[0] ^ b[1] ^ b[2] ^ b[3] ;
    assign a5 = b[5] ^ b[1] ^ b[2] ^ b[3] ^ b[4] ;
    assign a6 = b[6] ^ b[2] ^ b[3] ^ b[4] ^ b[5] ;
    assign a7 = b[7] ^ b[3] ^ b[4] ^ b[5] ^ b[6] ;

    assign out = {a7, a6, a5, a4, a3, a2, a1, a0};

endmodule
