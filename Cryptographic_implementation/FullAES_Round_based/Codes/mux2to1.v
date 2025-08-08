module mux_2to1 #(parameter N = 8)  (a, b, sel, y);
    input [N-1 : 0] a, b;
    input sel;
    output [N-1 : 0] y;

    assign y = (sel) ? (b) : (a);

endmodule