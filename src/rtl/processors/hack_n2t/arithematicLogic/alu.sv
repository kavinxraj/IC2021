/*********************************************************/
// MODULE: 
//
// FILE NAME: alu.sv 
// VERSION: 0.1
// DATE: 2021-May-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module alu
#(
	parameter DATA_WIDTH = 16
)
(
	input logic [DATA_WIDTH-1:0] dataX_in, dataY_in,
	input logic zx, zy, nx, ny, f, no,
	output logic [DATA_WIDTH-1:0] dataZ_out,
	output logic zr, ng
);

logic [DATA_WIDTH-1:0] mux1_to_mux3, mux2_to_mux4, not1_to_mux3, not2_to_mux4, mux3_to_arith_logic, mux4_to_arith_logic;
logic [DATA_WIDTH-1:0] arith_to_mux5, logic_to_mux5, mux5_to_mux6, not3_to_mux6;

logic [DATA_WIDTH-1:0] output_to_dataZ_out;

//zx multiplexer
mux_2x1_16bits mux1 (
	.a_in( dataX_in ),
	.b_in( 16'b0 ),
	.sel_in( zx ),
	.y_out( mux1_to_mux3 )
);

//zy multiplexer
mux_2x1_16bits mux2 (
	.a_in( dataY_in ),
	.b_in( 16'b0 ),
	.sel_in( zy ),
	.y_out( mux2_to_mux4 )
);

//nx not gates
not_16bits not1 (
	.data_in( mux1_to_mux3 ),
	.data_out( not1_to_mux3 )
);

//ny not gates
not_16bits not2 (
	.data_in( mux2_to_mux4 ),
	.data_out( not2_to_mux4 )
);

//nx multiplexer
mux_2x1_16bits mux3 (
	.a_in( mux1_to_mux3 ),
	.b_in( not1_to_mux3 ),
	.sel_in( nx ),
	.y_out( mux3_to_arith_logic )
);

//ny multiplexer
mux_2x1_16bits mux4 (
	.a_in( mux2_to_mux4 ),
	.b_in( not2_to_mux4 ),
	.sel_in( ny ),
	.y_out( mux4_to_arith_logic )
);

//Adder
adder
#(
	.DATA_WIDTH ( DATA_WIDTH )
) add1 (
	.dataA_in( mux3_to_arith_logic ),
	.dataB_in( mux4_to_arith_logic ),
	.sum( arith_to_mux5 ),
	.carry( )
);

//And Logic
and_16bits and1(
	.a_in( mux3_to_arith_logic ),
	.b_in( mux4_to_arith_logic ),
	.y_out( logic_to_mux5 )
);

//f multiplexer
mux_2x1_16bits mux5 (
	.a_in( logic_to_mux5 ),
	.b_in( arith_to_mux5 ),
	.sel_in( f ),
	.y_out( mux5_to_mux6 )
);

//no not gates
not_16bits not3 (
	.data_in( mux5_to_mux6 ),
	.data_out( not3_to_mux6 )
);

//no multiplexer
mux_2x1_16bits mux6 (
	.a_in( mux5_to_mux6 ),
	.b_in( not3_to_mux6 ),
	.sel_in( no ),
	.y_out( output_to_dataZ_out )
);

always_comb begin
	zr = ~|output_to_dataZ_out;
	ng = output_to_dataZ_out[DATA_WIDTH-1];
	dataZ_out = output_to_dataZ_out;
end

endmodule : alu
