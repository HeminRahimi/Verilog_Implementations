module MUX (a, b, sel, y);

    input sel;
    input signed [7 : 0] a, b;
    output signed [7 : 0] y;
    
    assign y = (sel) ? (b) : (a);
 
endmodule 