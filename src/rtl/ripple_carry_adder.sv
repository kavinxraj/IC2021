/*********************************************************/
// MODULE: 
//
// FILE NAME: ripple_carry_adder.sv 
// VERSION: 0.1
// DATE: 2021-May-18 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module ripple_carry_adder
(
	input [7:0] a_in, b_in,
	output logic [7:0] sum,
	output logic carry
);

logic [6:0] c2cin;

for ( genvar i = 0; i <= 7 ; i++ ) begin
	if ( i == 0 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(1'b0),
			.sum(sum[i]),
			.carry(c2cin[0])
		);
	end
	else if ( i == 7 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(c2cin[i-1]),
			.sum(sum[i]),
			.carry(carry)
		);
	end
	else begin

		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(c2cin[i-1]),
			.sum(sum[i]),
			.carry(c2cin[i])
		);
	end
end

endmodule : ripple_carry_adder
