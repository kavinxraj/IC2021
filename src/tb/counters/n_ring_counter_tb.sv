/*********************************************************/
// MODULE: 
//
// FILE NAME: n_ring_counter_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-18 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module n_ring_counter_tb;

parameter FLOPS = 3;

logic clk, stop, q_out;

n_ring_counter #(
	.NUMBER_OF_FLOPS( FLOPS )
)
dut
(
	.clk( clk ),
	.stop( stop ),
	.q_out( q_out )
);

initial begin
	$dumpfile( "n_ring_counter.vcd" );
	$dumpvars( 0, dut );
	#200 $finish;
end

initial begin
	stop = 'b0;
	#5 stop = 'b1;
end

initial begin
	clk = 'b0;
	forever #2 clk = ~clk;
end

endmodule

