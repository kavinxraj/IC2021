/*********************************************************/
// MODULE: 
//
// FILE NAME: rv_dmux_nxw.sv 
// VERSION: 0.1
// DATE: 2022-Jun-13 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module rv_dmux_nxw
#(
	parameter WIDTH = 8,  //width of one input
	parameter N = 5,  //number of inputs
	parameter S = $clog2( N )  //nuber of select bits
)
(
	input logic  [WIDTH-1:0] data_in,
	input logic  [S-1:0] sel_in,
	output logic [N-1:0] [WIDTH-1:0] data_out
);

always_comb begin
	data_out = 0; //added for dmux implementation without latch
	data_out[sel_in] = data_in;
end

endmodule : rv_dmux_nxw
