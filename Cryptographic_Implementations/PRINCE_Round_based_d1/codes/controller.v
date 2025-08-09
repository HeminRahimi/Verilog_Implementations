
module Controller(clk, reset, go, round_num,
    cnt_rst, cnt_en, start_path, inv1, inv2, done);

    input clk, reset, go;
    input [3 : 0] round_num;
    output reg cnt_rst, cnt_en, start_path, inv1, inv2, done;

    parameter idle = 0, start = 1, half_round = 2, halt_state = 3, intermed_state = 4,
    final_round = 5, Finish = 6;
    reg [2:0] present_st;

    always @ (posedge clk)
    begin
        if (reset)
            present_st <= idle;
        else case (present_st)
            idle:
            begin
                cnt_rst <= 1 ; cnt_en <= 0 ; start_path <= 1;
                inv1 <= 0 ; inv2 <= 0 ; done <= 0;
                if (go == 1'b1)
                    begin
                        present_st <= start ;
                    end
                else begin
                    present_st <= idle ;
                end
            end

            start:
            begin
                cnt_rst <= 0 ; cnt_en <= 1 ; start_path <= 1;
                inv1 <= 0 ; inv2 <= 0 ; done <= 0;
                present_st <= half_round;
            end

            half_round:
            begin
                if (round_num < 5)
                    begin
                        cnt_rst <= 0 ; cnt_en <= 1 ; start_path <= 0;
                        inv1 <= 0 ; inv2 <= 0 ; done <= 0;
                        present_st <= half_round ;
                    end
                else
                    present_st <= halt_state ;
            end

            halt_state:
            begin
                cnt_rst <= 0 ; cnt_en <= 0 ; start_path <= 0;
                inv1 <= 0 ; inv2 <= 0 ; done <= 0;
                present_st <= intermed_state ;
            end

            intermed_state :
            begin
                cnt_rst <= 0 ; cnt_en <= 1 ; start_path <= 0;
                inv1 <= 1 ; inv2 <= 0 ; done <= 0;
                present_st <= final_round ;
            end

            final_round:
            begin

                if (round_num == 11)
                    begin
                        present_st <= Finish;
                    end
                else
                    begin
                        cnt_rst <= 0 ; cnt_en <= 1 ; start_path <= 0;
                        inv1 <= 1 ; inv2 <= 1 ; done <= 0;
                        present_st <= final_round ;
                    end
            end

            Finish:
            begin
                done <= 1;
                cnt_en <= 0 ;
                present_st <= idle ;
            end

            default:
            present_st <= idle;
        endcase
    end

endmodule