/*********************************************************/
// MODULE: 
//
// FILE NAME: half_adder.sv 
// VERSION: 0.1
// DATE: 2021-May-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module half_adder
(
	input logic a, b,
	output logic sum, carry
);

always_comb begin
	sum = a ^ b;
	carry = a & b;
end

endmodule : half_adder
