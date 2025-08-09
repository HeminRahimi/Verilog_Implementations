`timescale 1ns / 1ps
///////////////////////////
module TB_TOP();

    reg clk, reset, go, Dec_EncBar;
    reg [287 : 0] PRNG;
    reg [63 : 0] inp_share0, inp_share1;
    reg [127 : 0] key;
    wire [63 : 0] out_share0, out_share1;
    wire done;

    PRINCE MUT (clk, reset, go, Dec_EncBar, PRNG, inp_share0, 
    inp_share1, key, out_share0, out_share1, done);

    always #5 clk = ~clk;
    always #10 PRNG = {$random, $random, $random, $random, 
    $random, $random, $random, $random, $random};

    initial begin
        $dumpfile("PRINCE.vcd");
        $dumpvars(0, TB_TOP);
        
        clk = 0 ; #5;
        Dec_EncBar = 0; // Enc mode
        reset = 0 ; go = 0;
        key = 128'h0;
        inp_share0 = 0;
        inp_share1 = 0;
        #10;
        go = 1;
        #10;
        go = 0;
        #150;
        
        reset = 1 ; #10; reset = 0;
        inp_share0 = 64'hEEEEEEEEEEEEEEEE;
        inp_share1 = 64'h1111111111111111;
        #10;
        go = 1;
        #10;
        go = 0;
        #150;    // Ciphertext : 604ae6ca03c20ada

        Dec_EncBar = 1; // Dec mode
        reset = 1;
        inp_share0 = 64'h604ae6ca03c20ada;
        inp_share1 = 64'h0;
        #10;
        reset = 0; go = 1;
        #10;
        go = 0;
        #150;

        $finish;
    end

    wire [63 : 0] Out_unshared;
    assign Out_unshared = out_share0 ^ out_share1;
    
endmodule
