module PRINCE(clk, reset, go, Dec_EncBar, PRNG, inp_share0, inp_share1,
    key, out_share0, out_share1, done);

    input clk, reset, go, Dec_EncBar;
    input [287 : 0] PRNG;
    input [63 : 0] inp_share0, inp_share1;
    input [127 : 0] key;
    output [63 : 0] out_share0, out_share1;
    output done;

    wire cnt_rst, cnt_en, start_path, inv1, inv2;
    wire [3 : 0] round_num;


    Datapath inst_DP (clk, cnt_rst, cnt_en, start_path, inv1, inv2, Dec_EncBar,
        PRNG, inp_share0, inp_share1, key, out_share0, out_share1, round_num);

    Controller inst_CTRL (clk, reset, go, round_num, cnt_rst, cnt_en, start_path,
        inv1, inv2, done);

endmodule
