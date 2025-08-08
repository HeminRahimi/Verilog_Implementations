module full_AES(clk, reset, go, PRNG, pt_shared, key_shared, Output_shared, done);

    input clk, reset, go;
    input [15 : 0] pt_shared, key_shared;
    input [18 : 0] PRNG;
    output done;
    output [255 : 0] Output_shared;

    wire [3 : 0] round_num;
    wire [1 : 0] op_ctrl, RK_ctrl;
    wire s20_ctrl, inp_ctrl, state_in_ctrl, rotate_ctrl,
    Kron_sel, SB_in_sel, En_round, rst, ld_data, sh_en;
    wire clk_inv;

    Datapath inst_DP (clk, rst, PRNG, pt_shared, key_shared, op_ctrl, s20_ctrl,
        inp_ctrl, state_in_ctrl, rotate_ctrl, RK_ctrl, Kron_sel, SB_in_sel,
        En_round, round_num, done, Output_shared);

    Controller inst_ctrl (clk, reset, go, round_num,
        op_ctrl, s20_ctrl, inp_ctrl, state_in_ctrl,
        rotate_ctrl, RK_ctrl, Kron_sel, SB_in_sel,
        rst, En_round, done);

endmodule