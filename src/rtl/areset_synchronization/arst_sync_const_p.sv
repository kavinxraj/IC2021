/*********************************************************/
// MODULE: 
//
// FILE NAME: arst_sync_const_p.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arst_sync_const_p
(
	input clk,
	input rst_i,
	output logic rst_o
);

logic q0, q1;

always_ff @ ( posedge clk, negedge rst_i ) begin
	if ( ~rst_i ) begin
		q1 <= 'b0;
		q0 <= 'b0;
	end
	else begin
		q1 <= q0;
		q0 <= 'b1;
	end
end

always_comb begin
	rst_o = q1; 
end

endmodule: arst_sync_const_p
