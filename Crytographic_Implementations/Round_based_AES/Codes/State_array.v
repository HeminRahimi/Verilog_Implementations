/////////////////////////////////////
module state_array(clk, op_ctrl, inp_ctrl, s20_ctrl,
    state_in_ctrl, pt_shared, RK, key_in, from_SB,
    MCout, to_SB, to_kronecker,
    MC_in, Out);

    input clk;
    input inp_ctrl, s20_ctrl, state_in_ctrl;
    input [1 : 0] op_ctrl;
    input [15 : 0] pt_shared, RK, key_in, from_SB;
    input [63 : 0] MCout;
    output [15 : 0] to_SB, to_kronecker;
    output [63 : 0] MC_in;
    output [255 : 0] Out;
    
    wire [15 : 0] data2xor, mux_to_s20,
    key2xor, mux_to_s33,
    s00, s01, s02, s03,
    s10, s11, s12, s13,
    s20, s21, s22, s23,
    s30, s31, s32, s33;
    
    assign MC_in = {s31, s21, s11, s01};

    // col 1
    ///    meander -- SR -- MC -- data loading
    state_mux St00 (clk, s10, s13, s10, s10, op_ctrl, s00);
    state_mux St10 (clk, s20, s20, s20, s20, op_ctrl, s10);
    state_mux St20 (clk, mux_to_s20, s31, mux_to_s20, to_kronecker, op_ctrl, s20);
    mux_2to1 #(16) mux_before_s20 (to_kronecker, s30, s20_ctrl, mux_to_s20);
    state_mux St30 (clk, s01, s03, MCout[15:0], s01, op_ctrl, s30);

    // col 2
    state_mux St01 (clk, s11, s10, MCout[31:16], s11, op_ctrl, s01);
    state_mux St11 (clk, s21, s21, MCout[47:32], s21, op_ctrl, s11);
    state_mux St21 (clk, s31, s32, MCout[63:48], s31, op_ctrl, s21);
    state_mux St31 (clk, s02, from_SB, s02, s02, op_ctrl, s31);

    // col 3
    state_mux St02  (clk, s12, s11, s12, s12, op_ctrl, s02);
    state_mux St12  (clk, s22, s22, s22, s22, op_ctrl, s12);
    state_mux St22 (clk, s32, s33, s32, s32, op_ctrl, s22);
    state_mux St32 (clk, s03, s01, s03, s03, op_ctrl, s32);

    // col 4
    state_mux St03 (clk, s13, s12, s13, s13, op_ctrl, s03);
    state_mux St13 (clk, s23, s23, s23, s23, op_ctrl, s13);
    state_mux St23 (clk, s33, s30, s33, s33, op_ctrl, s23);
    state_mux St33 (clk, mux_to_s33, s02, mux_to_s33, mux_to_s33, op_ctrl, s33);
    mux_2to1 #(16) inst_mux2s33 (s00, from_SB, state_in_ctrl, mux_to_s33);
    assign to_SB = s00;

    mux_2to1 #(16) MUX_data (pt_shared, s30, inp_ctrl, data2xor);
    mux_2to1 #(16) MUX_key (key_in , RK, inp_ctrl, key2xor);
    assign to_kronecker = key2xor ^ data2xor;


    assign Out[127:0] = {s30[7 : 0], s01[7 : 0], s11[7 : 0], s21[7 : 0],
    s31[7 : 0], s02[7 : 0], s12[7 : 0], s22[7 : 0],
    s32[7 : 0], s03[7 : 0], s13[7 : 0], s23[7 : 0],
    s33[7 : 0], s00[7 : 0], s10[7 : 0], s20[7 : 0]};


    assign Out[255:128] = {s30[15 : 8], s01[15 : 8], s11[15 : 8], s21[15 : 8],
    s31[15 : 8], s02[15 : 8], s12[15 : 8], s22[15 : 8],
    s32[15 : 8], s03[15 : 8], s13[15 : 8], s23[15 : 8],
    s33[15 : 8], s00[15 : 8], s10[15 : 8], s20[15 : 8]};

endmodule