`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Re_me (clk, mode, address, offset, out1, out2);

    input clk, mode;
    input [11:0] address, offset; 
    output reg [8:0] out1, out2;
    
    reg [8:0] Mem [0:5119];
    
    always @ (posedge clk) begin
        if (mode) begin
            out1 <= Mem [address];
            out2 <= Mem [address + offset];
        end
        
        else 
            out1 <= Mem [address];
     end
     
     initial begin $readmemb("real_data.txt", Mem); end
     
endmodule


module Img_me (clk, mode, address, offset, out1, out2);

    input clk, mode;
    input [11:0] address, offset; 
    output reg [8:0] out1, out2;
    
    reg [8:0] Mem [0:5119];
    
    always @ (posedge clk) begin
    
        if (mode) begin
            out1 <= Mem [address];
            out2 <= Mem [address + offset];
        end
        
        else 
            out1 <= Mem [address];
     end
     
     initial begin $readmemb("img_data.txt", Mem); end
     
endmodule
