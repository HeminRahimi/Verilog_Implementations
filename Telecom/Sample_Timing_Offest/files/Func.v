`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Func(clk, in_valid, r1, i1, r2, i2, out_data, out_valid);
    input clk, in_valid;
    input [8 : 0] r1, i1, r2, i2;
    output [35 : 0] out_data;
    output out_valid;
    
    wire [17 : 0] addout1, addout2, subout, sqrtout1,sqrtout2, 
         pow_out1, pow_out2, pow_out3, pow_out4; 
         
    pow_918 p1 (r1, r1, pow_out1);
    pow_918 p2 (i1, i1, pow_out2);
    pow_918 p3 (r2, r2, pow_out3);
    pow_918 p4 (i2, i2, pow_out4);

    adderN #(18) add_inst1  ({pow_out1[16:0],1'b0}, {pow_out2[16:0],1'b0}, addout1);
    adderN #(18) add_inst2 ({pow_out3[16:0],1'b0}, {pow_out4[16:0],1'b0}, addout2);
     
    sqrt sq1 (in_valid, {addout1[17], addout1[15:0], 1'b0}, out_valid, sqrtout1);
    sqrt sq2 (in_valid, {addout2[17], addout2[15:0], 1'b0}, out_valid, sqrtout2);

    subtractor18 sub_inst (sqrtout1, sqrtout2, subout); 
    
    pow_1836 p_final (subout, subout, out_data);
    
endmodule
