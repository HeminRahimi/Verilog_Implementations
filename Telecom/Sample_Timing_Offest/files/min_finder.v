`timescale 1ns / 1ps
///////////////////////////////////////////////
module min_finder (clk, rst, en, idx, inp, min_loc);

    input clk, en, rst;
    input [12 : 0] idx;
    input [35 : 0] inp;
    output reg [12:0] min_loc;
    
    reg [35 : 0] min_val;
    
    always @(posedge clk) begin
        if (rst) begin
            min_val <= 36'h3FFFFFFFF;
            min_loc <= 0;
        end
        else begin
            if (en) begin
                if (inp < min_val) begin
                    min_val <= inp;
                    min_loc <= idx;
                end
                else begin
                    min_val <= min_val;
                    min_loc <= min_loc;
                end
            end
        end
    end
endmodule





