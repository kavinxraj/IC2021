/*********************************************************/
// MODULE: 
//
// FILE NAME: general_clk_divider_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-12 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module general_clk_divider_tb;

parameter WIDTH = 4;

logic clk, rst_n, ld_en_n;
logic [WIDTH-1:0] data_in;
logic clk_out;

general_clk_divider #(
	.WIDTH( WIDTH )
) dut (
	.clk( clk ),
	.rst_n( rst_n ),
	.ld_en_n( ld_en_n ),
	.data_in( data_in ),
	.clk_out( clk_out )
);

initial begin
	$dumpfile( "general_clk_divider.vcd" );
	$dumpvars( 0, dut );
	#200 $finish;
end

initial begin
	rst_n = 'b0;
	data_in = 'h03;
	ld_en_n = 'b1;
	#5 rst_n = 'b1;
	#5 ld_en_n = 'b0;
end

initial begin
	clk <= 'b0;
	forever #2 clk <= ~clk;
end

endmodule: general_clk_divider_tb

