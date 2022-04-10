/*********************************************************/
// MODULE: 
//
// FILE NAME: arst_sync_comb_p.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arst_sync_comb_p
(
	input clk,
	input rst_i,
	output logic rst_o
);

logic q0, q1;

always_ff @ ( posedge clk ) begin
	q0 <= rst_i;
	q1 <= q0;
end

always_comb begin
	rst_o = rst_i | q1;
end

endmodule: arst_sync_comb_p
