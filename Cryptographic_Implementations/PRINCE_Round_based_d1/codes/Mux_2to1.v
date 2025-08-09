module Mux_2to1 #(parameter n = 64) (a, b, sel, y);
    input [n - 1 : 0] a, b;
    input sel;
    output [n - 1 : 0] y;
    
    assign y = (sel) ? (b) : (a) ;
    
endmodule 