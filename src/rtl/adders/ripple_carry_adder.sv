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
	parameter DATA_WIDTH = 4
)
(
	input [DATA_WIDTH-1:0] a_in, b_in,
	input c_in,
	output logic [DATA_WIDTH-1:0] sum,
	output logic carry
);

logic [DATA_WIDTH-2:0] cout2cin;

generate
for ( genvar i = 0; i < DATA_WIDTH ; i++ ) begin : rc_adder
	if ( i == 0 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(c_in),
			.sum(sum[i]),
			.carry(cout2cin[i])
		);
	end
	else if ( i == DATA_WIDTH-1 ) begin
		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(cout2cin[i-1]),
			.sum(sum[i]),
			.carry(carry)
		);
	end
	else begin

		full_adder inst (
			.a(a_in[i]),
			.b(b_in[i]),
			.cin(cout2cin[i-1]),
			.sum(sum[i]),
			.carry(cout2cin[i])
		);
	end
end
endgenerate

endmodule : ripple_carry_adder
