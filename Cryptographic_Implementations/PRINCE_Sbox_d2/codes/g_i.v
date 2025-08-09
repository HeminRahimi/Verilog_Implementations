
module gi_func (inp, out);

    input [3 : 0] inp;
    output [13 : 0] out;

    wire a, b, c, d;
    assign {a, b, c, d} = inp;
    
    assign out[0] = a ;
    assign out[1] = b ;
    assign out[2] = c ;
    assign out[3] = d ;

    assign out[4] = a & b ;
    assign out[5] = a & c ;
    assign out[6] = a & d ;
    assign out[7] = b & c ;
    assign out[8] = b & d ;
    assign out[9] = c & d ;

    assign out[10] = a & b & c ;
    assign out[11] = a & b & d ;
    assign out[12] = a & c & d ;
    assign out[13] = b & c & d ;

endmodule  