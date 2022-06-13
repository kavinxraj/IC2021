/*********************************************************/
// MODULE: 
//
// FILE NAME: rv_muxn.sv 
// VERSION: 0.1
// DATE: 2022-Jun-13 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module rv_mux_nxw
#(
	parameter WIDTH = 8,
	parameter N = 5,
	parameter S = $clog2( N ) 
)
(
	input logic  [N-1:0] [WIDTH-1:0] data_in,
	input logic  [S-1:0] sel_in,
	output logic [WIDTH-1:0] data_out
);

always_comb begin
	data_out = data_in[sel_in];
end

endmodule : rv_mux_nxw
