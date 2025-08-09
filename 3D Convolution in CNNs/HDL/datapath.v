//
module DP #(parameter stride = 1) 
    (clk, sel, rst_data, rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_win, cen_cnt_win, ld, lf_0, lf_1,
    l_mac, data_in_R, data_in_G, data_in_B, data_in_f0_R, data_in_f0_G, data_in_f0_B, 
    data_in_f1_R, data_in_f1_G, data_in_f1_B, one_window_done, one_row_done, done_row, Y);

    input clk, sel, rst_data, rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_win, ld, l_mac, lf_0, lf_1, cen_cnt_win;
    input signed [7 : 0] data_in_R, data_in_G, data_in_B, 
    data_in_f0_R, data_in_f0_G, data_in_f0_B,  data_in_f1_R, data_in_f1_G, data_in_f1_B;
    
    output signed [31 : 0] Y;
    output one_window_done, one_row_done, done_row;
    
    wire done_col;
    wire [2:0] col, row;
    wire [3 : 0] idx;
    wire  [6 : 0] read_addr_act;
    wire signed [7:0] data_out_R, data_out_G, data_out_B, filter_out0_R, filter_out0_G, filter_out0_B,  
    filter_out1_R, filter_out1_G, filter_out1_B, filter_out_R, filter_out_G, filter_out_B;
    wire signed [31:0]mac_out_R, mac_out_G, mac_out_B;
    
    reg [6 : 0] base_address;
    always @(*) begin
            case (idx)
                4'd0: base_address = 6'd0;
                4'd1: base_address = 6'd1;
                4'd2: base_address = 6'd2;
                4'd3: base_address = 6'd9;
                4'd4: base_address = 6'd10;
                4'd5: base_address = 6'd11;
                4'd6: base_address = 6'd18;
                4'd7: base_address = 6'd19;
                4'd8: base_address = 6'd20;
                default: base_address = 6'd0; 
            endcase
     end
    
    assign read_addr_act = 9 * row + (col) + base_address;
    counter_window inst_filter_conter (clk, rst_cnt_win, cen_cnt_win, idx, one_window_done);
    
    act_inp inst_R (clk, rst_data, ld, data_in_R, read_addr_act, data_out_R);
    act_inp inst_G (clk, rst_data, ld, data_in_G, read_addr_act, data_out_G);
    act_inp inst_B (clk, rst_data, ld, data_in_B, read_addr_act, data_out_B);
    ///
    filter inst_f0R (clk, rst_data, lf_0, data_in_f0_R, idx, filter_out0_R);
    filter inst_f0G (clk, rst_data, lf_0, data_in_f0_G, idx, filter_out0_G);
    filter inst_f0B (clk, rst_data, lf_0, data_in_f0_B, idx, filter_out0_B);
    filter inst_f1R (clk, rst_data, lf_1, data_in_f1_R, idx, filter_out1_R);
    filter inst_f1G (clk, rst_data, lf_1, data_in_f1_G, idx, filter_out1_G);
    filter inst_f1B (clk, rst_data, lf_1, data_in_f1_B, idx, filter_out1_B);
    
    MUX inst_filter_selectR (filter_out0_R, filter_out1_R, sel, filter_out_R);
    MUX inst_filter_selectG (filter_out0_G, filter_out1_G, sel, filter_out_G);
    MUX inst_filter_selectB (filter_out0_B, filter_out1_B, sel, filter_out_B);
    
	MAC inst_MAC (data_out_R, data_out_G, data_out_B, filter_out_R, filter_out_G, filter_out_B, clk, rst_mac, l_mac, Y);	

    counter_upto6 #(6) inst_col_counting (clk, rst_cnt_col, one_window_done, stride, col, done_col);
    assign one_row_done = done_col & one_window_done;
    counter_upto6 #(6) inst_row_counting (clk, rst_cnt_row, one_row_done , stride, row, done_row);
   
endmodule



