`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module adderN #(parameter N = 18)(a, b, y);
    input   [N - 1 : 0] a, b;
    output  [N - 1 : 0] y;
    
    assign y = a + b;
    
endmodule

