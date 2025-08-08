


module state_mux (clk, Meander, SR, MC, data_ld, ctrl, out);
    input[15 : 0] Meander, SR, MC, data_ld;
    input [1 : 0] ctrl;
    input clk;
    output [15 : 0] out;

    wire [15 : 0] mux2reg;

    mux_4to1 MUX_inst (Meander, SR, MC, data_ld, ctrl, mux2reg);
    register #(16) REG_inst (mux2reg, clk, out);

endmodule
