
module Adder (Ar, Ai, Br, Bi, Yr, Yi);
    input signed [23 : 0] Ar, Ai, Br, Bi;
    output signed [23 : 0] Yr, Yi;
    
    assign Yr = Ar + Br;
    assign Yi = Ai + Bi;
    
endmodule   