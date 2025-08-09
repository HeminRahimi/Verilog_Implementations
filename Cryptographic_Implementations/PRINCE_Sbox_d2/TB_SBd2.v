
module TB_SBd2 ();

    reg clk;
    reg [53 : 0] PRNG;
    reg [3 : 0] inp_sh0, inp_sh1, inp_sh2;
    wire [3 : 0] F_sh0, F_sh1, F_sh2;
    
    SB_TSM_d2 MUT (clk, PRNG, inp_sh0, inp_sh1, inp_sh2, F_sh0, F_sh1, F_sh2);
    
    always #5 clk = ~clk;
    always #10 PRNG = {$random, $random};

    reg [3 : 0] cnt;
    initial begin 

       $dumpfile("SB_d2.vcd");
       $dumpvars(0, TB_SBd2);
       
       cnt = 0;
       clk = 0 ;
       PRNG = {$random, $random};
       #10;
       repeat (16) 
       begin 
              inp_sh0 = 0; inp_sh1 = 0 ; inp_sh2 = cnt;
              cnt = cnt + 1;
              #10;
       end
       #40;
       $finish;

    end

    wire [3 : 0] OUT_unshared, INP_unshared;
    assign OUT_unshared = F_sh0 ^ F_sh1 ^ F_sh2;
    assign INP_unshared = inp_sh0 ^ inp_sh1 ^ inp_sh2;

endmodule

