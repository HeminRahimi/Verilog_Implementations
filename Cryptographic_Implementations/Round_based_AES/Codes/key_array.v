
module key_array(clk, inp_ctrl, rotate_ctrl, RK,
    key_in, key_out, to_sbox, to_kronecker);

    input clk, inp_ctrl, rotate_ctrl;
    input [15 : 0] RK, key_in;
    output [15 : 0] key_out, to_sbox, to_kronecker;

    wire [15 : 0] selected_key,
    mux_out1, mux_out2, mux_out3, mux_out4,
    k00, k01, k02, k03,
    k10, k11, k12, k13,
    k20, k21, k22, k23,
    k30, k31, k32, k33,
    mux_to_k33;

    register #(16) KS00 (k10, clk, k00);
    register #(16) KS10 (k20, clk, k10);
    register #(16) KS20 (k30, clk, k20);
    register #(16) KS30 (mux_out4, clk, k30);

    register #(16) KS01 (k11, clk, k01);
    register #(16) KS11 (k21, clk, k11);
    register #(16) KS21 (k31, clk, k21);
    register #(16) KS31 (mux_out3, clk, k31);

    register #(16) KS02 (k12, clk, k02);
    register #(16) KS12 (k22, clk,  k12);
    register #(16) KS22 (k32, clk,  k22);
    register #(16) KS32 (mux_out2, clk, k32);

    register #(16) KS03 (k13, clk, k03);
    register #(16) KS13 (k23, clk, k13);
    register #(16) KS23 (k33, clk, k23);
    assign mux_to_k33 = mux_out1;
    register #(16) KS33 (mux_to_k33, clk, k33);

    mux_2to1 #(16) M0 (key_in , RK, inp_ctrl, selected_key);

    mux_2to1 #(16) M1(selected_key, k03, rotate_ctrl, mux_out1);
    mux_2to1 #(16) M2(k03, k02, rotate_ctrl, mux_out2);
    mux_2to1 #(16) M3(k02, k01, rotate_ctrl, mux_out3);
    mux_2to1 #(16) M4(k01, k00, rotate_ctrl, mux_out4);

    assign key_out = k00;
    assign to_kronecker = k03 ;
    assign to_sbox = k13;

endmodule
