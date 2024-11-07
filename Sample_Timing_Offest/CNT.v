`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module CNT (clk, reset, go, nfft, ng, com_delay, Out_Ng, Out_Nofdm, inc_nofdm, done) ;
    input clk, reset, go; 
    input [11:0] nfft, ng, com_delay;
    output [12:0] Out_Ng, Out_Nofdm;
    output done, inc_nofdm;
    //assign inc_nofdm = cntf;
    wire en_Nofdm, en_Ng, rst_Ng, rst_Nofdm, End, cntf;
    
    CNT_controller ctrl_inst (clk, reset, go, End, cntf,en_Nofdm, 
                              en_Ng, rst_Ng, rst_Nofdm, inc_nofdm, done);
                      
    CNTDP DP_inst (clk, rst_Ng, rst_Nofdm, en_Ng, en_Nofdm, nfft,
                   ng, com_delay, cntf, End, Out_Ng, Out_Nofdm);                  
                      
endmodule 




module CNTDP(clk, rst1, rst2, en1, en2, nfft, ng, com_delay, cntf, End, Out_Ng, Out_Nofdm);
    input clk, rst1, rst2, en1, en2;
    input [11 : 0] nfft, ng, com_delay;
    output [12:0] Out_Ng, Out_Nofdm;
    output End;
    output cntf;
    wire [11:0] cnt2tocnt1;
    
    assign Out_Nofdm = {1'b0, cnt2tocnt1};
    UpCnt_Ng M1 (clk, rst1, en1, cnt2tocnt1, ng, com_delay, cntf, Out_Ng);
    UpCnt_Nofdm M2 (clk, rst2, en2, nfft, ng, End, cnt2tocnt1);
    
endmodule



module UpCnt_Ng(clk, rst, en, inp, ng, com_delay, cntf, y);
    input clk, rst, en;
    input [11:0] inp, ng, com_delay;
    output [12:0] y;
    output cntf;
    
    reg [12 : 0] temp;
    
    always @ (posedge clk) begin
        if (rst)
            temp <= com_delay; 
        else begin
            if (en) 
                temp <= temp + 1;
            else
                temp <= temp;
        end
    end
    assign y = inp + temp;
    assign cntf = (y == (inp + com_delay + ng - 2)) ? (1'b1) : (1'b0);
endmodule 

////////////////////////////////////////////////

module UpCnt_Nofdm (clk, rst, en, nfft, ng, End, Z);
    input clk, rst, en;
    input [11:0] nfft, ng;
    output reg [11:0] Z;
    output End;
    
    always @ (posedge clk) begin
        if (rst)
            Z <= 0;
        else begin
            if (en)
                Z <= Z + 1;
            else
                Z <= Z;
        end
    end
    
    assign End = (Z == (nfft + ng - 2)) ? (1'b1) :  (1'b0);
    
endmodule 

