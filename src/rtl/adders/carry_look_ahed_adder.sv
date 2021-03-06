/*********************************************************/
// MODULE: 
//
// FILE NAME: carry_look_ahed_adder.sv 
// VERSION: 0.1
// DATE: 2021-Sep-15 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module carry_look_ahead_adder
#(
	parameter DATA_WIDTH = 8 //1 to 8 are valid
)
(
	input logic [DATA_WIDTH-1:0] a_in,b_in,
	input logic carry_in,
	output logic [DATA_WIDTH-1:0] sum_out,
	output logic carry_out
);

logic [DATA_WIDTH-1:0] g,p,c; //generate, propagate, carry

generate
for( genvar i = 0; i < DATA_WIDTH; i++ ) begin : gen_prop
	assign g[i] = a_in[i] & b_in[i];
	assign p[i] = a_in[i] ^ b_in[i];
end
endgenerate

always_comb begin

	if( DATA_WIDTH == 8 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
		c[3] = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] ) | ( p[3] & p[2] & p[1] & p[0] & carry_in );
		c[4] = g[4] | ( p[4] & g[3] ) | ( p[4] & p[3] & g[2] ) | ( p[4] & p[3] & p[2] & g[1] ) | ( p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[5] = g[5] | ( p[5] & g[4] ) | ( p[5] & p[4] & g[3] ) | ( p[5] & p[4] & p[3] & g[2] ) | ( p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[6] = g[6] | ( p[6] & g[5] ) | ( p[6] & p[5] & g[4] ) | ( p[6] & p[5] & p[4] & g[3] ) | ( p[6] & p[5] & p[4] & p[3] & g[2] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[7] = g[7] | ( p[7] & g[6] ) | ( p[7] & p[6] & g[5] ) | ( p[7] & p[6] & p[5] & g[4] ) | ( p[7] & p[6] & p[5] & p[4] & g[3] ) | ( p[7] & p[6] & p[5] & p[4] & p[3] & g[2] ) | ( p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 7 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
		c[3] = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] ) | ( p[3] & p[2] & p[1] & p[0] & carry_in );
		c[4] = g[4] | ( p[4] & g[3] ) | ( p[4] & p[3] & g[2] ) | ( p[4] & p[3] & p[2] & g[1] ) | ( p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[5] = g[5] | ( p[5] & g[4] ) | ( p[5] & p[4] & g[3] ) | ( p[5] & p[4] & p[3] & g[2] ) | ( p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[6] = g[6] | ( p[6] & g[5] ) | ( p[6] & p[5] & g[4] ) | ( p[6] & p[5] & p[4] & g[3] ) | ( p[6] & p[5] & p[4] & p[3] & g[2] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 6 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
		c[3] = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] ) | ( p[3] & p[2] & p[1] & p[0] & carry_in );
		c[4] = g[4] | ( p[4] & g[3] ) | ( p[4] & p[3] & g[2] ) | ( p[4] & p[3] & p[2] & g[1] ) | ( p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
		c[5] = g[5] | ( p[5] & g[4] ) | ( p[5] & p[4] & g[3] ) | ( p[5] & p[4] & p[3] & g[2] ) | ( p[5] & p[4] & p[3] & p[2] & g[1] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 5 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
		c[3] = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] ) | ( p[3] & p[2] & p[1] & p[0] & carry_in );
		c[4] = g[4] | ( p[4] & g[3] ) | ( p[4] & p[3] & g[2] ) | ( p[4] & p[3] & p[2] & g[1] ) | ( p[4] & p[3] & p[2] & p[1] & g[0] ) | ( p[4] & p[3] & p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 4 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
		c[3] = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] ) | ( p[3] & p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 3 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
		c[2] = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & g[0] ) | ( p[2] & p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 2 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
		c[1] = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & carry_in );
	end
	else if ( DATA_WIDTH == 1 ) begin
		c[0] = g[0] | ( p[0] & carry_in );
	end

end

generate 
for( genvar k = 0; k < DATA_WIDTH; k++ ) begin : sum
	if( k == 0 ) begin
		assign sum_out[0] = carry_in ^ p[0];
	end
	else begin
		assign sum_out[k] = c[k-1] ^ p[k];
	end
end
endgenerate

assign carry_out = c[DATA_WIDTH-1];

endmodule : carry_look_ahead_adder
