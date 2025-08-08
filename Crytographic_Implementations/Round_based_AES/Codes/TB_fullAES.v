`timescale 1ns / 1ps
//////// -------- //////////
module TB_top_AES( );
    reg clk, reset, go;
    reg [15 : 0] pt_shared, key_shared;
    reg [18 : 0] PRNG;
    wire done;
    wire [255 : 0] Output_shared;

    full_AES SUT (clk, reset, go, PRNG, pt_shared, key_shared, Output_shared, done);
    reg [127 : 0] pt_share1, pt_share0;
    reg [127 : 0] key_share1, key_share0;
    initial begin

    end

    always #5 clk = ~clk;
    always #10 PRNG = $random;
    initial begin

        $dumpfile("AES.vcd");
        $dumpvars(0, TB_top_AES);
        
        ////-- expected output for ALL-ZERO inputs : '66 E9 4B D4 EF 8A 2C 3B 88 4C FA 59 CA 34 2B 2E' 
        clk = 0 ; reset = 1; #10;
        reset = 0 ;
        go = 1;
        PRNG = $random;
        #10;
        go = 0;
        repeat (16) begin
            pt_shared = 16'h00;
            key_shared = 16'h00;
            #10;
            
        end
        #2600;
        $finish;
    end

    wire [127 : 0] KEY_unshared, PT_unshared;
    assign KEY_unshared = key_shared[255 : 128] ^ key_shared[127 : 0];
    assign PT_unshared = pt_shared[255 : 128] ^ pt_shared[127 : 0];
    wire [127 : 0] OUTPUT_unshared;
    assign OUTPUT_unshared = Output_shared[255 : 128] ^ Output_shared[127 : 0] ;

endmodule
