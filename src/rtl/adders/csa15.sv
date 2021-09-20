module csa
#(
	parameter DEPTH = 15,
	parameter WIDTH = 4
)
(
	input [DEPTH-1:0] i,
	output [WIDTH-2:0] sum,
	output cy
);
localparam MAX_STAGES = WIDTH;

logic [MAX_STAGES-1:0][DEPTH:0] s,c;		//Number of Wires not accurate

csa3 csa_s0_a0(
					.a( i[0] ),
					.b( i[1] ),
					.c( i[2] ),
					.sum( s[0][0] ),
					.cy( c[0][0] ));
csa3 csa_s0_a1(
					.a( s[0][0] ),
					.b( i[3] ),
					.c( i[4] ),
					.sum( s[0][1] ),
					.cy( c[0][1] ));
csa3 csa_s0_a2(
					.a( s[0][1] ),
					.b( i[5] ),
					.c( i[6] ),
					.sum( s[0][2] ),
					.cy( c[0][2] ));
csa3 csa_s0_a3(
					.a( s[0][2] ),
					.b( i[7] ),
					.c( i[8] ),
					.sum( s[0][3] ),
					.cy( c[0][3] ));
csa3 csa_s0_a4(
					.a( s[0][3] ),
					.b( i[9] ),
					.c( i[10] ),
					.sum( s[0][4] ),
					.cy( c[0][4] ));
csa3 csa_s0_a5(
					.a( s[0][4] ),
					.b( i[11] ),
					.c( i[12] ),
					.sum( s[0][5] ),
					.cy( c[0][5] ));
csa3 csa_s0_a6(
					.a( s[0][5] ),
					.b( i[13] ),
					.c( i[14] ),
					.sum( s[0][6] ),
					.cy( c[0][6] ));
assign sum[0] = s[0][6];

csa3 csa_s1_a0(
					.a( c[0][0] ),
					.b( c[0][1] ),
					.c( c[0][2] ),
					.sum( s[1][0] ),
					.cy( c[1][0] ));
csa3 csa_s1_a1(
					.a( s[1][0] ),
					.b( c[0][3] ),
					.c( c[0][4] ),
					.sum( s[1][1] ),
					.cy( c[1][1] ));
csa3 csa_s1_a2(
					.a( s[1][1] ),
					.b( c[0][5] ),
					.c( c[0][6] ),
					.sum( s[1][2] ),
					.cy( c[1][2] ));
assign sum[1] = s[1][2];

csa3 csa_s2_a0(
					.a( c[1][0] ),
					.b( c[1][1] ),
					.c( c[1][2] ),
					.sum( s[2][0] ),
					.cy( c[2][0] ));
assign sum[2] = s[2][0];

assign cy = c[2][0];


endmodule