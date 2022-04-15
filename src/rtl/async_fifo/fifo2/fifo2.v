/*********************************************************/
// MODULE: 
//
// FILE NAME: fifo2.v
// VERSION: 0.1
// DATE: 2022-Apr-15
// AUTHOR: Clifford E. Cummings
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module fifo2 
(
	rdata, wfull, rempty, wdata,
	winc, wclk, wrst_n, rinc, rclk, rrst_n
);

parameter DSIZE = 8;
parameter ASIZE = 4;

output [DSIZE-1:0] rdata;
output wfull;
output rempty;
input [DSIZE-1:0] wdata;
input winc, wclk, wrst_n;
input rinc, rclk, rrst_n;
wire [ASIZE-1:0] wptr, rptr;
wire [ASIZE-1:0] waddr, raddr;

async_cmp2 #(
	ASIZE
)
async_cmp
(
	.aempty_n(aempty_n),
	.afull_n(afull_n),
	.wptr(wptr),
	.rptr(rptr),
	.wrst_n(wrst_n)
);

fifomem2 #(
	DSIZE, 
	ASIZE
)
fifomem
(
	.rdata(rdata),
	.wdata(wdata),
	.waddr(wptr),
	.raddr(rptr),
	.wclken(winc),
	.wclk(wclk)
);

rptr_empty_2 #(
	ASIZE
) 
rptr_empty
(
	.rempty(rempty), 
	.rptr(rptr),
	.aempty_n(aempty_n), 
	.rinc(rinc),
	.rclk(rclk), 
	.rrst_n(rrst_n)
);

wptr_full_2 #(
	ASIZE
) 
wptr_full
(
	.wfull(wfull), 
	.wptr(wptr),
	.afull_n(afull_n), 
	.winc(winc),
	.wclk(wclk), 
	.wrst_n(wrst_n)
);


endmodule
