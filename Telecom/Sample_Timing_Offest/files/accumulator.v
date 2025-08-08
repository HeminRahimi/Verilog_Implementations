`timescale 1ns / 1ps
///////////////////////
module accumulatorN #(parameter N = 18)(clk,
    inp, reg_rst, reg_ld, out);
    input [N-1 : 0] inp;
    input clk, reg_rst, reg_ld;
    output [N-1 : 0] out;

    wire [N-1 : 0] reg_out, adder_out;

    adderN #(N) D0 (inp, reg_out, adder_out);
    regN  #(N) D1 (clk, reg_rst, reg_ld,
        adder_out, reg_out);

    assign out = reg_out ;
endmodule
