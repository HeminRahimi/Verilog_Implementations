`timescale 1ns / 100ps

module arc_tan(clk, din, din_tvalid, dout, dout_tready);

    input clk, din_tvalid;
    input [47:0] din;
    output dout_tready;
    output [23:0] dout;
    
    wire [23 : 0] tmp_out;
    assign  dout = tmp_out [23 : 0];
    
    wire [23:0] im, re;
    assign re = din [23:0]; 
    assign im = din [47:24];
    
    cordic_0 inst ( .aclk (clk), 
                    .s_axis_cartesian_tvalid (din_tvalid),
                    .s_axis_cartesian_tdata (din),
                    .m_axis_dout_tvalid (dout_tready),
                    .m_axis_dout_tdata (tmp_out));
                                       
endmodule 

    