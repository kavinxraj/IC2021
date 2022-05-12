/*********************************************************/
// MODULE: 
//
// FILE NAME: incrementer.sv 
// VERSION: 0.1
// DATE: 2021-May-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module incrementer
#(
	parameter DATA_WIDTH = 32
)
(
	input logic [DATA_WIDTH-1:0] data_in,
	output logic [DATA_WIDTH-1:0] data_out,
	output logic carry
);

logic [DATA_WIDTH-2:0] cout2cin;

generate
for ( genvar i = 0; i <= DATA_WIDTH-1 ; i++ ) begin : incr
	if( i == 0 ) begin
		half_adder ha_inst (
			.a( 1'b1 ),
			.b( data_in[0] ),
			.sum( data_out[0] ),
			.carry( cout2cin[0] )
		);
	end else if( i == DATA_WIDTH -1 ) begin
		half_adder ha_inst (
			.a( cout2cin[i-1] ),
			.b( data_in[i] ),
			.sum( data_out[i]),
			.carry( carry )
		);
	end
       	else begin
		half_adder ha_inst (
			.a( cout2cin[i-1] ),
			.b( data_in[i] ),
			.sum( data_out[i]),
			.carry( cout2cin[i] )
		);
	end
end
endgenerate

endmodule : incrementer
