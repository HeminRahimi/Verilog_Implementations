
module Adder_const4 (adder_inp1, adder_out);
		
	parameter adder_inp2 = 4 ; 
	input [31:0] adder_inp1;
	output [31:0] adder_out;
				
	assign adder_out = adder_inp1 + adder_inp2 ;

endmodule
