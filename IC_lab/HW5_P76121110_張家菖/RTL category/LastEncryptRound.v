module LastEncryptRound
#
(
parameter DATA_W = 128,      //data width
parameter KEY_L = 128       //key length
)
(input [DATA_W-1:0] in, input [KEY_L-1:0] key, output [DATA_W-1:0] out);

	wire [DATA_W-1:0] afterSubBytes;
	wire [DATA_W-1:0] afterShiftRows;
	wire [DATA_W-1:0] afterAddroundKey;

	SubBytes SubBT(.in(in), .out(afterSubBytes));
	ShiftRows ShiftR(.in(afterSubBytes), .shifted(afterShiftRows));
	AddRoundKey AddRK(.in(afterShiftRows), .key(key), .out(out));

endmodule
