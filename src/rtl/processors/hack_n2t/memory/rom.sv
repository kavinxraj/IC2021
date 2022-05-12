/*********************************************************/
// MODULE: 
//
// FILE NAME: rom.sv 
// VERSION: 0.1
// DATE: 2021-Jun-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module rom
#(
	parameter DATA_WIDTH = 16,
	parameter ADDRESS_WIDTH = 6
)
(
	input writeEn,
	input [DATA_WIDTH-1:0] data_in,
	input [ADDRESS_WIDTH-1:0] address_in,
	output logic [DATA_WIDTH-1:0] data_out
);

localparam SIZE = 2 ** ADDRESS_WIDTH;

logic [DATA_WIDTH-1:0] memory [SIZE-1:0];

always_comb begin
	if( writeEn ) begin
		memory[address_in] = data_in;
	end
	else begin
		data_out = memory[address_in];
	end
end

endmodule: rom
