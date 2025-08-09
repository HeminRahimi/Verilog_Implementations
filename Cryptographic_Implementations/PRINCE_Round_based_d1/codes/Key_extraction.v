module Key_extraction(key, k_0, k_0_prim, k_1);
    input [127 : 0] key;
    output [63 : 0] k_0, k_0_prim, k_1;

assign k_0 = key[127:64];
assign k_0_prim = {key[64], key[127:66], key[65] ^ key[127]};
assign k_1 = key[63:0];


endmodule
