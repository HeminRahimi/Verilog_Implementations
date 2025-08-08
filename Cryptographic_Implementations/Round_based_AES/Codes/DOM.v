
module And_DOM_indep_d1 (bx, by, r, clk,  bz);

    input clk;
    input [1:0] bx, by;
    input r;
    output [1 : 0] bz;

    wire  xorout0, xorout1, xorout2, xorout3,
          reg_out0, reg_out1, reg_out2, reg_out3,
          AND0, AND1, AND2, AND3;
    
    assign AND0 = bx[0] & by[0] ;
    assign AND1 = bx[0] & by[1];
    assign AND2 = bx[1] & by[0];
    assign AND3 = bx[1] & by[1] ;

    assign xorout0 = r ^ (AND1);
    assign xorout1 = r ^ (AND2);

    register #(1) DFF0 (xorout0, clk, reg_out0);
    register #(1) DFF1 (xorout1, clk, reg_out1);
    register #(1) DFF2 (AND0, clk, reg_out2);
    register #(1) DFF3 (AND3, clk, reg_out3);

    assign xorout2 = reg_out0 ^ reg_out2;
    assign xorout3 = reg_out1 ^ reg_out3;

    assign bz = {xorout3, xorout2};

endmodule
