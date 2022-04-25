/*********************************************************/
// MODULE: 
//
// FILE NAME: rotate_left_shifter.v
// VERSION: 0.1
// DATE: 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module rotate_left_shifter #(
	parameter DATA_WIDTH = 32,
	parameter N = 0
)
(
	input 	[DATA_WIDTH-1:0]	IDATA,
	input				SHIFT,

	output	[DATA_WIDTH-1:0]	ODATA
);

//always @(*) begin
//	if(~SHIFT) begin
//		ODATA = IDATA;
//	end
//	else begin
//		ODATA = {IDATA[DATA_WIDTH-(1+N):0],{N{1'b0}}};
//	end
//end

assign ODATA = (~SHIFT)? IDATA :{ IDATA[DATA_WIDTH-(N+1):0], IDATA[DATA_WIDTH-1:DATA_WIDTH-N] };

endmodule
