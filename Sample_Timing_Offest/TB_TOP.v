`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////

module TB_TOP( );
    reg clk, reset, go;
    reg [11 : 0] Ng, Nfft, com_delay;
    wire [11 : 0] est_STO;
    wire done;
    
    STO_Estimator UUT (clk, reset, go, com_delay, Ng, Nfft, est_STO, done);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 1 ; reset = 0 ; go = 0 ;  
        com_delay = 32; Nfft = 128; Ng = 32;
        #10;
        go = 1 ; #10;
        go = 0 ; #51000;
        $stop;
    end

endmodule
