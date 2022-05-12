/*********************************************************/
// MODULE: 
//
// FILE NAME: mux_2x1.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mux_2x1
(
	input logic a_in,b_in,sel_in,
	output logic y_out
);

always_comb begin
	y_out = sel_in ? b_in : a_in;
end

endmodule : mux_2x1
