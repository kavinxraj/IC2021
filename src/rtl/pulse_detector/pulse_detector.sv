/*********************************************************/
// MODULE: 
//
// FILE NAME: pulse_detector.sv 
// VERSION: 0.1
// DATE: 2022-Apr-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/
module pulse_detector
(
	input clk,
	input async_rst,
	input pulse_in,
	output pulse_out
);

logic q0,q1;


always_ff @ ( posedge pulse_in, posedge q1, negedge async_rst ) begin
	if( q1 | ~async_rst ) begin
		q0 <= '0;
	end
	else begin
		q0 <= 'b1;
	end
end

always_ff @ ( posedge clk, negedge async_rst ) begin
	if( ~async_rst ) begin
		q1 <= 'b0;
	end
	else begin
		q1 <= q0;
	end
end

assign pulse_out = q1;

endmodule
