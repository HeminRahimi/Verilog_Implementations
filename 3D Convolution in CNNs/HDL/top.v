
module top #(parameter stride = 1) (clk, reset, go, rst_data, ld, lf_0, lf_1, data_in_R, data_in_G, data_in_B, 
data_in_f0_R, data_in_f0_G, data_in_f0_B, data_in_f1_R, data_in_f1_G, data_in_f1_B, Out, out_valid, done);
    
    input  clk, reset, go, rst_data, ld, lf_0, lf_1;
    input  signed [7 : 0] data_in_R, data_in_G, data_in_B, data_in_f0_R, data_in_f0_G, data_in_f0_B, 
        data_in_f1_R, data_in_f1_G, data_in_f1_B;
    output signed [31 : 0] Out;
    output done, out_valid;
    
    wire sel, out_valid, one_row_done, done_row, rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_window, cen_cnt_window, l_mac;
    wire signed [31 : 0] Y;

    DP #(stride) inst_DP 
    (clk, sel, rst_data, rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_window, cen_cnt_window, ld, lf_0, lf_1,
    l_mac, data_in_R, data_in_G, data_in_B, data_in_f0_R, data_in_f0_G, data_in_f0_B, 
    data_in_f1_R, data_in_f1_G, data_in_f1_B, out_valid, one_row_done, done_row, Y);
    
    Controller inst_CTRL 
    (clk, reset, go, out_valid, one_row_done, done_row,
    rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_window, cen_cnt_window, l_mac, sel, done);
    
    assign Out = (out_valid || done) ? (Y) : (0);
     
endmodule

