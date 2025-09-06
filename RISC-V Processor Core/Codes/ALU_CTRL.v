
module ALU_CTRL(AluOp, instruction, Op_choice);

		input [1:0] AluOp ;
		input [3:0] instruction ;
		output [3:0] Op_choice ;

		reg [3:0] temp ;
		assign Op_choice = temp ;

		always @ (*) begin
				case (AluOp)
					2'b00 : temp = 4'b0010 ;  
					
					2'b01 : temp = 4'b0110 ;  
					
					2'b10 : begin
						if (instruction[2 : 0] == 3'b000 && instruction[3] == 1'b0)  
							temp = 4'b0010 ;                   
						
						else if (instruction[2 : 0] == 3'b000 && instruction[3] == 1'b1)   
							temp = 4'b0110 ;                   
						
						else if (instruction[2 : 0] == 3'b111)   
							temp = 4'b0000 ;                   
						
						else if (instruction[2 : 0] == 3'b110)   
							temp = 4'b0001 ;                   
						
						else 
							temp = 4'b1111 ;

					end
						default : 
							temp = 4'b1111 ;                        
				endcase
		end

endmodule
