/*********************************************************/
// MODULE: 
//
// FILE NAME: mux_8x1_16bits.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mux_8x1_16bits
(
	input logic [15:0] a_in, b_in, c_in, d_in,
	input logic [15:0] e_in, f_in, g_in, h_in,
	input logic [2:0] sel_in,
	output logic [15:0] y_out
);

logic [15:0] mux_1_to_mux_3, mux_2_to_mux_3;

mux_4x1_16bits mux_1(
	.a_in( a_in ),
	.b_in( b_in ),
	.c_in( c_in ),
	.d_in( d_in ),
	.sel_in( {sel_in[0], sel_in[1]} ),
	.y_out( mux_1_to_mux_3 )
);
mux_4x1_16bits mux_2(
	.a_in( e_in ),
	.b_in( f_in ),
	.c_in( g_in ),
	.d_in( h_in ),
	.sel_in( {sel_in[0], sel_in[1]} ),
	.y_out( mux_2_to_mux_3 )
);
mux_2x1_16bits mux_3(
	.a_in( mux_1_to_mux_3 ),
	.b_in( mux_2_to_mux_3 ),
	.sel_in( sel_in[2] ),
	.y_out( y_out )
);

endmodule : mux_8x1_16bits
