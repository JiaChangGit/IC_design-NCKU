module AddRoundKey
#
(
parameter DATA_W = 128,            //data width
parameter KEY_L = 128       //key length
)
(input [DATA_W-1:0] in, input [KEY_L-1:0] key, output [DATA_W-1:0] out);

	assign out = key ^ in;

endmodule
