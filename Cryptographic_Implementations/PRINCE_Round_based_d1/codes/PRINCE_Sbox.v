
module SB_PRINCE (clk, PRNG, inp_share0, inp_share1, F_share0, F_share1);

    input clk;
    input  [17 : 0] PRNG;
    input  [3 : 0] inp_share0, inp_share1;
    output [3 : 0] F_share0, F_share1;

    wire [3 : 0] inp_share0_refereshed, inp_share1_refereshed, inp_sahre1_reg;
    wire [13 : 0] gi_out, gi_reg, hi_out, reg_rnd;

    inp_referesher inst_share0(inp_share0, PRNG[17 : 14], inp_share0_refereshed);
    inp_referesher inst_share1(inp_share1, PRNG[17 : 14], inp_share1_refereshed);

    gi_prime inst_gi_func_calc (inp_share0_refereshed, PRNG[13 : 0], gi_out);
    h_i inst_hi_func_calc(inp_sahre1_reg, hi_out);

    Register #(14) inst_reg_gi (gi_out, clk, gi_reg);
    Register #(14) inst_reg_rand_vals (PRNG[13 : 0], clk, reg_rnd);
    Register #(4) inst_reg_inp_share1 (inp_share1_refereshed, clk, inp_sahre1_reg);

    Sop_share0 inst_sum_of_prod0 (gi_reg, hi_out, F_share0);
    Sop_share1 inst_sum_of_prod1 (hi_out, reg_rnd, F_share1);

endmodule

/////////////

module Sop_share0 (gi_reg, hi_out, output_share0);

    input [13 : 0] gi_reg, hi_out;
    output [3 : 0] output_share0;

    wire a_share0, b_share0, c_share0, d_share0,
         ab_share0, ac_share0, ad_share0,
         bc_share0,bd_share0, cd_share0,
         abc_share0, abd_share0, bcd_share0, acd_share0;

    assign a_share0 = gi_reg[0];
    assign b_share0 = gi_reg[1];
    assign c_share0 = gi_reg[2];
    assign d_share0 = gi_reg[3];

    assign ab_share0 =  gi_reg[4] ^ (gi_reg[0] & hi_out[1]) ^ (gi_reg[1] & hi_out[0]);
    assign ac_share0 =  gi_reg[5] ^ (gi_reg[0] & hi_out[2]) ^ (gi_reg[2] & hi_out[0]);
    assign ad_share0 =  gi_reg[6] ^ (gi_reg[0] & hi_out[3]) ^ (gi_reg[3] & hi_out[0]);
    assign bc_share0 =  gi_reg[7] ^ (gi_reg[1] & hi_out[2]) ^ (gi_reg[2] & hi_out[1]);
    assign bd_share0 =  gi_reg[8] ^ (gi_reg[1] & hi_out[3]) ^ (gi_reg[3] & hi_out[1]);
    assign cd_share0 =  gi_reg[9] ^ (gi_reg[2] & hi_out[3]) ^ (gi_reg[3] & hi_out[2]);

    assign abc_share0 = (ab_share0 & hi_out[2]) ^ (gi_reg[10]) ^ (gi_reg[5] & hi_out[1]) ^ (gi_reg[7] & hi_out[0]) ^ (gi_reg[2] & hi_out[4]); 
    assign abd_share0 = (ab_share0 & hi_out[3]) ^ (gi_reg[11]) ^ (gi_reg[6] & hi_out[1]) ^ (gi_reg[8] & hi_out[0]) ^ (gi_reg[3] & hi_out[4]);
    assign acd_share0 = (ac_share0 & hi_out[3]) ^ (gi_reg[12]) ^ (gi_reg[6] & hi_out[2]) ^ (gi_reg[9] & hi_out[0]) ^ (gi_reg[3] & hi_out[5]);
    assign bcd_share0 = (bc_share0 & hi_out[3]) ^ (gi_reg[13]) ^ (gi_reg[8] & hi_out[2]) ^ (gi_reg[9] & hi_out[1]) ^ (gi_reg[3] & hi_out[7]);          
    
    assign output_share0[0] = 1'b1 ^ a_share0 ^ b_share0 ^ ab_share0 ^ ad_share0 ^ bc_share0 ^ cd_share0 ^ bcd_share0;
    assign output_share0[1] = 1'b1 ^ ac_share0 ^ bc_share0 ^ bd_share0 ^ abc_share0 ^ bcd_share0;
    assign output_share0[2] = a_share0 ^ d_share0 ^ ac_share0 ^ ad_share0 ^ cd_share0 ^ abc_share0 ^ acd_share0;
    assign output_share0[3] = 1'b1 ^ a_share0 ^ c_share0 ^ ab_share0 ^ bc_share0 ^ abd_share0 ^ acd_share0 ^ bcd_share0;

endmodule

///////////////

module Sop_share1 (hi_out, reg_rnd, output_share1);

    input [13 : 0] reg_rnd, hi_out;
    output [3 : 0] output_share1;

    wire a_share1, b_share1, c_share1, d_share1,
         ab_share1, ac_share1, ad_share1,
         bc_share1,bd_share1, cd_share1,
         abc_share1, abd_share1, bcd_share1, acd_share1;

    assign a_share1 = reg_rnd[0] ^ hi_out[0];
    assign b_share1 = reg_rnd[1] ^ hi_out[1];
    assign c_share1 = reg_rnd[2] ^ hi_out[2];
    assign d_share1 = reg_rnd[3] ^ hi_out[3];

    assign ab_share1 = reg_rnd[4] ^ (reg_rnd[0] & hi_out[1]) ^ (reg_rnd[1] & hi_out[0]) ^ (hi_out[4]);
    assign ac_share1 = reg_rnd[5] ^ (reg_rnd[0] & hi_out[2]) ^ (reg_rnd[2] & hi_out[0]) ^ (hi_out[5]);
    assign ad_share1 = reg_rnd[6] ^ (reg_rnd[0] & hi_out[3]) ^ (reg_rnd[3] & hi_out[0]) ^ (hi_out[6]); 
    assign bc_share1 = reg_rnd[7] ^ (reg_rnd[1] & hi_out[2]) ^ (reg_rnd[2] & hi_out[1]) ^ (hi_out[7]);
    assign bd_share1 = reg_rnd[8] ^ (reg_rnd[1] & hi_out[3]) ^ (reg_rnd[3] & hi_out[1]) ^ (hi_out[8]);
    assign cd_share1 = reg_rnd[9] ^ (reg_rnd[2] & hi_out[3]) ^ (reg_rnd[3] & hi_out[2]) ^ (hi_out[9]);

    assign abc_share1 = (ab_share1 & hi_out[2]) ^ reg_rnd[10] ^ (reg_rnd[5] & hi_out[1]) ^ 
                        (reg_rnd[7] & hi_out[0]) ^ (reg_rnd[2] & hi_out[4]);
    assign abd_share1 = (ab_share1 & hi_out[3]) ^ reg_rnd[11] ^ (reg_rnd[6] & hi_out[1]) ^ 
                        (reg_rnd[8] & hi_out[0]) ^ (reg_rnd[3] & hi_out[4]);
    assign acd_share1 = (ac_share1 & hi_out[3]) ^ reg_rnd[12] ^ (reg_rnd[6] & hi_out[2]) ^ 
                        (reg_rnd[9] & hi_out[0]) ^ (reg_rnd[3] & hi_out[5]);
    assign bcd_share1 = (bc_share1 & hi_out[3]) ^ reg_rnd[13] ^ (reg_rnd[8] & hi_out[2]) ^ 
                        (reg_rnd[9] & hi_out[1]) ^ (reg_rnd[3] & hi_out[7]);
    
    assign output_share1[0] = a_share1 ^ b_share1 ^ ab_share1 ^ ad_share1 ^ bc_share1 ^ cd_share1 ^ bcd_share1;
    assign output_share1[1] = ac_share1 ^ bc_share1 ^ bd_share1 ^ abc_share1 ^ bcd_share1;
    assign output_share1[2] = a_share1 ^ d_share1 ^ ac_share1 ^ ad_share1 ^ cd_share1 ^ abc_share1 ^ acd_share1;
    assign output_share1[3] = a_share1 ^ c_share1 ^ ab_share1 ^ bc_share1 ^ abd_share1 ^ acd_share1 ^ bcd_share1;

endmodule

///////

module inp_referesher (inp_shareX, rnd, out_shareX);

    input [3 : 0] inp_shareX, rnd;
    output [3 : 0] out_shareX;

    assign out_shareX[0] = inp_shareX[0] ^ rnd[0];
    assign out_shareX[1] = inp_shareX[1] ^ rnd[1];
    assign out_shareX[2] = inp_shareX[2] ^ rnd[2];
    assign out_shareX[3] = inp_shareX[3] ^ rnd[3];

endmodule


/////////////


module gi_prime (inp, rnd_val, out);
    input [3 : 0] inp;
    input [13 : 0] rnd_val;
    output [13 : 0] out;

    wire a_0, b_0, c_0, d_0;
    assign {a_0, b_0, c_0, d_0} = inp;
    
    assign out[0] = a_0 ^ rnd_val[0];
    assign out[1] = b_0 ^ rnd_val[1];
    assign out[2] = c_0 ^ rnd_val[2];
    assign out[3] = d_0 ^ rnd_val[3];

    assign out[4] = a_0 & b_0 ^ rnd_val[4];
    assign out[5] = a_0 & c_0 ^ rnd_val[5];
    assign out[6] = a_0 & d_0 ^ rnd_val[6];
    assign out[7] = b_0 & c_0 ^ rnd_val[7];
    assign out[8] = b_0 & d_0 ^ rnd_val[8];
    assign out[9] = c_0 & d_0 ^ rnd_val[9];

    assign out[10] = a_0 & b_0 & c_0 ^ rnd_val[10];
    assign out[11] = a_0 & b_0 & d_0 ^ rnd_val[11];
    assign out[12] = a_0 & c_0 & d_0 ^ rnd_val[12];
    assign out[13] = b_0 & c_0 & d_0 ^ rnd_val[13];

endmodule


/////////////


module h_i (inp, out);
    input [3 : 0] inp;
    output [13 : 0] out;

    wire a_1, b_1, c_1, d_1;
    assign {a_1, b_1, c_1, d_1} = inp;

    assign out[0] = a_1;
    assign out[1] = b_1;
    assign out[2] = c_1;
    assign out[3] = d_1;

    assign out[4] = a_1 & b_1;
    assign out[5] = a_1 & c_1;
    assign out[6] = a_1 & d_1;
    assign out[7] = b_1 & c_1;
    assign out[8] = b_1 & d_1;
    assign out[9] = c_1 & d_1;

    assign out[10] = a_1 & b_1 & c_1;
    assign out[11] = a_1 & b_1 & d_1;
    assign out[12] = a_1 & c_1 & d_1;
    assign out[13] = b_1 & c_1 & d_1;

endmodule


/////////////////////


module Register #(parameter N = 1)(in, clk, out);

    input [N-1 : 0] in;
    input clk;
    output reg [N-1 : 0] out;

    always @ (posedge clk) begin

        out <= in;

    end

endmodule





////////////// ----- Testbench ------- /////////////
/*
module TB_Sbox_PRINCE();

reg clk;
reg [18:1] PRNG;
reg [3:0] inp_share0;
reg [3:0] inp_share1;
wire [3:0] output_share0;
wire [3:0] output_share1;

SB_PRINCE MUT (clk, PRNG, inp_share0, inp_share1, output_share0, output_share1);

always #5 clk = ~clk;

reg [3 : 0] cnt;
initial begin 

    $dumpfile("PRINCE_sbox.vcd");
    $dumpvars(0,TB_Sbox_PRINCE);

    PRNG = $random;
    clk = 0 ;
    #10;
    inp_share0 = 0;
    cnt = 0;
    repeat (16) begin 
       inp_share1 = cnt;
       cnt = cnt + 1;
       #10; 
    end

    #10;
    $finish;

end

wire [3:0] OUT_unshared, INP_unshared;

assign OUT_unshared = output_share0 ^ output_share1;
assign INP_unshared = inp_share0 ^ inp_share1;

endmodule 
*/