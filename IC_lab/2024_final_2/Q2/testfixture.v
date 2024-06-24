`timescale 1ns/10ps
// `define SDFFILE    "../SYN/SET_syn.sdf"    // Modify your sdf file name here
`define cycle 25.0
`define terminate_cycle 400000000 // Modify your terminate cycle here


module testfixture1;
`define ep1 "ep.dat"
`define in_pattern1 "in.dat"
`define  result1 "out.dat"
`define  shape1 "mx_shape.dat"
parameter total_test = 100;//number of total cases
reg clk = 0;
reg rst;
reg [7:0] in_data;
wire busy;
wire valid;
wire [31:0] out_data;
reg col_end,row_end;
integer err_cnt;
wire change_row;
wire [2:0] ep;
wire is_legal;
reg [7:0] in_mem [0:1000000],in_mem2 [0:10000],in_mem3 [0:10000];//max input size
reg [31:0] out_mem [0:1000000],out_mem2 [0:10000],out_mem3 [0:10000];//max output size
reg [3:0] shape_mem[0:1000000],shape_mem2[0:10000],shape_mem3[0:10000];
reg [3:0] ep_mem[0:1000000];

`ifdef SDF
initial $sdf_annotate(`SDFFILE, u_set);
`endif


initial begin
	$timeformat(-9, 1, " ns", 9); //Display time in nanoseconds
	$readmemh(`in_pattern1, in_mem);
	$readmemh(`ep1, ep_mem);
	// $readmemh(`in_pattern2, in_mem2);
	// $readmemh(`in_pattern3, in_mem3);
	$readmemh(`result1, out_mem);
	// $readmemh(`result2, out_mem2);
	// $readmemh(`result3, out_mem3);
	$readmemh(`shape1, shape_mem);
	// $readmemh(`shape2, shape_mem2);
	// $readmemh(`shape3, shape_mem3);
	$display("--------------------------- [ Simulation START !! ] ---------------------------");
end



always #(`cycle/2) clk = ~clk;



MM u_set(.clk(clk),
        .rst(rst),
        .in_data(in_data),
        .col_end(col_end),
        .row_end(row_end),
		.busy(busy),
		.valid(valid),
        .ep(ep),
		.is_legal(is_legal),
        .out_data(out_data),
		.change_row(change_row));

integer k,current_k,shape_mem_index,mx2_size,mx1_size,mx3_size;
integer p,check_index,out_num,total,p_n,score,total_error;

integer mx1_total_row,mx2_total_row,mx3_total_row,mx_row_cnt,current_num,output_row,output_col,row1,col1,row2,col2,row3,col3,outdat_flag;
initial begin
    rst = 0;
	err_cnt = 0;
	k = 0;
	shape_mem_index = 0;
	current_k = 0;
	out_num = 0;
	total = 0;
	score = 0;
	current_num = 0;
	outdat_flag = 0;
# `cycle;     
	rst = 1;
#(`cycle*3);
	rst = 0;
	for(p = 0; p<total_test; p = p+1) begin
		//mx1 data
		mx1_total_row = shape_mem[shape_mem_index];
		row1 = shape_mem[shape_mem_index];
		mx1_size = 0;
		for(mx_row_cnt = 0;mx_row_cnt < mx1_total_row;mx_row_cnt = mx_row_cnt + 1)begin
			mx1_size = mx1_size + shape_mem[shape_mem_index+mx_row_cnt+1];	
		end
		for (k = 0; k<mx1_size; k = k+1) begin
			@(negedge clk);	
				wait(busy == 0);
					if(k == current_num + shape_mem[shape_mem_index+1] - 1)begin
						col_end = 1;
						current_num = current_num + shape_mem[shape_mem_index+1];
						shape_mem_index = shape_mem_index + 1;
						col1 = shape_mem[shape_mem_index];
					end
					else col_end = 0;

					if(k == mx1_size - 1)begin
						row_end = 1;
						shape_mem_index = shape_mem_index + 1;
					end
					else row_end = 0;
					in_data = in_mem[current_k+k];
		end
		current_k = current_k+k;
		current_num = 0;
		mx2_total_row = shape_mem[shape_mem_index];
		row2 = shape_mem[shape_mem_index];
		mx2_size = 0;
		@(posedge clk);
		#(`cycle/4)
		if(busy)begin
			@(negedge clk);
			col_end =0;
			row_end = 0;
			wait(busy == 0);
		end
		//mx2 data
		for(mx_row_cnt = 0;mx_row_cnt < mx2_total_row;mx_row_cnt = mx_row_cnt + 1)begin
			mx2_size = mx2_size + shape_mem[shape_mem_index+mx_row_cnt+1];	
		end
		for (k = 0; k<mx2_size; k = k+1) begin
			@(negedge clk);
					wait(busy == 0);
					if(k == current_num + shape_mem[shape_mem_index+1] - 1)begin
						col_end = 1;
						current_num = current_num + shape_mem[shape_mem_index+1];
						shape_mem_index = shape_mem_index + 1;
						col2 = shape_mem[shape_mem_index];
					end
					else col_end = 0;

					if(k == mx2_size - 1)begin
						row_end = 1;
						shape_mem_index = shape_mem_index + 1;
					end
					else row_end = 0;
					in_data = in_mem[current_k+k];
		end
		current_k = current_k+k;
		current_num = 0;
		mx3_total_row = shape_mem[shape_mem_index];
		row3 = shape_mem[shape_mem_index];
		mx3_size = 0;
		@(posedge clk);
		#(`cycle/4)
		if(busy)begin
			@(negedge clk);
			col_end =0;
			row_end = 0;
			wait(busy == 0);
		end
		//mx3
		for(mx_row_cnt = 0;mx_row_cnt < mx3_total_row;mx_row_cnt = mx_row_cnt + 1)begin
			mx3_size = mx3_size + shape_mem[shape_mem_index+mx_row_cnt+1];	
		end
		for (k = 0; k<mx3_size; k = k+1) begin
			@(negedge clk);
			
				wait(busy == 0);
					if(k == current_num + shape_mem[shape_mem_index+1] - 1)begin
						col_end = 1;
						current_num = current_num + shape_mem[shape_mem_index+1];
						shape_mem_index = shape_mem_index + 1;
						col3 = shape_mem[shape_mem_index];
					end
					else col_end = 0;

					if(k == mx3_size - 1)begin
						row_end = 1;
						shape_mem_index = shape_mem_index + 1;
					end
					else row_end = 0;
					in_data = in_mem[current_k+k];
		end
		current_k = current_k+k;
		current_num = 0;
		@(posedge clk);
		#(`cycle/4)
		if(busy)begin
			@(negedge clk);
			col_end =0;
			row_end = 0;
		end
		begin:Test
			for(check_index=0;check_index<row1 * col3;check_index=check_index+1)begin//start here
				#(`cycle)
				wait (valid == 1);
				@(negedge clk); begin
					if(ep_mem[p] == 3'b000)begin//three matrix all legal
						if(ep === ep_mem[p])begin
							if(col1 == row2 && col2 == row3)begin//can multiply
								outdat_flag = 1;
								if (out_data === out_mem[out_num + check_index] && is_legal == 1)//答案對，換行檢查
									if(check_index % col3 == col3 - 1)begin
										if(change_row == 1)begin
											$display(" 1:Pattern %d is PASS !", total + check_index);						
										end
										else  begin
											$display(" 2:Pattern %d out_data is PASS ! but change_row is FAIL !. Expected 1 but get %d", total + check_index,change_row);
											err_cnt = err_cnt + 1;
										end
									end
									else begin
										if(change_row == 0)begin
											$display(" 3:Pattern %d is PASS !", total + check_index); //Expected value = %d, but the Response value = %d !!", total + check_index, out_mem[out_num + check_index], out_data						
										end
										else  begin
											$display(" 4:Pattern %d out_data is PASS ! but change_row is FAIL !. Expected 0 but get 1", total + check_index);
											err_cnt = err_cnt + 1;
										end
									end
								else begin
									$display(" 5:Pattern %d is FAIL !. Expected value/is_legal = %d/1,but the Response value/is_legal = %d/%d !! ", total + check_index, out_mem[out_num + check_index], out_data,is_legal);
									err_cnt = err_cnt + 1;
								end
							end	
							else begin//can not multiply
								if(is_legal == 0)begin
									$display(" 6:Pattern %d is PASS !", total + check_index);
								end
								else begin
									$display(" 7:Pattern %d is FAIL !. Expected is_legal = %d, but the Response is_legal = %d !!", total + check_index,0,is_legal);//check
									err_cnt = err_cnt + 1;
								end
								disable Test;
							end
						end
						else begin
							$display(" 8:Pattern %d ep is FAIL !. Expected 0 but get %d", total + check_index,ep);
							err_cnt = err_cnt + 1;
							disable Test;
						end
					end
					else begin//no need to multiply
						if(ep === ep_mem[p])begin
							if(is_legal == 0)begin
								$display(" 9:Pattern %d is PASS !", total + check_index);
							end
							else begin
								$display(" 10:Pattern %d ep is PASS !. but is_legal is FAIL !. Expected is_legal = %d, but the Response is_legal = %d !!", total + check_index,0,is_legal);//check
								err_cnt = err_cnt + 1;
							end
						end
						else begin
							$display(" 11:Pattern %d ep is FAIL !. Expected %d but get %d", total + check_index,ep_mem[p],ep);
							err_cnt = err_cnt + 1;
						end
						disable Test;
					end
				end
			end
		end
		if(outdat_flag == 1)begin
			out_num = out_num + row1 * col3;
			total = total + row1 * col3;	
		end
		else total = total + 1;
		outdat_flag = 0;
		wait(busy == 0);
		// if(err_cnt>0)$stop;
	end



#(`cycle*2); 
     $display("--------------------------- Simulation FINISH !!---------------------------");
	//  $display("score = %d/100",score);
     if (err_cnt) begin 
     	$display("============================================================================");
     	$display("\n (T_T) FAIL!! The simulation result is FAIL!!! there were %d errors at all.\n", err_cnt);
	$display("============================================================================");
	end
     else begin 
     	$display("============================================================================");
	$display("\n \\(^o^)/ CONGRATULATIONS!!  The simulation result is PASS!!!\n");
	$display("============================================================================");
	end
$stop;
end


always@(err_cnt) begin
	if (err_cnt == 100) begin
	// 	$display("score = %d/100",score);
	$display("============================================================================");
     	$display("\n (>_<) FAIL!! The simulation FAIL result is too many ! Please check your code @@ \n");
	$display("============================================================================");
	$stop;
	end
end

initial begin 
	#`terminate_cycle;
	// $display("score = %d/100",score);
	$display("================================================================================================================");
	$display("--------------------------- (/`n`)/ ~#  There was something wrong with your code !! ---------------------------"); 
	$display("--------------------------- The simulation can't finished!!, Please check it !!! ---------------------------"); 
	$display("================================================================================================================");
	$stop;
end


endmodule
