/*********************************************************/
// MODULE: 
//
// FILE NAME: program_counter.sv 
// VERSION: 0.1
// DATE: 2021-Jun-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module program_counter
#(
	parameter DATA_WIDTH = 16
)
(
	input rst,
	input load,
	input incr,
	input clk,
	input [DATA_WIDTH-1:0] pc_in,
	output logic [DATA_WIDTH-1:0] pc_out
);

always_ff @ ( posedge clk or posedge rst ) begin
	if( rst ) begin
		pc_out <= 'b0;
	end
	else if( load ) begin
		pc_out <= pc_in;
	end
	else if( incr ) begin
		pc_out <= pc_out + 1;
	end
	else begin
		pc_out <= pc_out;
	end
end

endmodule: program_counter
