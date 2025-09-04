module Top (clk, rst);

    input clk, rst;

    wire ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch ;
    wire [1 : 0] AluOp;
    wire [6 : 0] instruction_6to0;

    DP inst_Datapath (clk, rst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOp, instruction_6to0);
    Main_controller inst_Controller (clk, instruction_6to0, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, AluOp);

endmodule
