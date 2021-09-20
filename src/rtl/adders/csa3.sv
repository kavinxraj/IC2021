/*********************************************************/
// MODULE: 
//
// FILE NAME: csa3.sv 
// VERSION: 0.1
// DATE: 2021-Sep-17 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: 3 bit Carry Save Adder
//
/*********************************************************/

module csa3
(
	input a, b, c,
	output logic sum, cy
);

always_comb begin
	sum = a ^ b ^ c;
	cy = (a ^ b)&c | (a&b) ;
end

endmodule
