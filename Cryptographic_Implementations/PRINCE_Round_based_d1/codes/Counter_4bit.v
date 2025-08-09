module Counter_4bit(clk, rst, start, y);
    input clk, rst, start;
    output [3 : 0] y;
    
    reg [3 : 0] r_y;
    assign y = r_y ;
    
    always @ (posedge clk) begin
        if (rst)
            r_y <= 4'b0010;
        else begin
            if (start)
                r_y <= r_y + 1;
            else
                r_y <= r_y;
        end    
    end
endmodule
