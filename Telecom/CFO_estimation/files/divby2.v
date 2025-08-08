`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Divby2 (en, binary_input_data, binary_output_data, finish);

  input signed [23:0] binary_input_data;
  input en;
  
  output reg signed [23:0] binary_output_data;
  output reg finish;
  always @ (*) begin
    if (en) begin
        if (binary_input_data[23] == 0) 
            binary_output_data <= binary_input_data >> 1;
            
        else 
          binary_output_data <= (binary_input_data + 1) >> 1;
          
        finish = 1;
     end
     
     else begin
         binary_output_data <= 24'b0;
         finish = 0;
    end
    
  end

endmodule
