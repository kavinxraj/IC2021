/*********************************************************/
// MODULE: 
//
// FILE NAME: clk_gate_p_tb.sv 
// VERSION: 0.1
// DATE: 2022-Apr-11 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module clk_gate_p_tb;

logic clk, enable, gated_clock;
 
clk_gate_p dut (
	.clk( clk ),
	.enable( enable ),
	.gated_clk( gated_clock )
);

initial begin 
	$dumpfile( "dut.vcd" );
	$dumpvars( 0 , dut );
	#50 $finish;
end

initial begin
	enable = 'b0;
	#10 enable = 'b1;
	#2 enable = 'b0;
end

initial begin
	clk = 'b0;
	forever #2 clk = ~clk;
end

endmodule: clk_gate_p_tb
