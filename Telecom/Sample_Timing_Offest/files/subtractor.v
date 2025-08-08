`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module subtractor18(a, b, y);
    input signed [17 : 0] a, b;
    output signed [17 : 0] y;
    
    assign y = a - b;
endmodule
