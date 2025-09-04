
module Adder (in1, in2, Alu_Result);

		input [31:0] in1 ;
		input [31:0] in2 ;
		output [31:0] Alu_Result ;
		
		assign Alu_Result = in1 + in2 ;

endmodule
