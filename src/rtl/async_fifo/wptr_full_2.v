/*********************************************************/
// MODULE: 
//
// FILE NAME: rptr_full_2.v
// VERSION: 0.1
// DATE: 2022-Apr-15
// AUTHOR: Clifford E. Cummings
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module wptr_full_2 
(
	wfull, wptr, afull_n, 
	winc, wclk, wrst_n
);

parameter ADDRSIZE = 4;

output wfull;
output [ADDRSIZE-1:0] wptr;
input afull_n;
input winc, wclk, wrst_n;
reg [ADDRSIZE-1:0] wptr, wbin;
reg wfull, wfull2;
wire [ADDRSIZE-1:0] wgnext, wbnext;

//---------------------------------------------------------------
// GRAYSTYLE2 pointer
//---------------------------------------------------------------
always @(posedge wclk or negedge wrst_n) begin
	if (!wrst_n) begin
		wbin <= 0;
		wptr <= 0;
	end
	else begin
		wbin <= wbnext;
		wptr <= wgnext;
	end
end

//---------------------------------------------------------------
// increment the binary count if not full
//---------------------------------------------------------------
assign wbnext = !wfull ? wbin + winc : wbin;
assign wgnext = (wbnext>>1) ^ wbnext; // binary-to-gray conversion

always @(posedge wclk or negedge wrst_n or negedge afull_n) begin
	if (!wrst_n ) {wfull,wfull2} <= 2'b00;
	else if (!afull_n) {wfull,wfull2} <= 2'b11;
	else {wfull,wfull2} <= {wfull2,~afull_n};
end

endmodule
