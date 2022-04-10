/*********************************************************/
// MODULE: 
//
// FILE NAME: arst_sync_comb_p_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arst_sync_comb_p_tb;

logic clk, rst_i, rst_o;

arst_sync_comb_p dut (
	.clk( clk ),
	.rst_i( rst_i ),
	.rst_o( rst_o )
);

initial begin 
	$dumpfile( "dut.vcd" );
	$dumpvars( 0, dut );
	#50 $finish;
end

initial begin
	#10 rst_i = 'b1;
	#2 rst_i = 'b0;
end

initial begin
	clk = 'b0;
	forever #3 clk <= ~clk;
end

endmodule: arst_sync_comb_p_tb
