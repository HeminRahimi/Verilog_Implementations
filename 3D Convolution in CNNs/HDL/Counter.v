//
module counter_upto6 #(parameter N = 1) (clk, rst, en, stride, cnt_out, done);

    input clk, rst, en;
    input [1: 0] stride;
    output [2 : 0] cnt_out;
    output done;
    
    reg [2 : 0] cnt;
    assign cnt_out = cnt;
    
    always @ (posedge clk) begin
    
        if (rst) 
            cnt <= 4'b0;
        else if (en)
            cnt <= cnt + stride;
        else
            cnt <= cnt;
    end
    
    assign done = (cnt_out == N) ? (1'b1) :(1'b0);

endmodule 

////

module counter_window (clk, rst, en, cnt_out, done);

    input clk, rst, en;
    output [3 : 0] cnt_out;
    output done;
    
    reg [3 : 0] cnt;
    assign cnt_out = cnt;
    
    always @ (posedge clk) begin
    
        if (rst) 
            cnt <= 4'b0;
        else if (en)
            cnt <= cnt + 1;
        else
            cnt <= cnt;
    end
    
    assign done = (cnt_out == 4'b1010) ? (1'b1) :(1'b0);

endmodule 