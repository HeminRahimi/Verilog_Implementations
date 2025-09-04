
module PC(clock, rst, pc_in, pc_out);

    input clock, rst;
	input [31:0] pc_in;
	output [31:0] pc_out;
		
	reg [31:0] temp;
	assign pc_out = temp;
		
	always @ (posedge clock) begin 
		if (rst)
			temp <= 0;
		else
			temp <= pc_in;
	end

endmodule
