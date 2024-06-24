`timescale 1ns/10ps
module MM( in_data, col_end, row_end, is_legal, out_data, rst, clk , change_row,valid,busy);
input           clk;
input           rst;
input           col_end;
input           row_end;
input      [7:0]     in_data;

output reg signed [19:0]   out_data;
output reg is_legal;
output reg change_row,valid,busy;
	// State
	parameter [2:0] LOADMX1 = 3'b000, LOADMX2 = 3'b001, MUL = 3'b010, WAIT = 3'b011, ILLEGAL = 3'b100, DONE = 3'b101;
	reg [2:0] state, nextState;

	// Matrix 1
	reg signed [7:0] MX1[3:0][3:0];
	reg [2:0] MX1_R, MX1_C, MX1_Rcur, MX1_Ccur;

	// Matrix 2
	reg signed [7:0] MX2[3:0][3:0];
	reg [2:0] MX2_R, MX2_C, MX2_Ccur;

	// State Register
	always @(posedge clk or posedge rst) begin
		if (rst)
			state <= LOADMX1;
		else
			state <= nextState;
	end

	// Next State
	always @(*) begin
		case (state)
			LOADMX1: begin
				if (row_end) 
					nextState = LOADMX2;    
				else 
					nextState = LOADMX1;
			end
			LOADMX2: begin
				if (row_end) begin
					if (MX1_C == MX2_R + 1) 
						nextState = MUL;
					else
						nextState = ILLEGAL;
				end else 
					nextState = LOADMX2;
			end
			MUL: begin
				if (MX1_Ccur == MX1_C - 1)
					if((MX1_Rcur == MX1_R - 1) && (MX2_Ccur == MX2_C - 1))
						nextState = DONE;
					else
						nextState = WAIT;
				else
					nextState = MUL;
			end
			WAIT: begin
				nextState = MUL;
			end
			ILLEGAL: begin
				nextState = DONE;
			end
			DONE: begin
				nextState = LOADMX1;
			end
		endcase
	end

	// Output logic
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			out_data <= 0;
			is_legal <= 0;
			change_row <= 0;
			valid <= 0;
			busy <= 0;
			MX1_R <= 0;
			MX1_C <= 0;
			MX1_Rcur <= 0;
			MX1_Ccur <= 0;
			MX2_R <= 0;
			MX2_C <= 0;
			MX2_Ccur <= 0;
		end else begin
			case (state)
				LOADMX1: begin
					MX1[MX1_R][MX1_C] <= in_data;

					if (col_end) begin
						MX1_R <= MX1_R + 1;
						MX1_C <= 0;
					end else
						MX1_C <= MX1_C + 1;

					if (row_end) begin
						MX1_R <= MX1_R + 1;
						MX1_C <= MX1_C + 1;
					end
					
					//out_data <= 0;
					//is_legal <= 0;
					//change_row <= 0;
					//valid <= 0;
					//busy <= 0;
				end
				LOADMX2: begin
					MX2[MX2_R][MX2_C] <= in_data;
					
					if (col_end) begin
						MX2_R <= MX2_R + 1;
						MX2_C <= 0;
					end else
						MX2_C <= MX2_C + 1;

					if (row_end) begin
						MX2_R <= MX2_R + 1;
						MX2_C <= MX2_C + 1;
						busy <= 1;
					end else
						busy <= 0;
					
					//out_data <= 0;
					//is_legal <= 0;
					//change_row <= 0;
					//valid <= 0;     
				end
				MUL: begin
					if ((MX1_Ccur == MX1_C - 1)) begin
						MX1_Ccur <= 0;
						is_legal <= 1;
						valid <= 1;
						
						if (MX2_Ccur == MX2_C - 1) begin
							MX2_Ccur <= 0;
							MX1_Rcur <= MX1_Rcur + 1;
							change_row <= 1;
						end else
							MX2_Ccur <= MX2_Ccur + 1;

					end else begin
						MX1_Ccur <= MX1_Ccur + 1;
						is_legal <= 0;
						valid <= 0;
						change_row <= 0;
					end						
					
					out_data <= out_data + (MX1[MX1_Rcur][MX1_Ccur] * MX2[MX1_Ccur][MX2_Ccur]);
				end
				WAIT: begin
					out_data <= 0;
					//is_legal <= 0;
					change_row <= 0;
					valid <= 0;
					//busy <= 0;             
				end
				ILLEGAL: begin
					out_data <= 0;
					//is_legal <= 0;
					change_row <= 0;
					valid <= 1;
					//busy <= 0;             
				end
				DONE: begin
					MX1_R <= 0;
					MX1_C <= 0;
					MX1_Rcur <= 0;
					MX1_Ccur <= 0;
					MX2_R <= 0;
					MX2_C <= 0;
					MX2_Ccur <= 0;
					out_data <= 0;
					is_legal <= 0;
					change_row <= 0;
					valid <= 0;
					busy <= 0;            
				end
			endcase
		end
	end

endmodule
