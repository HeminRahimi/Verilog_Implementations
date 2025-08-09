
module inp_referesher (inp_share0, inp_share1, inp_share2, rnd, 
    Out_refreshed_inp_sh0, Out_refreshed_inp_sh1, Out_refreshed_inp_sh2);

    input  [3  : 0] inp_share0, inp_share1, inp_share2;
    input  [11 : 0] rnd;
    output [3  : 0] Out_refreshed_inp_sh0, Out_refreshed_inp_sh1, Out_refreshed_inp_sh2;

    wire [ 3 : 0] r0, r1, r2;
    assign r0 = rnd [3  : 0]; 
    assign r1 = rnd [7  : 4];
    assign r2 = rnd [11 : 8];

    assign Out_refreshed_inp_sh0 = inp_share0 ^ r0 ^ r1;
    assign Out_refreshed_inp_sh1 = inp_share1 ^ r1 ^ r2;
    assign Out_refreshed_inp_sh2 = inp_share2 ^ r0 ^ r2;

endmodule
