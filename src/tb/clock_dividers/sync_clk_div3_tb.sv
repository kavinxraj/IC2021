/*********************************************************/
// MODULE: 
//
// FILE NAME: sync_clk_div3_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module clk_div_tb;

logic clk_in;
logic clk_out;
logic rst;

sync_clk_div3 dut (
	.clk( clk_in ),
	.rst( rst ),
	.clk_1b3( clk_out )
);

initial begin
	$dumpfile( "dut.vcd" );
	$dumpvars( 1, dut );
	#500 $finish;
end

initial begin
	clk_in = 'b0;
	rst = 'b0;
	#5 rst = 'b1;
	forever #2 clk_in <= ~clk_in;
end

endmodule
