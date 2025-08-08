// This module is a prototype and may not be fully secure.

module r0_mapper(clk, r0_in, r0_out);

    input [7 : 0] r0_in;
    input clk;
    output [7 : 0] r0_out;

    wire [7 : 0] mapped_val, mux_out;
    wire nor_to_sel;

    mux_2to1 mux_inst (r0_in, mapped_val, nor_to_sel, mux_out);

    assign nor_to_sel = ~ (r0_in[0] | r0_in[1] | r0_in[2] | r0_in[3] |
    r0_in[4] | r0_in[5] | r0_in[6] | r0_in[7]);

    register #(8) inst_reg0 (mux_out, clk, r0_out); 
    
    assign mapped_val[0] = r0_out[0] ^ r0_out[2];
    assign mapped_val[1] = r0_out[1] ^ ~(r0_out[7]);
    assign mapped_val[2] = ~r0_in[0];
    assign mapped_val[3] = r0_out[3];
    assign mapped_val[4] = r0_out[4] ^ r0_out[6];
    assign mapped_val[5] = ~r0_out[5];
    assign mapped_val[6] = ~r0_in[0];
    assign mapped_val[7] = r0_out[7];


endmodule