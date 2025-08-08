
module round_key(rk_ctrl, rnd_num, k00, k03, SB_out, rk);
    input [1 : 0] rk_ctrl;
    input [3 : 0] rnd_num;
    input [15 : 0] k00, k03, SB_out;
    output [15 : 0] rk;

    reg [7 : 0] reg_rk0, reg_rk1, intermed;
    assign rk = {reg_rk1, reg_rk0};

    reg [7 : 0] Rcon [0 : 9];

    always @ (*)  begin
        Rcon[0] = 8'h01;
        Rcon[1] = 8'h02;
        Rcon[2] = 8'h04;
        Rcon[3] = 8'h08;
        Rcon[4] = 8'h10;
        Rcon[5] = 8'h20;
        Rcon[6] = 8'h40;
        Rcon[7] = 8'h80;
        Rcon[8] = 8'h1B;
        Rcon[9] = 8'h36;
        case (rk_ctrl)
            2'b00 : begin
                intermed = k00[7 : 0] ^ SB_out[7 : 0];
                reg_rk0 = intermed ^ Rcon[rnd_num - 1];
                reg_rk1 = k00[15 : 8] ^ SB_out[15 : 8] ;
            end
            2'b01 : begin
                reg_rk0 = k00[7 : 0] ^ SB_out[7 : 0];
                reg_rk1 = k00[15 : 8] ^ SB_out[15 : 8];
            end
            2'b10 : begin
                reg_rk0 = k00[7 : 0] ^ k03[7 : 0] ;
                reg_rk1 = k00[15 : 8] ^ k03[15 : 8] ;
            end
            default : {reg_rk1, reg_rk0} = 0;
        endcase
    end

endmodule