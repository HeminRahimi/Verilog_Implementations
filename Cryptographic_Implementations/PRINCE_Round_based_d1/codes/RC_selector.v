module RC_Sel (sel, enc_dec, RC);
    input [3:0] sel;
    input enc_dec;
    output reg [63:0] RC;

    wire [3:0] roundXORenc;
    assign roundXORenc = sel ^ {4{enc_dec}};

    always @(*) begin
        case (roundXORenc)
            4'b0010: RC = 64'h0000000000000000;
            4'b0011: RC = 64'h13198A2E03707344;
            4'b0100: RC = 64'hA4093822299F31D0;
            4'b0101: RC = 64'h082EFA98EC4E6C89;
            4'b0110: RC = 64'h452821E638D01377;
            4'b0111: RC = 64'hBE5466CF34E90C6C;
            4'b1000: RC = 64'h7EF84F78FD955CB1;
            4'b1001: RC = 64'h85840851F1AC43AA;
            4'b1010: RC = 64'hC882D32F25323C54;
            4'b1011: RC = 64'h64A51195E0E3610D;
            4'b1100: RC = 64'hD3B5A399CA0C2399;
            4'b1101: RC = 64'hC0AC29B7C97C50DD;
            default: RC = 64'h0000000000000000; 
        endcase
    end
endmodule
