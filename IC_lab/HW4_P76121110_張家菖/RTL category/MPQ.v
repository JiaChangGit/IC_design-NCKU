// vlog testfixture.v +define+P0

module MPQ(clk,rst,data_valid,data,cmd_valid,cmd,index,value,busy,RAM_valid,RAM_A,RAM_D,done);
input clk;
input rst;
input data_valid;
input [7:0] data;
input cmd_valid;
input [2:0] cmd;
input [7:0] index;
input [7:0] value;
output reg busy;
output reg RAM_valid;
output reg [7:0]RAM_A;
output reg [7:0]RAM_D;
output reg done;

	parameter [2:0] LOAD = 3'b000, READ_CMD = 3'b001, EXE_CMD = 3'b010, MaxHeapify = 3'b011, SWAP = 3'b100, DONE = 3'b101;
	reg [2:0] state, nextState;

	parameter [2:0] Build = 3'b000, Extract_Max = 3'b001, Increase_Value = 3'b010, Insert_Data = 3'b011, Write = 3'b100;

	reg [2:0] tmp_cmd;
	reg [7:0] heap [0:255];
	reg [7:0] size, parentID, tmpID;
	wire [7:0] leftChild, rightChild;

	
	assign leftChild = (parentID << 1) + 1;
	assign rightChild = (parentID << 1) + 2;

	always @(posedge clk or posedge rst) 
	begin
		if (rst)
			state <= LOAD;
		else
			state <= nextState;
	end

	// Next State
	always @(*) 
	begin
		case (state)
			LOAD: begin
				if (data_valid)
					nextState = LOAD;
				else
					nextState = DONE;  
			end
			READ_CMD: begin
				nextState = EXE_CMD;
			end
			EXE_CMD: begin
				case(tmp_cmd)
					Build: begin
						nextState = MaxHeapify;
					end
					Extract_Max: begin
						nextState = MaxHeapify;
					end
					Increase_Value: begin
						nextState = SWAP;
					end
					Insert_Data: begin
						nextState = SWAP;
					end
					Write: begin
						nextState = EXE_CMD;
					end
					3'b101: begin
						nextState = DONE;
					end
					3'b111: begin
						nextState = EXE_CMD;
					end
				endcase
			end  
			MaxHeapify: begin
				if (((leftChild < size) && (heap[leftChild] > heap[parentID]))||((rightChild < size) && (heap[rightChild] > heap[parentID])))
					nextState = MaxHeapify;
				else
					nextState = EXE_CMD;
			end
			SWAP: begin
				if (tmpID > 0 && (heap[(tmpID - 1) >> 1] < heap[tmpID]))
					nextState = SWAP;
				else
					nextState = DONE;
			end
			DONE: begin
				nextState = READ_CMD;
			end
		endcase
	end

	// Output
	always @(posedge clk or posedge rst) 
	begin
		if (rst) begin
			RAM_valid <= 0;
			RAM_A <= 0;
			RAM_D <= 0;
			busy <= 1;  //// because of it, we cannot combine state
			done <= 0;
			size <= 0;
			parentID <= 0;
			tmpID <= 0;
			tmp_cmd <= 3'b0;
		end else begin
			case (state)
				LOAD: begin
					if (data_valid) begin
						heap[size] <= data;
						size <= size + 1;
					end
				end
				READ_CMD: begin
					if(cmd_valid) begin
						case (cmd)
							Build: begin
								tmp_cmd <= 3'b000;
								parentID <= (size >> 1);
								tmpID <= (size >> 1);
							end
							Extract_Max: begin
								tmp_cmd <= 3'b001;
								tmpID <= size;
							end
							Increase_Value: begin
								tmp_cmd <= 3'b010;
								heap[index] <= value;
								tmpID <= index;
							end
							Insert_Data: begin
								tmp_cmd <= 3'b011;
								heap[size] <= value;
								size <= size + 1;
								tmpID <= size;
							end
							Write: begin
								tmp_cmd <= 3'b100;
								tmpID <= 0;
							end
						endcase
						busy <= 1;
					end
				end
				EXE_CMD: begin
					case(tmp_cmd)
						Build: begin
							if (tmpID == 0) begin
								tmp_cmd <= 3'b101;
							end else begin
								tmpID <= tmpID - 1;
								parentID <= tmpID - 1;
							end
						end
						Extract_Max: begin
							if (tmpID - 1 == size)
								tmp_cmd <= 3'b101;
							else begin 
								heap[0] <= heap[size - 1];
								size <= size - 1;
								parentID <= 0;
							end
						end
						Write: begin
							if (tmpID < size) begin
								RAM_valid <= 1;
								RAM_D <= heap[tmpID];
								tmpID <= tmpID + 1;
								RAM_A <= tmpID;
							end else begin
								tmp_cmd <= 3'b101;
								RAM_valid <= 0;
								done <= 1;
							end
						end
					endcase
					busy <= 1;
				end
				MaxHeapify: begin
					if(((leftChild < size) && (heap[leftChild] > heap[parentID])) || ((rightChild < size) && (heap[rightChild] > heap[parentID]))) begin
						if((rightChild < size) && (heap[rightChild] > heap[leftChild])) begin
							parentID <= rightChild;
							heap[rightChild] <= heap[parentID];
							heap[parentID] <= heap[rightChild];
						end else begin
							parentID <= leftChild;
							heap[leftChild] <= heap[parentID];
							heap[parentID] <= heap[leftChild];
						end
					end
				end
				SWAP: begin
					if ((tmpID > 0) && (heap[(tmpID - 1) >> 1] < heap[tmpID])) begin
						heap[(tmpID - 1) >> 1] <= heap[tmpID];
						heap[tmpID] <= heap[(tmpID - 1) >> 1];
						tmpID <= (tmpID - 1) >> 1;
					end else 
						tmp_cmd <= 3'b101;
				end
				DONE: begin
					RAM_valid <= 0;
					RAM_A <= 0;
					RAM_D <= 0;
					busy <= 0;
					done <= 0;
					parentID <= 0;
					tmpID <= 0;
					tmp_cmd <= 3'b0;
				end
			endcase
		end
	end

endmodule