/*********************************************************/
// MODULE: 
//
// FILE NAME: arbiter_n2_sva.sv 
// VERSION: 0.1
// DATE: 2022-May-05 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

`include "arbiter_n2_sva_macros.sv"

module arbiter_n2_sva
import arbiter_n2_pkg::*;
(
	input clk, rst,
	input req_t req,
	input gnt_t gnt,
	input state_t pr_state, nx_state
);

//default clocking for assertions
default clocking DEFCLK @ ( posedge clk );
endclocking

//State Transistion Verification

property T1;
	( pr_state == IDLE ) && ( req  == REQ0 ) |=> ( pr_state == STATE_GNT0 );
endproperty	

property T2;
	( pr_state == IDLE ) && ( req  == REQ1 ) |=> ( pr_state == STATE_GNT1 );
endproperty	

property T3;
	( pr_state == IDLE ) && ( req  == REQ01 ) |=> ( pr_state == STATE_GNT0 );
endproperty	

property T4;
	( pr_state == IDLE ) && ( req  == NO_REQ ) |=> ( pr_state == IDLE );
endproperty	

IDLE_CHECK1: assert property ( T1 );
IDLE_CHECK2: assert property ( T2 );
IDLE_CHECK3: assert property ( T3 );
IDLE_CHECK4: assert property ( T4 );

//State Ouptput Verification

property O1;
	( pr_state == IDLE ) |-> ( gnt == NO_GNT );
endproperty

OP_CHECK: assert property ( O1 );

endmodule : arbiter_n2_sva
