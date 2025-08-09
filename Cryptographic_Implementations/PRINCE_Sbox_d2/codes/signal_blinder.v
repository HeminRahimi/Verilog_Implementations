
module signal_blinder #(parameter N = 14) (inp, rnd, Out_refreshed);

    input  [N - 1 : 0] inp, rnd;
    output [N - 1 : 0] Out_refreshed;
    
    genvar i;
    generate
       for (i = 0 ; i < N ; i = i + 1) begin : gen_blk
           assign Out_refreshed[i] = inp[i] ^ rnd[i];
       end
    endgenerate
    
endmodule

