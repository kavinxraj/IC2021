/*********************************************************/
// MODULE: 
//
// FILE NAME: general_clk_divider.sv 
// VERSION: 0.1
// DATE: 2022-Apr-12 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: a general purpose clock divider
//		with terminal count to adjust the div var
//		
//
/*********************************************************/

module general_clk_divider
#(
	parameter WIDTH = 8
)
(
	input clk, rst_n,
	input ld_en_n,
	input [WIDTH-1:0] data_in,
	output logic clk_out
);

logic [WIDTH-1:0] count;
logic [WIDTH-1:0] terminal_count;
logic tc_equal_c;

always_comb begin
	tc_equal_c = ( count == ( terminal_count - 1 ) );
end

always_ff @ ( posedge clk, negedge rst_n ) begin
	if( ~rst_n ) begin
		count <= 'b0;
	end
	else if ( tc_equal_c ) begin
		count <= 'b0;
	end
	else if ( ~ld_en_n ) begin
		count <= count + 1;
	end
	else begin
		count <= count;
	end
end

always_ff @ ( posedge clk, negedge rst_n ) begin
	if( ~rst_n ) begin
		terminal_count <= 8'h0f;
	end
	else if ( ld_en_n ) begin
		terminal_count <= data_in;
	end
end

always_comb begin
	clk_out = tc_equal_c;
end

endmodule: general_clk_divider
