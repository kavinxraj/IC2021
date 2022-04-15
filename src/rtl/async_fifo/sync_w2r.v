/*********************************************************/
// MODULE: 
//
// FILE NAME: sync_w2r.v
// VERSION: 0.1
// DATE: 2022-Apr-15
// AUTHOR: Clifford E. Cummings
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module sync_w2r #(
	parameter ADDRSIZE = 4
)
(
	output reg [ADDRSIZE:0] rq2_wptr,
	input [ADDRSIZE:0] wptr,
	input rclk, rrst_n
);

reg [ADDRSIZE:0] rq1_wptr;

always @(posedge rclk or negedge rrst_n)
	if (!rrst_n) {rq2_wptr,rq1_wptr} <= 0;
else
	{rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};

endmodule
