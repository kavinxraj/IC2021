/*********************************************************/
// MODULE: 
//
// FILE NAME: simple_counter.sv 
// VERSION: 0.1
// DATE: 2022-Feb-17 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module simple_counter
(
	input up, ena, clk, rst,
	output logic [2:0] outp
);

always_ff @ ( posedge clk, posedge rst ) begin
	if ( rst ) begin
		outp <= 0;
	end
	else begin
		if ( ena ) begin
			if ( up ) begin
				outp <= outp + 1;
			end
			else begin
				outp <= outp - 1;
			end
		end
		else
			outp <= outp;
	end
end

endmodule
