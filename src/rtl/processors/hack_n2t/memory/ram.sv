/*********************************************************/
// MODULE: 
//
// FILE NAME: ram.sv 
// VERSION: 0.1
// DATE: 2021-Jun-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module ram
#(
	DATA_WIDTH = 16,
	ADDRESS_WIDTH = 1
)
(
	input clk,
	input load,
	input [DATA_WIDTH-1:0] data_in,
	input [ADDRESS_WIDTH-1:0] address_in,
	output logic [DATA_WIDTH-1:0] data_out
);

localparam SIZE = 2 ** ADDRESS_WIDTH;

logic [DATA_WIDTH-1:0] memory [SIZE-1:0];

always_ff @ (posedge clk ) begin
	if( load ) begin
		memory[address_in] <= data_in;
	end
	else begin
		data_out <= memory[address_in];
	end
end

endmodule: ram
