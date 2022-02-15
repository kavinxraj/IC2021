/*********************************************************/
// MODULE: 
//
// FILE NAME: wallace_tree_multiplier.sv 
// VERSION: 0.1
// DATE: 2021-Sep-29 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module wallace_tree_multiplier 
#(
	WIDTH_A = 4;
	WIDTH_B = 4;
)
(
	input [WIDTH_A-1:0] a,
	input [WIDTH_B-1:0] b,
	output logic [WIDTH_A+WIDTH_B-1:0] p

);

logic [WIDTH_B-1:0][WIDTH_A-1:0] pp;

always_comb begin
	for( int i = 0; i < WIDTH_B; i++ ) begin
		for( int j = 0; j < WIDTH_A; j++ ) begin
			pp[i][j] = b[i] & a[j];
		end
	end
end

endmodule
