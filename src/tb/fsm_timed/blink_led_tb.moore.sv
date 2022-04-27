/*********************************************************/
// MODULE: 
//
// FILE NAME: blink_led_tb.moore.sv 
// VERSION: 0.1
// DATE: 2022-Apr-27 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module blink_led_tb;

logic clk, rst_n, enable, led;

blink_led dut (
	.clk( clk ),
	.rst_n( rst_n ),
	.enable( enable ),
	.led( led )
);

initial begin
	$dumpfile( "blink_led.vcd" );
	$dumpvars( 0, dut );
	#500 $finish;
end

initial begin
	rst_n = 'b0;
	enable = 'b0;
	#5 rst_n = 'b1;
	enable = 'b1;
	#200 enable = 'b0;
end

initial begin
	clk = 'b0;
	forever #2 clk = ~clk;
end

endmodule
