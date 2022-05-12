/*********************************************************/
// MODULE: 
//
// FILE NAME: not_16bits.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module not_16bits
(
	input logic [15:0] data_in,
	output logic [15:0] data_out
);

always_comb begin
	data_out = ~data_in;
end

endmodule : not_16bits
