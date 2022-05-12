/*********************************************************/
// MODULE: 
//
// FILE NAME: register.sv 
// VERSION: 0.1
// DATE: 2021-Jun-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module register
#(
	parameter DATA_WIDTH = 1
)
(
	input clk,
	input rst,
	input load,
	input [DATA_WIDTH-1:0] data_in,
	output logic [DATA_WIDTH-1:0] data_out
);

always_ff @ ( posedge clk or posedge rst ) begin
	if ( rst ) begin
		data_out <= '0;
	end
	else if ( load ) begin
		data_out <= data_in;
	end
	else begin
		data_out <= data_out;
	end
end

endmodule: register
