`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module TB_CFO();
    reg go, reset, clk;
    reg [11:0] Ng, nfft;
    wire done;
    wire [11:0] cfo;
    
    cfo_calc MUT (Ng, nfft, go, reset, clk, done, cfo);
    
    always #5 clk = ~clk;
    
    initial begin 
        clk = 0; go = 0 ; reset = 0; #5;
        Ng = 256; nfft = 1024; #10;
        reset = 1; #10;
        reset = 0; go = 1; #2700;
        $stop;
    end

endmodule
