`timescale 1ns/10ps
`define CYCLE    10.0

`define EXPECT "./golden.dat"
`define DATA   "./pat.dat"

module test;
parameter DATA_N_PAT = 16;
parameter t_reset = `CYCLE*2;


reg clk;
reg reset;
reg [6:0] err_IRAM;
reg [7:0]  out_mem[0:15];


wire IROM_rd;
wire [3:0] IROM_A;
wire IRAM_valid;
wire [7:0] IRAM_D;
wire [3:0] IRAM_A;
wire done;
wire [7:0]  IROM_Q;


integer i, j, k, l, err;

reg over;

	SORT U_SORT(.clk(clk), .reset(reset), 
                .IROM_rd(IROM_rd), .IROM_A(IROM_A), .IROM_Q(IROM_Q),//ROM
                .IRAM_valid(IRAM_valid), .IRAM_D(IRAM_D), .IRAM_A(IRAM_A),//RAM
		     	.done(done));

	IROM  IROM_1 (.clk(clk), .reset(reset), .IROM_rd(IROM_rd), .IROM_data(IROM_Q), .IROM_addr(IROM_A));

	IRAM  IRAM_1 (.clk(clk),.IRAM_valid(IRAM_valid), .IRAM_data(IRAM_D), .IRAM_addr(IRAM_A));

initial	$readmemh (`EXPECT, out_mem);

initial begin
   clk         = 1'b0;
   reset       = 1'b0;
   over	       = 1'b0;
   l	       = 0;
   err         = 0;   
end

always begin #(`CYCLE/2) clk = ~clk; end

initial begin
   @(negedge clk)  reset = 1'b1;
   #t_reset        reset = 1'b0;
                                  
end

initial @(posedge done) 
begin
	for(k=0;k<16;k=k+1)begin
		if( IRAM_1.IRAM_M[k] !== out_mem[k]) 
		begin
			$display("ERROR at %d:output %h !=expect %h ",k, IRAM_1.IRAM_M[k], out_mem[k]);
			err = err+1 ;
		end
		else if ( out_mem[k] === 8'dx)
		begin
			$display("ERROR at %d:output %h !=expect %h ",k, IRAM_1.IRAM_M[k], out_mem[k]);
			err=err+1;
		end   
		over=1'b1;
	end
	if (err === 0 &&  over===1'b1  )  
	begin
		$display("All data have been generated successfully!\n");
		$display("-------------------PASS-------------------\n");
	#10 $finish;
	end
	else if( over===1'b1 )
	begin 
		$display("There are %d errors!\n", err);
		$display("---------------------------------------------\n");
	#10 $finish;
	end
end

endmodule


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
module IROM (IROM_rd, IROM_data, IROM_addr, clk, reset);
input		IROM_rd;
input	[3:0] 	IROM_addr;
output	[7:0]	IROM_data;
input		clk, reset;

reg [7:0] sti_M [0:15];
integer i;

reg	[7:0]	IROM_data;

initial begin
	@ (negedge reset) $readmemh (`DATA , sti_M);
	end

always@(negedge clk) 
	if (IROM_rd) IROM_data <= sti_M[IROM_addr];
	
endmodule
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

module IRAM (clk, IRAM_valid, IRAM_data, IRAM_addr);
input	IRAM_valid;
input	[3:0] 	IRAM_addr;
input	[7:0]	IRAM_data;
input	clk;

reg [7:0] IRAM_M [0:15];
integer i;

initial begin
	for (i=0; i<=15; i=i+1) IRAM_M[i] = 0;
end

always@(negedge clk) 
	if (IRAM_valid) IRAM_M[ IRAM_addr ] <= IRAM_data;

endmodule

