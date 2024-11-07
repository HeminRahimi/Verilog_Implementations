module up_cnt #( parameter N = 12) (upper_band, cen, rst, clk, Out, cntf);
    input cen, clk, rst;
    input [(N - 1) : 0] upper_band;
    output cntf;
    output reg [(N - 1) : 0] Out;
    
    always @ (posedge clk) begin
        if (rst)
            Out <= 0;
        else if (cen)
            Out  <= Out + 1;        
        else
            Out <= Out;
    end
    
    assign cntf = (Out == upper_band-50) ? (1'b1) : (1'b0);
    
endmodule