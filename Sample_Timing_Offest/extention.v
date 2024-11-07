`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module extention(inp, out);

    input [8 : 0] inp;
    output [15 : 0] out;
    
    assign out = {9'b0000000, inp};
    
endmodule
