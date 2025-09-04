
module Reg_bank(clk, rst, read_reg1, read_reg2, write_reg, write_data, RegWrite, read_data1, read_data2);

		input RegWrite, clk, rst;
		input [4:0] read_reg1, read_reg2, write_reg ;
		input [31:0] write_data ;
		output reg [31:0] read_data1, read_data2 ;
		
		reg [31:0] Mem[0:31] ;
		
		always @ (posedge clk) begin
			read_data1 = Mem [read_reg1] ;
			read_data2 = Mem [read_reg2] ;
		end
		always @ (negedge clk) begin    
			  if (RegWrite == 1) begin              
					Mem[write_reg] <=	write_data ;
					end
			  else begin
		      	Mem[write_reg] <= Mem[write_reg] ;
			  end
		end

		always @ (rst) begin

			Mem[0] = 32'h0;
			Mem[1] = 32'h9;
			Mem[2] = 32'hF0A;
			Mem[3] = 32'h3;
			Mem[4] = 32'h4FC;
			Mem[5] = 32'h5;
			Mem[6] = 32'h6;
			Mem[7] = 32'h7;
			Mem[8] = 32'h8;
			Mem[9] = 32'h9;
			Mem[10] = 32'h10;
			Mem[11] = 32'h11;
			Mem[12] = 32'h12;
			Mem[13] = 32'h13;
			Mem[14] = 32'h14;
			Mem[15] = 32'h15;
			Mem[16] = 32'h16;
			Mem[17] = 32'h17;
			Mem[18] = 32'h18;
			Mem[19] = 32'h19;
			Mem[20] = 32'h20;
			Mem[21] = 32'h21;
			Mem[22] = 32'h22;
			Mem[23] = 32'h23;
			Mem[24] = 32'h24;
			Mem[25] = 32'h25;
			Mem[26] = 32'h26;
			Mem[27] = 32'h27;
			Mem[28] = 32'h28;
			Mem[29] = 32'h29;
			Mem[30] = 32'h30;
			Mem[31] = 32'h31;

		end

		/*
		initial begin
		$readmemh("reg_file_value.txt",Mem);
		end
        */
		
endmodule
