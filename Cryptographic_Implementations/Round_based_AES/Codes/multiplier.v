
module gf256_multiplier (a, b, result);

    input [7:0] a;
    input [7:0] b;
    output reg [7:0] result;

    reg [15:0] product;
    reg [3 : 0] i;

    always @ (*) begin
        product = 0;
        for (i = 0; i < 8; i = i + 1) begin
            if (b[i] == 1) begin
                product = product ^ (a << i);
            end
        end

        for (i = 15; i >= 8; i = i - 1) begin
            if (product[i] == 1) begin
                product = product ^ (9'h11B << (i - 8));
            end
        end

        result = product[7:0];
    end

endmodule
