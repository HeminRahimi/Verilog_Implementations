
module MAC (act0, act1, act2, weight0, weight1, weight2, clk, rst, load, mac_out);

    input clk, rst, load;
    input signed [7 : 0] act0, act1, act2, weight0, weight1, weight2;
    output reg signed [31 : 0] mac_out;

    wire signed [15 : 0] mult0_out, mult1_out, mult2_out;
    assign mult0_out = act0 * weight0;
    assign mult1_out = act1 * weight1;
    assign mult2_out = act2 * weight2;
    
    always @ (posedge clk) begin
        if (rst)
            mac_out <= 32'b0;
        else begin
            if (load)
                mac_out <= mac_out + mult0_out + mult1_out + mult2_out;
        end
    end
    
endmodule