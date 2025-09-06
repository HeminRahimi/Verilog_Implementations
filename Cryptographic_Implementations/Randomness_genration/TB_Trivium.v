module TB_trivium();
  
    reg clk, rst;
    reg [79 : 0] k, iv;
    wire  out;

    trivium DUT (clk, rst, iv, k, out);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("trivium.vcd");
        $dumpvars(0, TB_trivium);        
        clk = 0 ;
        rst = 1;
        k =  80'hC653219648_4E82B72473;
        iv = 80'hF35295A3BD_0235971F25;
        #10;
        rst = 0;
        #10000;
        $finish;

    end

endmodule
