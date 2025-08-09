
module Controller(clk, reset, go, one_window_done, one_row_done, done_row,
    rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_window, cen_cnt_window, mac_en, sel, done);

    input clk, reset, go, one_window_done, one_row_done, done_row;
    output reg rst_mac, rst_cnt_col, rst_cnt_row, rst_cnt_window;
    output reg cen_cnt_window, mac_en, sel, done;

    parameter N_FILTERS = 2;
    parameter  rst = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, idle = 5;
    
    reg [1 : 0] filter_calc;
    reg [2:0] present_st;

    always @ (posedge clk)
    begin
        if (reset) begin 
            sel <= 0;
            filter_calc <= 0;
            present_st <= rst;
        end
        else begin
            case (present_st)
                rst:
                begin
                    rst_mac <= 1; rst_cnt_col <= 1; rst_cnt_row <= 1; rst_cnt_window <= 1; 
                    cen_cnt_window <= 0; mac_en <= 0; done <= 0;
                    present_st <= idle ;
                end
                
                idle:
                begin
                    rst_mac <= 0; rst_cnt_col <= 0; rst_cnt_row <= 0; rst_cnt_window <= 0; 
                    cen_cnt_window <= 0; mac_en <= 0; done <= 0;
                    if (go == 1'b1 || filter_calc == 1)
                        present_st <= s1 ;
                    else
                        present_st <= idle ;
                end

                s1:
                begin
                    rst_mac <= 1; rst_cnt_window <= 1; rst_cnt_col <= 0; rst_cnt_row <= 0;  
                    cen_cnt_window <= 0; mac_en <= 0; done <= 0;
                    present_st <= s2 ;
                end
                
                s2:
                begin
                    rst_mac <= 0; rst_cnt_window <= 0; rst_cnt_col <= 0; rst_cnt_row <= 0;  
                    cen_cnt_window <= 1; mac_en <= 0; done <= 0;
                    present_st <= s3 ;
                end
                
                s3: 
                begin
                    if (one_window_done == 1 && one_row_done == 1 && done_row == 1) begin
                        present_st <= s4 ;
                    end
                    else if (one_window_done == 1 && one_row_done == 0 ) begin
                        present_st <= s1 ;        
                    end
                    else if (one_window_done == 1 && one_row_done == 1) begin
                        rst_mac <= 1; rst_cnt_window <= 1; rst_cnt_col <= 1; rst_cnt_row <= 0;  
                        cen_cnt_window <= 0; mac_en <= 0; done <= 0;
                        present_st <= s2 ;
                    end
                    else begin
                        rst_mac <= 0; rst_cnt_col <= 0; rst_cnt_row <= 0; rst_cnt_window <= 0; 
                        cen_cnt_window <= 1; mac_en <= 1; done <= 0;
                        present_st <= s3;
                    end  
                end
                
                s4:
                begin
                    filter_calc <= filter_calc + 1;
                    rst_mac <= 0; rst_cnt_window <= 0; rst_cnt_col <= 0; rst_cnt_row <= 0;  
                    cen_cnt_window <= 0; mac_en <= 0; done <= 0;

                    if (filter_calc == N_FILTERS - 1) begin
                        done <= 1;
                        present_st <= idle;
                    end  
                    else begin
                        sel <= 1;
                        present_st <= rst;
                    end
                end

                default:
                    present_st <= idle;
            endcase
        end
    end

endmodule
