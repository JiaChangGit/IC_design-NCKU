module MixColumns
#
(
parameter DATA_W = 128            //data width
)
(input [DATA_W-1:0] in, output[DATA_W-1:0] out);

// mod(x^8 + x^4 + x^3 + x + 1)
	function [7:0] modPoly;
		input [7:0] x;
		begin
			if(x[7] == 1)
				modPoly = ((x << 1) ^ 8'h1b);
			else
				modPoly = x << 1;
		end
	endfunction

	function [7:0] op_xor;
		input [7:0] x;
		begin
			op_xor = modPoly(x) ^ x;
		end
	endfunction


	genvar i;
	generate
	for(i = 0; i < 4; i = i + 1) begin: MIX
		assign out[(i*32) + 24 +: 8] = modPoly(in[(i*32) + 24 +: 8]) ^ op_xor(in[(i*32) + 16 +: 8]) ^ in[(i*32) + 8 +: 8] ^ in[i*32 +: 8];
		assign out[(i*32) + 16 +: 8] = in[(i*32) + 24 +: 8] ^ modPoly(in[(i*32) + 16 +: 8]) ^ op_xor(in[(i*32) + 8 +: 8]) ^ in[i*32 +: 8];
		assign out[(i*32) + 8 +: 8] = in[(i*32) + 24 +: 8] ^ in[(i*32) + 16 +: 8] ^ modPoly(in[(i*32) + 8 +: 8]) ^ op_xor(in[i*32 +: 8]);
		assign out[i*32 +: 8] = op_xor(in[(i*32) + 24 +: 8]) ^ in[(i*32) + 16 +: 8] ^ in[(i*32) + 8 +: 8] ^ modPoly(in[i*32 +: 8]);
	end
	endgenerate

endmodule
