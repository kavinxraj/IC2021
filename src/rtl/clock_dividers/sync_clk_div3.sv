/*********************************************************/
// MODULE: 
//
// FILE NAME: sync_clk_div3.sv 
// VERSION: 0.1
// DATE: 2022-Apr-08 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module sync_clk_div3
(
	input clk,
	input rst,
	output logic clk_1b3
);

logic [1:0] d,q;

always_comb begin
	d[0] = ~q[0] & ~q[1];
	d[1] = q[0] & ~q[1];
end

always_ff @ ( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		q <= 'b0;
	end
	else begin
		q <= d;
	end
end

logic q_;

always_ff @ ( posedge q[1], negedge rst ) begin
	if( ~rst ) begin
		q_ <= 'b0;
	end
	else begin
		q_ <= ~q_;
	end
end

assign clk_1b3 = q_;

endmodule: sync_clk_div3
