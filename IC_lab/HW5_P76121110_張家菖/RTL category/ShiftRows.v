module ShiftRows
#
(
parameter DATA_W = 128            //data width
)
(
    input [0:DATA_W-1] in,
    output [0:DATA_W-1] shifted
);
    // (r = 0), << 0
    assign shifted[0:7] = in[0:7];
    assign shifted[32:39] = in[32:39];
    assign shifted[64:71] = in[64:71];
    assign shifted[96:103] = in[96:103];

    // (r = 1), << 1
    assign shifted[8:15] = in[40:47];
    assign shifted[40:47] = in[72:79];
    assign shifted[72:79] = in[104:111];
    assign shifted[104:111] = in[8:15];

    // (r = 2), << 2
    assign shifted[16:23] = in[80:87];
    assign shifted[48:55] = in[112:119];
    assign shifted[80:87] = in[16:23];
    assign shifted[112:119] = in[48:55];

    // (r = 3), << 3
    assign shifted[24:31] = in[120:127];
    assign shifted[56:63] = in[24:31];
    assign shifted[88:95] = in[56:63];
    assign shifted[120:127] = in[88:95];
endmodule
