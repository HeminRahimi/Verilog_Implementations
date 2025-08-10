module inp_referesher (inp_shareX, rnd, out_shareX);

    input [3 : 0] inp_shareX, rnd;
    output [3 : 0] out_shareX;

    assign out_shareX[0] = inp_shareX[0] ^ rnd[0];
    assign out_shareX[1] = inp_shareX[1] ^ rnd[1];
    assign out_shareX[2] = inp_shareX[2] ^ rnd[2];
    assign out_shareX[3] = inp_shareX[3] ^ rnd[3];

endmodule
