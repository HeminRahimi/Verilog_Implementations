module tb_top #(parameter stride = 1) ();


    reg clk, reset, go, rst_data, ld, lf_0, lf_1;
    reg signed [7:0] data_in_R, data_in_G, data_in_B, 
                     data_in_f0_R, data_in_f0_G, data_in_f0_B, 
                     data_in_f1_R, data_in_f1_G, data_in_f1_B;
    wire done, out_valid;
    wire signed [31:0] Y;
    
    integer file; // File handle for output
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Instantiate top module
    top #(stride) MUT (
        .clk(clk),
        .reset(reset),
        .go(go),
        .rst_data(rst_data),
        .ld(ld),
        .lf_0(lf_0),
        .lf_1(lf_1),
        .data_in_R(data_in_R),
        .data_in_G(data_in_G),
        .data_in_B(data_in_B),
        .data_in_f0_R(data_in_f0_R),
        .data_in_f0_G(data_in_f0_G),
        .data_in_f0_B(data_in_f0_B),
        .data_in_f1_R(data_in_f1_R),
        .data_in_f1_G(data_in_f1_G),
        .data_in_f1_B(data_in_f1_B),
        .Out(Y),
        .out_valid(out_valid),
        .done(done)
    );
    
    // Data arrays
    reg signed [7:0] R [0:80];
    reg signed [7:0] G [0:80];
    reg signed [7:0] B [0:80];
    reg signed [7:0] f0R [0:8];
    reg signed [7:0] f1R [0:8];
    reg signed [7:0] f0G [0:8];
    reg signed [7:0] f1G [0:8];    
    reg signed [7:0] f0B [0:8];
    reg signed [7:0] f1B [0:8];
    
    reg [7 : 0] i;
    // Initial block for simulation
    initial begin 
        $display("SIMULATION STARTED WITH STRIDE = %0d", stride);
        // Initialize signals
        clk = 1;
        rst_data = 1;
        reset = 1;
        go = 0;
        ld = 0;
        lf_0 = 0;
        lf_1 = 0;
        
        // Open output file
        file = $fopen("../Generated_data/output_from_RTL.txt", "w");
        if (file == 0) $display("Error: Could not open output_from_RTL.txt");
        
        // Load data from files
        $readmemh("../Generated_data/data_R.txt", R, 0, 80);
        $readmemh("../Generated_data/data_G.txt", G, 0, 80);
        $readmemh("../Generated_data/data_B.txt", B, 0, 80);
        $readmemh("../Generated_data/first_filterR.txt", f0R, 0, 8);
        $readmemh("../Generated_data/first_filterG.txt", f0G, 0, 8);
        $readmemh("../Generated_data/first_filterB.txt", f0B, 0, 8);
        $readmemh("../Generated_data/second_filterR.txt", f1R, 0, 8);
        $readmemh("../Generated_data/second_filterG.txt", f1G, 0, 8);
        $readmemh("../Generated_data/second_filterB.txt", f1B, 0, 8);
        
        #10;
        // Load RGB data
        rst_data = 0;
        reset = 0;
        ld = 1;
        for (i = 0; i < 81; i = i + 1) begin
            data_in_R = R[i];
            data_in_G = G[i];
            data_in_B = B[i];
            #10;
        end
        ld = 0;
        
        // Load filter data
        lf_0 = 1;
        lf_1 = 1;
        rst_data = 1;
        #10;
        rst_data = 0;
        for (i = 0; i < 9; i = i + 1) begin
            data_in_f0_R = f0R[i];
            data_in_f1_R = f1R[i];
            data_in_f0_G = f0G[i];
            data_in_f1_G = f1G[i];
            data_in_f0_B = f0B[i];
            data_in_f1_B = f1B[i];
            #10;
        end
        lf_0 = 0;
        lf_1 = 0;
        
        // Start convolution
        go = 1;
        #10;
        go = 0;
        
        #12800;
        // Close file and end simulation
        $fclose(file);
        $finish;
    end
    
    // Write Y to file when out_valid is 1
    always @(posedge clk) begin
        if (out_valid == 1) begin
            $fwrite(file, "%h\n", Y); // Write Y in hex, one per line
        end
    end
    
endmodule