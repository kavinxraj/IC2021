/*********************************************************/
// MODULE: 
//
// FILE NAME: jump_logic.sv 
// VERSION: 0.1
// DATE: 2021-Jun-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module jump_logic
(
	input ng, zr,
	input j1,j2,j3,
	output logic jumpctrl
);

logic ng_n, zr_n;

always_comb begin
	ng_n = ~ng;
	zr_n = ~zr;
end

always_comb begin
	case({j1,j2,j3}) 
		3'b000: jumpctrl = 1'b0;
		3'b001: jumpctrl = ng_n & zr_n;
		3'b010: jumpctrl = zr;
		3'b011: jumpctrl = ng_n & zr;
		3'b100: jumpctrl = ng;
		3'b101: jumpctrl = zr_n;
		3'b110: jumpctrl = ng | zr;
		3'b111: jumpctrl = 1'b1;
	endcase
end

endmodule: jump_logic
