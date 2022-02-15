/*********************************************************/
// MODULE: 
//
// FILE NAME: mult.sv 
// VERSION: 0.1
// DATE: 2021-Sep-29 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mult
(
	input logic [255:0] a,b,
	output logic [511:0] p
);

always_comb begin
	p = a * b;
end

endmodule
