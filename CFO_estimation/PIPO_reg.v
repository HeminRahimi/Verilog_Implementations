`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PIPO_reg(inp_r, inp_i, clk, ld_in, rst, real_out, img_out);
    input clk, rst, ld_in;
    input [23 : 0] inp_r, inp_i;
    
    output reg[23 : 0] real_out, img_out;
    
    always @ (posedge clk) begin
        if (rst) begin
            real_out <= 0;
            img_out <= 0;
        end
        else if (ld_in) begin
            real_out <= inp_r;
            img_out <= inp_i;
        end
        else begin
            real_out <= real_out;
            img_out <= img_out;
        end
    end
    
endmodule
