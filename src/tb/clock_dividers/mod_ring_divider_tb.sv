/*********************************************************/
// MODULE: 
//
// FILE NAME: mod_ring_divider_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-24 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mod_ring_divider_tb;

logic clk, rst, q_out;

mod_ring_divider dut(
	.clk( clk ),
	.rst( rst ),
	.q_out( q_out )
);

initial begin
	$dumpfile("mod_ring_counter.vcd");
	$dumpvars( 0, dut );
	#100 $finish;
end

initial begin
	rst = 'b0;
	#5 rst = 'b1;
end

initial begin
	clk = 'b0;
	forever #2 clk = ~clk;
end

endmodule
