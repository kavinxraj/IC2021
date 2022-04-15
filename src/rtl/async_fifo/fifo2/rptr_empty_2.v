/*********************************************************/
// MODULE: 
//
// FILE NAME: rptr_empty_2.v
// VERSION: 0.1
// DATE: 2022-Apr-15
// AUTHOR: Clifford E. Cummings
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module rptr_empty_2 (
	rempty, rptr, aempty_n, 
	rinc, rclk, rrst_n
);

parameter ADDRSIZE = 4;

output rempty;
output [ADDRSIZE-1:0] rptr;
input aempty_n;
input rinc, rclk, rrst_n;
reg [ADDRSIZE-1:0] rptr, rbin;
reg rempty, rempty2;
wire [ADDRSIZE-1:0] rgnext, rbnext;

//---------------------------------------------------------------
// GRAYSTYLE2 pointer
//---------------------------------------------------------------
always @(posedge rclk or negedge rrst_n)
if (!rrst_n) begin
	rbin <= 0;
	rptr <= 0;
end
else begin
	rbin <= rbnext;
	rptr <= rgnext;
end

//---------------------------------------------------------------
// increment the binary count if not empty
//---------------------------------------------------------------
assign rbnext = !rempty ? rbin + rinc : rbin;
assign rgnext = (rbnext>>1) ^ rbnext; // binary-to-gray conversion

always @(posedge rclk or negedge aempty_n) begin
	if (!aempty_n) {rempty,rempty2} <= 2'b11;
	else {rempty,rempty2} <= {rempty2,~aempty_n};
end

endmodule
