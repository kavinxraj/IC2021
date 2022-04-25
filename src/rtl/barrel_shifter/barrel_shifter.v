/***************************************************************************/
// MODULE: barrel_shifter
//
// FILE NAME: barrel_shifter.v
// VERSION: 1.0
// DATE: 14 Jan 2021
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: Barrel Shifter (Parameterized)
//
// 		Performs 6 Shift Operations based on the N_SHIFT Input
//			OPR		Operation
//			3'b000		Logical Shift Right
//			3'b001 		Arithemetic Shift Right
//			3'b010 		Rotate Right
//			3'b100 		Logical Shift Left
//			3'b101 		Arithemetic Shift Left
//			3'b110 		Rotate Left
//
//		Modify the DATA_WIDTH paramter to modify the width of the
//		Barrel Shifter
/**************************************************************************/

module barrel_shifter #(
	parameter DATA_WIDTH = 4,				//Width of the Data Bus
	parameter SHIFT_WIDTH =$clog2( DATA_WIDTH )		//Width of the N_Shift Input Bus
)
(
	input	[DATA_WIDTH-1:0]	IDATA,			//Input Data Bus
	input	[SHIFT_WIDTH-1:0]	N_SHIFT,		//N_Shift input
	input	[2:0]			OPR,			//Operation Selection Input

	output reg [DATA_WIDTH-1:0]	ODATA			//Output Data Bus
);

localparam	LOGICAL_SHIFT_RIGHT	= 3'b000;		//Operation Defnitions
localparam 	ARITH_SHIFT_RIGHT	= 3'b001;
localparam 	ROTATE_RIGHT		= 3'b010;
localparam 	LOGICAL_SHIFT_LEFT	= 3'b100;
localparam 	ARITH_SHIFT_LEFT	= 3'b101;
localparam 	ROTATE_LEFT		= 3'b110;


wire	[DATA_WIDTH-1:0]	lsr2mux, asr2mux, rr2mux, lsl2mux, rl2mux;		//wires to connect shifter output to operation select multiplexer

N_right_shifter #( .DATA_WIDTH(DATA_WIDTH) ) lsr(		//N Logical Right Shifter
	.IDATA(IDATA),
	.N_SHIFT(N_SHIFT),
	.ODATA(lsr2mux)
);

N_arith_right_shifter #( .DATA_WIDTH(DATA_WIDTH) ) asr(		//N Arithemetic Right Shifter
	.IDATA(IDATA),
	.N_SHIFT(N_SHIFT),
	.ODATA(asr2mux)
);

N_rotate_right_shifter #( .DATA_WIDTH(DATA_WIDTH) ) rr(		//N Rotate Right Shifter
	.IDATA(IDATA),
	.N_SHIFT(N_SHIFT),
	.ODATA(rr2mux)
);

N_left_shifter #( .DATA_WIDTH(DATA_WIDTH) ) lsl(		//N Logical Left Shifter
	.IDATA(IDATA),
	.N_SHIFT(N_SHIFT),
	.ODATA(lsl2mux)
);

N_rotate_left_shifter #( .DATA_WIDTH(DATA_WIDTH) ) rl(		//N Rotate Left Shifter
	.IDATA(IDATA),
	.N_SHIFT(N_SHIFT),
	.ODATA(rl2mux)
);

always @* begin
	case(OPR)						//Multiplexer Logic to Select the shifter based on Operation Code
		LOGICAL_SHIFT_RIGHT:	ODATA <= lsr2mux;
		ARITH_SHIFT_RIGHT:	ODATA <= asr2mux;
		ROTATE_RIGHT:		ODATA <= rr2mux;
		LOGICAL_SHIFT_LEFT:	ODATA <= lsl2mux;
		ARITH_SHIFT_LEFT:	ODATA <= lsl2mux;
		ROTATE_LEFT:		ODATA <= rl2mux;
		default:		ODATA <= lsr2mux;
	endcase
end

endmodule
