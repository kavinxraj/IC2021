/*********************************************************/
// MODULE: 
//
// FILE NAME: arbiter_n2_pkg.sv 
// VERSION: 0.1
// DATE: 2022-May-04 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

package arbiter_n2_pkg;

typedef enum logic [1:0] {
	NO_REQ,
	REQ0,
	REQ1,
	REQ01
} req_t;

typedef enum logic [1:0] {
	NO_GNT,
	GNT0,
	GNT1
} gnt_t;

typedef enum logic [1:0] {
	IDLE,
	STATE_GNT0,
	STATE_GNT1
} state_t;

endpackage : arbiter_n2_pkg
