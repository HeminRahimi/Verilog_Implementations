module SR(state, out);
    input  [63:0] state;
    output [63:0] out;

    assign out =
    {
    state[63:60], state[43:40],
    state[23:20], state[3:0],
    state[47:44], state[27:24],
    state[7:4],   state[51:48],
    state[31:28], state[11:8],
    state[55:52], state[35:32],
    state[15:12], state[59:56],
    state[39:36], state[19:16]
    };

endmodule