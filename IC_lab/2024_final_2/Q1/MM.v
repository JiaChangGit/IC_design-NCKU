`timescale 1ns/10ps
module MM( in_data, col_end, row_end, ep,is_legal, out_data, rst, clk , change_row,valid,busy,overflow);
input           clk;
input           rst;
input           col_end;
input           row_end;
input      [7:0]     in_data;
output [11:0]   out_data;
output  overflow;
output  [1:0] ep;
output  is_legal;
output  change_row,valid,busy;

endmodule
