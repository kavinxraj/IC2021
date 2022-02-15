/*********************************************************/
// MODULE: 
//
// FILE NAME: cla_add_tb.sv 
// VERSION: 0.1
// DATE: 2021-Sep-15 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module cla_add_tb;

parameter DATA_WIDTH = 4;

logic [DATA_WIDTH-1:0] a_in, b_in, sum_out;
logic carry_in, carry_out;

carry_look_ahead_adder #(
	.DATA_WIDTH( DATA_WIDTH )
) dut (
	.a_in( a_in ),
	.b_in( b_in ),
	.carry_in( carry_in ),
	.sum_out( sum_out ),
	.carry_out( carry_out )
);

initial begin
	$monitor( "%0t A=%h B=%h c_in=%b c_out,SUM=%b_%h",$time, a_in, b_in, carry_in, carry_out, sum_out );
	$dumpfile( "dut.vcd" );
	$dumpvars( 0, dut );
end

initial begin
	#10 a_in = 4'h0; b_in = 4'h0; carry_in = 1'b0; 
	#10 a_in = 4'hf; b_in = 4'hf; carry_in = 1'b0; 
	#10 a_in = 4'h0; b_in = 4'h0; carry_in = 1'b1; 
	#10 a_in = 4'hf; b_in = 4'hf; carry_in = 1'b1; 
	#10 a_in = 4'h5; b_in = 4'h5; carry_in = 1'b0; 

end

endmodule
