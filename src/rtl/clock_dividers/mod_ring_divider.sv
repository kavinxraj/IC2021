/*********************************************************/
// MODULE: 
//
// FILE NAME: mod_ring_divider.sv 
// VERSION: 0.1
// DATE: 2022-Apr-24 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module mod_ring_divider
(
	input clk, rst,
	output logic q_out
);

logic q0, q1, q2;

always_ff @ ( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		q0 <= 'b0;
		q1 <= 'b0;
		q2 <= 'b0;
	end
	else begin
		q2 <= q1;
		q1 <= q0;
		q0 <= ~(q1&q2);
	end
end

endmodule
