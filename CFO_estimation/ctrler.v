`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Controller(clk, reset, go, End, cntf, mode, cen, cnt_rst, reg_rst, reg_ld, t_valid, done);
	input clk, reset, go, cntf, End ;
	output reg mode, cen, cnt_rst, reg_rst, reg_ld, t_valid, done ;
	
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5;
	
	reg [2:0] P , N ;
	
	always @ (go, P, cntf, End) begin
		N = s0;  
		mode = 0 ; cen = 0 ; cnt_rst = 0 ; reg_rst = 0 ;
	    reg_ld = 0 ; t_valid = 0 ; done = 0 ;
	    
	case (P)
		s0: begin
		if (go == 1'b1)
			N = s1 ;
		else
			N = s0 ; 
	    end
	
		s1: begin 
		    mode = 1 ; cen = 0 ; cnt_rst = 1 ; reg_rst = 1 ;
	        reg_ld = 0 ; t_valid = 0 ; done = 0 ;
			N = s2 ;
	    end
	
	    s2: begin
	        mode = 1 ; cen = 0 ; cnt_rst = 1 ; reg_rst = 1 ;
	        reg_ld = 0 ; t_valid = 0 ; done = 0 ;
		    N = s3 ;
	    end
	
		s3: begin 
            if (cntf==1'b0) begin 
                N = s3 ;
                mode = 1 ; cen = 1 ; cnt_rst = 0 ; reg_rst = 0 ;
	            reg_ld = 1 ; t_valid = 0 ; done = 0 ;
            end
            else begin
                N = s4 ;
			end
	    end
	
		s4: begin
            if (End==1'b0) begin 
                N = s4 ;
                mode = 0 ; cen = 0 ; cnt_rst = 0 ; reg_rst = 0 ;
                reg_ld = 0 ; t_valid = 1 ; done = 0 ;
			end
			else
			    N = s5;
		end
		
		s5: begin
		    N = s0 ;
            mode = 0 ; cen = 0 ; cnt_rst = 0 ; reg_rst = 0 ;
            reg_ld = 0 ; t_valid = 0 ; done = 1 ;
		end
		
	endcase
end

	always @(posedge clk) begin 
		if ( reset == 1'b1 )
			P <= s0 ;
		else
			P <= N ;
    end
	
endmodule


