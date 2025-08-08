module round_counting (clk, rst, en, round_num);
    input clk, rst, en;
    output [3 : 0] round_num;

    reg [3 : 0] cnt;
    assign round_num = cnt;

    always @ (posedge clk) begin
        if (rst)
            cnt <= 0;
        else begin
            if (en)
                cnt <= cnt + 1;
            else
                cnt <= cnt;
        end
    end

endmodule
