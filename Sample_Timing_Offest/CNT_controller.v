`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module CNT_controller(clk, reset, go, End, cntf,  
                      en_Nofdm, en_Ng, rst_Ng, rst_Nofdm, inc, done);
	input clk, reset, go, cntf, End ;
	output reg en_Nofdm, en_Ng, rst_Ng, rst_Nofdm, inc, done ;
	
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
	
	reg [2:0] P , N ;
	
	always @ (go, P, cntf, End) begin
		N = s0;  
		en_Nofdm = 0; en_Ng = 0; rst_Ng = 0; rst_Nofdm = 0; inc = 0; done = 0;
		
	case (P)
	   
	   //////////
		s0: begin
		en_Nofdm = 0; en_Ng = 0; rst_Ng = 0; rst_Nofdm = 0; inc = 0; done = 0;
		if (go == 1'b1)
			N = s1 ;
		else
			N = s0 ; 
	    end
	    
	    /////////
		s1: begin 
		    en_Nofdm = 0; en_Ng = 0; rst_Ng = 1; rst_Nofdm = 1; inc = 0; done = 0;
			N = s2 ;
	    end
	    ///////////
	    s2: begin
	       if (End==1'b0) begin
               N = s3 ;
               en_Nofdm = 1; en_Ng = 0; rst_Ng = 1; rst_Nofdm = 0; inc = 0; done = 0;
           end
           else
                N = s4;
	    end
	   ///////////
		s3: begin
            if (cntf==1'b0) begin 
                N = s3 ;
                en_Nofdm = 0; en_Ng = 1; rst_Ng = 0; rst_Nofdm = 0; inc = 0; done = 0;
			end
			else begin
			    N = s2;
			    inc = 1; en_Ng = 1;
			end
		end
		
		s4: begin
		    N = s0 ;
             en_Nofdm = 0; en_Ng = 0; rst_Ng = 0; rst_Nofdm = 0; inc = 0; done = 1;
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





/*

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module CNT_controller(clk, reset, go, End, cntf,  
                      en1, en2, cnt_rst1, cnt_rst2, done);
	input clk, reset, go, cntf, End ;
	output reg en1, en2, cnt_rst1, cnt_rst2, done ;
	
	parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
	
	reg [2:0] P , N ;
	
	always @ (go, P, cntf, End) begin
		N = s0;  
		en1 = 0 ; en2 = 0 ; cnt_rst1 = 0 ; 
		cnt_rst2 = 0 ; done = 0 ;
	    
	case (P)
		s0: begin
		cnt_rst1 = 0 ; cnt_rst2 = 0 ;
		en1 = 0 ; en2 = 0 ; done = 0 ;
		if (go == 1'b1)
			N = s1 ;
		else
			N = s0 ; 
	    end
	
		s1: begin 
		    cnt_rst1 = 1 ; cnt_rst2 = 1 ;
		    en1 = 0 ; en2 = 1 ; done = 0 ;
			N = s2 ;
	    end
	
	    s2: begin
	       if (cntf==1'b0) begin
               N = s2 ;
               cnt_rst1 = 0 ; cnt_rst2 = 0 ;
               en1 = 1 ; en2 = 0 ; done = 0 ;
           end
           else
                N = s3;
	    end
	
		s3: begin

            if (End==1'b0) begin 
                N = s2 ;
                cnt_rst1 = 1 ; cnt_rst2 = 0 ;
                en1 = 0 ; en2 = 1 ; done = 0 ;
			end
			else
			    N = s4;
		end
		
		
		s4: begin
		    N = s0 ;
            cnt_rst1 = 0 ; cnt_rst2 = 0 ;
            en1 = 0 ; en2 = 0 ; done = 1 ;
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




*/