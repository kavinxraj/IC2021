/*********************************************************/
// MODULE: 
//
// FILE NAME: demux_1x8.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module demux_1x8
(
	input logic y_in,
	input logic [2:0] sel_in,
	output logic a_out, b_out, c_out, d_out,
	output logic e_out, f_out, g_out, h_out
);

logic d1_to_d2, d1_to_d3, d1_to_d4, d1_to_d5;

demux_1x4 dmux_1(
	.y_in( y_in ),
	.sel_in( {sel_in[2], sel_in[1]} ),
	.a_out( d1_to_d2 ),
	.b_out( d1_to_d3 ),
	.c_out( d1_to_d4 ),
	.d_out( d1_to_d5 )
);

demux_1x2 dmux_2(
	.y_in( d1_to_d2 ),
	.sel_in( sel_in[0] ),
	.a_out( a_out ),
	.b_out( b_out )
);
demux_1x2 dmux_3(
	.y_in( d1_to_d3 ),
	.sel_in( sel_in[0] ),
	.a_out( c_out ),
	.b_out( d_out )
);
demux_1x2 dmux_4(
	.y_in( d1_to_d4 ),
	.sel_in( sel_in[0] ),
	.a_out( e_out ),
	.b_out( f_out )
);
demux_1x2 dmux_5(
	.y_in( d1_to_d5 ),
	.sel_in( sel_in[0] ),
	.a_out( g_out ),
	.b_out( h_out )
);

endmodule : demux_1x8
