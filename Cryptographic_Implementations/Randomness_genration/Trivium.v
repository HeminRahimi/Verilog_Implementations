module trivium (clk, reset, iv, k, Out);

    input  reset, clk;
    input [79 : 0] k, iv;
    output Out;

    //reg [287:0] state;
    reg [0 : 92] A;
    reg [0 : 83] B;
    reg [0 : 110] C;
    wire to_regA, from_regA, XorA2XorB,
    to_regB, from_regB, XorB2XorC,
    to_regC, from_regC, XorC2XorA;
    
    assign to_regA = A[68] ^ XorC2XorA;
    assign XorA2XorB = (A[90] & A[91]) ^ A[65] ^ A[92];
    
    assign to_regB = B[77] ^ XorA2XorB;
    assign XorB2XorC = B[68] ^ B[83] ^ (B[81] & B[82]);
    
    assign to_regC = C[86] ^ XorB2XorC;
    assign XorC2XorA = C[65] ^ C[110] ^ (C[108] & C[109]);
    
    always @ (posedge clk) begin
        if (reset)
        begin
            A <= 93'b0;
            A [0 : 79] <= iv;
            B <= 84'b0;
            B [0 : 79] <= k;
            C <= 0;
            C[108 : 110] <= 3'b111;
 
        end
        else
        begin
            A <= {to_regA, A[0 : 91]};
            B <= {to_regB, B[0 : 82]};
            C <= {to_regC, C[0 : 109]};
        end
    end
    
    assign Out = (A[65] ^ A[92]) ^ (B[68] ^ B[83]) ^ (C[65] ^ C[110]) ;
    
endmodule
