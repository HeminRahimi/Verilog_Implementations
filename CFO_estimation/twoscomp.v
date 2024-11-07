`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module negation(inp, out);
    input [8 : 0] inp;
    output reg [8 : 0] out;
    always @(*) begin
        out = ~inp + 1;
    end
    
endmodule
