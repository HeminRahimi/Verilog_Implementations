`timescale 1ns / 1ps
/////////////////////////
// ------------------------------------------------
// Project Name: 8-bit Multiplier - Testbench
// Author: Hemin Rahimi
// Date: March 2016
// Description: Testbench for the 8-bit multiplier implementing the sum methodology. This file contains test scenarios to verify the correct functionality of the multiplier.
// Version: 1.0
// ------------------------------------------------

// Additional comments about the specific test cases and expected results can go here.


module Multiplier_TB();

    reg clk, go, reset;
    reg [7:0] A, B;
    wire done;
    wire [15:0] Result ;

    Multiplier uut (clk, reset, go, A, B, done, Result);
    always #5 clk = ~clk ;
    initial begin
        clk = 1'b0; reset = 1'b0; go = 1'b0;
        A=8'b1010 ; B=8'b100;
        #10 ;
        go = 1'b1 ;
        #10;
        go = 1'b0 ;
        #100;
        A=8'b111 ; B=8'b101 ;
        #10 ; go = 1'b1 ;
        #10 ; go = 1'b0 ;
        #100 ;
        A=8'b110 ; B=8'b1010 ;
        #10 ; go = 1'b1 ;
        #10 ; go = 1'b0 ;
        #150;
        reset = 1'b1;
        #10;
        $finish;
    end

endmodule

