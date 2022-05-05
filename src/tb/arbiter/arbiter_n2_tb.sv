/*********************************************************/
// MODULE: 
//
// FILE NAME: arbiter_n2_tb.sv 
// VERSION: 0.1
// DATE: 2022-May-05 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arbiter_nb2_tb;
import arbiter_n2_pkg::*;

logic clk, rst;
req_t req;
gnt_t gnt;

arbiter_n2 dut (
	.clk( clk ),
	.rst( rst ),
	.req( req ),
	.gnt( gnt )
);

initial begin
	$dumpfile( "arbiter_n2.vcd" );
	$dumpvars( 0, dut );
	#200 $finish;
end

initial begin

	rst = 1'b0;

end

initial begin
	clk = 1'b0;
	forever #2 clk = ~clk;
end

//`ifdef SVA_ENABLE
//
//	bind arbiter_n2 : dut arbiter_n2_sva dut_sva( .* );
//
//`endif

endmodule
