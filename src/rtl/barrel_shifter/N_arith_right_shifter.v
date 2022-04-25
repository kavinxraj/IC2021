/*********************************************************/
// MODULE: N_arith_right_shifter
//
// FILE NAME: N_arith_right_shifter.v
// VERSION: 0.1
// DATE: 12/01/2021
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module N_arith_right_shifter #(
	parameter DATA_WIDTH = 8,				//Width of the Input and Output Data
	parameter SHIFT_WIDTH = $clog2( DATA_WIDTH ),		//Width of the Shift Input
	parameter NO_OF_SHIFT_STAGES = SHIFT_WIDTH		//Number of stages to shift the input data  //used for style-2
)
(
	input	[DATA_WIDTH-1:0]	IDATA,			//Input Data Port
	input	[SHIFT_WIDTH-1:0]	N_SHIFT,		//Shift By Number Input

	output	[DATA_WIDTH-1:0]	ODATA			//Output Data Port
);

//code Style 1
//wire [DATA_WIDTH-1:0]	stg2tostg1,stg1tostg0;
//
//arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(1)) dev0(.IDATA(stg1tostg0), .SHIFT(N_SHIFT[0]), .ODATA(ODATA));
//arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(2)) dev1(.IDATA(stg2tostg1), .SHIFT(N_SHIFT[1]), .ODATA(stg1tostg0));
//arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(4)) dev2(.IDATA(IDATA), .SHIFT(N_SHIFT[2]), .ODATA(stg2tostg1));

//code style 2
localparam NO_OF_WIRES = (NO_OF_SHIFT_STAGES - 1) * DATA_WIDTH;

//integer i;
wire	[NO_OF_WIRES-1:0]	stg2stg;		//Wires to connect stage to stage ex: stage 1 output connected to stage 0

genvar i;
generate
for( i = NO_OF_SHIFT_STAGES-1; i >= 0 ; i = i-1) begin : shift
			
			if( i == NO_OF_SHIFT_STAGES-1) begin
				arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(2**i)) 		//Stage n shifter
				dev(
					.IDATA(IDATA), 
					.SHIFT(N_SHIFT[i]), 
					.ODATA(stg2stg[ ((i-1)*DATA_WIDTH)+(DATA_WIDTH-1) : (i-1)*DATA_WIDTH] ));
			end
			else if( i > 0) begin
				arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(2**i)) 		//Stage 1..(n-1) Shifters
				dev(
					.IDATA(stg2stg[ (i*DATA_WIDTH)+(DATA_WIDTH-1) : i*DATA_WIDTH]), 
					.SHIFT(N_SHIFT[i]), 
					.ODATA(stg2stg[ ((i-1)*DATA_WIDTH)+(DATA_WIDTH-1) : (i-1)*DATA_WIDTH]));
			end
			else begin
				arith_right_shifter #(.DATA_WIDTH(DATA_WIDTH), .N(2**i)) 		//Stage 0 shifter
				dev(
					.IDATA(stg2stg[DATA_WIDTH-1:0]), 
					.SHIFT(N_SHIFT[i]), 
					.ODATA(ODATA));
			end
		end
endgenerate

endmodule
