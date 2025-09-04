
module ALU (inp1, inp2, Op_choice, alu_result, zero);
		input [3:0] Op_choice ;
		input [31:0] inp1, inp2 ;
		output reg zero ;
		output [31:0] alu_result ;
		
		reg [31:0] temp ;
		assign alu_result = temp ;
		
		always @ (*) begin                  
			case (Op_choice) 
				4'b0000 : temp = (inp1 & inp2) ;
				4'b0001 : temp = (inp1 | inp2) ;
				4'b0010 : temp = (inp1 + inp2) ;
			    4'b0110 : temp = (inp1 - inp2) ;
				default : temp = 32'b0 ;
			endcase
			zero = (temp == 32'b0) ? 1'b1 : 1'b0 ;
		end

endmodule
