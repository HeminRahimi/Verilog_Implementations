module Controller (clk, reset, go, round_num, op_ctrl, s20_ctrl, 
       inp_ctrl, state_in_ctrl, rotate_ctrl, RK_ctrl, kron_sel,
       SB_in_sel, rst, En_round, done);

    input clk, reset, go;
    input [3 : 0] round_num;
    output reg s20_ctrl, inp_ctrl, state_in_ctrl,
    rotate_ctrl, kron_sel, SB_in_sel, rst, En_round, done;
    output reg [1 : 0] op_ctrl, RK_ctrl;

    parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5,
    s6 = 6, s7 = 7, s8 = 8, s9 = 9, s10 = 10, s11 = 11,
    s12 = 12, s13 = 13, s14= 14, s15 = 15, s16 = 16,
    s17 = 17, s18 = 18, s19 = 19, s20 = 20, s21= 21,
    s22 = 22, s23 = 23, start = 30, idle = 31;
    reg [4:0] present_st;

    always @ (posedge clk) begin
        if (reset)
            present_st <= idle;
        else case (present_st)
            idle: begin

                present_st <= start ;
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 0; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 0; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 1 ; En_round <= 0; done <= 0;
            end

            start: begin
                rst <= 0;
                done <= 0;
                if (go == 1'b0) begin
                    present_st <= s0;
                    op_ctrl <= 3;
                end
                else
                    present_st <= start;

            end

            s0: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 1; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ; En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else begin
                    inp_ctrl <= 1;
                    op_ctrl <= 0;
                end
                present_st <= s1 ;
            end

            s1: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 1; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else
                    inp_ctrl <= 1;

                present_st <= s2 ;
            end

            s2: begin
                op_ctrl <= 2; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 1; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10)
                    op_ctrl <= 0;
                else begin
                    op_ctrl <= 2 ;
                    inp_ctrl  <= 1;
                end

                present_st <= s3 ;
            end

            s3: begin
                op_ctrl <= 0;s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else begin
                    op_ctrl <= 0 ;
                    inp_ctrl  <= 1;
                end
                present_st <= s4 ;
            end

            s4: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s5 ;
            end

            s5: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s6 ;
            end

            s6: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    inp_ctrl <= 1;
                    state_in_ctrl <= 0;
                    op_ctrl <= 0;
                end
                else begin
                    op_ctrl <= 2 ;
                    inp_ctrl  <= 1;
                end
                present_st <= s7 ;
            end

            s7: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    op_ctrl <= 3;
                    inp_ctrl  <= 0;
                end
                else if (round_num == 10) begin
                    op_ctrl <= 0;
                    state_in_ctrl <= 0;
                end
                else begin
                    op_ctrl <= 0 ;
                    inp_ctrl  <= 1;
                end
                present_st <= s8 ;
            end

            s8: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s9 ;
            end

            s9: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s10 ;
            end

            s10: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                    op_ctrl <= 0;
                end
                else begin
                    inp_ctrl <= 1;
                    op_ctrl <= 2;
                end
                present_st <= s11 ;
            end

            s11: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    op_ctrl <= 0;
                    state_in_ctrl <= 0;
                end
                else begin
                    op_ctrl <= 0 ;
                    inp_ctrl  <= 1;
                end

                present_st <= s12 ;
            end

            s12: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s13 ;
            end

            s13: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s14 ;
            end

            s14: begin
                op_ctrl <= 0; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 0 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 1;
                if (round_num == 0) begin
                    inp_ctrl <= 0;
                    op_ctrl <= 3;
                end
                else if (round_num == 10) begin
                    state_in_ctrl <= 0;
                end
                else
                    inp_ctrl <= 1;
                present_st <= s15 ;
            end

            s15: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ; En_round <= 0;

                if (round_num == 10) begin
                    done <= 1;
                    state_in_ctrl <= 0;
                    present_st <=  idle;
                end

                else begin
                    present_st <= s16 ;
                end

            end

            s16: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;

                present_st <= s17 ;
            end

            s17: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                present_st <= s18 ;
            end
            s18: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                present_st <= s19 ;
            end

            s19: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 1;
                rst <= 0 ;  En_round <= 0;
                present_st <= s20 ;
            end

            s20: begin
                op_ctrl <= 0; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 1;
                rst <= 0 ;  En_round <= 0;
                present_st <= s21 ;
            end

            s21: begin
                op_ctrl <= 1; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 1;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 1;
                rst <= 0 ;  En_round <= 0;
                present_st <= s22 ;
            end

            s22: begin
                op_ctrl <= 2; s20_ctrl <= 1 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 1 ; RK_ctrl <= 2; kron_sel <= 1; SB_in_sel <= 1;
                rst <= 0 ;  En_round <= 0;

                if (round_num == 10)
                    op_ctrl <= 0 ;
                else
                    op_ctrl  <= 2;

                present_st <= s23 ;
            end

            s23: begin

                op_ctrl <= 0 ; s20_ctrl <= 0 ; inp_ctrl <= 1; state_in_ctrl <= 0;
                rotate_ctrl <= 0 ; RK_ctrl <= 0; kron_sel <= 0; SB_in_sel <= 0;
                rst <= 0 ;  En_round <= 0;
                present_st <= s0;

            end
            default :
            present_st <= idle;
        endcase

    end

endmodule