module AES
#
(
parameter DATA_W = 128,      //data width
parameter KEY_L = 128,       //key length
parameter NO_ROUNDS = 10     //number of rounds
)
(
    input clk,
    input rst,
    input [DATA_W-1:0] P,
    input [KEY_L-1:0] K,
    output reg [DATA_W-1:0] C,
    output reg valid
);

// write your design here //

reg [KEY_L-1:0] fullkeys [NO_ROUNDS - 1:0];
reg [DATA_W-1:0] stateArr [NO_ROUNDS - 1:0];
wire [KEY_L-1:0] fullkeys_tmp [NO_ROUNDS - 1:0];
wire [DATA_W-1:0] stateArr_tmp [NO_ROUNDS - 1:0];
wire [DATA_W-1:0] result;
reg [3:0] roundCounter;   //  >= NO_ROUNDS

	KeyExpansion KE_first(.oldKey(K), .currentRound(0), .newKey(fullkeys_tmp[0]));
	AddRoundKey AddRK_first (.in(P), .key(K), .out(stateArr_tmp[0]));


	genvar i;
	generate
		for(i = 1; i < NO_ROUNDS; i = i + 1) begin: ROUND
			KeyExpansion KE(.oldKey(fullkeys[i - 1]), .currentRound(i), .newKey(fullkeys_tmp[i]));
			EncryptRound ER(.in(stateArr[i - 1]), .key(fullkeys[i - 1]), .out(stateArr_tmp[i]));
		end
		LastEncryptRound LastER(.in(stateArr[NO_ROUNDS - 1]), .key(fullkeys[NO_ROUNDS - 1]), .out(result));

	endgenerate


	integer j;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			roundCounter <= 0;
			valid <= 0;
			C <= 0;
			for(j = 0; j < NO_ROUNDS; j = j + 1) begin: INIT
				fullkeys[j] <= 0;
				stateArr[j] <= 0;
			end
		end
		else begin
			for(j = 0; j < NO_ROUNDS; j = j + 1) begin: ASSIGN
				fullkeys[j] <= fullkeys_tmp[j];
				stateArr[j] <= stateArr_tmp[j];
			end
			if (roundCounter > 10) begin
				C <= result;
				valid <= 1;
			end
			else begin
				C <= 0;
				valid <= 0;
				roundCounter <= roundCounter + 1;
			end
		end
	end

endmodule
