/*********************************************************/
// MODULE: 
//
// FILE NAME: two_sided_debouncer_tb.moore.sv 
// VERSION: 0.1
// DATE: 2022-May-02 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module two_sided_bounce_tb;

logic clk,rst;
logic bounce_in, bounce_out;

two_sided_debouncer dut (
	.clk( clk ),
	.rst( rst ),
	.bounce_in( bounce_in ),
	.bounce_out( bounce_out )
);

initial begin
	$dumpfile( "two_sided_debouncer.vcd" );
	$dumpvars( 0, dut );
	#100 $finish;
end

initial begin
	rst = 'b0;
	bounce_in = 1'bx;
	#5 rst = 'b1;
	#10 bounce_in = 1'b1;
	#1 bounce_in = 1'b0;
	#1 bounce_in = 1'b1;
	#1 bounce_in = 1'b0;
	#1 bounce_in = 1'b1;
	#6 bounce_in = 1'b0;
	#1 bounce_in = 1'b1;
	#1 bounce_in = 1'b0;
	#1 bounce_in = 1'b0;
end

initial begin
	clk = 1'b0;
	forever #1 clk = ~clk;
end

endmodule
