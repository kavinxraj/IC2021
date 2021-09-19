#!/usr/bin/perl

#/*********************************************************/
#// FILE NAME: csa.sv.pl 
#// VERSION: 0.1
#// DATE: 2021-Sep-19 
#// AUTHOR: KavinRaj D
#//
#// DESCRIPTION:code to generate a n bit carry save
#// 		adder by instantiating and connecting a 3
#//		bit carry save adder
#//
#/*********************************************************/

use strict;
use warnings;
use POSIX;

my $DEPTH = 63; # Best Config (2^n)-1
my $WIDTH = ceil (log( $DEPTH + 1 ) / log( 2 )); #Calculating Output Width
my $MAX_STAGES = $WIDTH -1 ;			#Number of 2^i Base Stages required
my $MAX_ADDERS = ceil( ( $DEPTH -1 ) /2 ) ;	#Number of Adders Required at Stage 2^0

open ( O_FILE, ">", "csa${DEPTH}.sv" );

print O_FILE "module csa
#(
	parameter DEPTH = $DEPTH,
	parameter WIDTH = $WIDTH
)
(
	input [DEPTH-1:0] i,
	output [WIDTH-2:0] sum,
	output cy
);
localparam MAX_STAGES = WIDTH;

logic [MAX_STAGES-1:0][DEPTH:0] s,c;		//Number of Wires not accurate
\n";

my $adders_per_stage = $MAX_ADDERS;

#Instantiating Based on No of Stages & Max Adders Required per stage

for( my $stage = 0 ; $stage < $MAX_STAGES; $stage++ ) {


	for( my $adder = 0; $adder < $adders_per_stage; $adder++ ) {
			if( $stage == 0 && $adder == 0 ) {
				my $a = "i[0]";
				my $index1 = ($adder*2) + 1;
				my $b = "i[$index1]";
				my $index2 = ($adder*2) + 2;
				my $c = "i[$index2]";
				my $sum = "s[$stage][$adder]";
				my $cy = "c[$stage][$adder]";
				print O_FILE "csa3 csa_s${stage}_a${adder}(
					.a( $a ),
					.b( $b ),
					.c( $c ),
					.sum( $sum ),
					.cy( $cy ));\n"
			}
			elsif( $stage == 0 ) {
				my $a_index = $adder -1;
				my $a = "s[$stage][$a_index]";
				my $index1 = ($adder*2) + 1;
				my $b = "i[$index1]";
				my $index2 = ($adder*2) + 2;
				my $c = "i[$index2]";
				my $sum = "s[$stage][$adder]";
				my $cy = "c[$stage][$adder]";
				print O_FILE "csa3 csa_s${stage}_a${adder}(
					.a( $a ),
					.b( $b ),
					.c( $c ),
					.sum( $sum ),
					.cy( $cy ));\n"
			}
			elsif( $stage != 0 && $adder == 0 ) {
				my $x_index = $stage-1;
				my $a = "c[$x_index][0]";
				my $index1 = ($adder*2) + 1;
				my $b = "c[$x_index][$index1]";
				my $index2 = ($adder*2) + 2;
				my $c = "c[$x_index][$index2]";
				my $sum = "s[$stage][$adder]";
				my $cy = "c[$stage][$adder]";
				print O_FILE "csa3 csa_s${stage}_a${adder}(
					.a( $a ),
					.b( $b ),
					.c( $c ),
					.sum( $sum ),
					.cy( $cy ));\n"
			}
			else {
				my $x_index = $stage-1;
				my $a_index = $adder-1;
				my $a = "s[$stage][$a_index]";
				my $index1 = ($adder*2) + 1;
				my $b = "c[$x_index][$index1]";
				my $index2 = ($adder*2) + 2;
				my $c = "c[$x_index][$index2]";
				my $sum = "s[$stage][$adder]";
				my $cy = "c[$stage][$adder]";
				print O_FILE "csa3 csa_s${stage}_a${adder}(
					.a( $a ),
					.b( $b ),
					.c( $c ),
					.sum( $sum ),
					.cy( $cy ));\n"
				}

	}

	my $s_index = $adders_per_stage-1;
	print O_FILE "assign sum[$stage] = s[$stage][$s_index];\n\n";

	$adders_per_stage = ceil( ( $adders_per_stage -1 ) / 2 );
}

my $c_index = $MAX_STAGES - 1;
print O_FILE "assign cy = c[$c_index][0];


endmodule";


close( O_FILE );
