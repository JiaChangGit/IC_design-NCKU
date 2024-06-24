module MixColumns
#
(
parameter DATA_W = 128            //data width
)
(input [DATA_W-1:0] in, output[DATA_W-1:0] out);

// multiply by 2
// multiplication by 2 is shifting on bit to the left, and if the original 8 bits had a 1 @ MSB, xor the result with {1b}
	function [7:0] multiply2;
		input [7:0] x;
		begin
			if(x[7] == 1)
				multiply2 = ((x << 1) ^ 8'h1b);
			else
				multiply2 = x << 1;
		end
	endfunction

// multiply by 3
/* 
	multiplication by 3 is done by:
		multiplication by {02} xor(the original x)
		so that 2+1=3. where xor is the addition of elements in finite fields
*/
	function [7:0] op_xor;
		input [7:0] x;
		begin
			op_xor = multiply2(x) ^ x;
		end
	endfunction


	genvar i;
	generate
	for(i = 0; i < 4; i = i + 1) begin: MIX
		assign out[(i*32) + 24 +: 8] = multiply2(in[(i*32) + 24 +: 8]) ^ op_xor(in[(i*32) + 16 +: 8]) ^ in[(i*32) + 8 +: 8] ^ in[i*32 +: 8];
		assign out[(i*32) + 16 +: 8] = in[(i*32) + 24 +: 8] ^ multiply2(in[(i*32) + 16 +: 8]) ^ op_xor(in[(i*32) + 8 +: 8]) ^ in[i*32 +: 8];
		assign out[(i*32) + 8 +: 8] = in[(i*32) + 24 +: 8] ^ in[(i*32) + 16 +: 8] ^ multiply2(in[(i*32) + 8 +: 8]) ^ op_xor(in[i*32 +: 8]);
		assign out[i*32 +: 8] = op_xor(in[(i*32) + 24 +: 8]) ^ in[(i*32) + 16 +: 8] ^ in[(i*32) + 8 +: 8] ^ multiply2(in[i*32 +: 8]);
	end
	endgenerate

endmodule
