/*********************************************************/
// MODULE: 
//
// FILE NAME: adder.sv 
// VERSION: 0.1
// DATE: 2021-May-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module adder
#(
	DATA_WIDTH = 32
)
(
	input logic [DATA_WIDTH-1:0] dataA_in, dataB_in,
	output logic [DATA_WIDTH-1:0] sum,
	output logic carry
);

logic [DATA_WIDTH-2:0] cout2cin;

generate
for( genvar i = 0; i <= DATA_WIDTH-1; i++ ) begin : adder_gen
	if( i == 0 ) begin
		half_adder ha_inst(
			.a( dataA_in[0] ),
			.b( dataB_in[0] ),
			.sum( sum[0] ),
			.carry( cout2cin[0] )
		);
	end else if( i == DATA_WIDTH-1 ) begin
		full_adder fa_inst(
			.a( dataA_in[i] ),
			.b( dataB_in[i] ),
			.cin( cout2cin[i-1] ),
			.sum( sum[i]),
			.carry( carry )
		);
	end else begin
		full_adder fa_inst(
			.a( dataA_in[i] ),
			.b( dataB_in[i] ),
			.cin( cout2cin[i-1] ),
			.sum( sum[i]),
			.carry( cout2cin[i] )
		);
	end
end
endgenerate

endmodule : adder
