module SubBytes
#
(
parameter DATA_W = 128            //data width
)
(input [DATA_W-1:0] in, output [DATA_W-1:0] out);

	genvar i;
	generate
		for(i = 0; i < DATA_W; i = i + 8) begin: SUB
			Sbox s(.word(in[i + 7:i]), .hashTB(out[i + 7:i]));
		end
	endgenerate

endmodule
