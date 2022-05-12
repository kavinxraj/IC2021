/*********************************************************/
// MODULE: 
//
// FILE NAME: and_16bits.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module and_16bits
(
	input logic [15:0] a_in, b_in,
	output logic [15:0] y_out
);

always_comb begin
	y_out = a_in & b_in;
end

endmodule : and_16bits
