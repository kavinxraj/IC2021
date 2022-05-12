/*********************************************************/
// MODULE: 
//
// FILE NAME: full_adder.sv 
// VERSION: 0.1
// DATE: 2021-May-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module full_adder
(
	input logic a, b, cin,
	output logic sum, carry
);

always_comb begin
	sum = a ^ b ^ cin;
	carry = (a & b) | ( cin & (a ^ b));
end

endmodule : full_adder
