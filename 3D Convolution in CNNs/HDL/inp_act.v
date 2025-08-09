module act_inp (clk, rst, load_en, data_in, read_addr, data_out);
    input clk;
    input rst;
    input load_en;
    input signed [7:0] data_in;
    input [6:0] read_addr;
    output reg signed [7:0] data_out;
    reg signed [7:0] data [0:80];
    reg [6:0] write_addr;
    always @(posedge clk) begin
        if (rst) begin
            write_addr <= 7'd0;
        end
        else if (load_en && write_addr < 7'd81) begin
            data[write_addr] <= data_in;
            write_addr <= write_addr + 1;
        end
    end
    always @(posedge clk) begin
        if (rst) begin
            data_out <= 8'sd0;
        end
        else begin
            if (read_addr <= 7'd80) begin
                data_out <= data[read_addr];
            end
            else begin
                data_out <= 8'sd0;
            end
        end
    end
endmodule

/////////////////////////

module filter (clk, rst, load_en, data_in, read_addr, data_out);
    input clk;
    input rst;
    input load_en;
    input signed [7:0] data_in;
    input [3:0] read_addr;
    output reg signed [7:0] data_out;
    reg signed [7:0] data [0:8];
    reg [3:0] write_addr;
    always @(posedge clk) begin
        if (rst) begin
            write_addr <= 4'd0;
        end
        else if (load_en && write_addr < 4'd9) begin
            data[write_addr] <= data_in;
            write_addr <= write_addr + 1;
        end
    end
    always @(posedge clk) begin
        if (rst) begin
            data_out <= 8'sd0;
        end
        else begin
            if (read_addr <= 4'd8) begin
                data_out <= data[read_addr];
            end
            else begin
                data_out <= 8'sd0;
            end
        end
    end
endmodule


