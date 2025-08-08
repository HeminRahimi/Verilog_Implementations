`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module regN #(parameter N = 36) (clk,
    rst, ld, inp, out);
    input clk, ld, rst;
    input [N-1 : 0] inp;
    output reg [N-1 : 0] out;

    always @ (posedge clk) begin
        if (rst)
            out <= 0;
        else begin
            if (ld)
                out <= inp;
            else
                out <= out;
        end
    end
endmodule
