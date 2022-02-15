/*********************************************************/
// MODULE: 
//
// FILE NAME: csa_tb.sv 
// VERSION: 0.1
// DATE: 2021-Sep-20 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module csa_tb;

parameter DEPTH = 64;
parameter WIDTH = $clog2( DEPTH + 1 );

logic [DEPTH-1:0] i;
logic [WIDTH-2:0] sum;
logic cy;

csa #(
	.DEPTH(DEPTH)
) dut (
	.i( i ),
	.sum( sum ),
	.cy( cy )
);

initial begin
	$monitor("%0t I = %h O = %b_%h",$time, i, cy, sum);
	$dumpfile("dut.vcd");
	$fsdbDumpfile("dut.fsdb");
	$dumpvars(0,dut);
	$fsdbDumpvars(0,dut);
	#1000 $finish;
end

initial begin

		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = {$urandom,$urandom};
		#10 i = 64'h0001_0001_0000_0000;
		#10 i = 64'hffff_ffff_ffff_ffff;
		#10 i = 64'h0000_0000_0000_0000;
		#10 i = 64'h0001_0000_0000_0000;
		#10 i = 64'h000f_0000_0000_0000;
end

endmodule
