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
#(
	parameter DATA_WIDTH = 8
)
(
	input [DATA_WIDTH-1:0] a_in, b_in,
	input carry_in,
	output logic [DATA_WIDTH-1:0] sum_out,
	output logic carry_out
);

logic [DATA_WIDTH-2:0] cout2cin;

generate
for ( genvar i = 0; i < DATA_WIDTH ; i++ ) begin : rc_adder
	if ( i == 0 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(carry_in),
			.sum(sum_out[i]),
			.carry(cout2cin[i])
		);
	end
	else if ( i == DATA_WIDTH-1 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(cout2cin[i-1]),
			.sum(sum_out[i]),
			.carry(carry_out)
		);
	end
	else begin

		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(cout2cin[i-1]),
			.sum(sum_out[i]),
			.carry(cout2cin[i])
		);
	end
end
endgenerate

endmodule : ripple_carry_adder
