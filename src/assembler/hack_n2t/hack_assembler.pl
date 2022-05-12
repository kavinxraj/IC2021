#!/usr/bin/perl

#/*********************************************************/
#// FILE NAME: hack_assembler.pl 
#// VERSION: 1.0
#// DATE: 2021-Jun-27 
#// AUTHOR: KavinRaj D
#//
#// DESCRIPTION:
#//
#/*********************************************************/

use strict;
use warnings;

if ( !defined $ARGV[0] ) {
	die"Usage: ./hack_assembler.pl asmblyCode.asm\n";
}

my %symbolTable = (
	"R0"	=> 0,
	"R1"	=> 1,
	"R2"	=> 2,
	"R3"	=> 3,
	"R4"	=> 4,
	"R5"	=> 5,
	"R6"	=> 6,
	"R7"	=> 7,
	"R8"	=> 8,
	"R9"	=> 9,
	"R10"	=> 10,
	"R11"	=> 11,
	"R12"	=> 12,
	"R13"	=> 13,
	"R14"	=> 14,
	"R15"	=> 15,
	"SP"	=> 0,
	"LCL"	=> 1,
	"ARG"	=> 2,
	"THIS"	=> 3,
	"THAT"	=> 4
);

my %compTable = (
	"0"	=> "0101010",
	"1"	=> "0111111",
	"-1"	=> "0111010",
	"D"	=> "0001100",
	"A"	=> "0110000",
	"!D"	=> "0001101",
	"!A"	=> "0110001",
	"-D"	=> "0001111",
	"-A"	=> "0110011",
	"D+1"	=> "0011111",
	"A+1"	=> "0110111",
	"D-1"	=> "0001110",
	"A-1"	=> "0110010",
	"D+A"	=> "0000010",
	"D-A"	=> "0010011",
	"A-D"	=> "0000111",
	"D&A"	=> "0000000",
	"D|A"	=> "0010101",
	"M"	=> "1110000",
	"!M"	=> "1110001",
	"M+1"	=> "1110111",
	"M-1"	=> "1110010",
	"D+M"	=> "1000010",
	"D-M"	=> "1010011",
	"M-D"	=> "1000111",
	"D&M"	=> "1000000",
	"D|M"	=> "1010101"
);

my %destTable = (
	"NULL"	=> "000",
	"D"	=> "001",
	"M"	=> "010",
	"MD"	=> "011",
	"A"	=> "100",
	"AD"	=> "101",
	"AM"	=> "110",
	"AMD"	=> "111"
);

my %jumpTable = (
	"NULL"	=> "000",
	"JGT"	=> "001",
	"JEQ"	=> "010",
	"JGE"	=> "011",
	"JLT"	=> "100",
	"JNE"	=> "101",
	"JLE"	=> "110",
	"JMP"	=> "111"
);

#Partially Working Parser
sub parser {
	my $instruction = $_[0];
	my $addressValue;
	my $compString;
	my $destString;
	my $jumpString;
	my $instructionType;
	my $labelString;

	if( $instruction =~ /\s*?@([\d]{1,5})\s*?(\/\/.*)?/ ){
		$instructionType = "AINST";
		$addressValue = $1;
	} elsif ( $instruction =~ /@([A-Za-z_]{1,20})/ ){
		$instructionType = "AINST";
		$labelString = $1;
	} elsif ( $instruction =~ /\s*?([amdAMD]{1,3})=([AMD01\-\+\&\|]{1,3});([Jj][GLENMglenm][TQEPtqep])\s*?/ ){
		$instructionType = "CINST";
		$destString = $1;
		$compString = $2;
		$jumpString = $3;
	} elsif ( $instruction =~ /\s*?([amdAMD]{1,3})=([AMD01\-\+\&\|]{1,3})\s*?/ ){
		$instructionType = "CINST";
		$destString = $1;
		$compString = $2;
		$jumpString = "NULL";
	} elsif ( $instruction =~ /\s?([amdAMD01\-\+\&\|]{1,3});([Jj][GLENMglenm][TQEPtqep])\s*?/ ){
		$instructionType = "CINST";
		$destString = "NULL";
		$compString = $1;
		$jumpString = $2;
	} elsif ( $instruction =~ /\(([A-Za-z_]{1,20})\)/ ){
		$instructionType = "LABEL";
		$labelString = $1;
	}	       

	return ($instructionType, $addressValue, $compString, $destString, $jumpString, $labelString);

}

#PASS 1
open( ASSEMBLY_FILE, "<", $ARGV[0] );

my $instructionAddress = -1;

while( <ASSEMBLY_FILE> ) {
	my $assemblyCodeLine = $_;	#Input
	chomp $assemblyCodeLine;

	#Parse
	my $addressValue;
	my $compString = "0";
	my $destString = "NULL";
	my $jumpString = "NULL";
	my $instructionType;
	my $labelString;

	($instructionType, $addressValue, $compString, $destString, $jumpString, $labelString) = parser( $assemblyCodeLine );

	##Debug
	#print "PASS 1: InstAddr $instructionAddress $assemblyCodeLine\n";
	#print "PASS 1: InsType $instructionType, addrVal $addressValue, comp $compString, dest $destString, jump $jumpString\n";

	#Updating Symbol Table
	if ( defined $instructionType ){
		if( $instructionType eq "AINST"  ){
			if( defined $labelString ){
				if( !defined $symbolTable{$labelString} ){
					$symbolTable{$labelString} = "NULL";
				}

			}
			$instructionAddress++;
		} elsif ( $instructionType eq "LABEL"){
			if( !defined $symbolTable{$labelString} ){
				$symbolTable{$labelString} = $instructionAddress + 1;
			} elsif ( $symbolTable{$labelString} eq "NULL" ){
				$symbolTable{$labelString} = $instructionAddress + 1;
			} elsif ( defined $symbolTable{$labelString} ){
				die "Multiple usage of Label $labelString at line number $assemblyCodeLine\n";
			}
		} elsif ( $instructionType eq "CINST" ){
			$instructionAddress++;
		}
	}

}

#Updating Symbol Table for Uninitialized values
my $n = 16;
for my $symbol (keys %symbolTable){
	if( $symbolTable{$symbol} eq "NULL" ){
		$symbolTable{$symbol} = $n;
		$n++;
	}
}
close( ASSEMBLY_FILE );

#Debug
#for my $keys (keys %symbolTable){
#	print" $keys --> $symbolTable{$keys}\n"
#}

#PASS 2
open( ASSEMBLY_FILE, "<", $ARGV[0] );
open( BINARY_FILE, ">", "$ARGV[0].binary" );

while( <ASSEMBLY_FILE> ) {
	my $assemblyCodeLine = $_;	#Input
	chomp $assemblyCodeLine;
	my $binaryCodeLine;		#Output

	#Parse
	my $addressValue;
	my $compString = "0";
	my $destString = "NULL";
	my $jumpString = "NULL";
	my $instructionType;
	my $labelString;

	($instructionType, $addressValue, $compString, $destString, $jumpString, $labelString) = parser( $assemblyCodeLine );

	##Debug
	#print "PASS 2: $assemblyCodeLine\n";
	#print "PASS 2: InsType $instructionType, addrVal $addressValue $symbolTable{$labelString}, comp $compString, dest $destString, jump $jumpString\n";

	#Translate
	if ( defined $instructionType ) {

		if( $instructionType eq "AINST" ){
			my $binAddress;
			if( defined $labelString ){
				$binAddress = sprintf("%015b",$symbolTable{$labelString});
			} else {
				$binAddress = sprintf("%015b",$addressValue);
			}
			$binaryCodeLine = "0".$binAddress;
		} elsif ( $instructionType eq "CINST"){
			my $COMP = uc($compString);
			my $DEST = uc($destString);
			my $JUMP = uc($jumpString);
			$binaryCodeLine = "111"."$compTable{\"$COMP\"}$destTable{\"$DEST\"}$jumpTable{\"$JUMP\"}";
		}

		##Debug
		#if ( $instructionType ne "LABEL" ){
		#	print "$binaryCodeLine\n";
		#}

		if( defined $binaryCodeLine ) {
			print BINARY_FILE "$binaryCodeLine\n";
		}
	}
}

close( ASSEMBLY_FILE );
close( BINARY_FILE );
