/*********************************************************/
// MODULE: 
//
// FILE NAME: csa.sv 
// VERSION: 1.0
// DATE: 2021-Sep-17 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: Parameterized Carry Save Adder
//
/*********************************************************/

module csa
#(
	parameter DEPTH = 8,
	parameter WIDTH = $clog2( DEPTH + 1 )
)
(
	input [DEPTH-1:0] i,
	output [WIDTH-2:0] sum,
	//output [WIDTH-1:0] sum,
	output cy
);

localparam STAGES = WIDTH-1;
localparam MAX_ADDERS =  (DEPTH-1)/2;

logic [STAGES-1:0][DEPTH:0] s,c;

//INFO : DEPTH/(2**stage+1) => Max No of Adders Required for the particular stage
//INFO : DEPTH/(2**stage) => No of wires from previous stage
//INFO : if the number of wires from previous stage is even, then the last adder 
//	 in the present stage will have a undriven, and that is driven by a special if condition here

generate
	for( genvar stage = 0 ; stage < STAGES;  stage ++ ) begin : stg
		
		assign sum[stage] = s[stage][ (DEPTH/(2**(stage+1))) - 1 ];

		for( genvar adder = 0; adder <  ( DEPTH/(2**(stage+1)) ) ; adder ++ ) begin : addr
			if( stage == 0 && adder == 0 ) begin
				csa3 csa_inst(
					.a( i[0] ),
					.b( i[(adder*2) + 1] ),
					.c( i[(adder*2) + 2] ),
					.sum( s[stage][adder] ),
					.cy( c[stage][adder] ));
			end
			else if( stage == 0 && adder == ( (DEPTH/(2**(stage+1))) - 1 ) && ((DEPTH-1)%2 == 1)  ) begin  //stage 0, last adder undriven fix
			csa3 csa_inst(
				.a( s[stage][adder-1] ),
				.b( i[(adder*2) + 1] ),
				.c( 1'b0 ),
				.sum( s[stage][adder] ),
				.cy( c[stage][adder] ));
			end
			else if( stage == 0 ) begin
			csa3 csa_inst(
				.a( s[stage][adder-1] ),
				.b( i[(adder*2) + 1] ),
				.c( i[(adder*2) + 2] ),
				.sum( s[stage][adder] ),
				.cy( c[stage][adder] ));
			end
			else if( stage != 0 && adder == 0 && adder == ( (DEPTH/(2**(stage+1))) - 1 ) && ( ((DEPTH/2**stage)-1)%2 ) == 1) begin //other stage, adder 0 undriven fix
			csa3 csa_inst(
				.a( c[stage-1][0] ),
				.b( c[stage-1][(adder*2)+1] ),
				.c( 1'b0 ),
				.sum( s[stage][adder] ),
				.cy( c[stage][adder] ));
			end
			else if( stage != 0 && adder == 0 ) begin
			csa3 csa_inst(
				.a( c[stage-1][0] ),
				.b( c[stage-1][(adder*2)+1] ),
				.c( c[stage-1][(adder*2)+2] ),
				.sum( s[stage][adder] ),
				.cy( c[stage][adder] ));
			end
			else if( stage != 0 && adder == ( (DEPTH/(2**(stage+1))) - 1 ) && ( ((DEPTH/2**stage)-1)%2 ) == 1 ) begin //other stages, last adder undriven fix
			csa3 csa_inst(
				.a( s[stage][adder-1] ),
				.b( c[stage-1][(adder*2)+1] ),
				.c( 1'b0 ),
				.sum( s[stage][adder] ),
				.cy( c[stage][adder] ));
			end
			else begin
				csa3 csa_inst(
					.a( s[stage][adder-1] ),
					.b( c[stage-1][(adder*2)+1] ),
					.c( c[stage-1][(adder*2)+2] ),
					.sum( s[stage][adder] ),
					.cy( c[stage][adder] ));
				end
		end
	end

endgenerate

assign cy = c[STAGES-1][0];
//assign sum[WIDTH-1] = c[STAGES-1][0];

endmodule
