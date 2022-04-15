/*********************************************************/
// MODULE: 
//
// FILE NAME: fifomem2.v
// VERSION: 0.1
// DATE: 2022-Apr-15
// AUTHOR: Clifford E. Cummings
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module fifomem2
(
	rdata, wdata, 
	waddr, raddr, 
	wclken, wclk
);

parameter DATASIZE = 8;

// Memory data word width
parameter ADDRSIZE = 4;

// Number of memory address bits
parameter DEPTH = 1<<ADDRSIZE; // DEPTH = 2**ADDRSIZE

output [DATASIZE-1:0] rdata;
input [DATASIZE-1:0] wdata;
input [ADDRSIZE-1:0] waddr, raddr;
input wclken, wclk;

`ifdef VENDORRAM
	// instantiation of a vendor's dual-port RAM
	VENDOR_RAM MEM (.dout(rdata), .din(wdata),
		.waddr(waddr), .raddr(raddr),
	.wclken(wclken), .clk(wclk));
`else
	reg [DATASIZE-1:0] MEM [0:DEPTH-1];

	assign rdata = MEM[raddr];

	always @(posedge wclk) begin
		if (wclken) MEM[waddr] <= wdata;
	end
`endif

endmodule
