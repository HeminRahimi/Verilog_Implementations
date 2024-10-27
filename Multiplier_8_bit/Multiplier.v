// ------------------------------------------------
// Project Name: 8-bit Multiplier 
// Author: Hemin Rahimi
// Date: March 2016
// Description: This project implements an 8-bit multiplier employing a methodology of multiplication using summation.
// Version: 1.0
// ------------------------------------------------


module Multiplier(clk, reset, go, A, B, done, Result);
	input [7:0] A, B ;
	input clk, go, reset;
	output [15:0] Result ;
	output done ;
	wire  ld_A , ld_B, ld_Result, rst, Cen, Cntf ;	
	
		DataPath inst_DP ( clk, A, B, ld_A, ld_B, ld_Result, 
		Result, rst, Cen ,Cntf );
		Controller inst_CTRL (clk, reset, go, Cntf, done, 
		ld_A, ld_B, Cen, ld_Result, rst );

endmodule

////////////////////

module DataPath(clk, A, B, ld_A, ld_B, ld_Result, Result, rst, Cen ,Cntf);
    input [7:0] A, B ;
    input clk, ld_A , ld_B, ld_Result, rst, Cen ;
    output [15:0] Result;
    output Cntf ;
    wire [15:0] regout2, result_in ;
    wire [7:0] regout1, Z ;

    Register_8bits M1 (clk, ld_A, A, regout1) ;
    Adder M2 (regout1, regout2, result_in) ;
    Register_16bits M3 (clk, rst, ld_Result, result_in, regout2) ;
    Counter_8bits M4 (clk, B, ld_B, Cen, Z, Cntf);

    assign Result = regout2 ;

endmodule 

///////////////////

module Controller(clk, reset,go, Cntf, done, ld_A, ld_B, Cen, ld_Result, rst);
    input clk, reset,go, Cntf ;
    output reg done, ld_A, ld_B, Cen, ld_Result, rst ;
    parameter start=2'b00, load=2'b01, calc=2'b10, out=2'b11 ;

    reg [1:0] PS , NS ;

    always @ (go, PS, Cntf) begin
        NS= start;
        done=1'b0; ld_A=1'b0; ld_B=1'b0;
        Cen=1'b0; ld_Result=1'b0; rst=1'b0 ;
        case (PS)

            start: begin
                if (go == 1'b1)
                    NS = load ;
                else
                    NS = start ;
            end

            load: begin
                done=1'b0; ld_A=1'b1; ld_B=1'b1;
                Cen=1'b0; ld_Result=1'b0; rst=1'b1 ;
                NS = calc ;
            end

            calc: begin
                if (Cntf==1'b0) begin
                    NS = calc ;
                    done=1'b0; ld_A=1'b0; ld_B=1'b0;
                    Cen=1'b1; ld_Result=1'b1; rst=1'b0 ;
                end
                else begin
                    done=1'b0; ld_A=1'b0; ld_B=1'b0;
                    Cen=1'b0; ld_Result=1'b0; rst=1'b0 ;
                    NS = out ;
                end
            end
            out: begin
                done=1'b1; ld_A=1'b0; ld_B=1'b0;
                Cen=1'b0; ld_Result=1'b0; rst=1'b0 ;
                NS = start ;
            end
        endcase
    end
    always @(posedge clk) begin
        if ( reset == 1'b1 )
            PS <= start ;
        else
            PS <= NS ;
    end

endmodule

//////////////////

module Adder(a, b, y);
    input [7:0] a ;
    input [15:0] b ;
    output [15:0] y ;

    assign y = a + b ;

endmodule

/////////////////////

module Counter_8bits(clk, B, ld_B, Cen, Z , Cntf);
	input [7:0] B ;
	input clk, ld_B, Cen ;
	output reg [7:0] Z ;
	output Cntf ;
	
	always @ ( posedge clk ) begin 
		if (ld_B)
			Z <= B ;
		else if (Cen)
			Z <= Z-1 ;		
	end
	assign Cntf = (Z==8'b0) ? 1'b1 : 1'b0 ;
endmodule

/////////////////////

module Register_8bits(clk, ld_A, A, out);
    input clk, ld_A ;
    input [7:0] A ;
    output reg [7:0] out ;

    always @ ( posedge clk ) begin
        if (ld_A)
            out <= A ;
        else
            out <= out;
    end

endmodule

////////////////////

module Register_16bits(clk, rst, ld, inp, out);
	input [15:0] inp ;
	input clk , rst, ld ;
	output reg [15:0] out ;
	
	always @ ( posedge clk ) begin 
		if (rst)
			out <= 16'b0 ;
		else if (ld)
			out <= inp ;
	end	

endmodule

