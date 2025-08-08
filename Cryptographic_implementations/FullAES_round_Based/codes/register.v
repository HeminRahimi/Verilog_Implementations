
module register #(parameter N = 1)(in, clk, out);
    input [N-1 : 0] in;
    input clk;
    output [N-1 : 0] out;

    reg [N-1 : 0] r_out;
    assign out = r_out;

    always @ (posedge clk) begin
        r_out <= in;
    end

endmodule