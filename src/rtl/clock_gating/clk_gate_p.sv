/*********************************************************/
// MODULE: 
//
// FILE NAME: clk_gate_p.sv 
// VERSION: 0.1
// DATE: 2022-Apr-11 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module clk_gate_p
(
	input clk,
	input enable,
	output logic gated_clk
);

logic q0;

always_latch begin
	if ( ~clk ) begin
		q0 <= enable;
	end
end

always_comb begin
	gated_clk = q0 & clk;
end

endmodule: clk_gate_p
