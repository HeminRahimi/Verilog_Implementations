`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Combiner(real_part, img_part, y);
    input[23:0] real_part, img_part;
    output [47:0] y;
    
    assign y = {img_part , real_part};   
  
endmodule