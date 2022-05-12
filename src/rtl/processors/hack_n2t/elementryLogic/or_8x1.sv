/*********************************************************/
// MODULE: 
//
// FILE NAME: or_8x1.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module or_8x1
(
	input logic [7:0] data_in,
	output logic y_out
);

always_comb begin
	y_out = |data_in;
end

endmodule : or_8x1
