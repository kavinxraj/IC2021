/*********************************************************/
// MODULE: 
//
// FILE NAME: control_fsm.sv 
// VERSION: 0.1
// DATE: 2021-Jun-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module control_fsm
(
	input clk,
	input rst,
	output logic fetch,
	output logic execute
);

typedef enum logic {
	FETCH = 1'b0,
	EXECUTE = 1'b1
} state_t;

state_t state_reg, next_state;

always_ff @ (posedge clk) begin
	if ( rst ) begin
		state_reg <= FETCH;
	end
	else begin
		state_reg <= next_state;
	end
end

always_comb begin
	if( state_reg == FETCH ) begin
		fetch = 1'b1;
		execute = 1'b0;
		next_state = EXECUTE;
	end
	else begin
		fetch = 1'b0;
		execute = 1'b1;
		next_state = FETCH;
	end
end

endmodule: control_fsm
