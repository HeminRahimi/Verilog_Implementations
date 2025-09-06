
module Data_mem (clk, rst, address, write_data, mem_read, mem_write, read_data);
		input mem_read, mem_write, clk, rst;
		input [31:0] address , write_data ;
		output [31:0] read_data ;
		
		reg [31:0] temp ;
		assign read_data = temp ;
		
		reg [31:0] Mem [0:255] ;
		
		
		always @ (*) begin
			if (mem_read == 1 && mem_write == 0)
				temp = Mem[address];
			else                                               
				temp = 32'b0;
		end
		///
		always @ (posedge clk) begin
			if (mem_read == 0 && mem_write == 1)  
				Mem[address] <= write_data ;
				
			else                                               
				temp <= 32'b0 ;
		end
     
	   always  @ (rst) begin                      
			Mem[0] = 32'h0;
			Mem[1] = 32'h1;
			Mem[2] = 32'h2;
			Mem[3] = 32'h3;
			Mem[4] = 32'h4;
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

endmodule

  
