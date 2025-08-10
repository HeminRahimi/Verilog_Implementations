module Register #(parameter N = 1)(in, clk, out);
                                    
    input [N-1 : 0] in;
    input clk;
    output reg [N-1 : 0] out;
                                    
    always @ (posedge clk) begin
        out <= in;
    end
                                    
endmodule
