/*********************************************************/
// MODULE: 
//
// FILE NAME: arst_sync_const_p_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arst_sync_const_p_tb;

logic clk, rst_i, rst_o;

arst_sync_const_p dut (
	.clk( clk ),
	.rst_i( rst_i ),
	.rst_o( rst_o )
);

initial begin
	$dumpfile( "dut.vcd" );
	$dumpvars( 0, dut );
	#100 $finish;
end

initial begin
	#10 rst_i = 'b1;
	#1 rst_i = 'b0;
	#1 rst_i = 'b1;
end

initial begin
	clk = 'b0;
	forever #2 clk = ~clk;
end

endmodule: arst_sync_const_p_tb
