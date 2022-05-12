/*********************************************************/
// MODULE: 
//
// FILE NAME: demux_1x2.sv 
// VERSION: 0.1
// DATE: 2021-May-22 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module demux_1x2
(
	input logic y_in, sel_in,
	output logic a_out, b_out
);

always_comb begin
	unique case (sel_in)
	1'b0: begin 
	a_out = y_in;
	b_out = 1'b0;
	end
	1'b1: begin
	a_out = 1'b0;
	b_out = y_in;
	end
endcase
end

endmodule : demux_1x2
