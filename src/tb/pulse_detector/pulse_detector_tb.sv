/*********************************************************/
// MODULE: 
//
// FILE NAME: pulse_detector_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/
module pulse_detector_tb;

logic clk, rst, pulse_in, pulse_out;

pulse_detector dut (
	.clk( clk ),
	.async_rst( rst ),
	.pulse_in( pulse_in ),
	.pulse_out( pulse_out )
);

initial begin
	$dumpfile( "dut.vcd" );
	$dumpvars( 1, dut );
	#50 $finish;
end

initial begin
	rst = 'b0;
	pulse_in = 'b0;
	#5 rst = 'b1;
	#10 pulse_in = 'b1;
	#1 pulse_in = 'b0;
end

initial begin
	clk = 'b0;
	forever begin
		#2 clk <= ~clk ;
	end
end

endmodule
