 
module Main_controller(Instruction, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOp);
		input [6:0] Instruction ;
		output reg [1:0] AluOp ;
		output reg ALUSrc, MemtoReg, 
			RegWrite, MemRead, MemWrite, Branch ;
		
	always @ (*) begin

		case (Instruction)
			7'b0110011 : begin  								            
				AluOp = 2'b10 ; ALUSrc = 1'b0 ; MemtoReg = 1'b0;
                RegWrite = 1'b1 ; MemRead = 1'b0 ; MemWrite = 1'b0 ; Branch = 1'b0;					
 
			end

		    7'b0000011 : begin       								     
				AluOp = 2'b00 ; ALUSrc = 1'b1 ; MemtoReg = 1'b1;
                RegWrite = 1'b1 ; MemRead = 1'b1 ;	MemWrite = 1'b0 ; Branch = 1'b0;
			end
				
			7'b0100011 : begin         									   
				AluOp = 2'b00 ; ALUSrc = 1'b1 ; MemtoReg = 1'b0;
                RegWrite = 1'b1 ; MemRead = 1'b0 ; MemWrite = 1'b0 ; Branch = 1'b0;
			end
				
			7'b1100011 : begin													
				AluOp = 2'b01 ; ALUSrc = 1'b0 ; MemtoReg = 1'b0;
                RegWrite = 1'b0 ; MemRead = 1'b0 ; MemWrite = 1'b0 ; Branch = 1'b1;
			end
				
			default : begin 
				AluOp = 2'b0 ; ALUSrc = 1'b0 ; MemtoReg = 1'b0;
            	RegWrite = 1'b0 ; MemRead = 1'b0 ; MemWrite = 1'b0 ; Branch = 1'b0;
			end
				
	    endcase
	  end
endmodule

