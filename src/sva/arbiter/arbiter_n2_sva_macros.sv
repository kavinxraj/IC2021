/*********************************************************/
// MODULE: 
//
// FILE NAME: arbiter_n2_sva_macros.sv 
// VERSION: 0.1
// DATE: 2022-May-05 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

`define assert_clk(arg) \
	assert property ( disable iff (~rst) arg )
