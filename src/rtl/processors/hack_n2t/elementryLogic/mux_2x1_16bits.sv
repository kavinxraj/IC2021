/*********************************************************/
// MODULE: 
//
// FILE NAME: mux_2x1_16bits.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mux_2x1_16bits
(
	input logic [15:0] a_in, b_in,
	input logic sel_in,
	output logic [15:0] y_out
);

generate
for( genvar i = 0; i <= 15; i++ ) begin: mux_block
	mux_2x1 mux_2x1_inst(
		.a_in( a_in[i] ),
		.b_in( b_in[i] ),
		.sel_in( sel_in ),
		.y_out( y_out[i] )
	);
end
endgenerate

endmodule : mux_2x1_16bits
