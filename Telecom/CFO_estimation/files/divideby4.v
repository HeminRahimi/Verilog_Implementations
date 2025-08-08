`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module divideby4(inp, out);
    input [23 : 0] inp;
    output [11 : 0] out;
    
        assign out = (inp[23]) ? ({2'b11, inp[23 : 12]}) : ({2'b00, inp[23 : 12]});
        
endmodule
