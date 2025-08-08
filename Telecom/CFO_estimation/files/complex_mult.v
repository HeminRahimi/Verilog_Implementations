`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Cmplx_Mult #(parameter N = 9)(real1, imag1,
    real2, imag2, real_result, imag_result);

    input signed [N - 1 : 0] real1, real2;
    input signed [N - 1 : 0] imag1, imag2;

    output reg signed [23  : 0] real_result, imag_result;

    reg [23 : 0] t1, t2, t3, t4;

    always @(*) begin

        t1 <= real1 * real2;
        t2 <= imag1 * imag2;
        real_result <= t1 - t2;
        t3 <= real1 * imag2;
        t4 <= imag1 * real2;
        imag_result <= t3 + t4;

    end
endmodule

