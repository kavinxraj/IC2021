/*********************************************************/
// MODULE: 
//
// FILE NAME: demux_1x4.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module demux_1x4
(
	input logic y_in,
	input logic [1:0] sel_in,
	output logic a_out, b_out, c_out, d_out
);

logic dmux_1_to_dmux_2, dmux_1_to_dmux_3;

demux_1x2 dmux_1(
	.y_in( y_in ),
	.sel_in( sel_in[1] ),
	.a_out( dmux_1_to_dmux_2 ),
	.b_out( dmux_1_to_dmux_3 )
);
demux_1x2 dmux_2(
	.y_in( dmux_1_to_dmux_2 ),
	.sel_in( sel_in[0] ),
	.a_out( a_out ),
	.b_out( b_out )
);
demux_1x2 dmux_3(
	.y_in( dmux_1_to_dmux_3 ),
	.sel_in( sel_in[0] ),
	.a_out( c_out ),
	.b_out( d_out )
);

endmodule : demux_1x4
